<?php
function handleGET($urlrouter) {
	$arg1 = $urlrouter->arg1();
	$arg2 = $urlrouter->arg2();
	$arg3 = $urlrouter->arg3();
	$user = new User($_SESSION['user_id']);

	if (!empty($arg1)) {
		//$arg1 = $urlrouter->arg1(); //singular (article) or plural (articles)
		
		$content_collections = array();
		foreach (App::$content as $c) { $content_collections[] = $c['plural']; }
		
		if ($arg1 == 'login') {
?>
			<form action="/login" method="post">
				<label for="username">Username</label><input type="text" name="username" id="username" /><br />
				<label for="password">Password</label><input type="password" name="password" id="password" /><br />
				<label>&nbsp;</label><input type="submit" name="sLogin" id="sLogin" value="Login" />
			</form>
<?php
		}
		elseif($arg1 == 'godb') {

//require_once('tmpFacebook.php');	

		}
		elseif ($arg1 == 'logout') {
			unset($_SESSION['user']);
			unset($_SESSION['user_id']);
			header('Location: http://localhost');
		}
		elseif (App::is_content($arg1)) {
			$Object = ucfirst($arg1);
			$object = new $Object($arg2);

			$comment = new Comment();
			$object->comments = $comment->getMany($arg2);

			if ($object->id > 0) {	
				header('http/1.1 200 OK');
				header('Content-type: application/json');
				echo json_encode($object->to_backbone_model());	
			} else {
				header('http/1.1 404 Not Found'); 		
			}
		}
		elseif (in_array($arg1, $content_collections)) {
			foreach (App::$content as $c => $args) {
				if ($args['plural'] == $arg1) {
					$Object = ucfirst($c);
					$model = new $Object();
				}
			}
			header('Content-type: application/json');
			echo json_encode($model->getMany());
		}
		elseif ($arg1 == 'countries') {
			$country = new Country();

			header('Content-type: application/json');
			echo json_encode($country->getMany());
		}
		elseif ($arg1 == 'users') {
			header('Content-type: application/json');
			echo json_encode($user->getMany());
		}
		elseif ($arg1 == 'user') {
			$object = new User($arg2);
			header('Content-type: application/json');
			echo json_encode($object->to_backbone_model());
		}
		elseif ($arg1 == 'contentlist') {
			header('Content-type: application/json');
			echo json_encode(getContentlist($arg2, $arg3));
		}
		elseif ($arg1 == 'ac_tags') {

			$tag = new Tag();
			//print_r($tag->fetchList($arg2)); exit;
			echo json_encode($tag->fetchList($urlrouter->arg2()));	
		}
	}
	elseif ($user->openSesame()) {
		loadHTML();
	}
	else {
		header('Location: http://localhost/login');
	}
}

function getContentlist($type = '', $tag = '') {
	$limit = 10;
	$content = array();

	if ($type == 'tag') {
		foreach (App::$content as $singular => $c) {
			$t = new Tag();
			$content = array_merge($content, $t->fetchContent($singular, $tag));
		}
	}
	elseif ($type == 'country') {
		foreach (App::$content as $singular => $c) {
			$content = array_merge($content, Country::fetchContent($singular, $tag));
		}
	}
	elseif ($type == 'user') {
		foreach (App::$content as $singular => $c) {
			$content = array_merge($content, User::fetchContent($singular, $tag));
		}
	}
	else {
		foreach (App::$content as $singular => $c) {
			$Singular = ucfirst($singular); $obj = new $Singular();
			$content = array_merge($content, $obj->getMany($limit));
		}
	}

	usort($content, function($a, $b) {
		if($a['created'] == $b['created']) return 0;
		return ($a['created'] > $b['created']) ? -1 : 1;
	});

	return array_slice($content, 0, $limit);
}
?>
