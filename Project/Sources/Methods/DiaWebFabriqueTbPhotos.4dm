//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 09/01/16, 07:06:31
// ----------------------------------------------------
// Méthode : WebFabriqueTbPhotos
// Description
// Fabrique le tableau des diapositives
//
// Paramètres $1 = type de liste DGAL ou ENV  (voir WebAfficheListePhotos)
// ----------------------------------------------------

C_LONGINT:C283($Salé; $FT; $L; $NumDiapoCourant)
$FT:=Size of array:C274(TbNumDiaR)
$TypeListe:=$1
If ($TypeListe="y") | ($TypeListe="d") | ($TypeListe="z") | ($TypeListe="x")  // liste ana-path en français OU dgal OU gibier
	$Langue:="F"
Else 
	$Langue:=$TypeListe
End if 
$Rep:="b<table id="+<>ZGuil+"TbRes"+<>ZGuil+" class="+<>ZGuil+"TbRes"+<>ZGuil+">"+<>ZCR
// ET du tableau
$Rep:=$Rep+"<thead class="+<>ZGuil+"TbETG"+<>ZGuil+">"+<>ZCR
$Rep:=$Rep+"<tr class="+<>ZGuil+"TbETL"+<>ZGuil+">"+<>ZCR
$Rep:=$Rep+"<th class="+<>ZGuil+"TbETC1"+<>ZGuil+"> N°</th>"+<>ZCR
$Rep:=$Rep+"<th class="+<>ZGuil+"TbETC2"+<>ZGuil+">"+DiaWebTraduitTexte("Organe"; $Langue)+"</th>"+<>ZCR
$Rep:=$Rep+"<th class="+<>ZGuil+"TbETC3"+<>ZGuil+">"+DiaWebTraduitTexte("Espèce"; $Langue)+"</th>"+<>ZCR
$Rep:=$Rep+"<th class="+<>ZGuil+"TbETC4"+<>ZGuil+">"+DiaWebTraduitTexte("Lésion"; $Langue)+"</th>"+<>ZCR
$Rep:=$Rep+"</tr>"+<>ZCR
$Rep:=$Rep+"</thead>"+<>ZCR2
// Corps du tableau
For ($Salé; 1; $FT)
	
	// recherche de la ligne du tableau de référence initialisé par WebCreerTbDescriptionPhotos
	$NumDiapoCourant:=TbNumDiaR{$Salé}
	$L:=Find in array:C230(<>TbNumDia; $NumDiapoCourant)
	
	$Rep:=$Rep+"<tr class="+<>ZGuil+"TbCorpsL"+<>ZGuil+">"+<>ZCR  // Ligne
	// 4 Colonnes : N°, organe, espece, lésion
	$Rep:=$Rep+"<td class="+<>ZGuil+"TbCorpsC1"+<>ZGuil+">"
	$Rep:=$Rep+String:C10($NumDiapoCourant)
	$Rep:=$Rep+"</td>"+<>ZCR
	
	$Rep:=$Rep+"<td class="+<>ZGuil+"TbCorpsC2"+<>ZGuil+">"
	$Rep:=$Rep+DiaWebTraduitTexte(<>TbOrgane{$L}; $Langue)
	$Rep:=$Rep+"</td>"+<>ZCR
	
	$Rep:=$Rep+"<td class="+<>ZGuil+"TbCorpsC3"+<>ZGuil+">"
	$Rep:=$Rep+DiaWebTraduitTexte(<>TbEspece{$L}; $Langue)
	$Rep:=$Rep+"</td>"+<>ZCR
	
	$Rep:=$Rep+"<td class="+<>ZGuil+"TbCorpsC4"+<>ZGuil+">"
	If ($TypeListe="d") & (<>TbMotif{$L}#"")
		$Rep:=$Rep+<>TbMotif{$L}
	Else 
		$Rep:=$Rep+DiaWebTraduitLesion(<>TbNomLes{$L}; $Langue)
	End if 
	$Rep:=$Rep+"</td>"+<>ZCR
	
	$Rep:=$Rep+"</tr>"+<>ZCR2  // fin de ligne
	
End for 

$Rep:=$Rep+<>ZCR+"</table>"
$Rep:=$Rep+"<button id="+<>ZGuil+"bouvisetrieuse"+<>ZGuil+" class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"
$Rep:=$Rep+DiaWebTraduitTexte("Voir les photographies"; $Langue)+"</button>"+<>ZCR
// FIXER TEXTE DANS CONTENEUR($rep)
$0:=$Rep