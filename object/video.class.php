<?php
class Video extends Content {
	public $data = array(	'title' 		=> '',
							'code'			=> '',
							'player'		=> array('embed', 'vimeo', 'youtube'),
							'description'	=> '',
							'source'		=> ''	);
	
	public $title;
	public $code;
	public $player = array('embed', 'vimeo', 'youtube');
	public $description;
	public $source;
}
?>