<?php
include('level.php');
include($level_header);
?>
<?php
if($_SESSION['group'] != 'visitor')
{
	if(@$_POST['new_message'] != 1)
	{
		$topic_id = mysql_real_escape_string(htmlspecialchars($_GET['topic_id']));
		$class_id = mysql_real_escape_string(htmlspecialchars($_GET['class_id']));
		$topic_title = mysql_fetch_assoc(mysql_query("SELECT topic_title FROM fom_topics WHERE id='".$topic_id."'"));
		$class_name = mysql_fetch_assoc(mysql_query("SELECT class_name FROM fom_class WHERE id='".$class_id."'"));
		?>
		
		<a href="index.php">Forum</a> ->
		<a href="fom_topics.php?class_id=<?php echo $class_id; ?>"><?php echo $class_name['class_name']; ?></a> ->
		<a href="fom_messages.php?topic_id=<?php echo $topic_id; ?>&amp;class_id=<?php echo $class_id; ?>"><?php echo $topic_title['topic_title']; ?></a>
		<form method="post" action="fom_new_message.php">
		<table>
		<tr><td><textarea rows="30" cols="100" name="message"">Tapez ici votre message</textarea></td></tr>
		<tr><td><input type="hidden" name="new_message" value="1" /></td></tr>
		<tr><td><input type="hidden" name="topic_id" value="<?php echo $topic_id; ?>" /></td></tr>
		<tr><td><input type="hidden" name="class_id" value="<?php echo $class_id; ?>" /></td></tr>
		<tr><td><input type="submit" value="Envoyer !" /></td></tr>
		</table>
		</form>
		<table class="forum_messages">
		<caption>Messages précédents:</caption>
		
		<?php
		$messages_topic_ = mysql_query("SELECT * FROM fom_responses WHERE response_to_topic_id='".$topic_id."' ORDER BY id DESC");
		
		while($messages_topic = mysql_fetch_assoc($messages_topic_))
		{
			?>
			
			<tr class="forum_message_bar">
			<td><?php echo $messages_topic['response_member']; ?></td>
			</tr>
			<tr>
			<td class="forum_message"><?php echo wordwrap(nl2br(stripslashes($messages_topic['response_message'])), 160, '<br />', true); ?></td>
			</tr>
			
			<?php
		}
		$messages_topic_ = mysql_query("SELECT * FROM fom_topics WHERE id='".$topic_id."'");
		
		while($messages_topic = mysql_fetch_assoc($messages_topic_))
		{
			?>
			
			<tr class="forum_message_bar">
			<td class="forum_member"><?php echo $messages_topic['topic_member']; ?></td>
			</tr>
			<tr>
			<td class="forum_message"><?php echo wordwrap(nl2br(stripslashes($messages_topic['topic_message'])), 160, '<br />', true); ?></td>
			</tr>
			
			<?php
		}
		?>
		
		</table>
		
		<?php
	}
	elseif($_POST['new_message'] == 1)
	{
		$topic_id = mysql_real_escape_string(htmlspecialchars($_POST['topic_id']));
		$topic_title = mysql_fetch_assoc(mysql_query("SELECT topic_title FROM fom_topics WHERE id='".$topic_id."'"));
		$class_id = mysql_real_escape_string(htmlspecialchars($_POST['class_id']));
		$class_name = mysql_fetch_assoc(mysql_query("SELECT class_name FROM fom_class WHERE id='".$class_id."'")); ?>
		
		<a href="index.php">Forum</a>-><a href="fom_topics.php?class_id=<?php echo $class_id; ?>"><?php echo $class_name['class_name']; ?></a>-><a href="fom_messages.php?topic_id=<?php echo $topic_id; ?>&amp;class_id=<?php echo $class_id; ?>"><?php echo $topic_title['topic_title']; ?></a><?php
		
		$message_ = mysql_real_escape_string($_POST['message']);
		$message = nl2br($message_);
		
		mysql_query("INSERT INTO fom_responses VALUES('','".$topic_id."','".$_SESSION['pseudo']."','".$message."','".time()."');");
		
		$nbr_messages = mysql_fetch_assoc(mysql_query("SELECT class_nbr_posts FROM fom_class WHERE id='".$class_id."'"));
		$nbr_messages['class_nbr_posts']++;
		
		mysql_query("UPDATE fom_class SET class_id_lp='".$topic_id."' , class_member_lp='".$_SESSION['pseudo']."' , class_datetime_lp='".time()."' , class_nbr_posts='".$nbr_messages['class_nbr_posts']."' WHERE id='".$class_id."'");
		mysql_query("UPDATE fom_topics SET topic_datetime='".time()."', topic_member_lp='".$_SESSION['pseudo']."' WHERE id='".$topic_id."'");
		
		echo "<p>Message enregistré.</p>";
	}
}
?>
<?php
include($level_footer);
?>