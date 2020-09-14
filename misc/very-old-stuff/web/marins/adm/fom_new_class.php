<?php
include('level.php');
include($level_header);

if($_SESSION['group'] == 'admin')
{
	if(@$_POST['new_class'] != 1)
	{	
		?>
		
		<form method="post" action="fom_new_class.php">
		<table>
		<tr><input type="text" name="class_name" maxlength="32" value="Nom de la classe"/></td></tr>
		<tr><td><input type="hidden" name="new_class" value="1" /></td></tr>
		<tr><td><input type="submit" value="Envoyer !" /></td></tr>
		</table>
		</form>
		
		<?php
	}
	elseif($_POST['new_class'] == 1)
	{
		$class_name = mysql_real_escape_string(htmlspecialchars($_POST['class_name']));
		
		mysql_query("INSERT INTO fom_class VALUES('','".$class_name."','','','".time()."','0');");
		
		echo "<p>La classe a bien été ajoutée.</p>";
	}
}

include($level_footer);
?>