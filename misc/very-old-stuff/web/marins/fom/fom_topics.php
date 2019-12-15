<?php
include('level.php');
include($level_header);

$class_id = mysql_real_escape_string(htmlspecialchars($_GET['class_id']));
$class_name = mysql_fetch_assoc(mysql_query("SELECT class_name FROM fom_class WHERE id='".$class_id."'"));
?>

<a href="index.php">Forum</a> ->
<a href="fom_topics.php?class_id=<?php echo $class_id; ?>"><?php echo $class_name['class_name']; ?></a>

<?php
if($_SESSION['group'] != 'visitor')
{
	?><p><a href="fom_new_topic.php?class_id=<?php echo $class_id; ?>" />Nouveau topic</a><?php
}
?>

<table>
<caption>Topics</caption>
<tr class="forum"><th class="forum">Nom du topic</th><th>Auteur</th><th>Dernier message par</th><th>Date</th></tr>

<?php
$topics_ = mysql_query("SELECT * FROM fom_topics WHERE topic_to_class_id='".$class_id."' ORDER BY topic_datetime DESC");

while($topics = mysql_fetch_assoc($topics_))
{
	?>
	
	<tr>
	<td><a href="fom_messages.php?topic_id=<?php echo $topics['id']; ?>&amp;class_id=<?php echo $class_id; ?>"><?php echo htmlspecialchars($topics['topic_title']); ?></a></td>
	<td class="forum"><?php echo $topics['topic_member']; ?></td>
	<td class="forum"><?php echo $topics['topic_member_lp']; ?></td>
	<td class="forum"><?php echo date('d/m/Y \à H\h i\m\i\n', $topics['topic_datetime']); ?></td>
	</tr>
	
	<?php
}
?>

</table>

<?php
include($level_footer);
?>