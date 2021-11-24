//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 24/07/16, 14:45:53
// ----------------------------------------------------
// Méthode : WebAbouleDetailDiapo
// Description
//
//
// Paramètres
// ----------------------------------------------------


// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 17/07/16, 09:02:20
// ----------------------------------------------------
// Méthode : WebAbouleDetailDiapo
// Description
// AJAX pour afficher le détail de la lésion en face de son nom
//
// Paramètres
// ----------------------------------------------------
C_TEXT:C284($Message; $1; $NumDiaA; $Langue)
C_OBJECT:C1216($Objet)
$Message:=$1
$Objet:=JSON Parse:C1218(Substring:C12($Message; 10))  // Elimination de diadetail
$Ordre:=OB Get:C1224($Objet; "id"; Est un texte:K8:3)
$Visiteur:=OB Get:C1224($Objet; "typevisiteur"; Est un texte:K8:3)

$NumDia:=Num:C11($Ordre)
$NumDiaA:=String:C10($NumDia)
$Langue:=$Ordre[[Length:C16($Ordre)]]
// Ad3TraducFabriqueTb

QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1=$NumDia)
QUERY:C277([DiaLesions:44]; [DiaLesions:44]NomLesion:1=[Diapositives:40]NomLesion:4)
$L:=Find in array:C230(<>TbNumLesN; [DiaLesions:44]NumLesion:18)
$PtTbFR:=Get pointer:C304("<>TbFR"+$Langue)
$VarNomLes:=DiaWebTraduitLesion([DiaLesions:44]NomLesion:1; $Langue)
$VarDesMacro:=DiaWebTraduitCommentaire($NumDia; $Langue)
$VarDesMacro:=Replace string:C233($VarDesMacro; <>ZCR; " <br/> ")
If ($Langue="F") & ([Diapositives:40]DiapoFicheReflexe:31#"")
	$VarFicheReflexe:=[Diapositives:40]DiapoFicheReflexe:31
Else 
	$VarFicheReflexe:=$PtTbFR->{$L}
End if 
$VarGTL:=DiaWebTraduitTexte([DiaLesions:44]GrandTypeLesionnel:2; $Langue)
$VarTLP:=DiaWebTraduitTexte([DiaLesions:44]TypeLesionnelPrecis:3; $Langue)
$VarEtio:=DiaWebTraduitTexte([DiaLesions:44]Etiologie:6; $Langue)
$VarMotif:=DiaWebTraduitTexte([DiaLesions:44]MotifSaisie:7; $Langue)
$VarJustif:=DiaWebTraduitTexte([DiaLesions:44]JustificationConduite:8; $Langue)
$VarFrequence:=DiaWebTraduitTexte([DiaLesions:44]Frequence:11; $Langue)
$VarRegle:=DiaWebTraduitTexte([DiaLesions:44]ReferenceReglementaireUE:17; $Langue)

$THTML:="<img src="+<>ZGuil+"PhotosAsaDia/"+$NumDiaA+"is.jpg"+<>ZGuil+" class="+<>ZGuil+"photoasadia imageenliste"+<>ZGuil
$THTML:=$THTML+" alt="+<>ZGuil+$NumDiaA+<>ZGuil+" title="+<>ZGuil+$NumDiaA+<>ZGuil+"><br/>"+<>ZCR
$VarEspece:=DiaWebTraduitTexte([Diapositives:40]Espece:3; $Langue)
$VarOrgane:=DiaWebTraduitTexte([Diapositives:40]Organe:2; $Langue)
$L:=Find in array:C230(<>TbNumDia; $NumDia)
$VarTriplette:=DiaWebAfficheTriplette($L; $Langue)

$THTML:=$THTML+"        <p class="+<>ZGuil+"titredetail"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"          <b>"+Uppercase:C13($VarTriplette)+"</b>"+<>ZCR
$THTML:=$THTML+"        </p>"+<>ZCR
$THTML:=$THTML+"        <p class="+<>ZGuil+"textedetail"+<>ZGuil+">"+<>ZCR
// les variables héritées de champs traduits par CM
//BlobVersVariable (->[XDonnées]XBlob;->TbNLF;->TbNLE;->TbDMF;->TbDME;->TbFRF;->TbFRE;->TbNumLes)
$Label:="<br /><br /><b>"+DiaWebTraduitTexte("Description de la lésion"; $Langue)+"</b><br />"
$THTML:=$THTML+$Label+$VarDesMacro
$Label:="<br /><br /><b>"+DiaWebTraduitTexte("Type lésionnel"; $Langue)+" : "+"</b><br />"
$THTML:=$THTML+$Label+$VarGTL+" / "+$VarTLP
If ($VarFicheReflexe#"")
	$Label:="<br /><br /><b>"+DiaWebTraduitTexte("Fiche réflexe"; $Langue)+"</b><br />"
	$THTML:=$THTML+$Label+$VarFicheReflexe
End if 

If ($VarFrequence#"") & ($Visiteur="")  // Animaux xe boucherie et charcuterie
	$Label:="<br /><br /><b>"+DiaWebTraduitTexte("Fréquence"; $Langue)+"</b><br />"
	$THTML:=$THTML+$Label+$VarFrequence
End if 

If ($VarEtio#"")
	$Label:="<br /><br /><b>"+DiaWebTraduitTexte("Etiologie"; $Langue)+"</b><br />"
	$THTML:=$THTML+$Label+$VarEtio
End if 

//  NPC
ARRAY TEXT:C222($TbNPC; 0)
If ([Diapositives:40]NPC:14#"")
	ZTexteVersTableau([Diapositives:40]NPC:14; ->$TbNPC)
Else 
	ZTexteVersTableau([DiaLesions:44]NPC:9; ->$TbNPC)
End if 
$FT:=Size of array:C274($TbNPC)
$PtTb:=Get pointer:C304("<>TbNL"+$Langue)
$NPC:=""
For ($Salé; 1; $FT)
	$L:=Find in array:C230(<>TbNLF; $TbNPC{$Salé})
	If ($L>0)
		$NPC:=$NPC+"<br />"+$PtTb->{$L}
	End if 
End for 
If ($NPC#"")
	$THTML:=$THTML+"<br /><br /><b>"+DiaWebTraduitTexte("Ne pas confondre"; $Langue)+"</b>"+$NPC+"</b>"
End if 
If ($VarRegle#"") & ($Langue#"R")
	$Label:="<br /><br /><b>"+DiaWebTraduitTexte("Réglementation"; $Langue)+" : "+"</b><br />"
	$THTML:=$THTML+$Label+$VarRegle
End if 
$THTML:=$THTML+"        <br /><br />"+<>ZCR
$THTML:=$THTML+"        </p>"+<>ZCR
WEB SEND TEXT:C677($THTML)
ZAmnistieInternationale