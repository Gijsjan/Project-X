<?php
class Document extends Content {
	public $data = array(	'title' => '',
							'author' => '',
							'pages' => 0,
							'filename' => '',
							'filesize' => 0,
							'md5hash' => ''	);
	
	public $title = '';
	public $author = '';
	public $pages = 0;
	public $filename  = '';
	public $filesize  = 0;
	public $md5hash  = '';
	
	function __construct($id = 0) {
		parent::__construct();
		
		if (is_numeric($id)) {
			$this->id = $id;
		}
		elseif (is_string($id)) {
			$this->id = 0;
			$this->md5hash = $id;
		}

		if ($this->id > 0 || !empty($this->md5hash)) $this->load($this->getDocument());
	}

	protected function getDocument() {
		$params = array();

		if (!empty($this->md5hash)) {
			$params = array(':md5hash' => $this->md5hash);
		}
		
		return $this->get($params);
	}
	
	public function getPDFinfo(&$model, $path) {
		$todo = array('Author', 'Title', 'Pages'); // the info to get from pdfinfo
		
		$pdfinfo = shell_exec('pdfinfo '.escapeshellarg($path)); // run pdfinfo
		$pdfinfo = explode("\n", $pdfinfo);

		foreach ($pdfinfo as $info) { // add pdfinfo to $model
			$a = explode(':', $info);
			if (in_array($a[0], $todo)) $model[lcfirst($a[0])] = trim($a[1]);
		}
	}	
}
?>