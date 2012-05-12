App.MainController = {
	unauthorized: function() {
		App.Routers.object.navigate('unauthorized');

		$('#main').html($('<i />').html('unauthorized'));
	}
};