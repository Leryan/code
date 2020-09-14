<?php
include('level.php');
include($level_header);
?>
<?php
if($_SESSION['group'] != 'visitor')
{
	if($_POST['new_topic'] != 1)
	{
		$class_id = mysql_real_escape_string(htmlspecialchars($_GET['class_id']));
		$class_name = mysql_fetch_assoc(mysql_query("SELECT class_name FROM fom_class WHERE id='".$class_id."'")); ?>
		
		<a href="index.php">Forum</a> ->
		<a href="fom_topics.php?class_id=<?php echo $class_id; ?>"><?php echo $class_name['class_name']; ?></a>
		<form method="post" action="fom_new_topic.php">
		<table>
		<tr><input type="text" name="title" maxlength="32" value="Titre du topic"/></td></tr>
		<tr><td><textarea rows="30" cols="100" name="message"">Tapez ici votre message</textarea></td></tr>
		<tr><td><input type="hidden" name="new_topic" value="1" /></td></tr>
		<tr><td><input type="hidden" name="class_id" value="<?php echo $class_id; ?>" /></td></tr>
		<tr><td><input type="submit" value="Envoyer !" /></td></tr>
		</table>
		</form>
		
		<?php
	}
	elseif($_POST['new_topic'] == 1)
	{
		$title = mysql_real_escape_string($_POST['title']);
		$message_ = mysql_real_escape_string($_POST['message']);
		$class_id = mysql_real_escape_string(htmlspecialchars($_POST['class_id']));
		$class_name = mysql_fetch_assoc(mysql_query("SELECT class_name FROM fom_class WHERE id='".$class_id."'")); ?>
		
		<a href="index.php">Forum</a>-><a href="fom_topics.php?class_id=<?php echo $class_id; ?>"><?php echo $class_name['class_name']; ?></a><?php
		
		$message = nl2br($message_);
		$time = time();
		
		mysql_query("INSERT INTO fom_topics VALUES('','".$class_id."','".$_SESSION['pseudo']."','".$title."','".$message."','".$time."', '".$_SESSION['pseudo']."');");
		
		$topic_id = mysql_fetch_assoc(mysql_query("SELECT id FROM fom_topics WHERE topic_datetime='".$time."' AND topic_member='".$_SESSION['pseudo']."'"));
		$nbr_messages = mysql_fetch_assoc(mysql_query("SELECT class_nbr_posts FROM fom_class WHERE id='".$class_id."'"));
		$nbr_messages['class_nbr_posts']++;
		
		mysql_query("UPDATE fom_class SET class_datetime_lp='".$time."' , class_id_lp='".$topic_id['id']."' , class_nbr_posts='".$nbr_messages['class_nbr_posts']."', class_member_lp='".$_SESSION['pseudo']."' WHERE id='".$class_id."'");
		
		echo "<p>Nouveau topic enregistré.</p>";
	}
}
?>
<?php
include($level_footer);
?>