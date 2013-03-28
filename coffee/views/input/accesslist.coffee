define (require) ->
	EditableList = require 'views/input/editablelist'
	Select = require 'views/input/select'

	class AccessList extends EditableList

		'className': 'accesslist'

		createElement: (item) ->
			[id, title] = [item.get('id'), item.get('title')]

			select = new Select
				'value': 
					'id': item.get('access')
					'value': item.get('access')
				'selectoptions': [
					'id': 'read'
					'value': 'read'
				,
					'id': 'write'
					'value': 'write']
				'span': 2
			select.on 'valuechanged', (option) => @selecteditems.get(id).set('access', option.id)

			anchor = $('<a />').html title
			li = $('<li />').addClass('span'+@span).attr('id', id)
			
			select.$el.css('display', 'inline-block')
			anchor.css('display', 'inline-block')

			li.html anchor
			li.append '('+item.get('type')+')'
			li.append select.$el

			# anchor.hover(
			# 	(-> anchor.append $('<i />').addClass('icon-remove icon-white pull-right')),
			# 	(-> $('.icon-remove').remove()))
			# li.click => @selecteditems.remove item
