define([
    'jquery',
    'underscore',
    'backbone',
    'views/content/edit'
], function($, _, Backbone, vEditContent) {
	return vEditContent.extend({
		events: _.extend({}, vEditContent.prototype.events, {
			"paste .address": "getPageContents",
			"change .possible_title_checkbox": "onLinkSelected",
			"click #submit_title": "onLinkSelected"
		}),
		onLinkSelected: function(e) {
			var selected_title = (!e.currentTarget.value) ? this.$('#title').val() : e.currentTarget.value;
			this.model.set('title', selected_title);

			this.render();
			this.$('#part1').hide();
			this.$('#part2').hide();
			this.$('#part3').show();
		},
		getPageContents: function(e) {
			var expression = /[-a-zA-Z0-9@:%_\+.~#?&//=]{2,256}\.[a-z]{2,4}\b(\/[-a-zA-Z0-9@:%_\+.~#?&//=]*)?/gi;
			var regex = new RegExp(expression);
			var url = '';
			var self = this;
			
			setTimeout(function() {
				url = $(e.currentTarget).val();
				
				if (url.match(regex) ) {
					$.post(	'/api/upload_link.php',
							{
								url: url
							},
							function(data) {
								if (data.id === undefined) {
									self.model.set(data);
									console.log(self.model);
									self.render();
									self.$('#part1').hide();
									self.$('#part2').show();
									self.$('#part3').hide();
								} else {
									self.model.set(data);
									self.render();
									self.$('#part1').hide();
									self.$('#part2').hide();
									self.$('#part3').show();
								}
							},
							"json"
					);
				} else {
					alert("No match");
				}
			}, 0);
		},
		render: function() {
			vEditContent.prototype.render.apply(this);

			if (!this.model.get('id')) {
				this.$('#part1').show(); }
			else {
				this.$('#part3').show(); }

			return this;
		}

	});
});