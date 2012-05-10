// app.js
define([
    'jquery',
    'underscore',
    'backbone',
    'views/main/menu',
    'routers/main',
    'routers/object'
], function($, _, Backbone, vMenu, MainRouter, ObjectRouter) {
    return {
        initialize: function() {
            $('header').html(new vMenu().render().el);

            var objectRouter = new ObjectRouter();
            var mainRouter = new MainRouter();
            

            Backbone.View.prototype.navigate = function(loc) {
                mainRouter.navigate(loc, true);
            };

            Backbone.history.start({pushState: true});

            $(document).on('click', 'a:not([data-bypass])', function (evt) {
                var href = $(this).attr('href');
                var protocol = this.protocol + '//';

                if (href.slice(protocol.length) !== protocol) {
                    evt.preventDefault();
                    mainRouter.navigate(href, true);
                }
            });

        }
    };
});

