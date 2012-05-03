<script id="tplListedDocument" type="text/template">
	<h2 class="title"><a href="#document/<%= id %>"><%= title %></a></h2>
	<%= _.renderListedInfobar(created, commentcount) %>
	<div class="filename"><%= filename %></div>
	<div class="md5hash"><%= md5hash %></div>
	<div class="tags_wrapper"></div>
</script>

<script id="tplFullDocument" type="text/template">
	<h2 class="title"><%= title %></h2>
	<%= _.renderFullInfobar(created) %>
	<div class="filename"><%= filename %></div>
	<div class="md5hash"><%= md5hash %></div>
	<div class="tags_wrapper"></div>
</script>

<script id="tplEditDocument" type="text/template">
	<h2>Edit Document</h2>
	<div id="part1">
		<form enctype="multipart/form-data">
			<input type="hidden" name="MAX_FILE_SIZE" value="30000000" />
			<label for="pdf-file">PDF</label><input class="upload" id="pdf-file" name="pdf-file" type="file" />
		</form>
	</div>
	<div id="part2">
		<label for="pdf-file">PDF</label><progress max="100" value="0" id="progressbar"></progress>
	</div>
	<div id="part3">
		<form>
			<label for="title">Uploaded PDF</label><i><%= filename %></i><br />
			<label for="title">Filesize</label><i><%= filesize %> bytes</i><br />
			<label for="title">Title</label><input class="bind" type="text" id="title" name="title" value="<%= title %>" /><br />
			<label for="author">Author</label><input class="bind" type="text" id="author" name="author" value="<%= author %>" /><br />
			<label for="pages">Pages</label><input class="bind" type="text" id="pages" name="pages" value="<%= pages %>" /><br />
			<div class="tags_wrapper"></div>
			<div id="sSubmit">Save</div>
		</form>
	</div>
</script>



