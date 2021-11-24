//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : cgm
// Date et heure : 07/12/15, 07:39:07
// ----------------------------------------------------
// Méthode : WebAfficheListeImage
// Description
// permet de renvoyer, dans une liste d'images,
// le bon texte en fonction du paramètre
// Paramètre : "lp"+type de  texte en 1 lettre
// (d pour [Diapositives]Commentaires)
// (r pour [Lésions]FicheReflexe)
// (l pour [Lésions]DescriptionTypeMacro)
// le [Diapositives]NumOrdreDiapos
// exemple : "alpr100092cegeheme@wanadoo.fr" demande la fiche réflexe ".lpr." en anglais "a."
// associée à la diapositive 10009  qui occuppe le rang 2 avec le login cegeheme@wanadoo.fr
// ----------------------------------------------------

$Dem:=$1

$Langue:=$Dem[[1]]
$Type:=$Dem[[4]]
NumImageA:=Substring:C12($Dem; 5; 5)
$Rang:=String:C10(Num:C11(Substring:C12($Dem; 10)))
If ($Type="p")  // panier : on a besoin du login
	$Login:=Substring:C12($Dem; (10+Length:C16($Rang)))
End if 
$Photo:=Num:C11(NumImageA)
QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1=$Photo)
$Envoi:=""
// Le texte renvoyé à la page Web
//Ad3TraducFabriqueTb
Case of 
	: ($Type="d")
		$Envoi:=$Envoi+DiaWebAffichePhotoCommentaire("Description macroscopique"; $Rang; $Langue)
		
	: ($Type="l")
		$Envoi:=$Envoi+DiaWebAffichePhotoCommentaire("Description de la lésion"; $Rang; $Langue)
		
	: ($Type="f")
		QUERY:C277([DiaLesions:44]; [DiaLesions:44]NomLesion:1=[Diapositives:40]NomLesion:4)
		$Envoi:=$Envoi+DiaWebAffichePhotoCommentaire("Fiche réflexe"; $Rang; $Langue)
		
	: ($Type="n")
		$Envoi:=$Envoi+DiaWebAffichePhotoCommentaire("Ne pas confondre"; $Rang; $Langue)
		
	: ($Type="r")
		RELATE MANY:C262([Diapositives:40]NomLesion:4)
		$Envoi:=$Envoi+DiaWebAffichePhotoCommentaire("Références réglementaires"; $Rang; $Langue)
		
	: ($Type="p")
		$Envoi:=$Envoi+DiaWebPanierFormNouvelleDia($Rang; $Login; $Langue)
End case 
// FIXER TEXTE DANS CONTENEUR($Envoi)
WEB SEND TEXT:C677($Envoi)
ZAmnistieInternationale