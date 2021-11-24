//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 17/07/16, 09:02:20
// ----------------------------------------------------
// Méthode : WebAbouleDetailLesion
// Description
// AJAX pour afficher le détail de la lésion en face de son nom
//
// Paramètre $1 = message AJAX type "lesiondetail{"id" : "detail700F","typevisiteur" : ""}"
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT; $NumLes)

$Message:=$1
$Objet:=JSON Parse:C1218(Substring:C12($Message; 13))  // Elimination de lesiondetail
$Ordre:=OB Get:C1224($Objet; "id"; Est un texte:K8:3)
$Visiteur:=OB Get:C1224($Objet; "typevisiteur"; Est un texte:K8:3)
$NumLes:=Num:C11($Ordre)

// Ad3TraducFabriqueTb

//$french:=($Message#"@a")
LangueEnCours:=$Ordre[[Length:C16($Ordre)]]
$DeuxPoints:=(Num:C11(LangueEnCours#"F")*": ")+(Num:C11(LangueEnCours="F")*" : ")
QUERY:C277([DiaLesions:44]; [DiaLesions:44]NumLesion:18=$NumLes)
$VarNomLes:=DiaWebAffecteChampLangue($NumLes; "<>TbNL"; [DiaLesions:44]NomLesion:1)
$VarDesMacro:=DiaWebAffecteChampLangue($NumLes; "<>TbDM"; [DiaLesions:44]DescriptionTypeMacro:4)
$VarFicheReflexe:=DiaWebAffecteChampLangue($NumLes; "<>TbFR"; [DiaLesions:44]FicheReflexe:12)
// les variables héritées de valeurs traduites par CGM
//BlobVersVariable (->[XDonnées]XBlob;->TbTexteF;->TbTexteE)
// type Ad3AffecteLangue adapté au contenu d'un champ

$VarGTL:=DiaWebTraduitTexte([DiaLesions:44]GrandTypeLesionnel:2; LangueEnCours)
$VarTLP:=DiaWebTraduitTexte([DiaLesions:44]TypeLesionnelPrecis:3; LangueEnCours)
$VarEtio:=DiaWebTraduitTexte([DiaLesions:44]Etiologie:6; LangueEnCours)
$VarMotif:=DiaWebTraduitTexte([DiaLesions:44]MotifSaisie:7; LangueEnCours)
$VarJustif:=DiaWebTraduitTexte([DiaLesions:44]JustificationConduite:8; LangueEnCours)
$VarFrequence:=DiaWebTraduitTexte([DiaLesions:44]Frequence:11; LangueEnCours)
$VarRegle:=DiaWebTraduitTexte([DiaLesions:44]ReferenceReglementaireUE:17; LangueEnCours)

//$VarGTL:=Ad3TraducAffecteValeur ([Lesions]GrandTypeLesionnel)
//$VarTLP:=Ad3TraducAffecteValeur ([Lesions]TypeLesionnelPrecis)
//$VarEtio:=Ad3TraducAffecteValeur ([Lesions]Etiologie)
//$VarMotif:=Ad3TraducAffecteValeur ([Lesions]MotifSaisie)
//$VarJustif:=Ad3TraducAffecteValeur ([Lesions]JustificationConduite)
//$VarFrequence:=Ad3TraducAffecteValeur ([Lesions]Frequence)
//$VarRegle:=Ad3TraducAffecteValeur ([Lesions]ReferenceReglementaireUE)

$THTML:=""
//$THTML:=$THTML+"        <img id="+<>ZGuil+"pointe"+<>ZGuil+" src="+<>ZGuil+"images/pointe.PNG"+<>ZGuil+" alt="+<>ZGuil+"pointe"+<>ZGuil+">"+<>ZCR
//$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+"        <p class="+<>ZGuil+"titredetail"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"          <b>"+Uppercase:C13($VarNomLes)+"</b>"+<>ZCR
$THTML:=$THTML+"        </p>"+<>ZCR
$THTML:=$THTML+"        <p class="+<>ZGuil+"textedetail"+<>ZGuil+">"+<>ZCR
// les variables héritées de champs traduits par CM
//BlobVersVariable (->[XDonnées]XBlob;->TbNLF;->TbNLE;->TbDMF;->TbDME;->TbFRF;->TbFRE;->TbNumLes)
If ($Visiteur="")  // Animaux de boucherie
	$Label:="<br /><br /><b>"+DiaWebTraduitTexte("Description de la lésion"; LangueEnCours)+$DeuxPoints+"</b><br />"
	$THTML:=$THTML+$Label+$VarDesMacro
	$Label:="<br /><br /><b>"+DiaWebTraduitTexte("Type lésionnel"; LangueEnCours)+"</b><br />"
	$THTML:=$THTML+$Label+$VarGTL+" / "+$VarTLP
	If ($VarFicheReflexe#"")
		$Label:="<br /><br /><b>"+DiaWebTraduitTexte("Fiche réflexe"; LangueEnCours)+$DeuxPoints+"</b><br />"
		$THTML:=$THTML+$Label+$VarFicheReflexe
	End if 
	If ($VarFrequence#"")
		$Label:="<br /><br /><b>"+DiaWebTraduitTexte("Fréquence"; LangueEnCours)+$DeuxPoints+"</b><br />"
		$THTML:=$THTML+$Label+$VarFrequence
	End if 
Else   // Gibier
	$VarDescriptionGibier:=OB Get:C1224([DiaLesions:44]ObjetLesion:19; "DescriptionGibier"; Est un texte:K8:3)
	If ($VarDescriptionGibier#"")
		$Label:="<br /><br /><b>"+DiaWebTraduitTexte("Description de la lésion"; LangueEnCours)+$DeuxPoints+"</b><br />"
		$THTML:=$THTML+$Label+$VarDescriptionGibier
	Else 
		If ($VarDesMacro#"")
			$Label:="<br /><br /><b>"+DiaWebTraduitTexte("Description de la lésion"; LangueEnCours)+$DeuxPoints+"</b><br />"
			$THTML:=$THTML+$Label+$VarDesMacro
		End if 
	End if 
	
	$Label:="<br /><br /><b>"+DiaWebTraduitTexte("Type lésionnel"; LangueEnCours)+"</b><br />"
	$THTML:=$THTML+$Label+$VarGTL+" / "+$VarTLP
	
	If ($VarFicheReflexe#"")
		$Label:="<br /><br /><b>"+DiaWebTraduitTexte("Fiche réflexe"; LangueEnCours)+$DeuxPoints+"</b><br />"
		$THTML:=$THTML+$Label+$VarFicheReflexe
	End if 
End if 

If ($VarEtio#"")
	$Label:="<br /><br /><b>"+DiaWebTraduitTexte("Etiologie"; LangueEnCours)+$DeuxPoints+"</b><br />"
	$THTML:=$THTML+$Label+$VarEtio
End if 
If ([DiaLesions:44]NPC:9#"")
	ARRAY TEXT:C222($TbNPC; 0)
	ZTexteVersTableau([DiaLesions:44]NPC:9; ->$TbNPC)
	$FT:=Size of array:C274($TbNPC)
	$PtTb:=Get pointer:C304("<>TbNL"+LangueEnCours)
	$NPC:=""
	For ($Salé; 1; $FT)
		$L:=Find in array:C230(<>TbNLF; $TbNPC{$Salé})
		If ($L>0)
			$NPC:=$NPC+"<br />"+$PtTb->{$L}
		End if 
	End for 
	If ($NPC#"")
		$THTML:=$THTML+"<br /><br /><b>"+DiaWebTraduitTexte("Ne pas confondre"; LangueEnCours)+"</b>"+$NPC+"</b>"
	End if 
	//Si ($french)
	
	//$NPC:=[Lesions]NPC
	//$Long:=Longueur($NPC)
	//Si ($NPC[[$Long]]=<>ZCR)
	//$NPC:=Sous chaîne($NPC;1;($Long-1))
	//Fin de si
	//$NPC:=Remplacer chaîne($NPC;<>ZCR;"<br />")
	//$THTML:=$THTML+"<br /><br /><b>Ne pas confondre avec : </b><br/>"+$NPC
	//Sinon
	//TABLEAU TEXTE($TbNPC;0)
	//$T:=[Lesions]NPC
	//$Pos:=Position(<>ZCR;$T)
	//Tant que ($Pos>0)
	//$Ajout:=Ad3TraducAffecteChampLangue (Sous chaîne($T;1;($Pos-1));"TbNL")
	//AJOUTER À TABLEAU($TbNPC;$Ajout)
	//$T:=Sous chaîne($T;($Pos+1))
	//$Pos:=Position(<>ZCR;$T)
	//Fin tant que
	//TRIER TABLEAU($TbNPC;>)
	//$THTML:=$THTML+"<br /><br /><b>Do not confuse: </b><br/>"+Remplacer chaîne(ZTableauVersTexte (->$TbNPC);<>ZCR;"<br />")
	//Fin de si
End if 
If ($VarRegle#"") & (LangueEnCours#"R")
	$Label:="<br /><br /><b>"+DiaWebTraduitTexte("Réglementation"; LangueEnCours)+" : "+"</b><br />"
	$THTML:=$THTML+$Label+$VarRegle
End if 
//$THTML:=$THTML+WebDecritChampDetail ([Lesions]Etiologie;"Etiologie";"Etiology";$french)
//$THTML:=$THTML+WebDecritChampDetail ([Lesions]NPC;"Ne pas confondre avec :";"Do not confuse";$french)
//$THTML:=$THTML+WebDecritChampDetail ([Lesions]ReferenceReglementaireUE;"Réglementation";"Reglementation";$french)

$THTML:=$THTML+"        <br /><br />"
$THTML:=$THTML+"        </p>"+<>ZCR
WEB SEND TEXT:C677($THTML)
ZAmnistieInternationale