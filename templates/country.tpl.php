<script id="tplFullCountry" type="text/template">
	<h2 class="name"><%= name %></h2>
	<div class="slug"><%= slug %></div>
	<div class="iso2"><%= iso2 %></div>
	<div class="iso3"><%= iso3 %></div>
</script>

<script id="tplListedCountry" type="text/template">
	<h2 class="name"><a href="#country/<%= slug %>"><%= name %></a></h2>	
	<div class="slug"><%= slug %></div>
	<div class="iso2"><%= iso2 %></div>
	<div class="iso3"><%= iso3 %></div>
	<div class="numcode"><%= numcode %></div>
</script>

<script id="tplEditCountry" type="text/template">
	<h2>Edit country</h2>
	<form id="EditCountry">
		<label for="name">Name</label><input class="bind" type="text" id="name" name="name" value="<%= name %>" /><br />
		<label for="slug">Slug</label><input class="bind" type="text" id="slug" name="slug" value="<%= slug %>" /><br />
		<label for="iso2">Iso2</label><input class="bind" type="text" id="iso2" name="iso2" value="<%= iso2 %>" /><br />
		<label for="iso3">Iso3</label><input class="bind" type="text" id="iso3" name="iso3" value="<%= iso3 %>" /><br />
		<div id="sSubmit">Save</div>
	</form>
</script>

<script id="tplCountries" type="text/template">

</script>