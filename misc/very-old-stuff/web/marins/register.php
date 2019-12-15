<?php
include('level.php');
include($level_header);

if(@$_POST['register'] != "1")
{
	unset($_SESSION['captcha']);
	
	$nbr1 = rand(0, 20);
	$nbr2 = rand(0, 20);
	$nbr3 = rand(0, 20);
	
	$_SESSION['captcha'] = $nbr1 * $nbr2 + $nbr3
	?>
	
	<form method="post" action="register.php">
	<p>Inscription</p>
	<table>
	<caption>Les champs suivis d'une étoile sont obligatoires !</caption>
	<tr><td><label for="name">Nom: </label></td><td><input type="text" name="name" id="name" /></td></tr>
	<tr><td><label for="first_name">Prénom: </label></td><td><input type="text" name="first_name" id="first_name" /></td></tr>
	<tr><td><label for="email">E-mail: </label></td><td><input type="text" name="email" id="email" />*</td></tr>
	<tr><td><label for="email_conf">Confirmez: </label></td><td><input type="text" name="email_conf" id="email_conf" />*</td></tr>
	<tr><td><label for="pseudo">Pseudonyme: </label></td><td><input type="text" name="pseudo" maxlength="15" id="pseudo" />*</td></tr>
	<tr><td><label for="mdp">Mot de passe (6 caractères minimum): </label></td><td><input type="password" name="mdp" id="mdp" />*</td></tr>
	<tr><td><label for="mdp_conf">Confirmez: </label></td><td><input type="password" name="mdp_conf" id="mdp_conf" />*</td></tr>
	<tr><td><label for="captcha">Combien font <?php echo "$nbr1 fois $nbr2 plus $nbr3"?> ?</label></td><td><input type="text" name="captcha" id="captcha" />*</td></tr>
	<tr><td><input type="hidden" name="register" value="1" /></td></tr>
	<tr><td><label>Cliquez pour valider !</label></td><td><input type="submit" value="Valider" /></td></tr>
	</table>
	</form>
	
	<?php
}
elseif($_POST['register'] == "1")
{
	$name = mysql_real_escape_string($_POST['name']);
	$first_name = mysql_real_escape_string($_POST['first_name']);
	$email = mysql_real_escape_string($_POST['email']);
	$email_conf = mysql_real_escape_string($_POST['email_conf']);
	$pseudo = mysql_real_escape_string($_POST['pseudo']);
	$len_mdp = strlen(mysql_real_escape_string($_POST['mdp']));
	$mdp = sha1($_POST['mdp']);
	$mdp_conf = sha1($_POST['mdp_conf']);
	$captcha = mysql_real_escape_string($_POST['captcha']);
	
	if(preg_match("#^[a-z0-9._-]+@[a-z0-9._-]{2,}\.[a-z]{2,4}$#", $email))
	{
		$conform = 1;
	}
	else
	{
		$conform = 0;
	}
	
	$retour_pseudo = mysql_query("SELECT COUNT(*) AS nbr FROM members WHERE member_pseudo='".$pseudo."'");
	$retour_pseudo = mysql_fetch_assoc($retour_pseudo);
	$retour_email = mysql_query("SELECT COUNT(*) AS nbr FROM members WHERE member_email='".$email."'");
	$retour_email = mysql_fetch_assoc($retour_email);
	
	if($retour_pseudo['nbr'] == 0 AND
		$retour_email['nbr'] == 0 AND
		$len_mdp > 5 AND
		$email != NULL AND
		$email_conf != NULL AND
		$email == $email_conf AND
		$pseudo != NULL AND
		$mdp != NULL AND
		$mdp_conf != NULL AND
		$mdp == $mdp_conf AND
		$captcha != NULL AND
		$captcha == $_SESSION['captcha'] AND
		$conform == 1)
	{
		$timestamp = time();
		
		if($captcha != $_SESSION['captcha'] OR $captcha == NULL)
		{
			echo "<p>Le résultat est faut.<br />Ecrivez avec des chiffres uniquement.</p>";
		}
		
		mysql_query("INSERT INTO members VALUES('','".$_SESSION['IP']."','".$timestamp."','member','".$name."','".$first_name."','".$email."','".$pseudo."','".$mdp."');");
		mysql_query("INSERT INTO members_IP VALUES('','".$pseudo."','".$_SESSION['IP']."','0');");
		
		?><p>Inscription réussie ! Vous pouvez dès maintenant vous <a href='login.php'>connecter</a> avec vos identifiants:<br /><?php echo htmlspecialchars($pseudo); ?></p><?php
		
		unset($_SESSION['captcha']);
	}
	if($retour_pseudo['nbr'] != 0)
	{
		echo "<p>Le pseudonyme est déjà prit.</p>";
	}
	if($retour_email['nbr'] != 0)
	{
		echo "<p>Vous ne pouvez utiliser cette adresse email car elle est déjà prise par un auter membre !</p>";
	}
	if($len_mdp < 6)
	{
		echo "<p>Le mot de passe est trop court. Vous devez avoir au moins 6 caractères !</p>";
	}
	if($mdp != $mdp_conf)
	{
		echo "<p>Les mots de passe ne sont pas identiques.</p>";
	}
	if($email != $email_conf)
	{
		echo "<p>Les email ne sont pas identiques.</p>";
	}
	if($conform == 0)
	{
		echo "<p>L'adresse email n'est pas valide !</p>";
	}
	$_POST['register'] = 0;
}
else
{
	echo "<p>Tricheur !</p>";
	unset($_SESSION['captcha']);
}
?>
<?php
include($level_footer);
?>