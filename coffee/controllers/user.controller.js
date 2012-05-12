App.UserController = {
	/*
	addUser: function() {
		$('#main').html('');
		App.Routers.user.navigate('user/add');
		
		App.Views.addUser = new App.Views.EditUser({
			object_type: 'user',
			className: 'content user',
			model: new App.Models.User()
		});
		$('#main').html(App.Views.addUser.render().el);
	},
	*/
	show: function(args) {
		$('#main').html('');
		App.Routers.user.navigate('user/'+args.username);
		
		App.Views.fullUser = new App.Views.FullModel({
			object_type: 'user',
			className: 'content user',
			object_id: args.username
		});
		$('#main').html(App.Views.fullUser.el);
	}
};