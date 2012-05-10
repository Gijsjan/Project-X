<?php
require_once 'object/db.class.php';

require_once 'object/object.class.php';

require_once 'object/app.class.php';

require_once 'object/content.class.php';

require_once 'object/urlrouter.class.php';

$objects = array_merge(App::$objects, App::$content);

foreach ($objects as $object => $args) { require_once 'object/'.$object.'.class.php'; }

//require_once 'dbconnect.php';
require_once 'get.php';
require_once 'post.php';
require_once 'put.php';
require_once 'delete.php';
?>
