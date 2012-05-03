<?php
class Link extends Content {
	protected $data = array(	'title' => '', 
								'address' => '');

	public $title = '';
	public $address = '';
	public $possible_titles = array();
	
	public function __construct($id = 0) {
		parent::__construct();

		if (is_numeric($id)) {
			$this->id = $id;
		}
		elseif (is_string($id)) {
			$this->id = 0;
			$this->address = $id;
		}

		if ($this->id > 0 || !empty($this->address)) $this->load($this->getLink());
	}
	
	protected function getLink() {
		$params = array();

		if (!empty($this->address)) {
			$params = array(':address' => $this->address);
		}
		
		return $this->get($params);
	}
}
?>