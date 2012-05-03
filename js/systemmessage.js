/**
 * 
 */
App.SystemMessageView = Backbone.View.extend({
	id: 'systemmessage',
	initialize: function() {
		$(this.el).prependTo($('#header'));
	},
	events: {
		"click": "hideSystemMessage"
	},
	//showSuccess gets this.message from setting App.systemmessage.setMessage
	showSuccess: function() {
		if (!this.message) {
			this.showError('No message set, use App.systemmessage.setMessage(var) before calling model.save().');
			return false;
		}
		var self = this;
		
		$(this.el).addClass('success');
		$(this.el).html(this.message);
		$(this.el).slideDown('slow', function() {
										setTimeout(function() { self.hideSystemMessage(); }, 1000);
									});
	},
	//showError get's message automagically from BaseModel
	showError: function(message) {
		$(this.el).addClass('error');
		$(this.el).html(message);
		$(this.el).slideDown('slow');
	},
	hideSystemMessage: function() {
		var self = this;
		
		$(this.el).slideUp('slow', function() {
										$(this.el).removeClass();
										$(this.el).html('');
										self.message = '';
									});
		
	},
	setMessage: function(message) {
		this.message = message;
	}
});