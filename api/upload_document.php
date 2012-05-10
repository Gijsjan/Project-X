<?php 
session_start();

require_once 'load.php';

$model = array();

$model['filesize'] = $_SERVER['HTTP_X_FILE_SIZE'];
$model['filename'] = $_SERVER['HTTP_X_FILE_NAME'];

$path = '../uploads/'.$model['filename'];

if (!$model['filesize'] > 0) { throw new Exception('No file uploaded!'); }

if (file_put_contents($path, file_get_contents("php://input")) === false) { 
	echo  'gone wrong'; 
}
else {
	$model['md5hash'] = substr(shell_exec('md5sum '.escapeshellarg($path)), 0, 32);
	$newpath = '../uploads/'.$model['md5hash'].'.pdf';
	rename($path, $newpath);
	
	$document = new Document($model['md5hash']);

	if (!$document->id > 0) {
		$document->getPDFinfo($model, $newpath);
		$document->save($model);
	}
	
	header('http/1.1 200 OK');
	header('Content-type: application/json');
	echo json_encode($document->to_backbone_model());
}
?>