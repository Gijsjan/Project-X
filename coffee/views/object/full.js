define([
    'jquery',
    'underscore',
    'backbone',
    'switchers/models',
    'switchers/templates.full'
], function($, _, Backbone, Models, FullTemplates) {
	return Backbone.View.extend({
		events: {
			"click .edit" : "edit",
			"click .new" : "add",
			"click .delete" : "deleteContent"
		},
		edit: function(e) {
			//App.EventDispatcher.trigger('editContent', {type: this.options.object_type, id: this.options.object_id});
			//App.ObjectController.edit(this.options.object_type, this.options.object_id);
			this.navigate(this.options.object_type + '/edit/' + this.options.object_id);
		},
		add: function(e) {
			//App.EventDispatcher.trigger('addContent', {type: this.options.object_type});
			this.navigate(this.options.object_type + '/add');
		},
		deleteContent: function(e) {
			App.EventDispatcher.trigger('deleteContent', {model: this.model, e: e});
		},
		initialize: function() {
			var self = this;

			//var mdl = Models[this.options.object_type];
			//this.model = new mdl({id: this.options.object_id}); //get the correct model from Models

			this.model.fetch({ // fetch model from newly created instance
				success: function(model, response) {
					self.render();
				},
				error: function(model, response) {
					if (response.status == 401) self.navigate('login');
				}
			});
		},
		render: function() {
			var tpl = FullTemplates[this.model.get('type')];
			var tplRendered = _.template(tpl, this.model.toJSON());
			this.$el.html(tplRendered);
			
			return this;
		}

	});
});