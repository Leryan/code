<?php
include('level.php');
include($level_header);

if($_SESSION['group'] == 'admin')
{
	?>
	
	<form method="post" action="media.php">
	<table>
	<caption>Envois de medias. Les fichiers doivent être de type MP3 et l'url DOIT être absolue !</caption>
	<tr><td><input type="text" name="media0" /></td></tr>
	<tr><td><input type="hidden" name="media" value="1" /></td></tr>
	<tr><td><input type="submit" value="Envoyer !" /></td></tr>
	</table>
	</form>
	
	<?php
	if(@$_POST['media'] == 1)
	{
		$media0 = mysql_real_escape_string(htmlspecialchars($_POST['media0']));
		$timestamp = time();
		
		mysql_query("INSERT INTO medias VALUES('','".$media0."');");
		
		echo "<p>Media ajouté.</p>";
	}
}

include($level_footer);
?>