<?php
include('level.php');
include($level_header);
?>

<a href="index.php">Forum</a> ->
<table>
<caption>Le forum</caption>
<tr><th>Classes</th><th>Nombre de messages</th><th>Dernier message par</th><th>Dans</th><th>Date</th></tr>

<?php
$class_ = mysql_query("SELECT * FROM fom_class");
while($class = mysql_fetch_assoc($class_))
{
	?>
	
	<tr>
	<td><a href="fom_topics.php?class_id=<?php echo $class['id']; ?>"><?php echo stripslashes($class['class_name']); ?></a></td>
	<td class="forum"><?php echo $class['class_nbr_posts']; ?></td>
	<td class="forum"><?php echo $class['class_member_lp']; ?></td>
	<?php
	$topic_title = mysql_fetch_assoc(mysql_query("SELECT topic_title FROM fom_topics WHERE id='".$class['class_id_lp']."'"));
	?>
	<td><a href="fom_messages.php?topic_id=<?php echo $class['class_id_lp']; ?>&amp;class_id=<?php echo $class['id']; ?>"><?php echo $topic_title['topic_title']; ?></a></td>
	<td class="forum"><?php echo date('d/m/Y \à H\h i\m\i\n', $class['class_datetime_lp']); ?></td>
	</tr>
	
	<?php
}
?>

</table>

<?php
include($level_footer);
?>