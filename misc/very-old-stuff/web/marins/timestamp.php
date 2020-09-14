<?php
include('level.php');
include($level_header);

$timestamp = time();

echo $timestamp;
echo "<br />";

mysql_query("INSERT INTO timestamp VALUES('','".$timestamp."');");

$timestamp_ = mysql_query("SLECT * FROM timestamp");

while($timestamp = mysql_fetch_assoc($timestamp_))
{
	echo $timestamp['timestamp'];
	echo "<br />";
}

include($level_footer);
?>