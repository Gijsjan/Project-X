<?php
class Video extends Content {
	public $title;
	public $code;
	public $player = array('embed', 'vimeo', 'youtube');
	public $description;
	public $source;
}
?>