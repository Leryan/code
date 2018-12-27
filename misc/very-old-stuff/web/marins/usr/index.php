<?php
include('level.php');
include($level_header);

if($_SESSION['group'] != NULL OR $_SESSION['group'] != 'visitor')
{
	if($_SESSION['group'] == 'admin')
	{
		?>
		
		<ul>
		<li><a href="edit_article.php">Editer un article</a></li>
		<li><a href="edit_group.php">Modifier le groupe d'un membre</a></li>
		</ul>
		
		<?php
	}
	elseif($_SESSION['group'] == 'modo')
	{
		
	}
	elseif($_SESSION['group'] == 'usr')
	{
		
	}
}
else
{
	?><p>Vous n'avez pas de compte !</p><?php
}

include($level_footer);
?>