define([
    'backbone',
    'markdown',
    'views/content/full'
], function(Backbone, Markdown, vFullContent) {
	return vFullContent.extend({
		render: function() {
			var body = new Markdown.Converter().makeHtml(this.model.get('body'));
			this.model.set('body', body);
			
			vFullContent.prototype.render.apply(this);
		}
	});
});