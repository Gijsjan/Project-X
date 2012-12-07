class CallbackQueue

	constructor: (@queueLength, @queueCallback) ->
		@waiting = 0
		@registered = 0
		@queueResponse = {}

	register: (id) ->
		# console.log 'CallbackQueue.register: '+id
		@waiting++
		@registered++

		(response) => @callbackComplete(response, id) # return a function calling the callback with the response and the id

	callbackComplete: (callbackResponse, id) =>
		# console.log 'CallbackQueue.callbackComplete: '+id
		@waiting--

		@queueResponse[id] = if callbackResponse is 404 then [] else callbackResponse

		@queueCallback @queueResponse if @waiting is 0 and @registered is @queueLength # if all callbacks are finished, trigger the final total queueCallback

module.exports = CallbackQueue