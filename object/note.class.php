<?php
class Note extends Content {
	public $data = array(	"title" => '',
							"body" 	=> ''	);
	
	public $title = '';
	public $body = '';

	public function __construct($id = 0) {
		parent::__construct();

		$this->id = $id;
		if ($this->id > 0) $this->load($this->get());
	}
}
?>