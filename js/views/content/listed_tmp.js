define([
    'jquery',
    'underscore',
    'backbone',
    'switchers/templates.listed',
    'text!../../../templates/content/listed'
], function($, _, Backbone, ListedTemplates, tplListedContent) {
    return Backbone.View.extend({
        render: function() {
            this.$el.html(_.template(tplListedContent, {type: this.model.get('type')}));
            
            var tpl = ListedTemplates[this.model.get('type')];
            var tplRendered = _.template(tpl, this.model.toJSON());
            this.$('.body').html(tplRendered);

            return this;
        }
    });
});