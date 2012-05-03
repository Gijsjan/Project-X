<script id="tplFullVideo" type="text/template">
	<h2 class="title"><%= title %></h2>
	<%= _.renderFullInfobar(created) %>
	<div class="video_wrapper">
		<% if (player == 'youtube') { %>
			<iframe width="560" height="315" src="http://www.youtube.com/embed/<%= code %>" frameborder="0" allowfullscreen></iframe>
		<% } else if (player == 'embed') { %>
			<%= code %>
		<% } %>
	</div>
	<div class="tags_wrapper"></div>
</script>

<script id="tplListedVideo" type="text/template">
	<h2 class="title"><a href="#video/<%= id %>"><%= title %></a></h2>
	<%= _.renderListedInfobar(created, commentcount) %>	
	<div class="video_wrapper">
		<% if (player == 'youtube') { %>
			<iframe width="560" height="315" src="http://www.youtube.com/embed/<%= code %>" frameborder="0" allowfullscreen></iframe>
		<% } else if (player == 'embed') { %>
			<%= code %>
		<% } %>
	</div>
	<div class="tags_wrapper"></div>
</script>

<script id="tplEditVideo" type="text/template">
	<h2>Edit video</h2>
	<form id="EditVideo">
		<label for="title">Title</label><input class="bind" type="text" id="title" name="title" value="<%= title %>" /><br />
		<label for="player">Player</label>
			<select class="bind" id="player" name="player">
			<%	_(player).each(function(play) { %>
				<option class="play"><%= play %></option> 
			<% 	}); %>
			</select><br />
		<label for="code">Code</label><textarea class="bind" id="code" name="code"><%= code %></textarea><br />
		<label for="source">Source</label><input class="bind" type="text" id="source" name="source" value="<%= source %>" /><br />
		<label for="description">Description</label><textarea class="bind" id="description" name="description"><%= description %></textarea><br />
		<div class="tags_wrapper"></div>
		<div id="sSubmit">Save</div>
	</form>
</script>