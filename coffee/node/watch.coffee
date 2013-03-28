fs = require 'fs'
util = require 'util'
exec = require('child_process').exec

try
	_ = require 'lodash'
catch err
	throw new Error "\n\nI love Lo-Dash, don't you?\n\n"

console.log "Watching to convert Coffee/Stylus/Jade"

srcdir = '/home/gijs/www-src/'
outdir = '/home/gijs/www/'

jade =
	'src': srcdir + 'jade/'
	'out': outdir + 'html/'
	'exec': 'jade --out %newpath% %filepath%'
	'extension': 'jade'

stylus =
	'src': srcdir + 'stylus/'
	'out': outdir + 'css/'
	'exec': 'stylus --out %newpath% %filepath%'
	'extension': 'styl'

coffee =
	'src': srcdir + 'coffee/'
	'out': outdir + 'js/'
	'exec': 'coffee --output %newpath% --compile %filepath%'
	'extension': 'coffee'

convertors = [jade, stylus, coffee]


watchConvertor = (convertor) ->
	exec 'find ' + convertor.src, (error, stdout, stderr) ->
		throw error if (error)
		
		dirs = _.compact stdout.split('\n')
		
		_.each dirs, (dir) ->
			fs.stat dir, (error, stats) ->
				throw error if error

				if stats.isDirectory()
					fs.watch dir, (event, filename) ->
						execConvertor convertor, dir + '/' + filename if filename.split('.').pop() is convertor.extension


execConvertor = (convertor, filepath) ->
	part = filepath.replace(convertor.src, "")
	dirs = _.initial(part.split('/')).join('/')
	newpath = convertor.out + dirs
	exec_str = convertor.exec.replace '%newpath%', newpath
	exec_str = exec_str.replace '%filepath%', filepath

	exec exec_str, (error, stdout, stderr) ->
			throw error if error

			console.log 'stdout: ' + stdout
			console.log 'stderr: ' + stderr
			
_.each convertors, (convertor) -> watchConvertor(convertor)