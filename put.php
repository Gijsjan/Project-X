<?php
function handlePUT($urlrouter) {
	$model = json_decode(file_get_contents('php://input'), true);
	$arg1 = $urlrouter->arg1();
	$arg2 = $urlrouter->arg2();
	$Object = ucfirst($arg1);
	
	$user = new User($_SESSION['user_id']); //TEMP
	if (!$user->id > 0) { echo 'No user found!'; exit; } //TEMP
	if (!isset($arg2)) { echo 'No second arg!'; exit; } //TEMP

	if (App::is_content($arg1)) {
		$object = new $Object($arg2); // instantiate object AFTER tags have been modified
		$object->save($model); // update the object with the model
		$object->saveTags($model['newtags']);
	} 

	if ($object->id > 0) {
		header('http/1.1 200 OK');
		header('Content-type: application/json');
		echo json_encode($object->to_backbone_model());
	} else {
		header('http/1.1 400 Bad Request'); 
		print_r('PUT Bad Request');
	}
}
?>