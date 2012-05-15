<?php
class DB extends PDO {
	public function __construct() {
		try {
			$settings = parse_ini_file('settings.ini');

			$dsn = sprintf('mysql:dbname=%s;host=%s', $settings['dbname'], $settings['dbhost']);
			parent::__construct($dsn, $settings['dbuser'], $settings['dbpassword']);
			$this->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
			$this->exec("SET CHARACTER SET utf8");
		} catch (PDOException $e) {
			$this->log(array("error" => $e->getMessage(), "sql" => '', "params" => '')); exit;
		}
	}

	public function log($params) {
		$sql = "INSERT INTO `log` (`error`, `sql`, `params`, `created`) VALUES (:error, :sql, :params, NOW())";

		$this->execute($sql, $params);
	}

	public function execute($sql, $params = array()) {
		$sth = $this->prepare($sql);
		
		try {
			$sth->execute($params);
		} catch (PDOException $e) {
			$this->log(array("error" => $e->getMessage(), "sql" => $sql, "params" => serialize($params)));
		}

		$return = ($this->lastInsertId() > 0) ? $this->lastInsertId() : $sth; // INSERT INTO returns id, SELECT returns statement handler to fetch rows
		
		return $return;
	}

	public function fetchArray($sql, $params) {
		$a = array();

		$sth = $this->execute($sql, $params);

		$row = $sth->fetch(PDO::FETCH_ASSOC);
		if (array_key_exists('tags', $row)) $row['tags'] = preg_split("~,~", $row['tags'], -1, PREG_SPLIT_NO_EMPTY);
		if (array_key_exists('countries', $row)) $row['countries'] = preg_split("~,~", $row['countries'], -1, PREG_SPLIT_NO_EMPTY);

		if (array_key_exists('tags', $row) && array_key_exists('countries', $row)) {
			foreach ($row['tags'] as $tag) {
				$row['newtags'][] = array("slug" => $tag, "type" => 'tag');
			}
			foreach ($row['countries'] as $tag) {
				$row['newtags'][] = array("slug" => $tag, "type" => 'country');
			}
		}

		return $row;
	}

	public function fetchArrays($sql, $params = array()) {
		$a = array();

		$sth = $this->execute($sql, $params);

		while($row = $sth->fetch(PDO::FETCH_ASSOC)) {
			if (array_key_exists('tags', $row)) $row['tags'] = preg_split("~,~", $row['tags'], -1, PREG_SPLIT_NO_EMPTY);
			if (array_key_exists('countries', $row)) $row['countries'] = preg_split("~,~", $row['countries'], -1, PREG_SPLIT_NO_EMPTY);

			$row['newtags'] = array();
			if (array_key_exists('tags', $row) && array_key_exists('countries', $row)) {
				foreach ($row['tags'] as $tag) {
					$row['newtags'][] = array("slug" => $tag, "type" => 'tag');
				}
				foreach ($row['countries'] as $tag) {
					$row['newtags'][] = array("slug" => $tag, "type" => 'country');
				}
			}

			$a[] = $row;
		}

		return $a;
	}
}
?>