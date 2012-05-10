<?php
class Comment extends Object {
	public $content_id = 0;
	public $user_id = 0;
	public $comment = '';
	
	public function getMany($content_id) {
		$sql = "SELECT  c.*, 
						u.username as created_by, 
						o.*, 
						'comment' as type
				FROM comment c
					JOIN object co ON co.id = c.content_id
					LEFT JOIN object o ON o.id = c.comment_id
					LEFT JOIN user u ON u.user_id = c.user_id
				WHERE c.content_id = '$content_id'
				ORDER BY o.created DESC";

		return $this->db->fetchArrays($sql);
	}
	
	public function save($model) {
		$model['user_id'] = $this->user->id;
		$this->created_by = $this->user->username;

		$this->insert_object();
		$this->insert_child($model);

		$sql = "INSERT INTO `content_commentcount`
					(`content_id`, `commentcount`)
				SELECT '$content_id', count(comment_id) as count FROM comment c WHERE content_id = '$content_id'
					ON DUPLICATE KEY UPDATE `commentcount`=values(commentcount)"; //use values bc count() is not valid here
		$this->db->exec($sql);
	}

}
?>
