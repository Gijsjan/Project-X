<script id="tplFullEvent" type="text/template">
	<h2 class="title"><%= title %></h2>
	<%= _.renderFullInfobar(created) %>
	<div class="description"><%= description %></div>
	<div class="tags_wrapper"></div>
</script>

<script id="tplListedEvent" type="text/template">
	<div class="content-header">
		<h2 class="title"><a href="#event/<%= id %>"><%= title %></a></h2>
		<%= _.renderListedInfobar(created, commentcount) %>	
	</div>
	<div class="content-body">
		<div class="description"><%= description %></div>
		<div class="dates">from <%= start %> to <%= end %></div>
		<div class="tags_wrapper"></div>
	</div>
</script>

<script id="tplEditEvent" type="text/template">
	<h2>Edit event</h2>
	<form id="EditEvent">
		<label for="title">Title</label><input class="bind" type="text" id="title" name="title" value="<%= title %>" /><br />
		<label for="description">Description</label><textarea class="bind" id="description" name="description"><%= description %></textarea><br />
		<label for="address">Address</label><input class="bind" type="text" id="address" name="address" value="<%= address %>" /><br />
		<label for="city">City</label><input class="bind" type="text" id="city" name="city" value="<%= city %>" /><br />
		<label for="start">Start</label><input class="bind" type="text" id="start" name="start" value="<%= start %>" /><br />
		<label for="end">End</label><input class="bind" type="text" id="end" name="end" value="<%= end %>" /><br />
		<div class="tags_wrapper"></div>
		<div id="sSubmit">Save</div>
	</form>
</script>