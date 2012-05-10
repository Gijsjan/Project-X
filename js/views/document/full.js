define([
    'backbone',
    'views/content/full'
], function(Backbone, vFullContent) {
	return vFullContent.extend({
		render: function() {
			vFullContent.prototype.render.apply(this);
		}
	});
});