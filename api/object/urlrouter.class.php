<?php
/**
 * Converts the URL to an object
 * 
 * @author BrouwerG
 *
 */
class UrlRouter
{
	protected $arg1;
	protected $arg2;
	protected $arg3;
	
	public function arg1() { return $this->arg1; }
	public function arg2() { return $this->arg2; }
	public function arg3() { return $this->arg3; }
	
	function __construct() {		
        $url = parse_url($_SERVER['REQUEST_URI']);
		$path = explode('/', $url['path']);

		$this->arg1 = (isset($path[2])) ? $path[2] : null; //path[0] is empty, path[1] is 'api', start with path[2]
		$this->arg2 = (isset($path[3])) ? $path[3] : null;
		$this->arg3 = (isset($path[4])) ? $path[4] : null;
    }
}
