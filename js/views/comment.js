App.Views.Comment = Backbone.View.extend({
	events: {
		"click .delete": "onDelete"
	},
	onDelete: function() {
		console.log('del');
	},
	template: _.template($('#tplComment').html()),
	render: function() {
		var rendered_html = this.template({comment: this.model.toJSON(), count: this.options.count});		
		$(this.el).html(rendered_html);

		return this;
	}
});

App.Views.ManyComments = Backbone.View.extend({
	id: 'comments',
	events: {
		"click #sComment": "addComment"
	},
	template: _.template($('#tplComments').html()),
	initialize: function() {
		this.content_id = this.options.model.get('id');
		this.comments = this.options.model.get('comments');
	},
	render: function() {
		var rendered_html = this.template($('#tplComments').html());
		
		$(this.el).html(rendered_html);
		
		var self = this;
		this.comments.each(function(model, i) {
			var c = new App.Views.Comment({
				className: 'comment',
				id: 'object-'+model.get('id'), 
				model: model, 
				count: i
			});
			console.log(c.render().el);
			self.$('#comments-wrapper').append(c.render().el);
		});
		
		return this;
	},
	addComment: function(e) {
		var self = this;
		var comment = new App.Models.Comment({
			content_id: this.content_id,
			comment: $('#commenttext').val()
		});
		comment.url = '/comment/'+this.content_id;
		comment.save({}, {
			success: function(model, response) {
				self.comments.add(model, {at: 0}); // add model to collection
				self.render(); // render manyComments
				$('#fComment').slideUp();
			},
			error: function(model, response) {
				console.log(response);
			}
		});
	}
});


