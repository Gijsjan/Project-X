<?php
class Country extends Object {  
	public $data = array(	'name' => '', 
							'slug' => '',
							'iso2' => '',
							'iso3' => '',
							'numcode' => 0	);

	public $name = '';
	public $slug = ''; 
	public $iso2 = '';
	public $iso3 = '';
	public $numcode = 0;

	function __construct($id = 0) {
		parent::__construct();
		
		if (is_numeric($id)) {
			$this->id = $id;
		}
		elseif (is_string($id)) {
			$this->id = 0;
			$this->slug = $id;
		}

		if ($this->id > 0 || !empty($this->slug)) $this->load($this->getCountry());
	}

	protected function getCountry() {
		$params = array();

		if (!empty($this->slug)) {
			$params = array(':slug' => $this->slug);
		}
		
		return $this->get($params);
	}

	
	/*
	 * @param $object_type The type of content, ie: article, link
	* @param $tag The tag the content is tagged with
	*/
	static function fetchContent($type, $country) {
		//////////
		///// IS LEFT JOIN USER U NECESSARY?
		///////////
		
		$sql = "SELECT 	y.*, 
						o.*, 
						cc.commentcount,
						group_concat( t2.name ORDER BY t2.name ASC ) AS tags,
						group_concat( c.slug ORDER BY c.slug ASC ) AS countries,
						'$type' as type
				FROM country co
					JOIN content_tag_user ctu ON ctu.tag_id = co.id AND ctu.tag_type = 'country' AND ctu.user_id = '".$this->user->id."'
					JOIN object o ON o.id = ctu.content_id
					JOIN $type y ON y.".$type."_id = o.id
					LEFT JOIN content_user cu ON cu.content_id = o.id
					LEFT JOIN user u ON u.id = cu.user_id
					LEFT JOIN content_commentcount cc ON cc.content_id = o.id
					LEFT JOIN content_tag_user ctu2 ON ctu2.content_id = o.id AND ctu2.user_id = '".$this->user->id."'
					LEFT JOIN tag t2 ON t2.tag_id = ctu2.tag_id AND ctu2.tag_type = 'tag'
					LEFT JOIN country c ON c.country_id = ctu2.tag_id AND ctu2.tag_type = 'country'
				WHERE co.slug = '$country'
				GROUP BY o.id";

		return $this->db->fetchArrays($sql);
	}
}
?>