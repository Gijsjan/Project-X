<?php 
session_start();

require_once 'load.php';

$urlrouter = new UrlRouter();

//request method in urlrouter verwerken?
if ($_SERVER['REQUEST_METHOD'] == 'POST' && $urlrouter->arg1() == 'login') {
	echo 'okk';exit;
	$user = new User($_POST['username'], $_POST['password']);

	if ($user->id > 0) {
		$_SESSION['user'] = json_encode($user->to_backbone_model());
		$_SESSION['user_id'] = $user->id;

		header('http/1.1 200 OK');
	} else {
		header('http/1.1 401 UNAUTHORIZED');
	}

	exit;
}

if (!$user) $user = new User($_SESSION['user_id']);
if ($user->id == 0) header('http/1.1 401 UNAUTHORIZED');

switch ($_SERVER['REQUEST_METHOD']) {
	case 'GET':
		handleGET($urlrouter);
		break;
	case 'POST':
		handlePOST($urlrouter);
		break;
	case 'PUT':
		handlePUT($urlrouter);
		break;
	case 'DELETE':
		handleDELETE($urlrouter);
		break;
}

function loadHTML() {	
?>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>Data - backbone.js test</title>
	<?php 
	$objects = array_merge(App::$objects, App::$content);
	foreach ($objects as $object_type => $args) {
		require_once "templates/$object_type.tpl.php";
	}
	//require_once  "templates/user.tpl.php";
	require_once  "templates/infobar.tpl.php";
	?>
	
	<script id="tplSystemMessage" type="text/template">
		
	</script>
	
	<!-- libs -->
	<script type="text/javascript" src="/js/lib/jquery/jquery-1.6.4.min.js"></script>
	<script type="text/javascript" src="/js/lib/json2.js"></script>
	<script type="text/javascript" src="/js/lib/underscore/underscore133.js"></script>
	<script type="text/javascript" src="/js/lib/backbone/backbone091.js"></script>
	<script type="text/javascript" src="/js/lib/Markdown.Converter.js"></script>

	<script>
		var App = {};
		App.Models = {};
		App.Collections = {};
		App.Views = {};
		App.Routers = {};
		App.EventDispatcher = _.clone(Backbone.Events);
		App.objects = <?php print_r(json_encode(array_keys(App::$objects))); ?>;
		App.contents = <?php print_r(json_encode(array_keys(App::$content))); ?>;
	</script>
	
	<!-- mixin lib needs App -->
	<script type="text/javascript" src="/js/lib/mixin.js"></script>

	<!-- controllers -->
	<script type="text/javascript" src="/js/controllers/object.controller.js"></script>
	<script type="text/javascript" src="/js/controllers/content.controller.js"></script>
	<script type="text/javascript" src="/js/controllers/document.controller.js"></script>
	<script type="text/javascript" src="/js/controllers/user.controller.js"></script>
	<script type="text/javascript" src="/js/controllers/tag.controller.js"></script>
	<script type="text/javascript" src="/js/controllers/main.controller.js"></script>
	
	<!-- object views -->
	<script type="text/javascript" src="/js/views/object.js"></script>
	<script type="text/javascript" src="/js/views/comment.js"></script>
	<script type="text/javascript" src="/js/views/tag.js"></script>
	<script type="text/javascript" src="/js/views/user.js"></script>
	
	<!-- content views -->
	<script type="text/javascript" src="/js/views/content.js"></script>
	<script type="text/javascript" src="/js/views/document.js"></script>
	<script type="text/javascript" src="/js/views/link.js"></script>
	<script type="text/javascript" src="/js/views/note.js"></script>

	<script type="text/javascript" src="/js/views/contentlist.js"></script>
	
	<!-- collections -->
	<script type="text/javascript" src="/js/collections/contentlist.js"></script>
	
	<!-- routers -->
	<script type="text/javascript" src="/js/routers/object.router.js"></script>
	<script type="text/javascript" src="/js/routers/user.router.js"></script>
	<script type="text/javascript" src="/js/routers/tag.router.js"></script>
	<script type="text/javascript" src="/js/routers/main.router.js"></script>
	
	<!-- eventlisteners -->
	<script type="text/javascript" src="/js/eventlisteners.js"></script>
	
	<script>
	App.Models.Object = Backbone.Model.extend({
	});

	App.Models.Content = App.Models.Object.extend({
		set: function(attributes, options) {
			var a = [];
			
			if (attributes.newtags !== undefined && !(attributes.newtags instanceof App.Collections.Tags)) {
		        attributes.newtags = new App.Collections.Tags(attributes.newtags);
		    }

		    if (attributes.tags !== undefined && !(attributes.tags instanceof App.Collections.Tags)) {
			    _.each(attributes.tags, function(tag) { a.push({'name': tag}); }); // add name to tag for model
		        attributes.tags = new App.Collections.Tags(a); a = [];
		    }
		    if (attributes.countries !== undefined && !(attributes.countries instanceof App.Collections.Tags)) {
				_.each(attributes.countries, function(country) { a.push({'name': country}); }); // add name to tag for model
		        attributes.countries = new App.Collections.Tags(a); a = [];
		    }
		    if (attributes.comments !== undefined && !(attributes.comments instanceof App.Collections.Comments)) attributes.comments = new App.Collections.Comments(attributes.comments);
		    if (attributes.commentcount !== undefined && attributes.commentcount === null) attributes.commentcount = 0;
		    
		    return Backbone.Model.prototype.set.call(this, attributes, options);
		}
	});

	<?php 
	function printModelAndCollection($object_type, $args, $type) {
		$plural = $args['plural'];
		$Object = ucfirst($object_type);
		$Objects = ucfirst($plural);
	
		$obj = new $Object();
		$obj = $obj->to_backbone_model();
		unset($obj['id']);
		//$vars = $obj->vars();
		//$vars['type'] = $object;
		$defaults = json_encode($obj);
	
		$str = '';
		$str = "App.Models.$Object = App.Models.$type.extend();\n\t";
		$str .= "App.Models.$Object.prototype.defaults = $defaults;\n\t";
		$str .= "App.Models.$Object.prototype.urlRoot = '/$object_type';\n\t";
	
		$str .= "App.Collections.$Objects = Backbone.Collection.extend({
					model: App.Models.$Object,
					url: '/$plural'
				});\n\t";
	
		return $str;
	}
	
	foreach (App::$objects as $object_type => $args) {
		echo printModelAndCollection($object_type, $args, 'Object');
	}
	
	foreach (App::$content as $object_type => $args) {
		echo printModelAndCollection($object_type, $args, 'Content');
	}
	
	
	/*
	foreach (App::$content as $object => $args) {
		$plural = $args['plural'];
		$Object = ucfirst($object);
		$Objects = ucfirst($plural);
		
		$obj = new $Object();
		$defaults = json_encode(App::vars($obj));
	
		
		echo "App.Models.$Object = App.Models.Content.extend({
			urlRoot: '/$object'		
		});\n\t";
		echo "App.Models.$Object.prototype.defaults = $defaults;\n\t";
		
		echo "App.Collections.$Objects = Backbone.Collection.extend({
			model: App.Models.$Object,
			url: '/$plural'		
		});\n\t";
	}
	*/
	?>
	App.user = new App.Models.User();
	App.user.set(<?php echo $_SESSION['user'] ?>);
	</script>

	<link type="text/css" rel="stylesheet" href="/css/style.css" />
	<link type="text/css" rel="stylesheet" href="/css/document.css" />
	<link type="text/css" rel="stylesheet" href="/css/link.css" />
	<link type="text/css" rel="stylesheet" href="/css/form.css" />
	<link type="text/css" rel="stylesheet" href="/css/popup.css" />
	<link type="text/css" rel="stylesheet" href="/css/systemmessage.css" />
</head>
<body>	
	<div id="wrapper">
		<div id="header">
			<div id="menu">
				<a href="">Home</a> - 
				<?php 
				foreach (App::$content as $c) {
					echo '<a href="#'.$c['plural'].'">'.ucfirst($c['plural']).'</a> - ';
				}
				$loginout = ($_SESSION['user']) ? 'logout' : 'login';
				?>
				<a href="/<?php echo $loginout; ?>"><?php echo $loginout; ?></a>
			</div>
		</div>
		
		<div id="main"></div>
	</div>
	<script>
	(function($) {		
		App.Routers.object = new App.ObjectRouter();
		App.Routers.user = new App.UserRouter();
		App.Routers.tag = new App.TagRouter();
		App.Routers.main = new App.MainRouter();
		
		Backbone.history.start();
	})(jQuery);
	</script>
</body>
</html>
<?php } ?>
