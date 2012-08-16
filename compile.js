var fs = require('fs'),
	util = require('util'),
	exec = require('child_process').exec;

try { var _ = require('underscore'); }
catch (err) { throw new Error("\n\nI love Underscore.js, don't you?\n\n"); }

console.log("Watching to convert Coffee/Stylus/Jade");

var srcdir = '/home/gijs/www-src/';
var outdir = '/home/gijs/www/';

var jade = {
	src: srcdir + 'jade/',
	out: outdir + 'html/',
	exec: 'jade --out %newpath% %filepath%',
	extension: 'jade'
};
var stylus = {
	src: srcdir + 'stylus/',
	out: outdir + 'css/',
	exec: 'stylus --out %newpath% %filepath%',
	extension: 'styl'
};
var coffee = {
	src: srcdir + 'coffee/',
	out: outdir + 'js/',
	exec: 'coffee --output %newpath% --compile %filepath%',
	extension: 'coffee'
};

var convertors = [jade, stylus, coffee];

_.each(convertors, function(convertor) {
	watchConvertor(convertor);
});

function watchConvertor(convertor) {
	exec('find ' + convertor.src, function(error, stdout, stderr) {
		if (error) throw error;
		var results = _.compact(stdout.split('\n'));
		
		_.each(results, function(result) {
			fs.stat(result, function (error, stats) {
				if (error) throw error;

				if (stats.isFile()) {
					extension = result.split('.').pop();
					if (extension === convertor.extension) {
						execConvertor(convertor, result);
					}
				}
			});
		});
	});
}

function execConvertor(convertor, filepath) {
	var part = filepath.replace(convertor.src, ""); // main/login/login.jade
	var dirs = _.initial(part.split('/')).join('/'); // main/login
	var newpath = convertor.out + dirs; // /var/www/templates/main/login
	var exec_str = convertor.exec.replace('%newpath%', newpath);
	exec_str = exec_str.replace('%filepath%', filepath);

	exec(exec_str,
		function (error, stdout, stderr) {
			if (error) throw error;

			console.log('stdout: ' + stdout);
			console.log('stderr: ' + stderr);
		}
	);
}