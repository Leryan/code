<?php
include('level.php');
include($level_header);
?>
<?php
if(@$_POST['login'] != 1)
{
	?>
	<form method="post" action="login.php">
	<p>Connexion</p>
	<table>
	<tr><td><label for="pseudo">Pseudonyme: </label></td><td><input type="text" name="pseudo" id="pseudo" /></td></tr>
	<tr><td><label for="mdp">Mot de passe: </label></td><td><input type="password" name="mdp" id="mdp" /></td></tr>
	<tr><td><input type="hidden" name="login" value="1" /></td></tr>
	<tr><td><label>Cliquez pour valider !</label></td><td><input type="submit" value="Valider" /></td></tr>
	</table>
	</form>
	<?php
}
elseif($_POST['login'] == 1)
{
	$pseudo = mysql_real_escape_string($_POST['pseudo']);
	$mdp = sha1($_POST['mdp']);
	$retour = mysql_query("SELECT COUNT(*) AS nbr FROM members WHERE member_pseudo='".$pseudo."' AND member_mdp='".$mdp."'");
	$retour = mysql_fetch_assoc($retour);
	
	if($retour['nbr'] == 1)
	{
		$info_con = mysql_fetch_assoc(mysql_query("SELECT * FROM members WHERE member_pseudo='".$pseudo."' AND member_mdp='".$mdp."'"));
		
		$_SESSION['pseudo'] = $info_con['member_pseudo'];
		$_SESSION['group'] = $info_con['member_group'];
		
		$retour_IP = mysql_fetch_assoc(mysql_query("SELECT COUNT(*) AS nbr FROM members_IP WHERE IP_member='".$_SESSION['pseudo']."' AND IP_member_IP='".$_SESSION['IP']."'"));
		
		if($retour_IP['nbr'] == 0)
		{
			mysql_query("INSERT INTO members_IP VALUES('','".$_SESSION['pseudo']."','".$_SESSION['IP']."','1','".time()."');");
		}
		elseif($retour_IP['nbr'] != 0)
		{
			$retour_IP = mysql_fetch_assoc(mysql_query("SELECT id FROM members_IP WHERE IP_member='".$_SESSION['pseudo']."' AND IP_member_IP='".$_SESSION['IP']."'"));
			$nbr_conn_IP = mysql_fetch_assoc(mysql_query("SELECT IP_nbr_conn_IP FROM members_IP WHERE IP_member_IP='".$_SESSION['IP']."' AND IP_member='".$_SESSION['pseudo']."'"));
			$nbr_conn_IP['IP_nbr_conn_IP']++;
			
			mysql_query("UPDATE members_IP SET IP_nbr_conn_IP='".$nbr_conn_IP['IP_nbr_conn_IP']."' WHERE id='".$retour_IP['id']."'");
			
			$index = 'index.php?action=2';
			
			header("Location: $index");
		}
	}
	else
	{
		echo "<p>Identifiants incorrectes !</p>";
	}
}
else
{
	echo "<p>Tricheur !</p>";
}

include($level_footer);
?>