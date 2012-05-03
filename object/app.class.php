<?php 
class App {
	public static $content = array(
		"note" => array('plural' => 'notes'),
		"link" => array('plural' => 'links'),
		"video" => array('plural' => 'videos'),
		"event" => array('plural' => 'events'),
		"document" => array('plural' => 'documents')
	);
	public static $objects = array(
		"country" => array('plural' => 'countries'),
		"comment" => array('plural' => 'comments'),
		"tag" => array('plural' => 'tags'),
		"user" => array('plural' => 'users'),
		"group" => array('plural' =>  'groups')
	);
	
	public static function is_content($content_type) {
		return in_array($content_type, array_keys(App::$content));
	}
	
	public static function vars($obj) {
		$vars = get_object_vars($obj);

		unset($vars['db']);
		unset($vars['id']);

		return $vars;
	}
	
	/*
	 * @param string $called_class class that called the function (ie. note, video, event, etc)
	 * @param string $parent_class parent class of the called class (ie. content, object)
	 * @return array the vars of the content object
	 */
	/*
	public static function get_vars($class, $parent_class) {
		$content_type = lcfirst($class);
		print_r(get_class_vars('link'));
		$content_vars = array_diff_key(get_class_vars($content_type), get_class_vars($parent_class)); // get only the called class (ie: note, video, etc) vars
	
		return $content_vars;
	}
	*/
	public static function get_update_string($vars, $model) {
		global $mysqli;
		$update = '';
		
		foreach ($vars as $key => $value) {
			if ($key != 'id') $update .= "`$key` = '".$mysqli->real_escape_string($model[$key])."',";
		}
		
		return rtrim($update, ',');
	}
	
	public static function get_insert_strings($vars, $model) {
		global $mysqli;
		$update = '';
	
		foreach ($vars as $key => $value) {
			//if ($key != 'id') $update .= "`$key` = '".$mysqli->real_escape_string($model[$key])."',";
			$keys .= "`$key`,";
			$values .= "'".$mysqli->real_escape_string($model[$key])."',";
		}
	
		return array(rtrim($keys,','), rtrim($values,','));
	}
}
?>