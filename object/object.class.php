<?php 
abstract class Object {
	public $id = 0; //object_id
	public $created = '';
	public $updated = '';
	public $type = 'object';
	
	function __construct() {
		$this->type = lcfirst(get_class($this));
		$this->db = new DB();
		$this->user = new User($_SESSION['user_id']);
	}
	
	public function __get($property) {
		return $this->$property;
	}
	
	public function __set($property, $value) {
		$this->$property = $value;
	}

	protected function get($params = array()) {
		$where = '';

		if (empty($params)) {
			$params = array(':object_id' => $this->id);
			$where = $this->type.".".$this->type."_id=:object_id";
		} else {
			foreach ($params as $key => $value) {
				$where .= $this->type.'.'.substr($key, 1).'='.$key.' AND ';
			}

			$where = substr($where, 0, -5);
		}

		$sql = "SELECT  `".$this->type."`.*, 
						`object`.*
				FROM `".$this->type."`, `object`
				WHERE ".$where."
					AND ".$this->type.".".$this->type."_id = object.id";

		return $this->db->fetchArray($sql, $params);
	}

	protected function load($a = array()) {
		foreach ($a as $key => $value) {					
			$this->$key = $value;
		}
	}
/*
	public function runIt($sql) {
		//$sth = $this->db->query($sql);
		//$sth->setFetchMode(PDO::FETCH_CLASS, $class);
		return $this->db->fetchArrays($sql);
	}

	public function runIt2($sql) {
		//$sth = $this->db->query($sql);
		//$sth->setFetchMode(PDO::FETCH_CLASS, $class);
		return $this->db->fetchArray($sql);
	}

	public function runIt3($sql) {
		$this->db->query($sql);
	}
*/

	public function save($model = array()) {
		if ($this->id > 0) {
			$this->update_object();
			$this->update_child($model);
		} else {
			$this->insert_object();
			$this->insert_child($model);
		}

		$this->add_user(); // add user at insert AND update bc user has to be added regardless of prior existence
	}
/*
	public function insert($model) {
		$this->insert_object();
		$this->insert_child($model);
		$this->add_user();
	}

	public function update($model) {
		$this->update_object();
		$this->update_child($model);
		$this->add_user();
	}
*/
	public function insert_object() {
		$sql = "INSERT INTO object (created) VALUES (NOW())";
		$this->db->execute($sql);

		$this->id = $this->db->lastInsertId();
		$this->created = date("Y-m-d H:i:s");
	}

	protected function insert_child($model) {		
		$ia = array_intersect_key($model, $this->data); //check if $model only has the vars declared in $this->data
		$this->load($ia); //load $model vars in object
		$ia[$this->type.'_id'] = $this->id; // add the object_id BEFORE building $keys and $values

		$keys = array_keys($ia);
		$values = array();
		foreach ($keys as $key) {
			$values[] = ':'.$key;
		}
		
		$sql = "INSERT INTO `".$this->type."` (".implode(',', $keys).") VALUES (".implode(',', $values).")";
		$sth = $this->db->prepare($sql);
		try {
			$sth->execute($ia);
		} catch (PDOException $e) {
			print_r($e->getMessage()); exit;
		}
	}

	protected function update_object() {
		$sql = "UPDATE object SET `updated`=NOW() WHERE object.id=:id";
		$this->db->execute($sql, array('id' => $this->id));

		$this->updated = date("Y-m-d H:i:s");
	}

	protected function update_child($model) {
		$ia = array_intersect_key($model, $this->data); //check if $model only has this object vars
		$this->load($ia); //load $model vars in object

		$keyvalues = array();
		foreach ($ia as $key => $values) {
			$keyvalues[] = $key.'=:'.$key;
		}
		
		$type_id = $this->type.'_id';
		$ia[$type_id] = $this->id; // add the object_id AFTER building $keyvalues

		$sql = "UPDATE `".$this->type."` SET ".implode(',', $keyvalues)." WHERE $type_id=:$type_id";
		$sth = $this->db->prepare($sql);

		try {
			$sth->execute($ia);
		} catch (PDOException $e) {
			print_r($e->getMessage()); exit;
		}
	}

	protected function add_user() {
		$sql = "INSERT INTO content_user (`content_id`, `user_id`) 
				VALUES (:content_id, :user_id)";
		$params = array('content_id' => $this->id, 'user_id' => $this->user->id);
		$this->db->execute($sql, $params);
	}

	public function to_backbone_model() {
		$a = array();
		$not = array("db", "object_id", "user", "password", "data");
		foreach ($this as $key => $value) {
			if (!in_array($key, $not)) $a[$key] = $value;
		}
	
		return $a;
	}
	
	public static function exists($field, $value) {
		$called_class = get_called_class();
		$sql = "SELECT id FROM $called_class
				WHERE $field = '$value'";
		
		return DB::num_rows($sql);
	}
	/*
	public function vars() {
		$vars = (get_parent_class($this->type) == null) ? get_class_vars($this->type) : array_diff_key(get_class_vars($this->type), get_class_vars(get_parent_class($this->type)));
		
		return $vars;
	}
	*/
	public function getMany($limit = null) {
		$sql = "SELECT 	y.*, 
						o.*,
						'".$this->type."' as type
				FROM ".$this->type." y
					JOIN object o ON o.id = y.".$this->type."_id";
		if ($limit) $sql .= ' LIMIT '.$limit;

		return $this->db->fetchArrays($sql);
	}

	public function getAll($limit = null) {
		$sql = "SELECT 	*
				FROM ".$this->type;
		if ($limit) $sql .= ' LIMIT '.$limit;

		return $this->db->fetchArrays($sql);
	}
	/*
	protected function fetchArrays($sql) {
		global $mysqli;
		$a = array();
	
		if ($result = $mysqli->query($sql)) {
			while ($row = $result->fetch_assoc()) {
				if (get_parent_class(get_called_class())) unset($row['object_id']);
				if (array_key_exists('tags', $row)) $row['tags'] = preg_split("~,~", $row['tags'], -1, PREG_SPLIT_NO_EMPTY);
				if (array_key_exists('countries', $row)) $row['countries'] = preg_split("~,~", $row['countries'], -1, PREG_SPLIT_NO_EMPTY);
				
				$a[] = $row;
				
			}
			$result->close();
		}
		
		return $a;
	}
	*/
	
	/*
	 public function format() {
	$a = array();
	
	foreach ($this as $property => $value) {
	if (in_array($property, array_keys(get_class_vars('object')))) $a['object'][$property] = $value;
	else $a[$property] = $value;
	}
	
	return $a;
	}
	*/
	/*
	 public static function update($model) {
	$vars = App::get_vars(get_called_class(), get_class());
	$update = App::get_update_string($vars, $model);
	
	$sql = "UPDATE `".lcfirst(get_called_class())."` SET $update WHERE id='".$model['id']."'";
	
	return DB::query($sql);
	}
	*/
}
?>