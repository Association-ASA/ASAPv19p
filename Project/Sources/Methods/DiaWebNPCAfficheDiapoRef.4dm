//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 09/06/16, 07:37:44
// ----------------------------------------------------
// Méthode : WebNPCAfficheDiapoRef
// Description
// Affiche la présentation de l'image désignée
// dans le menu local
// ----------------------------------------------------
FIRST RECORD:C50([Diapositives:40])
$THTML:=""
$THTML:=$THTML+"        <p id="+<>ZGuil+"textecom"+<>ZGuil+">"+<>ZCR
PermRetrait:=False:C215
$THTML:=$THTML+"          <b>"+DiaAfficheTriplette+"</b><br /><br />"
$THTML:=$THTML+"          <b>Description de la diapositive</b><br />"+<>ZCR
$THTML:=$THTML+"          "+Replace string:C233([Diapositives:40]Commentaires:7; <>ZCR; "<br />")
$THTML:=$THTML+"        </p>"+<>ZCR
$NumA:=String:C10([Diapositives:40]NumOrdreDiapos:1)
$THTML:=$THTML+"        <img src="+<>ZGuil+"PhotosAsaDia/"+$NumA+"i.JPG"+<>ZGuil+" alt="+<>ZGuil+"photo "+$NumA+<>ZGuil+" class="+<>ZGuil+"photoasadia"+<>ZGuil
$THTML:=$THTML+" width="+<>ZGuil+"300px"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <br /><br /><b>Fiche réflexe</b><br />"+<>ZCR
$THTML:=$THTML+"        <textarea name="+<>ZGuil+"fr"+$NumA+<>ZGuil+" id="+<>ZGuil+"fr"+$NumA+<>ZGuil+" cols="+<>ZGuil+"38"+<>ZGuil+" rows="+<>ZGuil+"8"+<>ZGuil+">"
$FR:=ZfVireLesVides([Diapositives:40]DiapoFicheReflexe:31)
If ($FR="")
	QUERY:C277([DiaLesions:44]; [DiaLesions:44]NomLesion:1=[Diapositives:40]NomLesion:4)
	$THTML:=$THTML+ZfVireLesVides([DiaLesions:44]FicheReflexe:12)
Else 
	$THTML:=$THTML+$FR
End if 
$THTML:=$THTML+"</textarea>"+<>ZCR
$THTML:=$THTML+"        <br /><br /><b>"+<>ZGuil+"Ne pas confondre"+<>ZGuil+" de la photographie</b><br />"+<>ZCR
$THTML:=$THTML+"         "+Replace string:C233([Diapositives:40]NPC:14; <>ZCR; "<br />")+<>ZCR
//$THTML:=$THTML+"        <b>Texte "+<>ZGuil+"Ne pas confondre"+<>ZGuil+"</b><br />"+<>ZCR
//$THTML:=$THTML+"        <textarea name="+<>ZGuil+"comnpc"+$NumA+<>ZGuil+" id="+<>ZGuil+"comnpc"+$NumA+<>ZGuil+" cols="+<>ZGuil+"38"+<>ZGuil
//$THTML:=$THTML+" rows="+<>ZGuil+"8"+<>ZGuil+">"+[XDonnées]XTexte+"</textarea>"+<>ZCR  // [XDonnées]XTexte = le texte à afficher pour les NPC
$THTML:=$THTML+"        <br /><br /><b>Remarque de l'expert pour le groupe AsaDia</b><br />"+<>ZCR
$THTML:=$THTML+"        <textarea name="+<>ZGuil+"remnpc"+$NumA+<>ZGuil+" id="+<>ZGuil+"remnpc"+$NumA+<>ZGuil+" cols="+<>ZGuil+"38"+<>ZGuil
$THTML:=$THTML+" rows="+<>ZGuil+"18"+<>ZGuil+">"+[Diapositives:40]RemarqueExpertNPC:29+"</textarea>"+<>ZCR
$0:=$THTML