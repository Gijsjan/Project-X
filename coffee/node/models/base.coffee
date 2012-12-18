_ = require 'underscore'
Backbone = require 'backbone'
riak = require '../riak'
CallbackQueue = require '../CallbackQueue'
exec = require('child_process').exec

class Base extends Backbone.Model

	'defaults':
		'created': ''
		'updated': ''

	# Default relationAttributes, can be overriden
	'relationAttributes': [
		'id'
		'title'
	]			

	getRelationAttributes: ->
		attributes = {}

		for attribute in @relationAttributes
			attributes[attribute] = @get attributeverkiezingen oss

		attributes

	save: (success) ->
		# if model has an id (on update), than callback(), else (on create) generate key with uuidgen and callback() after the exec callback(stdout)
		generateKey = (callback) =>
			if not @isNew() 
				@set 'updated', new Date()
				
				callback() 
			else
				@set 'created', new Date()
				
				exec 'uuidgen', (error, stdout, stderr) =>
					@set 'id', stdout.replace(/[^a-z0-9-]+/g, '') # remove unwanted chars (spaces) from stdout and set id
					callback()

		@_setRelations
			success: (response) =>
				generateKey =>
					# Loop through attributes and unset every attribute that is not defined in @defaults
					# This is done to discard 'relations' and other client side mess if necessary
					for own attribute, value of @attributes
						if not @defaults[attribute]? and attribute isnt 'id'
							@unset attribute

					riak.write
						'bucket': @get 'type'
						'key': @get 'id'
						'data': @toJSON()
						'success': success

	_getRelations: (args) ->
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


	
	_setRelations: (args) ->
		[success] = [args.success]

		relations = @get('relations')? || {}
		groupBucket = @get 'type'

		queueLength = _.size(@relations)
		mainQueue = new CallbackQueue queueLength, success

		_writeRelations = (itemBucket) =>
			queue = new CallbackQueue 2, (data) =>
				newRelations = relations[itemBucket] || []
				
				# REMOVE COLLECTIONS? ONLY SLOWING THINGS DOWN
				[allRelations, oldRelations] = [data.allRelations, data.oldRelations]

				riak.write
					'bucket': 'relations'
					'key': @get('id')+'|'+itemBucket
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
					groups.push @toJSON()
					
					item.set groupBucket, groups

					allRelations.add item

				remove.each (model) ->
					item = allRelations.get(model.id) || model
					
					groups = item.get(groupBucket) || []
					groups = _.filter groups, (group) -> group.id isnt @id

					item.set groupBucket, groups

					allRelations.add item

				riak.write
					'bucket': 'relations'
					'key': itemBucket
					'data': allRelations.toJSON()

			riak.read
				'bucket': 'relations'
				'key': @get('id')+'|'+itemBucket
				success: queue.register('oldRelations')

			riak.read
				'bucket': 'relations'
				'key': itemBucket
				success: queue.register('allRelations')

		for own itemBucket, relationType of @relations
			_writeRelations itemBucket

module.exports = Base

			




	# addRelations: (args) ->
	# 	[bucket, relations] = [args.bucket, args.relations]

	# 	switch @relations[bucket]

	# 		when 'separate'	
	# 			riak.write
	# 				'bucket': 'relations'
	# 				'key': @get('id')+'|'+bucket
	# 				'data': relations
	# 				success: ->

	# 		when 'attached'
	# 			riak.read
	# 				'bucket': @get('type')
	# 				'key': @get('id')
	# 				success: (attributes) =>
	# 					@set attributes
	# 					@set bucket, relations
	# 					@save()

	# removeRelation: (model) ->
	# 	bucket = model.get 'type'

	# 	switch @relations[bucket]

	# 		when 'separate'
	# 			console.log 'remove separate'

	# 		when 'attached'
	# 			console.log 'remove attached'
	# 			riak.read
	# 				'bucket': @get('type')
	# 				'key': @get('id')
	# 				success: (attributes) =>
	# 					@set attributes

	# 					# Create collection to easily remove relation, atlernatively use _.find or indexOf/splice
	# 					relations = new Backbone.Collection @get(bucket)
	# 					relations.remove model.get('id')

	# 					@set bucket, relations.toJSON()
	# 					@save()


	# # SWITCH SEPARATE / ATTACHED
	# addRelation: (model) ->
	# 	bucket = model.get 'type'

	# 	switch @relations[bucket]

	# 		when 'separate'
	# 			console.log 'separate'
	# 			# riak.read
	# 			# 	'bucket': bucket
	# 			# 	'key': key
	# 			# 	success: (list) ->
	# 			# 		list.push relation
	# 			# 		riak.write
	# 			# 			'bucket': bucket
	# 			# 			'key': key
	# 			# 			'data': list
	# 			# 			success: ->

	# 		when 'attached'
	# 			console.log 'attached'
	# 			riak.read
	# 				'bucket': @get('type')
	# 				'key': @get('id')
	# 				success: (attributes) =>
	# 					@set attributes

	# 					relations = @get bucket
	# 					relations.push model.getRelationAttributes()

	# 					@set bucket, relations
						
	# 					@save()



	# saveRelations:  ->
	# 	for own name, newRelations of @get('relations') # name = "members", newRelations = [{rel1}, {rel2}, ...]
	# 		if @relations.hasOwnProperty(name)
	# 			key = @get('id')+'|'+name
	# 			newRelationIDs = _.pluck(newRelations, 'id')

	# 			riak.read
	# 				'bucket': 'relations'
	# 				'key': key
	# 				success: (data) ->
	# 					oldRelationIDs = _.pluck(data.relations, 'id')
						
	# 					toAdd = _.difference(newRelationIDs, oldRelationIDs)
	# 					toRemove = _.difference(oldRelationIDs, newRelationIDs)

	# 					console.log ModelSwitcher
	# 					# model = new ModelSwitcher[name]()
	# 					# console.log model.relations[@get('type')]

	# 					# for id in toAdd

	# 			switch @relations[name]
	# 				when 'separate'
	# 					riak.write
	# 						'data':
	# 							'type': 'relations'
	# 							'id': key
	# 							'relations': newRelations
	# 						'success': ->


