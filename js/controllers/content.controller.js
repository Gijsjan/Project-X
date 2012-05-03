App.ContentController = {
	deleteContent: function(args) {
		//if (args.model.get('user_id') !== App.user.get('id')) { App.EventDispatcher.trigger('unauthorized'); }
		//else {
		console.log(args.e);
			var types = args.model.get('type')+'s';
			if(confirm('Are you sure you want to delete '+ args.model.get('type') +' '+args.model.get('id')+'?')) {
				args.model.destroy({
					success: function() {
						App.EventDispatcher.trigger('showContentCollection', {types: types});
					},
					error: function(model, response) {
						console.log(response);
					}
				});		
			}
		//}
	}
};