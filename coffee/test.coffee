define (require) ->
	
	class Test
		that: (variable) ->
			@variable = variable
			@

		exists: ->
			console.log '[Test] variable does not exist' if not @variable?
			@

	new Test()