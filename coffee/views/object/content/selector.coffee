#NOT IN USE
#NOT IN USE
#NOT IN USE
define [
		'text!../../../../templates/content/selector'
	], (tpl) ->
		Backbone.View.extend
			id: 'content-selector'
			events:
				"change ul li input": "onContentSelected"
			onContentSelected: (e) ->
				target = $(e.currentTarget)
				id = target.attr 'id'
				if target.prop 'checked'
					@checkboxes.push id
				else
					@checkboxes.splice @checkboxes.indexOf(id), 1				
				@trigger 'checkboxChecked'
			initialize: ->
				@labelInfo = new Backbone.Collection()
				@labelInfo.comparator = (model) ->
					-model.get 'active'
				@checkboxes = []
				@checkboxes.push 'link'
			render: ->
				@labelInfo.sort()
				@$el.html _.template tpl, content: @labelInfo

				_.each @checkboxes, (checkbox) =>
					checkbox = checkbox.replace(/(:|\.)/g,'\\$1');
					@$('input#'+checkbox).prop('checked', true)

				$('#sidebar').html @$el
			updateLabelInfo: (type, active) ->
				index = @labelInfo.pluck('type').indexOf(type)
				if index isnt -1
					model = @labelInfo.at(index)

					if active	
						active_count = model.get('active')
						model.set('active', active_count + 1)
					
					inactive_count = model.get('inactive')
					model.set('inactive', inactive_count + 1)
				else
					@labelInfo.add
						type: type
						active: 0
						inactive: 0
