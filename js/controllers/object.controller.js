App.ObjectController = {
	add: function(object_type) {
		$('#main').html('');
		App.Routers.object.navigate(object_type+'/add');
		
		var editfunction = (App.Views['Edit'+_.ucfirst(object_type)] instanceof Function) ? App.Views['Edit'+_.ucfirst(object_type)] : App.Views.EditObject; 
		App.Views.addObject = new editfunction({
			object_type: object_type,
			className: 'content '+object_type, 
			model:new App.Models[_.ucfirst(object_type)]()
		});
		$('#main').html(App.Views.addObject.render().el);
	},
	edit: function(object_type, id) {
		$('#main').html('');
		App.Routers.object.navigate(object_type+'/edit/'+id);
		
		var parent_type = _.getParentType(object_type);

		_.fetchModel(object_type, id, function(model) {
			//if (model.get('user_id') !== App.user.get('id')) { App.EventDispatcher.trigger('unauthorized'); }
			//else {
				//add parent_type
				var editfunction = (App.Views['Edit'+_.ucfirst(object_type)] instanceof Function) ? App.Views['Edit'+_.ucfirst(object_type)] : App.Views['Edit'+_.ucfirst(parent_type)]; // ? EditDocument : EditContent/Object

				App.Views.edit = new editfunction({
					id: 'object-'+id, 
					object_id: id,
					object_type: object_type,
					className: parent_type+' '+object_type,
					model:model
				});
				$('#main').html(App.Views.edit.render().el);
			//}
		});		
	},
	show: function(object_type, id) {
		$('#main').html('');
		App.Routers.object.navigate(object_type+'/'+id);

		var parent_type = _.getParentType(object_type); // get parent of the object (ie user -> object, document -> content)

		App.Views.full = new App.Views['Full'+_.ucfirst(parent_type)]({ // new App.Views.FullContent or new App.Views.FullObject
			object_type: object_type,
			object_id: id,
			className: parent_type+' '+object_type,
			id: 'object-'+id,
		});
		$('#main').html(App.Views.full.el);
	},
	collection: function(object_types) {
		$('#main').html('');
		App.Routers.object.navigate(object_types);
		
		var v = new App.Views.ContentList({'collection': new App.Collections[_.ucfirst(object_types)]()});
		$('#main').append(v.el);
	}
}