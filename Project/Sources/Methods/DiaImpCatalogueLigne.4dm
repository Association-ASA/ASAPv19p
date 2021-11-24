//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 18/10/21, 10:43:23
  // ----------------------------------------------------
  // Méthode : DiaImpCatalogueLigne
  // Description
  // Méthode qui écrit une ligne du catalogue
  //
  // Paramètres
  // ----------------------------------------------------

$TypeCateg:=$1
$Taquet1:=$2
$Taquet2:=$3
$Taquet3:=$4
$Taquet4:=$5
If ($TypeCateg="Lésion")
	DISTINCT VALUES:C339([DiaData:45]XTexteSup:8;$TableauVD)
	$PtTbRef:=->TbLésion
	$PtTbAutre:=->TbEspece
Else 
	DISTINCT VALUES:C339([DiaData:45]XTexte:7;$TableauVD)
	$PtTbRef:=->TbEspece
	$PtTbAutre:=->TbLésion
End if 
If (Size of array:C274($TableauVD)>0)
	If ($TableauVD{1}="")
		DELETE FROM ARRAY:C228($TableauVD;1)
	End if 
End if 
$TT:=Size of array:C274($TableauVD)
For ($Fumé;1;$TT)
	$HauteurUtile:=($Taquet2-$Taquet1)+($Taquet4-$Taquet3)
	If (HauteurRestante<$HauteurUtile)
		PAGE BREAK:C6(>)
		HauteurRestante:=HauteurMax
		NbPage:=NbPage+1
		VarPagination:="page "+String:C10(NbPage)
		$H:=Print form:C5("ImpressionCatalogue";0;23)
		HauteurRestante:=HauteurRestante-$H
		If ($Fumé>1)
			VarCatégorie:=VarCatégorie+" (suite)"
			$H:=Print form:C5("ImpressionCatalogue";30;50)
			HauteurRestante:=HauteurRestante-$H
		End if 
	End if 
	$ValeurCourante:=$TableauVD{$Fumé}
	VarCatégorie:=$ValeurCourante
	$H:=Print form:C5("ImpressionCatalogue";$Taquet1;$Taquet2)
	HauteurRestante:=HauteurRestante-$H
	$L:=Find in array:C230($PtTbRef->;$ValeurCourante)
	While ($L>0)
		For ($Salé;1;5)
			$PtT:=Get pointer:C304("VarType"+String:C10($Salé))
			$PtC:=Get pointer:C304("VarCom"+String:C10($Salé))
			$PtI:=Get pointer:C304("VarImage"+String:C10($Salé))
			If ($L>0)
				$PtT->:=Origine+String:C10(TbOrdre{$L})
				$AutreValeur:=(Num:C11($PtTbAutre->{$L}="")*"Non renseigné")+(Num:C11($PtTbAutre->{$L}#"")*$PtTbAutre->{$L})
				$PtC->:=$AutreValeur
				$CD:=<>PermCheDossierAsaDiaWeb+"Q"+Origine+String:C10(TbOrdre{$L};"00000")+"i.jpg"
				READ PICTURE FILE:C678($CD;$Image)
				$PtI->:=$Image
				$L:=Find in array:C230($PtTbRef->;$ValeurCourante;($L+1))
			Else 
				$PtT->:=""
				$PtC->:=""
				$PtI->:=<>VarImageVide
			End if 
		End for 
		ContexteImpression:="CadrePlus"
		$H:=Print form:C5("ImpressionCatalogue";50;211)
		HauteurRestante:=HauteurRestante-$H
	End while 
End for 