define (require) ->
	NoteMin = require 'models/content/note.min'

	class NoteFull extends NoteMin

		validate: (attrs, options) ->
			errors = {}

			if _.isEmpty attrs.title
				errors.title = 'There is no title.'

			if _.isEmpty attrs.body
				errors.body = 'There is no body.'

			if not _.isEmpty errors
				return errors
