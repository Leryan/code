<?php
include('level.php');
include($level_header);

$topic_id = mysql_real_escape_string(htmlspecialchars($_GET['topic_id']));
$topic_title = mysql_fetch_assoc(mysql_query("SELECT topic_title FROM fom_topics WHERE id='".$topic_id."'"));
$class_id = mysql_real_escape_string(htmlspecialchars($_GET['class_id']));
$class_name = mysql_fetch_assoc(mysql_query("SELECT class_name FROM fom_class WHERE id='".$class_id."'"));
?>

<a href="index.php">Forum</a> ->
<a href="fom_topics.php?class_id=<?php echo $class_id; ?>"><?php echo $class_name['class_name']; ?></a> ->
<a href="#"><?php echo $topic_title['topic_title']; ?></a>
<div id="path"></div>
<table class="forum_messages">
<caption>Messages</caption>

<?php
$messages_topic = mysql_fetch_assoc(mysql_query("SELECT * FROM fom_topics WHERE id='".$topic_id."'"));
$statut = mysql_fetch_assoc(mysql_query("SELECT * FROM members WHERE member_pseudo='".$messages_topic['topic_member']."'"));
$date = date('d/m/Y \à H\h i\m\i\n', $messages_topic['topic_datetime']);
?>

<tr id="<?php echo $topic_id; ?>" class="forum_message_bar">
<td><a href="#<?php echo $topic_id; ?>">#</a><?php echo $messages_topic['topic_member']; ?> [<?php echo $statut['member_group']; ?>] Le <?php echo $date; ?></td>
</tr>
<tr>
<td class="forum_message"><?php echo wordwrap(nl2br(stripslashes(htmlspecialchars($messages_topic['topic_message']))), 160, '<br />', true); ?></td>
</tr>

<?php
$retour = mysql_query("SELECT * FROM fom_responses WHERE response_to_topic_id='".$topic_id."' ORDER BY id");

while($messages_topic = mysql_fetch_assoc($retour))
{
	?>
	
	<tr id="<?php echo $messages_topic['id']; ?>" class="forum_message_bar">
	<td><a href="#<?php echo $messages_topic['id']; ?>">#</a><?php echo $messages_topic['response_member']; ?> [<?php echo $statut['member_group']; ?>]  Le <?php echo date('d/m/Y \à H\h i\m\i\n', $messages_topic['response_datetime']); ?></td>
	</tr>
	<tr>
	<td class="forum_message"><?php echo wordwrap(nl2br(stripslashes(htmlspecialchars($messages_topic['response_message']))), 160, '<br />', true); ?></td>
	</tr>
	
	<?php
}
if($_SESSION['group'] != 'visitor')
{
	?><tr><td><a href="fom_new_message.php?topic_id=<?php echo $topic_id; ?>&amp;class_id=<?php echo $class_id; ?>">Répondre</a></td></tr><?php
}
?>

</table>

<?php
include($level_footer);
?>