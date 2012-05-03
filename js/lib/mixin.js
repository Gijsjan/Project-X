_.mixin({
	/*
	findIndex: function(obj, iterator, context) {
		var result;
		_.any(obj, function(value, index, list) {
			if(iterator.call(context, value, index, list)) {
				result = index;
				return true;
			}
		});
		return result;
	},
	*/
	ucfirst: function(string) {
		return string.charAt(0).toUpperCase() + string.slice(1);
	},
	getParentType: function(object_type) {
		return ($.inArray(object_type, App.contents) > -1) ? 'content' : 'object';
	},
	fetchModel: function(object_type, object_id, callback) {
		App.Models[object_type] = new App.Models[_.ucfirst(object_type)]({id: object_id}); // create new instance article from App.Models.Article
		
		App.Models[object_type].fetch({ // fetch model from newly created instance
			success: function(model, response) {
				callback(model);
			},
			error: function(model, response) {
				console.log(response);
			}
		});
	},
	fetchModel2: function(instance, callback) {
		instance.fetch({ // fetch model from newly created instance
			success: function(model, response) {
				callback();
			},
			error: function(model, response) {
				console.log(response);
			}
		});
	},
	fetchCollection: function(object_types, callback) {
		App.Collections[object_types] = new App.Collections[_.ucfirst(object_types)]();
		
		App.Collections[object_types].fetch({
			success: function(collection, response) {
				callback(collection);
			},
			error: function(collection, response) {
				console.log(response);
			}
		});
	},
	/*
	 * instance = instance of Backbone.Collection
	 */
	fetchCollection2: function(instance, callback, self) {
		instance.fetch({
			data: {
				user_id: App.user.get('id')
			},
			success: function(collection, response) {
				callback(collection, self);
			},
			error: function(collection, response) {
				console.log(response);
			}
		});
	},
	renderTemplate: function(template_type, model) {
		var template_id = '#tpl' + template_type + _.ucfirst(model.get('type'));
		var template_html = $(template_id).html();

		return _.template(template_html, model.toJSON());
	},
	renderTags: function(model) {
		if (model.get('tags') !== undefined && model.get('countries') !== undefined) { 
			var tags = new App.Views.TagList({ tags: model.get('newtags') });
			//var tags = new App.Views.TagList({ tags: model.get('tags'), type: 'tag' });
			//var countries = new App.Views.TagList({ tags: model.get('countries'), type: 'country' });		
			


			var wrapper = $('<div />').addClass('tags_wrapper');
			wrapper.html(tags.render().el);
			//wrapper.append(countries.render().el);

			return wrapper;
		}
	},
	renderComments: function(model) {
		if (model.get('comments') !== undefined) {
			var manyComments = new App.Views.ManyComments({ model: model });

			return manyComments.render().el;
		}
	},
	renderFullInfobar: function(created) {
		return _.template($('#tplFullInfobar').html(), {'created': created});
	},
	renderListedInfobar: function(created, commentcount) {
		return _.template($('#tplListedInfobar').html(), {
			'created': created,
			'commentcount': commentcount
		});
	}
});