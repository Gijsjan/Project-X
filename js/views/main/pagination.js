define([
    'jquery',
    'underscore',
    'backbone',
    'text!../../../templates/main/pagination'
], function($, _, Backbone, tpl) {
	return Backbone.View.extend({
		currentPage: 0,
		itemsPerPage: 3,
		totalPages: 0,
		totalItems: 0,
		pageDivs: [],
		id: 'pagination-wrapper',
		events: {
			"click li.pgn-nav-elem" : "changePage2"//,
			//"click li.previous" : "changePage",
			//"click li.next" : "changePage",
			//"click li.page-number" : "gotoPage"
		},
		initialize: function() {
			this.totalItems = this.options.totalItems;
			this.totalPages = Math.ceil(this.totalItems / this.itemsPerPage);
		},
		addPage: function() {
			this.currentPage++;

			var pageDiv = $('<div />').attr('class', 'page index-'+this.currentPage);

			this.pageDivs[this.currentPage - 1] = pageDiv;
		},
		addItem: function(index, itemDiv) {
			if (index % this.itemsPerPage === 0) this.addPage();
			this.pageDivs[this.currentPage - 1].append(itemDiv);
		},
		render: function() {
			var self = this;
			this.currentPage = 1;

			this.$el.html(_.template(tpl, {totalPages: self.totalPages}));

			_.each(this.pageDivs, function(pageDiv) {
				self.$('#item-wrapper').append(pageDiv);
			});

			this.showPage(1);

			return this;
		},
		renderNavigation: function() {
			this.$('li.pgn-nav-elem').removeClass('greyed-out');


			this.$('li[data-page-number="'+this.currentPage+'"]').addClass('greyed-out');

			if (this.currentPage == 1) this.$('li.previous').addClass('greyed-out');
			if (this.currentPage == this.totalPages) this.$('li.next').addClass('greyed-out');

			/*
			this.$('li[data-page-number]').removeClass('greyed-out');

			this.$('li[data-page-number="'+this.currentPage+'"]').addClass('greyed-out');

			if (this.currentPage === 1) this.$('.previous').addClass('greyed-out');
			else this.$('.previous').removeClass('greyed-out');

			if (this.currentPage === this.totalPages) this.$('.next').addClass('greyed-out');
			else this.$('.next').removeClass('greyed-out');
			*/
			// grey out the current page_number
		},
		changePage2: function(e) {
			var target = $(e.currentTarget);

			if (!target.hasClass('greyed-out')) {
				var pagenumber = target.attr('data-page-number');

				if (pagenumber) this.showPage(pagenumber);
				else if (target.hasClass('previous')) this.showPage(this.currentPage - 1); // no need for double check, if page == 1 href is greyed out
				else if (target.hasClass('next')) this.showPage(this.currentPage + 1); // no need for double check, if page == currentpage href is greyed out
			}
		},
		changePage: function(e) {
			if (!$(e.currentTarget).hasClass('greyed-out')) {
				this.pageDivs[this.currentPage].hide();

				if ($(e.currentTarget).hasClass('next')) this.showPage(this.currentPage + 1);
				else this.showPage(this.currentPage - 1);
			}
		},
		gotoPage: function(e) {
			if (!$(e.currentTarget).hasClass('greyed-out')) {
				var pn = parseInt(e.currentTarget.innerHTML, 10);
				this.showPage(pn);
			}
		},
		showPage: function(pageNumber) {
			this.pageDivs[this.currentPage - 1].hide();

			this.currentPage = pageNumber;

			this.renderNavigation();

			this.pageDivs[this.currentPage - 1].show();
		}
	});
});