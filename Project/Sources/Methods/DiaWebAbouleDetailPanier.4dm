//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 10/12/17, 05:01:26
// ----------------------------------------------------
// Méthode : WebAbouleDetailPanier
// Description
// Liste les diapositives contenues dans le panier
//  et les met dans la trieuse
// Paramètre $1= message Ajax type detailpanier3456
//   où 3456 = n° d'enregistrement de la Xdonnées du panier
// ----------------------------------------------------

C_LONGINT:C283($Salé; $FT)
C_TEXT:C284($Langue)

$Mess:=$1
$Langue:=$Mess[[Length:C16($Mess)]]
$NumEnr:=Num:C11($1)
$NumXDonneesA:=String:C10($NumEnr)
GOTO RECORD:C242([DiaData:45]; $NumEnr)
ARRAY TEXT:C222($PtPanier; 0)
ZTexteVersTableau([DiaData:45]XTexte:7; ->$PtPanier)
$FT:=Size of array:C274($PtPanier)
$THTML:="        "+DiaWebTraduitTexte("Vous pouvez changer l'ordre"; $Langue)+"<br /><br />"+<>ZCR
$THTML:=$THTML+"      <input type="+<>ZGuil+"hidden"+<>ZGuil+" id="+<>ZGuil+"valeurxdonnees"+<>ZGuil+" value="+<>ZGuil+$NumXDonneesA+<>ZGuil+" />"+<>ZCR

For ($Salé; 1; $FT)
	$NumDiapoCouranteA:=$PtPanier{$Salé}
	$NumDiapoCouranteN:=Num:C11($NumDiapoCouranteA)
	$Rang:=String:C10($Salé)
	$CDNomImage:=Get 4D folder:C485(Dossier racine HTML:K5:20)+"PhotosAsaDia"+Séparateur dossier:K24:12+String:C10($NumDiapoCouranteN)+".jpg"
	READ PICTURE FILE:C678($CDNomImage; $VarDia)
	PICTURE PROPERTIES:C457($VarDia; $Largeur; $Hauteur)
	$Orientation:=(Num:C11($Largeur>=$Hauteur)*"h")+(Num:C11($Largeur<$Hauteur)*"v")
	$L:=Find in array:C230(<>TbNumDia; $NumDiapoCouranteN)
	$Triplette:=DiaWebAfficheTriplette($L; $Langue)
	//$Triplette:=<>TbNomLes{$L}+" sur "+<>TbOrgane{$L}+" de "+<>TbEspece{$L}
	$IdPhoto:=$NumDiapoCouranteA+$Rang+"_"+$NumXDonneesA
	$THTML:=$THTML+"         <div id="+<>ZGuil+"photopanier"+$IdPhoto+<>ZGuil+" class="+<>ZGuil+"photopanier"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"           "+$NumDiapoCouranteA+" <br />"+<>ZCR
	
	$THTML:=$THTML+"           <img class="+<>ZGuil+"diapanier"+$Orientation+<>ZGuil
	$THTML:=$THTML+" src="+<>ZGuil+"PhotosAsaDia/"+$NumDiapoCouranteA+"is.jpg"+<>ZGuil+" alt="+<>ZGuil+"photo n°"+$NumDiapoCouranteA+<>ZGuil+" />"+<>ZCR2
	$THTML:=$THTML+"           <img class="+<>ZGuil+"information"+<>ZGuil+" src="+<>ZGuil+"images/information.png"+<>ZGuil+" alt="+<>ZGuil+$Triplette+<>ZGuil
	$THTML:=$THTML+"             title="+<>ZGuil+$Triplette+<>ZGuil+"/><br />"+<>ZCR
	$THTML:=$THTML+"           <img id="+<>ZGuil+"poubelle"+$IdPhoto+<>ZGuil+" class="+<>ZGuil+"poubelle"+<>ZGuil+" src="+<>ZGuil+"images/poubelle.png"+<>ZGuil
	$THTML:=$THTML+" alt="+<>ZGuil+DiaWebTraduitTexte("supprimer la photo"; $Langue)+<>ZGuil+" title="+<>ZGuil+DiaWebTraduitTexte("supprimer la photo"; $Langue)+<>ZGuil+"/><br />"+<>ZCR
	$THTML:=$THTML+"           <img id="+<>ZGuil+"loupe"+$NumDiapoCouranteA+<>ZGuil+" class="+<>ZGuil+"loupe"+<>ZGuil+" src="+<>ZGuil+"images/Loupe panier.png"+<>ZGuil
	$THTML:=$THTML+" alt="+<>ZGuil+DiaWebTraduitTexte("agrandir la photo"; $Langue)+<>ZGuil
	$THTML:=$THTML+"             title="+<>ZGuil+DiaWebTraduitTexte("agrandir la photo"; $Langue)+<>ZGuil+"/><br />"+<>ZCR
	$THTML:=$THTML+"         </div>"+<>ZCR
End for 


WEB SEND TEXT:C677($THTML)
// FIXER TEXTE DANS CONTENEUR($THTML)
$THTML:=""

