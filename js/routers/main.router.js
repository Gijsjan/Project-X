App.MainRouter = Backbone.Router.extend({
	routes: {
		"": "home",
		"unauthorized": "unauthorized"
	},
	home: function() {
		App.Views.home = new App.Views.ContentList();
		$('div#main').html(App.Views.home.el);
	},
	unauthorized: function() {
		App.EventDispatcher.trigger('unauthorized');
	}
});