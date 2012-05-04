<?php
function handlePOST($urlrouter) {
	$model = json_decode(file_get_contents('php://input'), true);
	$arg1 = $urlrouter->arg1();
	
	if ($arg1 == 'login') {		
		$user = new User($_POST['username'], $_POST['password']);

		if ($user->openSesame()) {
			$_SESSION['user'] = json_encode($user->to_backbone_model());
			$_SESSION['user_id'] = $user->id;

			header('Location: http://localhost');
		} else {
			header('Location: http://localhost/login');
		}
	} else {
		$user = new User($_SESSION['user_id']);
		if ($user->id == 0) { 'No user!'; exit; }

		if ($arg1 == 'comment') {		
			$object = new Comment();
			$object->save($model); // model has content_id and comment
		}
		elseif ($arg1 == 'user') {		
			$object = new User();
			$object->save($model);
		}
		else {
			/*
			$tags = $model['tags']; //put tags in local variable b4 unsetting
			$countries = $model['countries'];
			unset($model['tags']);
			unset($model['countries']);
			unset($model['comments']);
			unset($model['commentcount']);
			*/
			$Object = ucfirst($arg1);
			$object = new $Object();
			$object->save($model); //insert the model
			$object->saveTags($model['newtags']);
			/*
			if ($object->id > 0 && isset($tags) && isset($countries)) {
				if (count($model['tags']) > 0 || count($model['countries']) > 0) {				
					$tag = new Tag();
					$tag->save($tags, $countries, $object->id); //update tags
				}
			}
			*/
		}

		if ($object->id > 0) {		
			header('http/1.1 200 OK');
			header('Content-type: application/json');
			echo json_encode($object->to_backbone_model());
		} else {
			header('http/1.1 400 Bad Request');
		}
	}
	

}
?>