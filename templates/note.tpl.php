<script id="tplFullNote" type="text/template">
	<h2 class="title"><%= title %></h2>
	<%= _.renderFullInfobar(created) %>
	<div class="body"><%= new Markdown.Converter().makeHtml(body) %></div>
	<div class="tags_wrapper"></div>
</script>

<script id="tplListedNote" type="text/template">
	<h2 class="title"><a href="#note/<%= id %>"><%= title %></a></h2>
	<%= _.renderListedInfobar(created, commentcount) %>
	<div class="body"><%= body %></div>
	<div class="tags_wrapper"></div>
</script>

<script id="tplEditNote" type="text/template">
	<h2>Edit Note</h2>
	<form>
		<label for="title">Title</label><input class="bind" type="text" id="title" name="title" value="<%= title %>" /><br />
		<label for="body">Body</label><textarea class="bind" id="body" name="body"><%= body %></textarea>
		<div id="pagedown"></div><br />
		<div class="tags_wrapper"></div>
		<div id="sSubmit">Save</div>
	</form>
</script>