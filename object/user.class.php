<?php
class User extends Object {
	public $username = '';
	public $password = '';
	
	function __construct($id = 0, $password = '') {
		$this->type = lcfirst(get_class($this));
		$this->db = new DB();
		
		if (is_numeric($id)) { 
			$this->id = $id;
		}
		elseif (is_string($id) && !empty($password)) {
			$this->id = 0;	
			$this->username = $id;
			$this->password = $password;
		}	
		
		$this->load($this->get());
	}

	/*
	public function insert($model) {
		$this->insert_object();
		$this->insert_child($model);
	}
	*/
	/*
	 * @return array
	 */
	protected function get() {	

		$sql = "SELECT 	user.*, 
						object.*, 
						'user' as type
				FROM `user`, `object`
				WHERE `user`.user_id = `object`.id ";
		$sql .= ($this->id > 0) ? "AND `object`.id=:id" : "AND `user`.username=:username AND `user`.password=:password";

		$sth = $this->db->prepare($sql);
		if ($this->id > 0) {
			$sth->bindParam(':id', $this->id);
		} else {
			$sth->bindParam(':username', $this->username);
			$sth->bindParam(':password', $this->password);
		}
		try {
			$sth->execute();
		} catch (PDOException $e) {
			print_r($e->getMessage()); exit;
		}
		
		
		return $sth->fetch(PDO::FETCH_ASSOC);
	}
    
    /*
     * @return bool
     */
    public function openSesame() {
    	return ($this->id > 0 && !empty($this->username)) ? true : false;
    }
    
    public function authorized() {
    	return ($this->id == $_SESSION['user_id']) ? true : false;
    }
    
    /*
     * @param $object_type The type of content, ie: article, link
    * @param $tag The tag the content is tagged with
    */
    static function fetchContent($type, $tag) {
    	/////////
    	/////which user finds what? from what user? rights management!!

    	$sql = "SELECT 	y.*, 
    					o.*, 
    					cc.commentcount,
				    	group_concat( t2.name ORDER BY t2.name ASC ) AS tags,
				    	group_concat( c.slug ORDER BY c.slug ASC ) AS countries,
				    	'$type' as type
		    	FROM user us
			    	JOIN object o ON o.user_id = us.id
			    	JOIN $type y ON y.".$type."_id = o.id
			    	LEFT JOIN user u ON u.id = o.user_id
			    	LEFT JOIN content_user cu ON cu.user_id = u.id
			    	LEFT JOIN content_commentcount cc ON cc.content_id = o.id
			    	LEFT JOIN content_tag_user ctu2 ON ctu2.content_id = o.id AND ctu2.user_id = us.id
			    	LEFT JOIN tag t2 ON t2.tag_id = ctu2.tag_id AND ctu2.tag_type = 'tag'
			    	LEFT JOIN country c ON c.country_id = ctu2.tag_id AND ctu2.tag_type = 'country'
			    WHERE us.username = '$tag'
		    	GROUP BY o.id";
    
    	return DB::fetchArrays($sql);
    }
}
?>