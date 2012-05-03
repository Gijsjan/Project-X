<script id="tplTagList" type="text/template">
	<%	tags.each(function(tag) { %>
			<li class="tag-item"><a href="#<%= tag.get('type') %>/<%= tag.get('slug') %>" class="tag"><%= tag.get('slug') %></a></li> 
	<% 	}); %>
</script>

<script id="tplEditTagList" type="text/template">
	<%	tags.each(function(tag) { %>
			<li class="tag-item"><%= tag.get('slug') %> <span class="del-tag">x</span></li> 
	<% 	}); %>
</script>

<script id="tplEditTags" type="text/template">
	<label for="tags">Tags</label>
	<input type="text" id="add-tag" name="add-tag" style="float: none" />
	<div id="autocomplete_wrapper"></div>
	<div id="edit-tag-list-wrapper"></div>
	<div id="edit-country-list-wrapper"></div>
</script>