App.EventDispatcher.on('showContent', App.ContentController.show);
App.EventDispatcher.on('addContent', App.ContentController.add);
App.EventDispatcher.on('editContent', App.ContentController.edit);
App.EventDispatcher.on('deleteContent', App.ContentController.deleteContent);
App.EventDispatcher.on('showContentCollection', App.ContentController.collection);

//App.EventDispatcher.on('addDocument', App.DocumentController.add);

//App.EventDispatcher.on('addLink', App.LinkController.add);

App.EventDispatcher.on('unauthorized', App.MainController.unauthorized);