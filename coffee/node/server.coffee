http = require 'http'
fs = require 'fs'

http.createServer( (request, response) ->
	base = '../..'
	url = request.url.split '/'

	switch url[1]

		when 'api'
			data =
				'lala': 'loloala'
				'lelel': 'lilial'

			stringy = JSON.stringify(data)

			response.writeHead 200,
				'Content-Length': stringy.length
				'Content-Type': 'application/json'

			response.end stringy

		when 'js'
			fs.readFile base+request.url, 'utf8', (err, js) ->
				if (err)
					throw err

				response.writeHead 200,
					'Content-Type': 'application/javascript'

				response.end js

		when 'css'
			fs.readFile base+request.url, 'utf8', (err, css) ->
				if (err)
					throw err

				response.writeHead 200,
					'Content-Type': 'text/css'

				response.end css

		when 'templates'
			fs.readFile base+request.url, 'utf8', (err, html) ->
				if (err)
					throw err

				response.writeHead 200,
					'Content-Type': 'text/html'

				response.end html

		else
			fs.readFile '../../index.html', 'utf8', (err, html) ->
				if (err)
					throw err

				response.writeHead 200,
					'Content-Type': 'text/html'

				response.end html

).listen 80

console.log 'Server running at http://127.0.0.1:80/'