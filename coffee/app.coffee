define (require) ->
    Backbone = require 'backbone'

    modelManager = require 'ModelManager'
    collectionManager = require 'CollectionManager'
    viewManager = require 'ViewManager'

    vMenu = require 'views/main/menu'

    GroupRouter = require 'routers/group'
    DepartmentsRouter = require 'routers/departments'
    OrganisationsRouter = require 'routers/organisations'
    PeopleRouter = require 'routers/people'
    NotesRouter = require 'routers/notes'
    MainRouter = require 'routers/main'
    AdminRouter = require 'routers/admin'
    
    hlpr = require 'helper'

    initialize: ->

        Backbone.View::screenwidth = $(document).width()
        Backbone.View::screenheight = $(document).height()

        new vMenu()

        adminRouter = new AdminRouter()
        groupRouter = new GroupRouter()
        departmentsRouter = new DepartmentsRouter()
        organisationsRouter = new OrganisationsRouter()
        peopleRouter = new PeopleRouter()
        notesRouter = new NotesRouter()
        mainRouter = new MainRouter() # define mainRouter after objectRouter so mainRouter's routes are used firs

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

        div = $('<div />').html('viewManager').on 'click', -> console.log hlpr.deepCopy(viewManager.views)
        $('#webdev').append div

        div = $('<div />').html('curView').on 'click', -> console.log hlpr.deepCopy(viewManager.currentView)
        $('#webdev').append div

        div = $('<div />').html('curView -> model').on 'click', -> console.log hlpr.deepCopy(viewManager.currentView.model)
        $('#webdev').append div
        
        div = $('<div />').html('curView -> model -> attrs').on 'click', -> console.log hlpr.deepCopy(viewManager.currentView.model.attributes)
        $('#webdev').append div