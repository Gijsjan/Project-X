define (require) ->
    $ = require 'jquery'
    _ = require 'underscore'
    Backbone = require 'backbone'
    vMenu = require 'views/main/menu'
    MainRouter = require 'routers/main'
    ObjectRouter = require 'routers/object'

    initialize: ->
        $('header').html new vMenu().render().$el

        objectRouter = new ObjectRouter()
        mainRouter = new MainRouter()

        Backbone.View.prototype.navigate = (loc) ->
            mainRouter.navigate loc, true

        Backbone.history.start pushState: true

        $(document).on 'click', 'a:not([data-bypass])', (evt) ->
            href = $(@).attr 'href'
            protocol = @protocol + '//'

            if href.slice protocol.length isnt protocol
                evt.preventDefault()
                mainRouter.navigate href, true

        return