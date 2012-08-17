define (require) ->
    $ = require 'jquery'
    _ = require 'underscore'
    Backbone = require 'backbone'
    ModelManager = require 'modelmanager'
    ViewManager = require 'viewmanager'
    vMenu = require 'views/main/menu'
    UserRouter = require 'routers/user'
    GroupRouter = require 'routers/group'
    ContentRouter = require 'routers/content'
    MainRouter = require 'routers/main'
    hlpr = require 'helper'

    initialize: ->
        localStorage.clear()
        
        $('header').html new vMenu().render().$el

        globalEvents = _.extend {}, Backbone.Events

        modelManager = new ModelManager(globalEvents)
        viewManager = new ViewManager(globalEvents)
        
        Backbone.Model::modelManager = modelManager
        Backbone.Model::globalEvents = globalEvents

        Backbone.View::globalEvents = globalEvents
        Backbone.View::screenwidth = $(document).width()
        Backbone.View::screenheight = $(document).height()
        Backbone.View::navigate = (loc) -> mainRouter.navigate loc, 'trigger': true # Set a generic navigate function for all views

        Backbone.Router::globalEvents = globalEvents
        #Backbone.Router::currentView = currentView


        # Initiate the Routers
        contentRouter = new ContentRouter()
        userRouter = new UserRouter()
        groupRouter = new GroupRouter()
        mainRouter = new MainRouter() # define mainRouter after objectRouter so mainRouter's routes are used first

        ### MOVE TO VIEWMANAGER ###
        # Set the onhashchange to detect changes by the user in the url hash
        currentView = new Backbone.View() # The currentView is populated from the Routers
        window.onhashchange = (e) -> currentView.trigger 'hashchange', 'hash': e.currentTarget.location.hash.substr(1)

        # Enable pushState    
        Backbone.history.start pushState: true

        $(document).on 'click', 'a:not([data-bypass])', (e) ->
            mainRouter.lastRoute = Backbone.history.fragment # store the previous route in the mainRouter (property is also available in objectRouter)
            href = $(@).attr 'href'

            e.preventDefault()
            mainRouter.navigate href, true

        div = $('<div />').html('viewManager').on 'click', -> viewManager.viewsToLog()
        $('#webdev').append div

        div = $('<div />').html('modelManager').on 'click', -> console.log hlpr.deepCopy(modelManager.models)
        $('#webdev').append div

        div = $('<div />').html('curView').on 'click', -> viewManager.currentViewToLog()
        $('#webdev').append div
        
        div = $('<div />').html('curView -> model -> attrs').on 'click', -> console.log hlpr.deepCopy(viewManager.currentView.model.attributes)
        $('#webdev').append div

        div = $('<div />').html('globalEvents').on 'click', -> console.log globalEvents
        $('#webdev').append div