<?php
class Tag extends Object {
	public $data = array('slug' => '');

	public $slug = '';

	function __construct($id = 0) {
		parent::__construct();
		
		if (is_numeric($id)) {
			$this->id = $id;
		}
		elseif (is_string($id)) {
			$this->id = 0;
			$this->slug = $id;
		}

		if ($this->id > 0 || !empty($this->slug)) $this->load($this->getTag());
	}

	protected function getTag() {
		$params = array();

		if (!empty($this->slug)) {
			$params = array(':slug' => $this->slug);
		}
		
		return $this->get($params);
	}
	
	////////////////
	//// save tags als normaal laten werken? dus vanuit put.php $tag->save($model); en $country->save($model); en als laatste insertRelations
	/*
	public function save($tags = array(), $countries = array(), $content_id) {
		global $mysqli;
		$t = array();
		
		foreach ($tags as $tag) {
			$tg = trim($tag['slug']); // remove leading and trailing spaces

			$tg = new Tag($tg);

			if ($tg->id == 0) {
				$tg->insert_object();
				$tg->insert_child($tag);
			}

			$t[] = array("content_id" => $content_id, "tag_id" => $tg->id, "tag_type" => "tag", "user_id" => $this->user->id);		
		}
		
		foreach ($countries as $country) {
			$sql = "SELECT `country_id` FROM `country` WHERE `slug` = :slug";
			$params = array(':slug' => $country['name']);
			$row = $this->db->fetchArray($sql, $params);

			$t[] = array("content_id" => $content_id, "tag_id" => $row['country_id'], "tag_type" => "country", "user_id" => $this->user->id);
		}

		$this->insertRelations($t, $content_id);
	}
	*/

	public function deleteTags($content_id) {
		$sql = "DELETE FROM `content_tag_user` WHERE `content_id`=$content_id AND `user_id`=".$this->user->id;
		$this->db->exec($sql);
	}

	public function insertRelation($content_id, $tag_id, $tag_type) {
		
		
		///// of met prepared???
		//$sql = "DELETE FROM `content_tag_user` WHERE `content_id`=:content_id AND `user_id`=:user_id";
		//$params = array(':content_id' => $content_id, ':user_id' => $this->user->id);
		//$this->db->execute($sql, $params);

		$sql = "INSERT INTO `content_tag_user` 
					(`content_id`, `tag_id`, `tag_type`,`user_id`)
				VALUES (:content_id, :tag_id, :tag_type, :user_id)";
		$params = array('content_id' => $content_id, 'tag_id' => $tag_id, 'tag_type' => $tag_type, 'user_id' => $this->user->id);
		$this->db->execute($sql, $params);
	}
	
	/*
	 * @param $object_type The type of content, ie: article, link
	 * @param $tag The tag the content is tagged with
	 */
	public function fetchContent($type, $tag) {

		$sql = "SELECT 	y.*, 
						o.*, 
						cc.commentcount,  
						group_concat( t2.slug ORDER BY t2.slug ASC ) AS tags,
						group_concat( c.slug ORDER BY c.slug ASC ) AS countries,
						'$type' as type
				FROM tag t
					JOIN content_tag_user ctu ON ctu.tag_id = t.tag_id AND ctu.tag_type = 'tag' AND ctu.user_id = '".$this->user->id."'
					JOIN object o ON o.id = ctu.content_id
					JOIN $type y ON y.".$type."_id = o.id
					LEFT JOIN content_commentcount cc ON cc.content_id = o.id
					LEFT JOIN content_tag_user ctu2 ON ctu2.content_id = o.id
					LEFT JOIN tag t2 ON t2.tag_id = ctu2.tag_id AND ctu2.tag_type = 'tag'  AND ctu2.user_id = '".$this->user->id."'
					LEFT JOIN country c ON c.country_id = ctu2.tag_id AND ctu2.tag_type = 'country'  AND ctu2.user_id = '".$this->user->id."'
				WHERE t.slug = :tag
				GROUP BY o.id";

		$params = array(':tag' => $tag);		
		return $this->db->fetchArrays($sql, $params);
	}
	
	public function fetchList($part) {
		$sql = "(SELECT tag.slug as slug, 'tag' as type
				 FROM `tag`
				 WHERE tag.`slug` LIKE :part
				)
				UNION 
				(SELECT country.slug as slug, 'country' as type
				FROM `country`
				WHERE country.`slug` LIKE :part)
				ORDER BY slug";

		$params = array(':part' => '%'.$part.'%');

		return $this->db->fetchArrays($sql, $params);
	}
}