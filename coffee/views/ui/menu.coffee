# The menu is rendered in two fases and partly re-rendered when views change
# First the static elements of the menu are rendered.
# Second the user menu is rendered after the user is loaded from the server (cookieSession) or logged in.
# When the page changes, the breadcrumbs and the active menu item are re-rendered

define (require) ->
	BaseView = require 'views/base'
	currentUser = require 'models/CurrentUser'

	tpl = require 'text!html/ui/menu.html'
	tplUserMenu = require 'text!html/ui/menu.user.html'
	ev = require 'EventDispatcher'
	h = require 'helper'

	class vMenu extends BaseView

		'events':
			'click .logout': 'logout'

		logout: ->
			currentUser.logout()

		initialize: ->
			ev.on 'newRoute', @renderBreadcrumbs, @
			ev.on 'newRoute', @renderActiveMenu, @

			@render()

		render: ->
			@$el.html _.template tpl
			@renderUserMenu() if currentUser.authorized
			$('body').prepend @$el

		renderUserMenu: ->
			rtpl = _.template tplUserMenu, currentUser.toJSON()

			@$('.navbar-inner .container').append rtpl

		renderBreadcrumbs: (breadcrumbs) ->			
			a = $('<a />').attr('href', '/').html 'Home'
			span = $('<span />').addClass('divider').html '/'
			li = $('<li />').append(a).append(span)
			@$('ul.breadcrumb .container').html li

			for own title, path of breadcrumbs
				a = $('<a />').attr('href', path).html title
				span = $('<span />').addClass('divider').html "/"
				li = if path is '' then $('<li />').html(title).addClass('active') else $('<li />').append(a).append(span)
				@$('ul.breadcrumb .container').append li

		# BIND TO CLICK EVENT WHEN ITEM CLICKED ACTIVATE ITEM PLUS PARENT
		# BUT HOW IS THE MENU ACTIVATED ON PAGE RENDER? :)
		renderActiveMenu: (breadcrumbs) ->
			lis = @$('ul.nav li')
			lis.removeClass 'active'
			
			if _.isEmpty breadcrumbs
				lis.first().addClass('active')
			else
				for own title, path of breadcrumbs
					for li in lis
						a = $(li).children()[0] # Get the anchors from the li items to compare the innerText
						$(li).addClass('active') if $(a).text() is title
					break

