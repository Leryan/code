<?php
session_start();

include('level.php');

mysql_connect(A_BDD , U_BDD , M_BDD);
mysql_select_db(N_BDD);

if(isset($_GET['action']) AND $_GET['action'] == 1)
{
	session_destroy();
	header('Location: index.php?action_=1');
}

$_SESSION['IP'] = $_SERVER['REMOTE_ADDR'];

if(!isset($_SESSION['group']) AND !isset($_SESSION['pseudo']))
{
	$_SESSION['pseudo'] = 'visitor';
	$_SESSION['group'] = 'visitor';
}
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xml:lang="fr" lang="fr" xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><?php echo TITLE; ?></title>
<meta http-equiv="content-type" content="text/html; charset=utf-8" />
<link rel="stylesheet" media="screen" type="text/css" title="Design" href="<?php echo $level; ?>css/general.css" />
</head>
<body>
<div id="header">
<div id="titre_header">
<h1><?php echo TITLE; ?></h1>
</div>
</div>
<div id="conteneur">
<div id="menu">
<div class="bouton">Site</div>
<ul class="list">
<li><a href="/marins/index.php">Index</a></li>
<?php
if($_SESSION['group'] == 'visitor' AND $_SESSION['group'] == 'visitor')
{ 
	?>
	
	<li><a href="<?php echo $level; ?>register.php">Register</a></li>
	<li><a href="<?php echo $level; ?>login.php">Login</a></li>
	
	<?php
}

elseif($_SESSION['group'] != 'visitor')
{
	?><li><a href="<?php echo $level; ?>index.php?action=1">Déconnexion</a></li><?php
} 
?>

</ul>
<div class="bouton">Forum</div>
<ul class="list">
<li><a href="http://marrrins.ze.cx/forum/">Forum - phpBB</a></li>
<li><a href="<?php echo $level; ?>fom/">Forum - Dev</a></li>
</ul>

<?php
if($_SESSION['group'] == 'admin')
{
	?>
	
	<div class="bouton">Adm</div>
	<ul class="list">
	<li><a href="<?php echo $level; ?>adm/new_art.php">New_art</a></li>
	<li><a href="<?php echo $level; ?>adm/edit_art.php">Edit_art</a></li>
	<li><a href="<?php echo $level; ?>adm/media.php">Add_media</a></li>
	<li><a href="<?php echo $level; ?>adm/fom_new_class.php">Fom_new_class</a></li>
	</ul>
	
	<?php
}
?>

<div class="bouton">Dev</div>
<ul class="list">
<li><a href="http://localhost/phpMyAdmin/">PMA - local</a></li>
<li><a href="http://phpmyadmin.alwaysdata.com/">PMA - AD</a></li>
<li><a href="http://localhost/users/florent/new/"><?php echo TITLE; ?> - local</a></li>
<li><a href="http://marrrins.ze.cx"><?php echo TITLE; ?> - AD</a></li>
<li><a href="<?php echo $level; ?>media/todolist.txt">Todo-list</a></li>
</ul>
<div class="bouton">Trucs</div>
<ul class="list">
<li>
<a href="http://validator.w3.org/check?uri=referer">
<img src="http://www.w3.org/Icons/valid-xhtml10-blue" alt="Valid XHTML 1.0 Strict" height="31" width="88" />
</a>
</li>
</ul>
</div>
<div id="corps">

<?php
if(isset($_GET['action']) AND $_GET['action'] == 2)
{
	echo "<p>Vous êtes connecté(e) !</p>";
}
elseif(isset($_GET['action_']) AND $_GET['action_'] == 1)
{
	echo "<p>Vous êtes déconnecté(e) !</p>";
}
?>