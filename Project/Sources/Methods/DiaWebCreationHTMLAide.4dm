//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 19/04/18, 08:32:46
// ----------------------------------------------------
// Méthode : WebCreationHTMLAide
// Description
// Ecrit le HTML des icônes d'aide (mode d'emploi et vidéo)
//
// Paramètres : $1= Langue courante
//  $2 = 0 si pas d'aide, 1 si aide sans vidéo,  2 si aide avec vidéo
// $3 = nom du fichier pdf de l'aide,
// ----------------------------------------------------
$Langue:=$1
$PortéeAide:=$2
$Page:=$3
$NomFichierPDFAide:=$Page+$Langue
$LangueFrançaise:=($Langue="F")
$CDFichierAide:="pdf/"+$NomFichierPDFAide+".pdf"
$CDImageAide:="images/Aide"+$Langue+".png"
//$CDImageAide:=(Num($Langue#"F")*"images/Help.png")+(Num($Langue="F")*"images/Aide.png")
$AideEnPdf:=DiaWebTraduitTexte("Aide"; $Langue)+" PDF"
$THTML:=""
If ($PortéeAide>0)
	$THTML:=$THTML+"   <div id="+<>ZGuil+"aidepdfvideo"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"    <a href="+<>ZGuil+$CDFichierAide+<>ZGuil+" target="+<>ZGuil+"_blank"+<>ZGuil+" >"+<>ZCR
	$THTML:=$THTML+"      <img type="+<>ZGuil+"image"+<>ZGuil+" src="+<>ZGuil+$CDImageAide+<>ZGuil
	$THTML:=$THTML+" alt="+<>ZGuil+$AideEnPdf+<>ZGuil+" title="+<>ZGuil+$AideEnPdf+<>ZGuil+"  height="+<>ZGuil+"40"+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"    </a>"+<>ZCR
	If ($PortéeAide=2) & ($LangueFrançaise)
		$THTML:=$THTML+"    <a href="+<>ZGuil+"pdf/FirefoxScreenSnapz001.mov"+<>ZGuil+" >"+<>ZCR
		$THTML:=$THTML+"      <img src="+<>ZGuil+"images/Video.png"+<>ZGuil
		$THTML:=$THTML+" alt="+<>ZGuil+"Aide en vidéo"+<>ZGuil+" title="+<>ZGuil+"Aide en vidéo"+<>ZGuil+"  height="+<>ZGuil+"40"+<>ZGuil+" />"+<>ZCR
		$THTML:=$THTML+"    </a>"+<>ZCR
	End if 
	If ($LangueFrançaise)
		$THTML:=$THTML+"    <a href="+<>ZGuil+"#"+<>ZGuil+" >"+<>ZCR
		$THTML:=$THTML+(<>ZInsec*4)+"  <img src="+<>ZGuil+"images/FAQ.png"+<>ZGuil+" id="+<>ZGuil+"faqpage"+<>ZGuil
		$THTML:=$THTML+" alt="+<>ZGuil+"Envoyer un message à l'ASA"+<>ZGuil+" title="+<>ZGuil+"Envoyer un message à l'ASA"+<>ZGuil+" height="+<>ZGuil+"40"+<>ZGuil+" />"+<>ZCR
		$THTML:=$THTML+"    </a>"+<>ZCR
	End if 
	
	// Modifié par : cgm (03/12/2018)
	$THTML:=$THTML+"  </div>"+<>ZCR
	If ($LangueFrançaise)
		$THTML:=$THTML+"  <div id="+<>ZGuil+"faqcontenu"+<>ZGuil+"></div>"+<>ZCR
	End if 
End if 
$0:=$THTML