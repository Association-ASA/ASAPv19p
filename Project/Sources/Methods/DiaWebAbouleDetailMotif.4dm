//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 10/08/16, 15:43:27
// ----------------------------------------------------
// Méthode : WebAbouleDetailMotif
// Description
// 
//
// Paramètre : $1 = message AJAX type jSON motifdetail+[MotifSaisieDGAL]Ordre 
// ----------------------------------------------------

$Mess:=$1
C_OBJECT:C1216($Objet)
$Objet:=JSON Parse:C1218(Substring:C12($Mess; 12))  // Elimination de motifdetail
$Ordre:=Num:C11(OB Get:C1224($Objet; "id"; Est un texte:K8:3))
$Visiteur:=OB Get:C1224($Objet; "typevisiteur"; Est un texte:K8:3)
QUERY:C277([DiaMotifSaisieDGAL:42]; [DiaMotifSaisieDGAL:42]Ordre:10=$Ordre)


$THTML:=""
//$THTML:=$THTML+"        <img id="+<>ZGuil+"pointe"+<>ZGuil+" src="+<>ZGuil+"images/pointe.PNG"+<>ZGuil+" alt="+<>ZGuil+"pointe"+<>ZGuil+">"+<>ZCR
//$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+"        <p class="+<>ZGuil+"titredetail"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"          <b>"+Uppercase:C13([DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1)+"</b>"+<>ZCR
$THTML:=$THTML+"        </p>"+<>ZCR
$THTML:=$THTML+"        <p class="+<>ZGuil+"textedetail"+<>ZGuil+">"+<>ZCR
// les variables héritées de champs traduits par CM
//BlobVersVariable (->[XDonnées]XBlob;->TbNLF;->TbNLE;->TbDMF;->TbDME;->TbFRF;->TbFRE;->TbNumLes)
$Label:="<br /><br /><b>Lésions concernées :"+"</b><br />"
$THTML:=$THTML+$Label+Replace string:C233([DiaMotifSaisieDGAL:42]LesionsLiees:12; <>ZCR; "<br />")

$Label:="<br /><br /><b>"+"Reférence réglementaire européenne : "+"</b><br />"
$THTML:=$THTML+$Label+Replace string:C233([DiaMotifSaisieDGAL:42]RefRegEuropeenne:5; <>ZCR; "<br />")

$Label:="<br /><br /><b>"+"Reférence UE courte : "+"</b><br />"
$THTML:=$THTML+$Label+Replace string:C233([DiaMotifSaisieDGAL:42]IntituleRegCECourt:2; <>ZCR; "<br />")

$Label:="<br /><br /><b>"+"Classement Sous Produits Animaux : "+"</b><br />"
$THTML:=$THTML+$Label+[DiaMotifSaisieDGAL:42]ClassementNonConsoHumaine:6


If ($Visiteur="G")
	If ([DiaMotifSaisieDGAL:42]PrecisionsGibier:14#"")
		$Label:="<br /><br /><b>"+"Précisions : "+"</b><br />"
		$THTML:=$THTML+$Label+Replace string:C233([DiaMotifSaisieDGAL:42]PrecisionsGibier:14; <>ZCR; "<br />")
	End if 
	If ([DiaMotifSaisieDGAL:42]InformationEleveurs:11#"")
		$Label:="<br /><br /><b>"+"Eléments de communication : "+"</b><br />"
		$THTML:=$THTML+$Label+Replace string:C233([DiaMotifSaisieDGAL:42]InformationChasseurs:15; <>ZCR; "<br />")
	End if 
Else 
	If ([DiaMotifSaisieDGAL:42]PrecisionsEleveur:7#"")
		$Label:="<br /><br /><b>"+"Précisions : "+"</b><br />"
		$THTML:=$THTML+$Label+Replace string:C233([DiaMotifSaisieDGAL:42]PrecisionsEleveur:7; <>ZCR; "<br />")
	End if 
	If ([DiaMotifSaisieDGAL:42]InformationEleveurs:11#"")
		$Label:="<br /><br /><b>"+"Communication aux éleveurs : "+"</b><br />"
		$THTML:=$THTML+$Label+Replace string:C233([DiaMotifSaisieDGAL:42]InformationEleveurs:11; <>ZCR; "<br />")
	End if 
End if 



$THTML:=$THTML+"        </p>"+<>ZCR
WEB SEND TEXT:C677($THTML)
ZAmnistieInternationale