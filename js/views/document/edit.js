define([
    'jquery',
    'underscore',
    'backbone',
    'views/content/edit'
], function($, _, Backbone, vEditContent) {
	return vEditContent.extend({
		events: _.extend({}, vEditContent.prototype.events, {
			"change .upload": "onDocumentSelected"
		}),
		onDocumentSelected: function(e) {
			var file = document.getElementById('pdf-file').files[0];
			var xhr = new XMLHttpRequest();
			var self = this;

			xhr.upload.addEventListener("loadstart", function() {
				self.$('#part1').hide();
				self.$('#part2').show();
			}, false);
			xhr.upload.addEventListener("progress", function(e, f, g) {
				self.$('#progressbar').attr('value', e.loaded/e.total * 100);
			}, false);
			xhr.upload.addEventListener("load", this.onLoad, false);
			xhr.open("POST", "/api/upload_document.php", true);
			xhr.setRequestHeader("Content-type", file.type);
			xhr.setRequestHeader("X_FILE_NAME", file.name);
			xhr.setRequestHeader("X_FILE_SIZE", file.size);
			xhr.send(file);
			xhr.onreadystatechange = function() {
				if (xhr.readyState === 4) {
					if (xhr.status === 200) {
						console.log(xhr.responseText);
						var response = JSON.parse(xhr.responseText);
						//self.$('#upload-pdf-file').append($('<i />').html(response.filename));
						self.model.set(response);
						self.render();
						self.$('#part1').hide();
						self.$('#part2').hide();
						self.$('#part3').show();
					}
				}
			};
		},

		render: function() {
			vEditContent.prototype.render.apply(this);

			if (!this.model.get('id')) {
				this.$('#part1').show(); }
			else {
				this.$('#part3').show(); }

			return this;
		}
	});
});