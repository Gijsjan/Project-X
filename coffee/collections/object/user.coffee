define (require) ->
	_ = require 'underscore'
	BaseCollection = require 'collections/base'
	mUser = require 'models/object/user'

	class cUser extends BaseCollection

		model: mUser