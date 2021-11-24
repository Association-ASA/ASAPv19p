//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 16/10/21, 17:37:28
  // ----------------------------------------------------
  // Méthode : DiaImpCatalogueOrganesSains
  // Description
  // Méthode qui imprime le catalogue des organes sains
  //   à partir d'une sélection de [DiaData] 
  //   de XType="quizzphoto"
  // Paramètres
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$L;$FT;$Fumé;$TT)
C_POINTER:C301($PtT;$PtC;$PtI)
SELECTION TO ARRAY:C260([DiaData:45]XBool:9;$TbCaduc\
;[DiaData:45]XNom:1;$TbNomFichier\
;[DiaData:45]XEntier:2;TbOrdre\
;[DiaData:45]XTexte:7;TbEspèce\
;[DiaData:45]XTexteSup:8;TbLésion)
$FT:=Size of array:C274($TbNomFichier)
ARRAY TEXT:C222(TbEspèceLésion;$FT)
DISTINCT VALUES:C339([DiaData:45]XTexte:7;$TableauVDEspece)
If (Size of array:C274($TableauVDEspece)>0)
	If ($TableauVDEspece{1}="")
		DELETE FROM ARRAY:C228($TableauVDEspece;1)
	End if 
End if 
For ($Salé;1;$FT)
	TbEspèceLésion{$Salé}:=TbEspèce{$Salé}+"_"+TbLésion{$Salé}
End for 
SORT ARRAY:C229(TbOrdre;$TbCaduc;$TbNomFichier;TbEspèce;TbLésion;TbEspèceLésion;>)

VarType1:=""
VarType2:=""
VarType5:=""
VarType4:=""
VarType5:=""
VarCom1:=""
VarCom2:=""
VarCom5:=""
VarCom4:=""
VarCom5:=""
VarImage1:=<>VarImageVide
VarImage2:=<>VarImageVide
VarImage5:=<>VarImageVide
VarImage4:=<>VarImageVide
VarImage5:=<>VarImageVide
ContexteImpression:=""
  // Recherche des non cataloguées
$NbPage:=1
NbPage:=$NbPage
GET PRINTABLE AREA:C703(HauteurMax)
HauteurRestante:=HauteurMax
VarPagination:="page "+String:C10($NbPage)
$H:=Print form:C5("ImpressionCatalogue";0;23)
HauteurRestante:=HauteurRestante-$H

VarCatégorie:="Non cataloguées"
$H:=Print form:C5("ImpressionCatalogue";30;50)
HauteurRestante:=HauteurRestante-$H
$L:=Find in array:C230(TbEspèceLésion;"_")
While ($L>0)
	For ($Salé;1;5)
		$PtT:=Get pointer:C304("VarType"+String:C10($Salé))
		$PtC:=Get pointer:C304("VarCom"+String:C10($Salé))
		$PtI:=Get pointer:C304("VarImage"+String:C10($Salé))
		If ($L>0)
			$PtT->:=Origine+String:C10(TbOrdre{$L})
			$PtC->:=""
			$CD:=<>PermCheDossierAsaDiaWeb+"Q"+Origine+String:C10(TbOrdre{$L};"00000")+"i.jpg"
			READ PICTURE FILE:C678($CD;$Image)
			$PtI->:=$Image
			$L:=Find in array:C230(TbEspèceLésion;"_";($L+1))
		Else 
			$PtT->:=""
			$PtC->:=""
			$PtI->:=<>VarImageVide
		End if 
	End for 
	ContexteImpression:="CadreMoins"
	$H:=Print form:C5("ImpressionCatalogue";50;176)
	HauteurRestante:=HauteurRestante-$H
	If (HauteurRestante<(176-50))
		PAGE BREAK:C6(>)
		HauteurRestante:=HauteurMax
		$NbPage:=$NbPage+1
		VarPagination:="page "+String:C10($NbPage)
		$H:=Print form:C5("ImpressionCatalogue";0;23)
		HauteurRestante:=HauteurRestante-$H
		VarCatégorie:=VarCatégorie+" (suite)"
		$H:=Print form:C5("ImpressionCatalogue";30;50)
		HauteurRestante:=HauteurRestante-$H
	End if 
End while 

  // les espèces
DiaImpCatalogueLigne ("Espece";21;48;50;211)
  // Passons aux lésions
DiaImpCatalogueLigne ("Lésion";21;48;50;211)
