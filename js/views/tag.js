App.Views.TagList = Backbone.View.extend({
	tagName: 'ul',
	className: 'tags',
	template: _.template($('#tplTagList').html()),
	render: function() {
		var html = this.template({ "tags": this.options.tags });
		this.$el.html(html);
		
		return this;
	}
});

App.Views.EditTagList = Backbone.View.extend({
	events: {
		"click span.del-tag": "deleteTag",
		"click": "seeIt"
	},
	seeIt: function(e) {
		console.log(e);
	},
	deleteTag: function(e) {
		this.options.parent.deleteTag(e);
	},
	tagName: 'ul',
	className: 'edit-tag-list',
	template: _.template($('#tplEditTagList').html()),
	render: function() {	
		var html = this.template({ "tags": this.collection });
		this.$el.html(html);
		
		return this;
	}
});

App.Views.AutocompleteTags = Backbone.View.extend({
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
		})
		
		return this;
	},
	close: function() {
		this.$el.html('');
		this.selected = false;
	},
	onEnter: function() {
		var v = this.parent.inputValue;
		if (this.selected) v = this.$('.selected').text()
		this.parent.addTag(v);
	},
	onUp: function() {
		var s = this.$('.selected');
		var first = this.$('.ac-tag:first');
		var last = this.$('.ac-tag:last');
		this.selected = true;
		
		if (s.length == 0) { last.addClass('selected'); } 
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
		
		if (s.length == 0) { first.addClass('selected'); } 
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
			$.getJSON('/ac_tags/'+iv, function(tags) {
				self.fetchedTagLists[iv] = tags;
				self.render(tags);
			});
		} else {
			self.render(self.fetchedTagLists[iv]);
		}
	}
});

App.Views.EditTags = Backbone.View.extend({
	id: 'edit-tags',
	template: _.template($('#tplEditTags').html()),
	events: {
		"keyup input#add-tag": "onKeyup",
		"blur input#add-tag": "closeAC"
	},
	initialize: function() {
		this.inputValue = '';
		
		this.tags = this.model.get('newtags');
		this.edit_tag_list = App.Views.editTagList = new App.Views.EditTagList({'parent': this, 'collection': this.tags});
		this.tags.bind("add", this.edit_tag_list.render, this.edit_tag_list);
		this.tags.bind("remove", this.edit_tag_list.render, this.edit_tag_list);
		
		/*
		this.countries = this.model.get('countries');
		this.edit_country_list = App.Views.editCountryList = new App.Views.EditTagList({'parent': this, 'collection': this.countries});
		this.countries.bind("add", this.edit_country_list.render, this.edit_country_list);
		this.countries.bind("remove", this.edit_country_list.render, this.edit_country_list);
		*/
		this.ac_tags = new App.Views.AutocompleteTags({'parent': this});
	},
	render: function() {
		this.$el.html(this.template());
		
		this.$('#edit-tag-list-wrapper').html(this.edit_tag_list.render().el);
		//this.$('#edit-country-list-wrapper').html(this.edit_country_list.render().el);
		
		this.$('#autocomplete_wrapper').html(this.ac_tags.render().el);
		
		return this;
	},
	closeAC: function() {
		this.ac_tags.close();
	},
	onKeyup: function(e) {
		var v = e.target.value;
		var kc = e.keyCode;
		
		if (kc == 188) { this.addTag(v); } //comma
		else if (kc == 40) { this.ac_tags.onDown(); }
		else if (kc == 38) { this.ac_tags.onUp(); }
		else if (kc == 13) { this.ac_tags.onEnter(); }
		else if (kc == 27) { this.closeAC(); } //escape
		else if (v.length > 1) { 
			if (this.inputValue != v) {
				this.inputValue = v;
				this.ac_tags.getTagList();
			}
		} 
		else { this.closeAC(); }
	},
	clearInput: function() {
		$('input#add-tag').val('');
	},
	addTag: function(value) {
		var tag = $.trim(value); //trim whitespaces
		if (tag.indexOf(',') > 0) tag = tag.slice(0, tag.indexOf(',')); //remove trailing comma
		
		if (tag.length > 1) {
			var ftl = this.ac_tags.fetchedTagLists[this.inputValue]; //get last used taglists from AutocompleteView using the inputValue
			var tag_obj = _.find(ftl, function(obj) { return obj.slug.toLowerCase() == tag.toLowerCase(); }); //check if tag is in used taglists
			if (!tag_obj) tag_obj = {'slug': tag, 'type': 'tag'}; //if not, make new tag object

			this.tags.add(tag_obj);
		}
		
		this.closeAC();
		this.clearInput();
	},
	deleteTag: function(e) {
		var text = $(e.target.parentElement).text().slice(0, -2); //remove space and 'x' => image instead?
		var t = this.tags.find(function(tag) { return tag.get('slug') == text}); //find the model of the tag to remove

		if (t) this.tags.remove(t);
		
		this.closeAC();
	}
});