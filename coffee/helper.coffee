define (require) ->
	$ = require 'jquery'
	_ = require 'underscore'
	Backbone = require 'backbone'

	content_objects: ['note', 'video', 'link', 'document', 'event', 'format']

	objects: ['user', 'tag', 'comment', 'country']

	groups: ['departement', 'organisation', 'project']
	
	ucfirst: (string) ->
		string.charAt(0).toUpperCase() + string.slice(1);
	
	getParentType: (object_type) ->
		if ($.inArray(object_type, this.content_objects) > -1) then 'content' else 'object'
	
	### DEP ###
	saveToLocalStorage: (attributes) ->
		localStorage.clear()

		_.each attributes, (value, key) ->
			if typeof value is 'string' or typeof value is 'number'
				localStorage[Backbone.history.fragment+'|'+key] = value

	slugify: (value) ->
		strip = /[^\w\s-.]/g
		hyphenate = /[-\s]+/g

		value = value.replace(strip, '').trim().toLowerCase();
		value = value.replace(hyphenate, '-');
		
		value

	deepCopy: (object) ->
		$.extend true, {}, object

	logObj: (object) ->
		console.log @deepCopy(object)

	delay: (ms, callback) ->
		setTimeout callback, ms

	delayWithReset: do ->
		timer = 0

		(ms, callback) ->
			clearTimeout (timer)
			timer = setTimeout(callback, ms)

	date2datetime: (date) ->
		date.getUTCFullYear() + '-' + ('00' + (date.getUTCMonth()+1)).slice(-2) + '-' + date.getUTCDate() + ' ' + ('00' + date.getUTCHours()).slice(-2) + ':' + ('00' + date.getUTCMinutes()).slice(-2) + ':' + ('00' + date.getUTCSeconds()).slice(-2)

	datetime2date: (datetime) ->
		m = datetime.match /(\d+)/g
		new Date m[2], m[1] - 1, m[0], m[3], m[4], m[5]

	toPercentage: (amount = 0) ->
		amount = amount.toString().match /[1-9][0-9]*/ # Regexp must have a string, so if an int is given, convert to string
		amount = if 0 <= parseInt(amount) <= 100 then amount else 0 # If amount is smaller then zero or bigger than hundred amount is zero
		amount + '%' # Add % and return string

	getSumFromInputs: (inputs) ->
		total = 0
		
		for input, index in inputs
			value = $(input).val().match /[1-9][0-9]*/
			total = total + parseInt value if value?

		total