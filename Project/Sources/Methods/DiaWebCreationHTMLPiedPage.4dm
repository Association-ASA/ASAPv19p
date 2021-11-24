//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 05/01/17, 18:42:04
// ----------------------------------------------------
// Méthode : WebCreationHTMLPiedPage
// Description
// Ecrit le HTML de la fin de la page 
// depuis </div> id=corps inclus
// Paramètres
// ----------------------------------------------------
$Langue:=$1
$THTML:=""
$THTML:=$THTML+"    </div>"+<>ZCR
$THTML:=$THTML+"<div id="+<>ZGuil+"pied"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"    <!--4dinclude pied"+$Langue+".shtml-->"+<>ZCR
$THTML:=$THTML+"   </div>"+<>ZCR

//$THTML:=$THTML+"    <div id="+<>ZGuil+"pied"+<>ZGuil+">"+<>ZCR
//$THTML:=$THTML+"      <br>"+<>ZCR
//$THTML:=$THTML+"      Site officiel de l'association Animal - Société - Aliment (ASA) <br> Adresse : Bâtiment Jean GIRARD - Ecole Nationale Vétérinaire d'Alfort -"+<>ZCR
//$THTML:=$THTML+"      7 avenue du Général de Gaulle - 94704 Maisons-Alfort Cedex &nbsp;&nbsp;&nbsp;FRANCE<br>"+<>ZCR
//$THTML:=$THTML+"      Téléphone : <b>+ 33 (0)1 56 29 36 30</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fax : <b>+ 33 (0)9 61 24 33 81</b>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+<>ZCR
//$THTML:=$THTML+"      e-mail : <a href="+<>ZGuil+"mailto:asa-spv@wanadoo.fr"+<>ZGuil+"><b>asa-spv@wanadoo.fr</b></a> <br>"+<>ZCR
//$THTML:=$THTML+"      <em>Pour signaler un problème, cliquez sur le lien suivant "+<>ZCR
//$THTML:=$THTML+"      <a href="+<>ZGuil+"mailto:cegeheme@wanadoo.fr"+<>ZGuil+"> écrire au webmaster</a></em>"+<>ZCR
//$THTML:=$THTML+"      <br><br>"+<>ZCR
//$THTML:=$THTML+"    </div>"+<>ZCR2

$THTML:=$THTML+"    </body>"+<>ZCR
$THTML:=$THTML+"  </html>"+<>ZCR
$0:=$THTML