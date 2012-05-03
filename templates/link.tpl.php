<script id="tplFullLink" type="text/template">
	<h2><%= title %></h2>
	<%= _.renderFullInfobar(created) %>
	<a href="<%= address %>">link</a>
	<div class="tags_wrapper"></div>
</script>

<script id="tplListedLink" type="text/template">
	<div class="content-header">
		<h2><a href="#link/<%= id %>"><%= title %></a></h2>
		<%= _.renderListedInfobar(created, commentcount) %>	
	</div>
	<div class="content-body">
		<a href="<%= address %>">link</a>	
		<div class="tags_wrapper"></div>
	</div>
</script>

<script id="tplEditLink" type="text/template">
	<h2>Edit link</h2>
	<div id="part1">
		<form>
			<label for="address">Address</label>
			<input class="address" type="text" id="address" name="address" value="<%= address %>" />
		</form>
	</div>

	<div id="part2">
		<label for="address">Address</label><i><%= address %></i><br />
		
		<% if (_.size(possible_titles) > 0) { %>
				<label>H1</label><br />
				<%	_.each(possible_titles.h1, function(title, i) { %>
						<input name="title" id="h1_<%= i %>" class="possible_title_checkbox" value="<%= title %>" type="radio"><label class="possible_link_title" for="h1_<%= i %>"><%= title %></label><br />
				<%	}); %>
				<label>H2</label><br />
				<%	_.each(possible_titles.h2, function(title, i) { %>
						<input name="title" id="h2_<%= i %>" class="possible_title_checkbox" value="<%= title %>" type="radio"><label class="possible_link_title" for="h2_<%= i %>"><%= title %></label><br />
				<%	}); %>
				<label>H3</label><br />	
				<%	_.each(possible_titles.h3, function(title, i) { %>
						<input name="title" id="h3_<%= i %>" class="possible_title_checkbox" value="<%= title %>" type="radio"><label class="possible_link_title" for="h3_<%= i %>"><%= title %></label><br />
				<%	}); %>

				<label class="link_title" for="title">Or write your own:</label><br />
		<% } else { %>
				<label class="link_title" for="title">Title:</label><br />
		<% } %>
		<input type="text" name="title" id="title" value="" /><br />
		<div id="submit_title">Save</div>

	</div>

	<div id="part3">
	<form onsubmit="return false" autocomplete="off">
		<label for="address">Address</label><i><%= address %></i><br />
		<label for="title">Title</label><i><%= title %></i><br />
		<label for="created">Created</label><i><%= created %></i><br />
		<div class="tags_wrapper"></div>
		<div id="sSubmit">Save</div>
	</form>
	</div>
</script>



