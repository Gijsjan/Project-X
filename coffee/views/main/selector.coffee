define [
		'text!../../../templates/main/selector'
	], (tpl) ->
		Backbone.View.extend
			id: 'selector'
			filtered: {}
			events:
				"change #selector ul li": "onContentSelected"
			onContentSelected: (e) ->
				console.log e
				checkboxes = $('#selector ul li input:checked')
				coll = []
				@collection.reset()

				_.each checkboxes, (checkbox) =>
					coll = _.union @base_collection.where({type: checkbox.id}), coll

				@collection.reset coll

				tags = {}
				@base_collection.each (model) ->
					model.get('newtags').each (tag) ->
						t = tag.get('slug')
						if _.has(tags, t) 
							tags[t] = tags[t] + 1
						else 
							tags[t] = 1
				return
			initialize: ->
				@base_collection = @options.base_collection
				@collection.comparator = (model) ->
					m = parseInt model.get('created').replace(/[- :]/g, "") # remove -, space and : from datetime string and convert to number (is conversion necessary?)
					return -m # return negated number
			render: ->
				@$el.html _.template tpl
				$('#sidebar').html(@$el);