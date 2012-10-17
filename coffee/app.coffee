define (require) ->
    $ = require 'jquery'
    _ = require 'underscore'
    Backbone = require 'backbone'
    ModelManager = require 'modelmanager'
    CollectionManager = require 'collectionmanager'
    ViewManager = require 'viewmanager'
    AjaxManager = require 'ajaxmanager'
    mUser = require 'models/object/user'
    vMenu = require 'views/main/menu'
    UserRouter = require 'routers/user'
    GroupRouter = require 'routers/group'
    ContentRouter = require 'routers/content'
    MainRouter = require 'routers/main'
    hlpr = require 'helper'

    initialize: ->
        routeHistory = []
        localStorage.clear()

        globalEvents = _.extend {}, Backbone.Events

        modelManager = new ModelManager()
        collectionManager = new CollectionManager()
        viewManager = new ViewManager(globalEvents)
        ajaxManager = new AjaxManager(globalEvents)
        
        Backbone.Model::modelManager = modelManager
        Backbone.Model::globalEvents = globalEvents

        Backbone.Collection::collectionManager = collectionManager
        Backbone.Collection::removeByCid = (cid) ->
            model = @getByCid(cid)
            @remove model

        Backbone.View::routeHistory = routeHistory
        Backbone.View::modelManager = modelManager
        Backbone.View::collectionManager = collectionManager
        # Backbone.View::ajaxManager = ajaxManager
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

        # OPT: REWRITE ONCE TO ALL ROUTERS
        contentRouter.on 'all', (trigger, args) =>
            routeHistory.push Backbone.history.fragment if Backbone.history.fragment isnt 'logout' and Backbone.history.fragment isnt 'login'

        mainRouter.on 'all', (trigger, args) =>
            routeHistory.push Backbone.history.fragment if Backbone.history.fragment isnt 'logout' and Backbone.history.fragment isnt 'login'

        ### MOVE TO VIEWMANAGER ###
        # Set the onhashchange to detect changes by the user in the url hash
        currentView = new Backbone.View() # The currentView is populated from the Routers
        # window.onhashchange = (e) -> 
            # globalEvents.trigger 'hashchange', 'hash': e.currentTarget.location.hash.substr(1)

        # Enable pushState    
        Backbone.history.start pushState: true

        $(document).on 'click', 'a:not([data-bypass])', (e) ->
            # mainRouter.lastRoute = Backbone.history.fragment # store the previous route in the mainRouter (property is also available in objectRouter)
            
            href = $(@).attr 'href'
            if href?
                if href.charAt(0) is '#'
                    window.location.hash = href
                    href = Backbone.history.fragment

                e.preventDefault()

                options = 'trigger': true
                options['replace'] = true if href is '/logout' or href is '/login'

                mainRouter.navigate href, options

        currentUser = new mUser().login()

        new vMenu()

        div = $('<div />').html('viewManager').on 'click', -> viewManager.viewsToLog()
        $('#webdev').append div

        div = $('<div />').html('modelManager').on 'click', -> console.log hlpr.deepCopy(modelManager.models)
        $('#webdev').append div

        div = $('<div />').html('collectionManager').on 'click', -> console.log hlpr.deepCopy(collectionManager.collections)
        $('#webdev').append div

        div = $('<div />').html('curView').on 'click', -> viewManager.currentViewToLog()
        $('#webdev').append div
        
        div = $('<div />').html('curView -> model -> attrs').on 'click', -> console.log hlpr.deepCopy(viewManager.currentView.model.attributes)
        $('#webdev').append div

        div = $('<div />').html('globalEvents').on 'click', -> console.log globalEvents
        $('#webdev').append div

        div = $('<div />').html('routeHistory').on 'click', -> console.log routeHistory
        $('#webdev').append div