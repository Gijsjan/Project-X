<script id="tplFullGroup" type="text/template">
	<div class="title"><%= title %></div>
</script>

<script id="tplListedGroup" type="text/template">
	<div class="title"><%= title %></div>
</script>

<script id="tplEditGroup" type="text/template">
	<h2>Edit Group</h2>

	<form>
		<label for="title">Title</label><input class="bind" type="text" id="title" name="title" value="<%= title %>" /><br />
		<div id="sSubmit">Save</div>
	</form>
</script>