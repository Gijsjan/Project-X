_ = require 'underscore'
Backbone = require 'backbone'
riak = require '../riak'
exec = require('child_process').exec

class BaseModel extends Backbone.Model

	# Default relationAttributes, can be overriden
	'relationAttributes': [
		'id'
		'title'
	]

	getRelationAttributes: ->
		attributes = {}

		for attribute in @relationAttributes
			attributes[attribute] = @get attribute

		attributes

	save: (success) ->
		@unset 'relations'
		# if model has an id (on update), than callback(), else (on create) generate key with uuidgen and callback() after the exec callback(stdout)
		generateKey = (callback) =>
			if not @isNew() then callback() else
				exec 'uuidgen', (error, stdout, stderr) =>
					@set 'id', stdout.replace(/[^a-z0-9-]+/g, '') # remove unwanted chars (spaces) from stdout and set id
					callback()
		
		generateKey =>
			riak.write
				'bucket': @get 'type'
				'key': @get 'id'
				'data': @toJSON()
				'success': success

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


module.exports = BaseModel