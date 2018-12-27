<?php
include('level.php');
include($level_header);
?>

<form method="post" action="old_timestamp.php">
<table>
<tr><td><label>Secondes: </label></td><td><input type="text" name="sec" /></td></tr>
<tr><td><label>Minutes: </label></td><td><input type="text" name="min" /></td></tr>
<tr><td><label>Heures: </label></td><td><input type="text" name="hours" /></td></tr>
<tr><td><label>Jour: </label></td><td><input type="text" name="day" /></td></tr>
<tr><td><label>Mois: </label></td><td><input type="text" name="month" /></td></tr>
<tr><td><label>Année: </label></td><td><input type="text" name="year" /></td></tr>
<tr><td><input type="hidden" name="mktime" value="1"/></td></tr>
<tr><td><input type="submit" /></td></tr>
</table>
</form>

<?php
if($_POST['mktime'] == 1)
{
	$vieux_timestamp = mktime($_POST['hours'], $_POST['min'], $_POST['sec'], $_POST['month'], $_POST['day'], $_POST['year']);
	
	echo 'Le timestamp du '.$_POST['day'].'/'.$_POST['month'].'/'.$_POST['year'].' à '.$_POST['hours'].'h '.$_POST['min'].'min '.$_POST['sec'].'s était : ' . $vieux_timestamp;
}

include($level_footer);
?>