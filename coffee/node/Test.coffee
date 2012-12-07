class Test

	argTypes: (@id, defaults, args) ->
		for own arg, types of defaults
			if types.indexOf(typeof args[arg]) is -1
				@_log arg + ' isn\'t of types ' + types + ', but ' + typeof args[arg]
				
	_log: (msg) ->
		console.log @id + ': ' + msg

module.exports = new Test()