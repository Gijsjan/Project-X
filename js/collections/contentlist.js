App.Collections.ContentList = Backbone.Collection.extend({
	url: 'contentlist',
	model: function(attributes, options) {
		var model = new Backbone.Model(); //default model is a normal backbone model
		if (attributes.type !== undefined) model = new App.Models[_.ucfirst(attributes.type)](attributes, options);//if type exists make an according model
		
		return model;
	}
});