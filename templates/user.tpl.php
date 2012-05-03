<script id="tplFullUser" type="text/template">
	<div class="username"><%= username %></div>
</script>

<script id="tplListedUser" type="text/template">
	<div class="username"><%= username %></div>
</script>

<script id="tplEditUser" type="text/template">
	<h2>Edit User</h2>

	<form>
		<label for="username">Username</label><input class="bind" type="text" id="username" name="username" value="<%= username %>" /><br />
		<label for="password">Password</label><input class="bind" type="password" id="password" name="password" /><br />
		<div id="sSubmit">Save</div>
	</form>
</script>