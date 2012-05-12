App.TagController = {
	/*
	newTag: function(type) {
		$('#main').html('');
		App.Routers[type].navigate(type+'/new');
		
		var ucType = App.Func.ucfirst(type);
		var v = new App.Views['Edit'+ucType]({model:new App.Models[ucType]()});
		$('#main').html(v.render().el);
	},
	*/
	showCountry: function(name) {
		$('#main').html('');
		App.Routers.tag.navigate('country/'+name);

		var v = new App.Views.ContentList({country: name});
		$('#main').html(v.el);
	},
	showTag: function(name) {
		$('#main').html('');
		App.Routers.tag.navigate('tag/'+name);

		var v = new App.Views.ContentList({tag: name});
		$('#main').html(v.el);
	},
	editTag: function(name) {
	/*
		$('#main').html('');
		App.Routers[type].navigate(type+'/edit/'+id);
		
		var ucType = App.Func.ucfirst(type);
		App.Func.getModel(type, id, function(model) {
			var v = new App.Views['Edit'+ucType]({model:model});
			$('#main').html(v.render().el);
		});
	*/		
	},
	showTags: function() {
	/*	
		$('#main').html('');
		App.Routers[type].navigate(type+'s');
		
		var ucType = App.Func.ucfirst(type);
		App.Func._fetchCollection(type+'s', function(collection) {
			var v = new App.Views[ucType+'s']({collection: collection});
			$('#main').html(v.render().el);
		});
	*/
	}
};