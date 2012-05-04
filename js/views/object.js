App.Views.FullObject = Backbone.View.extend({
	events: {
		"click .edit" : "edit",
		"click .new" : "add",
		"click .delete" : "deleteContent"
	},
	edit: function(e) {
		//App.EventDispatcher.trigger('editContent', {type: this.options.object_type, id: this.options.object_id});
		App.ObjectController.edit(this.options.object_type, this.options.object_id); 
	},
	add: function(e) {
		App.EventDispatcher.trigger('addContent', {type: this.options.object_type});
	},
	deleteContent: function(e) {
		App.EventDispatcher.trigger('deleteContent', {model: this.model, e: e});
	},
	initialize: function() {
		var self = this;
		this.model = new App.Models[_.ucfirst(this.options.object_type)]({id: this.options.object_id}); // create new instance article from App.Models.Article
		
		_.fetchModel2(this.model, function(model) {
			self.render();
		});
	},
	render: function() {
		this.$el.html(_.renderTemplate('Full', this.model));
		
		return this;
	}
});

App.Views.EditObject = Backbone.View.extend({
	events: {
		"change input.bind": "valueChanged",
		"change textarea.bind": "valueChanged",
		"change select.bind": "valueChanged",
		"click #sSubmit": "saveModel"
	},
	valueChanged: function(e) {
		this.model.set(e.target.id, e.target.value);
	},
	render: function() {
		var html = _.renderTemplate('Edit', this.model);
		$(this.el).html(html);
		
		return this;
	},
	saveModel: function() {
		_.saveToLocalStorage(this.model.attributes);

		this.model.save({}, {
			success: function(model, response) {
				App.ObjectController.show(model.get('type'), model.get('id'));
			},
			error: function(model, response) {
				console.log(response);
			}
		});
		
		return false;
	}
});