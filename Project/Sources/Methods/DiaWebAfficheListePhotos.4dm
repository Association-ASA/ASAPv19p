//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : cgm
// Date et heure : 06/07/15, 13:41:16
// ----------------------------------------------------
// Méthode : WebAfficheListePhotos
// Description
// Affiche les photographies selon deux modalités :
//  soit à la suite de critères de choix ($mess="flipflop@")
//  soit par un clic sur le bouton Voir les photographies ($Mess="filelesphotos@")
// Paramètre : chaine AJAX
// ----------------------------------------------------
C_LONGINT:C283(FT; $Salé; $FT)
$Mess:=$1

// La chaine est de type "flipflop"
//                      +"s" (sans les variantes)
//                      +"d" (liste dgal pour animaux de boucherie)
//                    ou "z"(liste dgal pour gibier)
//                    ou "y"(liste asa pour liste anatomo-pathologique en français pour gibier)
//                    ou "x"(liste asa pour liste anatomo-pathologique en français pour animaux de boucherie)
//                    ou "a" ou "r"  (pour langue autres que le français)
//                      +"Espèces : bovins<br />Organes : langue, foie<br />Lésions : Actinobacillose/Actinomycose" (formule recherche)
// ou provenant du clic sur le bouton voir les photographies : filelesphotosA12098;30432;....;50654;
AffichageListeNombreuse:=($Mess[[11]]="c")
// $TypeClic:=$Mess[[9]]  // Test de l'origine du clic
// Ad3FabriqueTbTraduc

// Recrutement des photos pertinentes
If ($mess="diaflipflo@")
	$Variantes:=$Mess[[(12+Num:C11(AffichageListeNombreuse))]]  // Test du type de photographies t = toutes, s= sans variantes v=que variantes
	$TypeListe:=$Mess[[(13+Num:C11(AffichageListeNombreuse))]]  // Test du type de liste d=DGAL, a=ASA et e=anglais
	If ($TypeListe="y") | ($TypeListe="d") | ($TypeListe="z") | ($TypeListe="x")  // liste ana-path en français OU dgal OU gibier
		$Langue:="F"
	Else 
		$Langue:=$TypeListe
	End if 
	$Critere:=DiaWebRecruteSurCriteres($Mess; $TypeListe; $Variantes)
Else   // provenant du clic sur le bouton voir les photographies : filelesphotosF12098;30432;....;50654;
	$Langue:=$Mess[[14]]
	$Critere:=DiaWebRecruteSurTableau($Mess)
End if 


$FT:=Size of array:C274(TbNumDiaR)
$Rep:=$Critere+"§"+String:C10($FT)+"£"
//Si (AffichageListeNombreuse)
If (AffichageListeNombreuse)
	$Rep:=$Rep+DiaWebFabriqueTbPhotos($TypeListe)
Else 
	If ($FT<200)
		// Affichage des photos pertinentes
		If ($FT<20)  // On affiche directement les photos
			// $Langue:=(Num($TypeListe#"d")*$TypeListe)+(Num($TypeListe="d")*"F")
			$Rep:=$Rep+DiaWebFabriqueListePhotos($Langue)
		Else   // On affiche le tableau
			$Rep:=$Rep+DiaWebFabriqueTbPhotos($TypeListe)
		End if 
	End if 
End if 

WEB SEND TEXT:C677($Rep)
// FIXER TEXTE DANS CONTENEUR($Rep)