define([
    'jquery',
    'underscore',
    'backbone',
    'text!../../../templates/tag/list'
], function($, _, Backbone, tplTagList) {
	return Backbone.View.extend({
		id: 'ac-tag-list',
		initialize: function() {
			this.parent = this.options.parent;
			this.fetchedTagLists = {};
			this.selected = false;
		},
		render: function(tags) {
			var self = this;
			this.close();
			
			_.each(tags, function(tag) {
				$(self.el).append($('<div />', {'class': 'ac-tag', text: tag.slug}));
			});
			
			return this;
		},
		close: function() {
			this.$el.html('');
			this.selected = false;
		},
		onEnter: function() {
			var v = this.parent.inputValue;
			if (this.selected) v = this.$('.selected').text();
			this.parent.addTag(v);
		},
		onUp: function() {
			var s = this.$('.selected');
			var first = this.$('.ac-tag:first');
			var last = this.$('.ac-tag:last');
			this.selected = true;
			
			if (s.length === 0) { last.addClass('selected'); }
			else {
				s.removeClass('selected');
				if (first.text() == s.text()) last.addClass('selected');
				else s.prev().addClass('selected');
			}
		},
		onDown: function() {
			var s = this.$('.selected');
			var first = this.$('.ac-tag:first');
			var last = this.$('.ac-tag:last');
			this.selected = true;
			
			if (s.length === 0) { first.addClass('selected'); }
			else {
				s.removeClass('selected');
				if (last.text() == s.text()) first.addClass('selected');
				else s.next().addClass('selected');
			}
		},
		getTagList: function() {
			var self = this;
			var iv = self.parent.inputValue;
			
			if (self.fetchedTagLists[iv] === undefined) {
				$.getJSON('/api/ac_tags/'+iv, function(tags) {
					self.fetchedTagLists[iv] = tags;
					self.render(tags);
				}).error(function(response) {
					if (response.status === 401) self.navigate('login');
				});
			} else {
				self.render(self.fetchedTagLists[iv]);
			}
		}
	});
});