<?php 
session_start();

require_once 'load.php';

$response = array();
$url = trim($_POST['url']);
$link = new Link($url);

if ($link->id > 0) {
	$response = $link->to_backbone_model();
} 
else {
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	$html = curl_exec($ch);
	curl_close($ch);
	
	$doc = new DOMDocument();
	@$doc->loadHTML($html);
	$heading1s = $doc->getElementsByTagName("h1");
	$heading2s = $doc->getElementsByTagName("h2");
	$heading3s = $doc->getElementsByTagName("h3");
	
	$headings = array('h1' => array(), 'h2' => array(), 'h3' => array());
	foreach($heading1s as $header) {
		$headings['possible_titles']['h1'][] = $header->nodeValue;
	}
	foreach($heading2s as $header) {
		$headings['possible_titles']['h2'][] = $header->nodeValue;
	}
	foreach($heading3s as $header) {
		$headings['possible_titles']['h3'][] = $header->nodeValue;
	}
	
	$headings['address'] = $url;

	$response = $headings;
}

header('http/1.1 200 OK');
header('Content-type: application/json');
echo json_encode($response);

?>