<?php
include('level.php');
include($level_header);

if($_SESSION['group'] == 'admin')
{
	if(@$_POST['new_art'] != 1)
	{	
		?>
		
		<form method="post" action="new_art.php">
		<table>
		<tr><input type="text" name="title_article" value="Titre de l'article" maxlength="64" /></td></tr>
		<tr><td><textarea rows="30" cols="100" name="article"">Tapez ici votre article</textarea></td></tr>
		<tr><td><input type="hidden" name="new_art" value="1" /></td></tr>
		<tr><td><input type="submit" value="Envoyer !" /></td></tr>
		</table>
		</form>
		
		<?php
	}
	elseif($_POST['new_art'] == 1)
	{
		$title = mysql_real_escape_string($_POST['title_article']);
		$article_ = mysql_real_escape_string($_POST['article']);
		$article = nl2br($article_);
		$timestamp = time();
		
		mysql_query("INSERT INTO articles VALUES('','".$timestamp."','".$_SESSION['pseudo']."','".$title."','".$article."','0');");
		
		echo "<p>Votre article a bien été ajouté.</p>";
	}
}

include($level_footer);
?>