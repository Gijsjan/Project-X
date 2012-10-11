http = require 'http'
url = require 'url'
jsdom = require 'jsdom'

http.createServer( (request, response) ->
	urlparts = url.parse request.url, true
	path = urlparts.pathname
	console.log path

	if path is '//getheadings/'
		jsdom.env urlparts.query.url, ['http://ajax.googleapis.com/ajax/libs/jquery/1.8.0/jquery.min.js'], (errors, window) ->
			$ = window.$
			
			h1 = $.map($('h1'), (h1, i) -> $(h1).text().replace(/\s+/g, " ").trim())
			h2 = $.map($('h2'), (h2, i) -> $(h2).text().replace(/\s+/g, " ").trim())
			
			response.writeHead 200, 'Content-Type': 'application/json'
			response.end JSON.stringify('h1': h1, 'h2': h2)
	else
		response.writeHead 200, 'Content-Type': 'text/html'
		response.end 'error'
).listen(3000, '127.0.0.1')

console.log 'Server running at http://127.0.0.1:3000/'