<?php
include('level.php');
include($level_header);

if($_SESSION['group'] == 'admin')
{
	if(htmlspecialchars(@$_POST['edit_art']) != 1)
	{
		if(@$_GET['article_id'] == NULL)
		{
			?>
			
			<table>
			<th>Titre de l'article</th><th></th>
			
			<?php
			$edit_article_ = mysql_query("SELECT * FROM articles WHERE article_member='".$_SESSION['pseudo']."' ORDER BY id DESC");
			
			while($edit_article = mysql_fetch_assoc($edit_article_))
			{
				?>
				
				<tr><td><a href="edit_art.php?article_id=<?php echo $edit_article['id']; ?>"><?php echo $edit_article['article_title']; ?></a></td></tr>
				
				<?php
			}
			?>
			
			</table>
			
			<?php
		}
		elseif(isset($_GET['article_id']) AND $_GET['article_id'] != NULL)
		{
			$article_id = mysql_real_escape_string(htmlspecialchars($_GET['article_id']));
			$article = mysql_fetch_assoc(mysql_query("SELECT * FROM articles WHERE id='".$article_id."'"));
			
			if($article['article_member'] == $_SESSION['pseudo']){
				?>
				
				<form method="post" action="edit_art.php">
				<table>
				<tr><input type="text" name="title_article" value="<?php echo stripslashes($article['article_title']); ?>" maxlength="64" /></td></tr>
				<tr><td><textarea rows="30" cols="100" name="article""><?php echo stripslashes($article['article_message']); ?></textarea></td></tr>
				<tr><td><input type="hidden" name="edit_art" value="1" /></td></tr>
				<tr><td><input type="hidden" name="article_id" value="<?php echo $article_id; ?>" /></td></tr>
				<tr><td><input type="submit" value="Envoyer !" /></td></tr>
				</table>
				</form>
				
				<?php
			}
			else
			{
				echo "<p>TRICHEUR !</p>";
			}
		}
	}
	elseif($_POST['edit_art'] == 1)
	{
		$title = mysql_real_escape_string($_POST['title_article']);
		$article_ = mysql_real_escape_string($_POST['article']);
		$article = nl2br($article_);
		$article_id = mysql_real_escape_string(htmlspecialchars($_POST['article_id']));
		
		mysql_query("UPDATE articles SET article_title='".$title."', article_message='".$article."' WHERE id='".$article_id."'");
		
		echo "<p>Votre article a bien été modifié.</p>";
	}
}

include($level_footer);
?>