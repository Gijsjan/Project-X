define([
    'jquery',
    'underscore',
    'backbone',
    'switchers/templates.edit',
    'helper'
], function($, _, Backbone, EditTemplates, helper) {
	return Backbone.View.extend({
		events: {
			"change input.bind": "valueChanged",
			"change textarea.bind": "valueChanged",
			"change select.bind": "valueChanged",
			"click #sSubmit": "saveModel"
		},
		valueChanged: function(e) {
			this.model.set(e.target.id, e.target.value);
		},
		initialize: function() {
			var self = this;
			
			if (this.model.get('id')) {
				this.model.fetch({ // fetch model from newly created instance
					success: function(model, response) {
						self.render();
					},
					error: function(model, response) {
						if (response.status == 401) self.navigate('login');
					}
				});
			}
		},
		render: function() {
			var html = _.template(EditTemplates[this.model.get('type')], this.model.toJSON());

			$(this.el).html(html);

			return this;
		},
		saveModel: function() {
			console.log('lala');
			var self = this;
			
			helper.saveToLocalStorage(this.model.attributes);

			this.model.save({}, {
				success: function(model, response) {
					//App.ObjectController.show(model.get('type'), model.get('id'));
					self.navigate(model.get('type') + '/' + model.get('id'));
				},
				error: function(model, response) {
					if (response.status == 401) self.navigate('login');
				}
			});
			
			return false;
		}
	});
});