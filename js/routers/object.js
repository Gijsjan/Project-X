define([
    'jquery',
    'underscore',
    'backbone',
    'switchers/views.edit',
    'switchers/views.full',
    'switchers/collections',
    'switchers/models',
    'views/content/list',
    'helper'
], function($, _, Backbone, EditViews, FullViews, Collections, Models, vContentList, helper) {
	return Backbone.Router.extend({
		routes: {
			":object_type/add": "edit",
			":object_type/edit/:id": "edit",
			":object_type/:id": "show",
			":object_types": "collection"
		},
		add: function(object_type) {
			var parent_type = helper.getParentType(object_type);

			var data = {
				object_type: object_type,
				className: parent_type+' '+object_type,
				model: new Models[object_type]()
			};

			var add = new EditViews[object_type](data);

			$('div#main').html(add.render().el);
		},
		show: function(object_type, id) {
			//$('#main').html('');
			//App.Routers.object.navigate(object_type+'/'+id);

			var parent_type = helper.getParentType(object_type); // get parent of the object (ie user -> object, document -> content)

			var data = {
				object_type: object_type,
				object_id: id,
				className: parent_type+' full '+object_type,
				id: 'object-'+id,
				model: new Models[object_type]({id: id})
			};

//console.log(FullViews[object_type]);
			//var full = (parent_type == 'object') ? new vFullObject(data) : new vFullContent(data);

			var full = new FullViews[object_type](data);

			$('div#main').html(full.el);
		},
		edit: function(object_type, id) {
			var parent_type = helper.getParentType(object_type);

			var data = {
				object_type: object_type,
				className: parent_type+' edit '+object_type,
				model: new Models[object_type]()
			};

			if (id) {
				data['id'] = 'object-'+id;
				data['object_id'] = id;
				data['model'] = new Models[object_type]({id: id});
			} else {
				data['model'] = new Models[object_type]();
			}

			var ev = new EditViews[object_type](data);

			$('div#main').html(ev.render().$el);
		},
		collection: function(object_types) {
			var v = new vContentList({'collection': new Collections[object_types]()});
			$('div#main').html(v.el);
		}
	});
});