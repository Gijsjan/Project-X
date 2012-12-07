define (require) ->
    # $ = require 'jquery'
    # _ = require 'underscore'
    Backbone = require 'backbone'

    modelManager = require 'ModelManager'
    collectionManager = require 'CollectionManager'
    viewManager = require 'ViewManager'
    # AjaxManager = require 'ajaxmanager'

    # mPerson = require 'models/person'
    vMenu = require 'views/main/menu'

    DepartmentsRouter = require 'routers/departments'
    OrganisationsRouter = require 'routers/organisations'
    PeopleRouter = require 'routers/people'
    NotesRouter = require 'routers/notes'
    MainRouter = require 'routers/main'
    AdminRouter = require 'routers/admin'
    # ContentRouter = require 'routers/content'
    # vLogin = require 'views/main/login'
    
    hlpr = require 'helper'

    initialize: ->
        
        # routeHistory = []
        # localStorage.clear()

        # globalEvents = _.extend {}, Backbone.Events

        # modelManager = new ModelManager()
        # collectionManager = new CollectionManager()
        # viewManager = new ViewManager(globalEvents)
        # ajaxManager = new AjaxManager()
        
        # Backbone.Model::modelManager = modelManager
        # Backbone.Model::collectionManager = collectionManager
        # Backbone.Model::globalEvents = globalEvents
        # Backbone.Model::ajaxManager = ajaxManager

        # Backbone.Collection::modelManager = modelManager
        # Backbone.Collection::collectionManager = collectionManager

        # Backbone.View::routeHistory = routeHistory
        # Backbone.View::modelManager = modelManager
        # Backbone.View::collectionManager = collectionManager
        # Backbone.View::ajaxManager = ajaxManager
        # Backbone.View::globalEvents = globalEvents
        Backbone.View::screenwidth = $(document).width()
        Backbone.View::screenheight = $(document).height()
        # Backbone.View::navigate = (loc) -> mainRouter.navigate loc, 'trigger': true # Set a generic navigate function for all views

        # Backbone.Router::globalEvents = globalEvents
        # Backbone.Router::viewManager = viewManager
        # Backbone.Router::ajaxManager = ajaxManager
        #Backbone.Router::currentView = currentView

        new vMenu()
        # currentUser = new mPerson()
        # currentUser.authorize() # load new user and check if a login cookie is set (and the user can be savely loaded)

        # Initiate the Routers
        # contentRouter = new ContentRouter()

        adminRouter = new AdminRouter()
        departmentsRouter = new DepartmentsRouter()
        organisationsRouter = new OrganisationsRouter()
        peopleRouter = new PeopleRouter()
        notesRouter = new NotesRouter()
        mainRouter = new MainRouter() # define mainRouter after objectRouter so mainRouter's routes are used firs

        Backbone.history.start pushState: true
        # # OPT: REWRITE ONCE TO ALL ROUTERS
        # contentRouter.on 'all', (trigger, args) =>
        #     routeHistory.push Backbone.history.fragment if Backbone.history.fragment isnt 'logout' and Backbone.history.fragment isnt 'login'

        # mainRouter.on 'all', (trigger, args) =>
        #     routeHistory.push Backbone.history.fragment if Backbone.history.fragment isnt 'logout' and Backbone.history.fragment isnt 'login'

        ### MOVE TO VIEWMANAGER ###
        # Set the onhashchange to detect changes by the user in the url hash
        # currentView = new Backbone.View() # The currentView is populated from the Routers
        # window.onhashchange = (e) -> 
            # globalEvents.trigger 'hashchange', 'hash': e.currentTarget.location.hash.substr(1)
        # Enable pushState    

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

        div = $('<div />').html('modelManager').on 'click', -> console.log hlpr.deepCopy(modelManager.models)
        $('#webdev').append div

        div = $('<div />').html('collectionManager').on 'click', -> console.log hlpr.deepCopy(collectionManager.collections)
        $('#webdev').append div

        div = $('<div />').html('curView -> relations').on 'click', -> console.log hlpr.deepCopy(viewManager.currentView.model.relations)
        $('#webdev').append div
        
        div = $('<div />').html('curView -> model -> attrs').on 'click', -> console.log hlpr.deepCopy(viewManager.currentView.model.attributes)
        $('#webdev').append div

        # div = $('<div />').html('globalEvents').on 'click', -> console.log globalEvents
        # $('#webdev').append div

        # div = $('<div />').html('routeHistory').on 'click', -> console.log routeHistory
        # $('#webdev').append div

        # globalEvents.on '401', -> # Unauthorized
        #     loginView = new vLogin 'currentUser': currentUser
        #     $('div#main').html loginView.render().$el

        # globalEvents.on 'unauthorized', -> # The 'login' events triggers the route to /login
        #     loginView = new vLogin 'currentUser': currentUser
        #     $('div#main').html loginView.render().$el

        # # globalEvents.on 'loginSuccess', -> # If the login is a success, the user info is still not loaded, so re-check the login
        # #     new mPerson().checkLogin()

        # globalEvents.on 'modelSaved', (model) ->
        #     mainRouter.navigate model.get('type')+'/'+model.get('id'), 
        #         'trigger': true

        # globalEvents.on 'modelRemoved', (model) ->
        #     mainRouter.navigate model.get('type'), 
        #         'trigger': true