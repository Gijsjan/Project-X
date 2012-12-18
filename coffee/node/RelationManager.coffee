_ = require 'underscore'
Backbone = require 'backbone'
riak = require './riak'
ModelSwitcher = require './switchers/models'
CollectionSwitcher = require './switchers/collections'
CallbackQueue = require './CallbackQueue'

class RelationManager

	destroy: (args) ->

	get: (args) ->
		[groupBucket, groupKey, success] = [args.groupBucket, args.groupKey, args.success]

		groupModel = new ModelSwitcher[groupBucket] 'id': groupKey

		# Calculate the queueLength and determine if attached relations exist
		attached = false
		queueLength = 0
		for own itemBucket, relationType of groupModel.relations
			if relationType is 'separate' then queueLength++ else attached = true
		queueLength++ if attached

		_queueComplete = (response) ->
			if attached # if the model has attached relations, response returns a list of groups in response[groupBucket]
				groups = response[groupBucket] # get groups from response
				attachedRelations = _.find groups, (group) -> group.id is groupKey # find the group we are looking for

				for own itemBucket, relationType of groupModel.relations # iterate the relations of the model
					if relationType is 'attached'
						response[itemBucket] = if attachedRelations? then attachedRelations[itemBucket] else []

				delete response[groupBucket] # discard the list

			success response

		# Create a callback queue
		callbackQueue = new CallbackQueue queueLength, _queueComplete

		# Iterate the relations to read the separate relations
		for own itemBucket, relationType of groupModel.relations
			if relationType is 'separate'
				riak.read
					'bucket': 'relations'
					'key': groupKey + '|' + itemBucket
					'success': callbackQueue.register(itemBucket)

		# Attached relations are all located in 'relations||groupBucket' (ie: relations||people), so only one read is needed
		if attached
			riak.read
				'bucket': 'relations'
				'key': groupBucket
				'success': callbackQueue.register(groupBucket)


	
	set: (args) ->
		[groupModel, success] = [args.groupModel, args.success]

		relations = groupModel.get('relations')? || {}
		console.log relations
		groupBucket = groupModel.get 'type'

		queueLength = _.size(groupModel.relations)
		mainQueue = new CallbackQueue queueLength, success

		_writeRelations = (itemBucket) ->
			queue = new CallbackQueue 2, (data) ->
				items = relations[itemBucket] || []
				
				# REMOVE COLLECTIONS? ONLY SLOWING THINGS DOWN
				allRelations = new CollectionSwitcher[itemBucket] data.allRelations
				oldRelations = new CollectionSwitcher[itemBucket] data.oldRelations
				newRelations = new CollectionSwitcher[itemBucket] items

				riak.write
					'bucket': 'relations'
					'key': groupModel.get('id')+'|'+itemBucket
					'data': newRelations.toJSON()
					'success': mainQueue.register(itemBucket)

				_difference = (oldRelations, newRelations) ->
					remove = []

					newRelations.each (relation) ->
						model = oldRelations.get relation.id

						remove.push model.id if model?

					newRelations.remove remove
					oldRelations.remove remove

					[oldRelations, newRelations]


				[remove, add] = _difference(oldRelations, newRelations)

				add.each (model) ->
					item = allRelations.get(model.id) || model

					groups = item.get(groupBucket) || []
					groups.push groupModel.toJSON()
					
					item.set groupBucket, groups

					allRelations.add item

				remove.each (model) ->
					item = allRelations.get(model.id) || model
					
					groups = item.get(groupBucket) || []
					groups = _.filter groups, (group) -> group.id isnt groupModel.id

					item.set groupBucket, groups

					allRelations.add item

				riak.write
					'bucket': 'relations'
					'key': itemBucket
					'data': allRelations.toJSON()

			riak.read
				'bucket': 'relations'
				'key': groupModel.get('id')+'|'+itemBucket
				success: queue.register('oldRelations')

			riak.read
				'bucket': 'relations'
				'key': itemBucket
				success: queue.register('allRelations')

		for own itemBucket, relationType of groupModel.relations
			_writeRelations itemBucket

module.exports = new RelationManager()