<?php
function handleDELETE($urlrouter) {
	$user = new User($_SESSION['user_id']);
	
	$arg1 = $urlrouter->arg1();
	$arg2 = $urlrouter->arg2();

	$Obj = ucfirst($arg1); 
	$Obj = new $Obj($arg2);

	if ($user->authorized()) {
		$Obj->delete();
		header('http/1.1 200 OK');
	} else {
		header('http/1.1 404 NOT FOUND');
	}
}
?>