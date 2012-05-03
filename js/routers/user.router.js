App.UserRouter = Backbone.Router.extend({
	routes: {
		"user/add": "addUser",
		"user/edit/:username": "editUser",
		"user/:username": "showUser",
		"users": "showUsers"
	},
	addUser: function() {
		App.UserController.addUser();
	},
	editUser: function(username) {
		App.UserController.edit(username);
	},
	showUser: function(username) {
		App.UserController.show({username: username});
	},
	showUsers: function() {
		App.ContentController.collection({types: 'users'});
	}
});