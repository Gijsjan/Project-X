<script id="tplComment" type="text/template">
	<div class="counter"><%= count %></div>
	<%= _.renderFullInfobar(comment.created_by, comment.created) %>	
	<div class="comment-text"><%= comment.comment %></div> 
	<hr />
</script>

<script id="tplComments" type="text/template">
	<h3>Comments</h3>
	<div id="fComment">
	<form>
		<textarea id="commenttext"></textarea>
		<span id="sComment">Save</span><br />
	</form>
	</div>
	<div id="comments_wrapper">

	</div>
</script>