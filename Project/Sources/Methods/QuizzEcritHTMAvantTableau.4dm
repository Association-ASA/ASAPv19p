//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 13/09/21, 09:56:16
// ----------------------------------------------------
// Méthode : QuizzEcritHTMAvantTableau
// Description
// Méthode qui écrit le HTML de la ligne au desssus du tableau
//  de la ligne au dessus du tableau
//  à partir de la sélection des [DiaData]
//  des images originales de l'institution
// ----------------------------------------------------
C_LONGINT:C283($Salé; $TT)
ARRAY TEXT:C222($Tb; 0)
$Structure:=$1
If (Size of array:C274(TbPUMListeEspece)=0)
	ARRAY TEXT:C222(TbPUMListeEspece; 2)
	TbPUMListeEspece{1}:="Choisissez une espèce"
	TbPUMListeEspece{2}:="Toutes les espèces"
Else 
	If (TbPUMListeEspece{1}="")
		If (Find in array:C230(TbPUMListeEspece; "non attribuée")<0)
			TbPUMListeEspece{1}:="non attribuée"
		Else 
			DELETE FROM ARRAY:C228(TbPUMListeEspece; 1)
		End if 
	End if 
	INSERT IN ARRAY:C227(TbPUMListeEspece; 2)
	TbPUMListeEspece{1}:="Choisissez une espèce"
	TbPUMListeEspece{2}:="Toutes les espèces"
End if 

$THTML:="Espèces : "+<>ZCR
$THTML:=$THTML+<>ZCR+"     <select id="+<>ZGuil+"LiPUMEspece"+<>ZGuil+" class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"+<>ZCR
$TT:=Size of array:C274(TbPUMListeEspece)
For ($Salé; 1; $TT)
	$Selected:=Num:C11($Salé=1)*"selected "
	$THTML:=$THTML+"       <option "+$Selected+"value="+<>ZGuil+String:C10($Salé)+<>ZGuil+" >"+TbPUMListeEspece{$Salé}+"</option>"+<>ZCR
End for 
$THTML:=$THTML+"     </select>"+<>ZCR+"          "

// Les lésions
If (Size of array:C274(TbPUMListeLesion)=0)
	ARRAY TEXT:C222(TbPUMListeLesion; 2)
	TbPUMListeLesion{1}:="Choisissez une lésion"
	TbPUMListeLesion{2}:="Toutes les lésions"
Else 
	If (TbPUMListeLesion{1}="")
		If (Find in array:C230(TbPUMListeLesion; "Non attribuée")<0)
			TbPUMListeLesion{1}:="non attribuée"
		Else 
			DELETE FROM ARRAY:C228($Tb; 1)
		End if 
	End if 
	INSERT IN ARRAY:C227(TbPUMListeLesion; 2)
	TbPUMListeLesion{1}:="Choisissez une lésion"
	TbPUMListeLesion{2}:="Toutes les lésions"
End if 
$THTML:=$THTML+"Lésions : "+<>ZCR
$THTML:=$THTML+<>ZCR+"     <select id="+<>ZGuil+"LiPUMLesion"+<>ZGuil+" class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"+<>ZCR
$TT:=Size of array:C274(TbPUMListeLesion)
For ($Salé; 1; $TT)
	$Selected:=Num:C11($Salé=1)*"selected "
	$THTML:=$THTML+"       <option "+$Selected+"value="+<>ZGuil+String:C10($Salé)+<>ZGuil+" >"+TbPUMListeLesion{$Salé}+"</option>"+<>ZCR
End for 
$THTML:=$THTML+"     </select>"+<>ZCR+"          "

// Le bouton
//$THTML:=$THTML+"         <input class="+<>ZGuil+"titrepage"+<>ZGuil+" type="+<>ZGuil+"reset"+<>ZGuil
//$THTML:=$THTML+" id="+<>ZGuil+"pdf"+<>ZGuil+" value="+<>ZGuil+"Imprimer le catalogue"+<>ZGuil+" /><br />"
$CDPDFCatalogue:=<>PermCheDosPdf+"Catalogue"+$Structure+".pdf"
If (Test path name:C476($CDPDFCatalogue)=Est un document:K24:1)
	$THTML:=$THTML+"         <a href="+<>ZGuil+"PDF/"+"Catalogue"+$Structure+".pdf"+<>ZGuil
	$THTML:=$THTML+"> <span class="+<>ZGuil+"titrepage"+<>ZGuil+">Télécharger le catalogue</span></a><br />"
End if 
$0:=$THTML
