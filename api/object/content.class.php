<?php
abstract class Content extends Object {
	public $commentcount = 0;
	public $comments = array();
	public $tags = array();
	public $countries = array();
	public $newtags = array();

	function __construct() {
		parent::__construct();
	}

	protected function get($params = array()) {
		$where = '';

		if (empty($params)) {
			$params = array(':id' => $this->id);
			$where = "o.id = :id";
		} else {
			foreach ($params as $key => $value) {
				$where .= 'y.'.substr($key, 1).'='.$key.' AND ';
			}

			$where = substr($where, 0, -5);
		}

		$sql = "SELECT 	y.*,
						o.*,
						group_concat(t.slug ORDER BY t.slug ASC) as tags,
						group_concat(c.slug ORDER BY c.slug ASC) as countries,
						'".$this->type."' as type
				FROM object o
					LEFT JOIN ".$this->type." y ON o.id = y.".$this->type."_id
					LEFT JOIN content_tag_user ctu ON ctu.content_id = o.id AND ctu.user_id = ".$this->user->id."
					LEFT JOIN tag t ON t.tag_id = ctu.tag_id AND ctu.tag_type = 'tag'
					LEFT JOIN country c ON c.country_id = ctu.tag_id AND ctu.tag_type = 'country'
				WHERE ".$where;

		return $this->db->fetchArray($sql, $params);
	}
	
	public function getMany($limit = null) {	
		$sql = "SELECT 	y.*, 
						o.*, 
						cc.commentcount,
						group_concat(t.slug ORDER BY t.slug ASC) as tags,
						group_concat(c.slug ORDER BY c.slug ASC) as countries,
						'".$this->type."' as type
				FROM content_user cu
					JOIN object o ON o.id = cu.content_id AND cu.user_id = ".$this->user->id."
					JOIN ".$this->type." y ON y.".$this->type."_id = o.id
					LEFT JOIN content_tag_user ctu ON ctu.content_id = o.id AND ctu.user_id = ".$this->user->id."
					LEFT JOIN tag t ON t.tag_id = ctu.tag_id AND ctu.tag_type = 'tag'
					LEFT JOIN country c ON c.country_id = ctu.tag_id AND ctu.tag_type = 'country'
					LEFT JOIN content_commentcount cc ON cc.content_id = o.id
				GROUP BY o.id
				ORDER BY o.created DESC";
		if ($limit) $sql .= ' LIMIT '.$limit;

		return $this->db->fetchArrays($sql);
	}

	public function saveTags($tags = array()) {
		$t = new Tag();
		$t->deleteTags($this->id);

		foreach ($tags as $tag) {
			$Type = ucfirst($tag['type']);
			$t = new $Type($tag['slug']);

			if ($t->id == 0 && $tag['type'] == 'tag') $t->save($tag);
			
			$t->insertRelation($this->id, $t->id, $tag['type']);
		}

		
	}

	/*
	private function insert_content($model) {
		$ia = array_intersect_key($model, $this->vars()); //check if $model only has this object vars
		$this->load($ia); //load $model vars in object
		$ia['object_id'] = $this->id; // add the object_id BEFORE building $keys and $values

		$keys = array_keys($ia);
		$values = array();
		foreach ($keys as $key) {
			$values[] = ':'.$key;
		}
		
		$sql = "INSERT INTO `".$this->type."` (".implode(',', $keys).") VALUES (".implode(',', $values).")";
		$sth = $this->db->prepare($sql);
		$sth->execute($ia);
	}
	*/
	
	public function delete() {
		/////////////
		//USER CAN DELETE CONTENT THAT IS REGISTERED TO OTHER USERS!
		/////////////

		//delete relations
		//$sql = "DELETE FROM `content_commentcount` WHERE content_id = '".$this->id."'";
		//$this->db->query($sql);
		
		$sql = "DELETE FROM `content_tag_user` WHERE `content_id` = '".$this->id."' AND `user_id` = '".$this->user->id."'";
		$this->db->query($sql);
		
		$sql = "DELETE FROM `content_user` WHERE `content_id` = '".$this->id."' AND `user_id` = '".$this->user->id."'";
		$this->db->query($sql);

		//delete comments
		//$sql = "DELETE FROM `comment` WHERE object_id = '".$this->id."'";
		//$this->db->query($sql);
		
		//delete content
		//$sql = "DELETE FROM `".$this->type."` WHERE object_id = '".$this->id."'";
		//$this->db->query($sql);
		
		//delete object
		//$sql = "DELETE FROM `object` WHERE id = '".$this->id."'";
		//$this->db->query($sql);
	}
}
?>