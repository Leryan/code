<?php
include('inc/header.php');
?>

<div id="dewplayer">
    <object type="application/x-shockwave-flash" data="<?php echo $level . 'media/dewplayer-multi.swf?mp3=' ?>

            <?php
            $media_ = mysql_query("SELECT media FROM medias ORDER BY id DESC");

            while ($media = mysql_fetch_assoc($media_)) {
                $medias[] = $media['media'];
            }

            $media_final = implode('|', $medias);

            echo $media_final;
            ?>" width="240" height="20">
        <param name="wmode" value="transparent" />
        <param name="movie" value="<?php echo $level . 'media/dewplayer-multi.swf?mp3=' . $media_final ?>" />
    </object>
</div>
<div id="articles">

<?php
$nbr_articles_per_page = 10;
$nb_messages = mysql_fetch_assoc(mysql_query('SELECT COUNT(*) AS nb_messages FROM articles'));
$nbr_pages = ceil($nb_messages['nb_messages'] / $nbr_articles_per_page);
$pages_max = 5;

echo "<p>Page : ";
if ($pages_max > $nbr_pages) {
    for ($i = 1; $i <= $nbr_pages; $i++) {
        echo '<a href="index.php?page=' . $i . '">' . $i . '</a>';
    }
} elseif ($pages_max < $nbr_pages) {
    for ($i = 1; $i <= $pages_max; $i++) {
        echo '<a href="index.php?page=' . $i . '">' . $i . '</a>';
    }
    echo '...';
}
?></p><?php
    if (isset($_GET['page'])) {
        $page = $_GET['page'];
    } else {
        $page = 1;
    }
?>

<table>

<?php
$firts_message = ($page - 1) * $nbr_articles_per_page;
$article_ = mysql_query('SELECT * FROM articles ORDER BY id DESC LIMIT ' . $firts_message . ', ' . $nbr_articles_per_page . '');

while ($article = mysql_fetch_assoc($article_)) {
    ?>

        <tr class="a_titre">
            <td><label><a href="#"><img src="img/css/pic.png" alt="pic" /></a></label></td>
            <td class="a_titre"><h2><?php echo stripslashes($article['article_title']) . '</h2> par ' . $article['article_member'] . ' le ' . date('d/m/Y', $article['article_datetime']) . ' à ' . date('H\h i\m\i\n s\s', $article['article_datetime']); ?></td>
        </tr>
        <tr class="a_article">
            <td></td>
            <td><?php echo wordwrap(stripslashes(nl2br($article['article_message'])), 160, '<br />', true); ?></td>
        </tr>

        <?php
    }
    ?>

</table>
</div>

<?php
include('inc/footer.php');
?>