//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 03/04/18, 17:20:52
  // ----------------------------------------------------
  // Méthode : AntichambreImprimePhotos
  // Description
  // Permet d'imprimer les nouvelles candidates
  //  pour les photos à partir de la liste présente dans la 
  //   LB "ListBoxVisuAC"
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT;$Pos;$SFT)
C_PICTURE:C286(VarImageImp)
C_TEXT:C284($Organe;$Lesion;$Espèce)
ARRAY OBJECT:C1221($TbObjet;0)
C_OBJECT:C1216($Objet)

PRINT SETTINGS:C106
If (OK=1)
	GET PRINTABLE AREA:C703($HauteurMax)
	$ImageVide:=<>VarImageVide
	$Type:="AjoutDia"+(Num:C11(PUMTypePhoto=2)*"G")  //+(Num(VarPOD=1)*"POD")
	QUERY:C277([DiaData:45];[DiaData:45]XType:5=$Type;*)
	QUERY:C277([DiaData:45]; & [DiaData:45]XAlpha:14="A traiter")
	SELECTION TO ARRAY:C260([DiaData:45]XBool:9;$TbBool;[DiaData:45]XObjet:15;$TbObjet;[DiaData:45]XTexte:7;$TbCD;[DiaData:45]XTexteSup:8;$TbCom;[DiaData:45]XValeur:4;$TbNumSériePhotos)
	$FT:=Size of array:C274($TbBool)
	
	For ($Salé;1;$FT)
		$HauteurCourante:=$HauteurMax
		$Objet:=$TbObjet{$Salé}
		$CDCourant:=$TbCD{$Salé}
		$Pos:=Position:C15(":Dropbox:";$CDCourant)
		VarCDImp:=Substring:C12($CDCourant;($Pos+Length:C16(":Dropbox:")))
		$CDCourant:=<>PermCheDropBox+VarCDImp
		If (Test path name:C476($CDCourant)#Est un document:K24:1)
			$CDCourant:=$TbCD{$Salé}
			If (Test path name:C476($CDCourant)#Est un document:K24:1)
				ARRAY TEXT:C222($TbCDDia;0)
				ZTexteVersTableau ($TbCD{$Salé};->$TbCDDia;Séparateur dossier:K24:12)
				DELETE FROM ARRAY:C228($TbCDDia;1;7)
				$CDCourant:=<>PermCheDropBox+"Experts AsaDia"+Séparateur dossier:K24:12+ZTableauVersTexte (->$TbCDDia;Séparateur dossier:K24:12)
			End if 
		End if 
		
		$NumS:=$TbNumSériePhotos{$Salé}
		VarTriplette:="Cas n°"+String:C10($NumS+1)+" : "+OB Get:C1224($Objet;"Lésion")+" sur "+OB Get:C1224($Objet;"Organe")+" de "+OB Get:C1224($Objet;"Espèce")
		READ PICTURE FILE:C678($CDCourant;VarImageImp)
		
		  //  Composition de VarDescriptionImp
		$Pos:=Position:C15(<>ZCR;$TbCom{$Salé})
		$Taille:=Substring:C12($TbCom{$Salé};1;($Pos-1))
		$Pos:=Position:C15(":";$Taille)
		VarTailleImage:="Taille de l'image : "+Substring:C12($Taille;($Pos+2))
		VarDescriptionImp:=""
		  //VarDescriptionImp:="TAILLE IMAGE : "+sous chaine($Taille;($Pos+2))+<>ZCR2
		
		$Var:=OB Get:C1224($Objet;"Auteur";Est un texte:K8:3)
		If ($Var#"")
			VarDescriptionImp:=VarDescriptionImp+"AUTEUR : "+$Var+<>ZCR2
		End if 
		$VarDelaiAbattageP2:=OB Get:C1224($Objet;"Délai";Est un texte:K8:3)
		If ($VarDelaiAbattageP2#"")
			VarDescriptionImp:=VarDescriptionImp+"DELAI depuis l'ABATTAGE :"+<>ZCR+$VarDelaiAbattageP2+<>ZCR2
		End if 
		$Var:=OB Get:C1224($Objet;"Commémoratifs";Est un texte:K8:3)
		If ($Var#"")
			VarDescriptionImp:=VarDescriptionImp+"COMMEMORATIFS : "+$Var+<>ZCR2
		End if 
		$Var:=OB Get:C1224($Objet;"Commentaires";Est un texte:K8:3)
		If ($Var#"")
			VarDescriptionImp:=VarDescriptionImp+"COMMENTAIRES : "+$Var+<>ZCR2
		End if 
		$H:=Print form:C5("AntichambreImpression";0;402)
		$HauteurCourante:=$HauteurCourante-$H
		
		
		  // Impression des diapos d'AsaDia
		$Espèce:=OB Get:C1224($Objet;"Espèce")
		$Lesion:=OB Get:C1224($Objet;"Lésion")
		$Organe:=OB Get:C1224($Objet;"Organe")
		QUERY:C277([Diapositives:40];[Diapositives:40]Organe:2=$Organe;*)
		If ($Organe="Péritoine") | ($Organe="Plèvre") | ($Organe="muscles")
			QUERY:C277([Diapositives:40]; | [Diapositives:40]Organe:2="Carcasse";*)
		End if 
		If ($Organe="Carcasse")
			QUERY:C277([Diapositives:40]; | [Diapositives:40]Organe:2="muscles";*)
		End if 
		If ($Organe="Muscles")
			QUERY:C277([Diapositives:40]; | [Diapositives:40]Organe:2="oesophage";*)
		End if 
		QUERY:C277([Diapositives:40]; & [Diapositives:40]Espece:3=$Espèce;*)
		QUERY:C277([Diapositives:40]; & [Diapositives:40]NomLesion:4=$Lesion)
		
		If (Records in selection:C76([Diapositives:40])=0)  // pas de diapo
			$H:=Print form:C5("AntichambreImpression";715;741)
			
		Else   // des diapos
			
			$H:=Print form:C5("AntichambreImpression";403;427)
			$HauteurCourante:=$HauteurCourante-$H
			
			  // Repérage des Portrait / Paysage
			SELECTION TO ARRAY:C260([Diapositives:40]NumOrdreDiapos:1;$TbNumDia;[Diapositives:40]OrientationPhotoH:30;$TbBoolH)
			ARRAY LONGINT:C221($TbDiaH;0)
			ARRAY LONGINT:C221($TbDiaV;0)
			
			$SFT:=Records in selection:C76([Diapositives:40])
			For ($Fumé;1;$SFT)
				If ($TbBoolH{$Fumé})
					APPEND TO ARRAY:C911($TbDiaH;$TbNumDia{$Fumé})
				Else 
					APPEND TO ARRAY:C911($TbDiaV;$TbNumDia{$Fumé})
				End if 
			End for 
			
			  // Impression des portraits puis des paysages
			For ($Fumé;1;2)
				$DiaH:=($Fumé=1)
				$SFT:=(Num:C11($DiaH)*Size of array:C274($TbDiaH))+(Num:C11(Not:C34($DiaH))*Size of array:C274($TbDiaV))
				If ($SFT>0)
					$CompteurPhoto:=0
					$Fini:=False:C215
					Repeat 
						$TT:=3+Num:C11($Fumé=2)
						For ($Sec;1;$TT)
							$CompteurPhoto:=$CompteurPhoto+1
							$PtI:=Get pointer:C304("VarImageAD"+String:C10($Sec))
							$PtT:=Get pointer:C304("VarTripletteAD"+String:C10($Sec))
							If ($CompteurPhoto>$SFT)  // Plus de photos
								$PtI->:=$ImageVide
								$PtT->:=""
								$Fini:=True:C214
							Else 
								If ($DiaH)
									$CDNomImage:=<>CDPhotosSauveAsaDia+String:C10($TbDiaH{$CompteurPhoto})+"i.jpg"
								Else 
									$CDNomImage:=<>CDPhotosSauveAsaDia+String:C10($TbDiaV{$CompteurPhoto})+"i.jpg"
								End if 
								READ PICTURE FILE:C678($CDNomImage;$VarImage)
								$PtI->:=$VarImage
								If ($DiaH)
									$PtT->:=String:C10($TbDiaH{$CompteurPhoto})
								Else 
									$PtT->:=String:C10($TbDiaV{$CompteurPhoto})
								End if 
							End if 
						End for 
						$DiaET:=(Num:C11($DiaH)*429)+(Num:C11(Not:C34($DiaH))*553)
						$DiaPied:=(Num:C11($DiaH)*534)+(Num:C11(Not:C34($DiaH))*708)
						$HauteurPrévue:=$DiaPied-$DiaET
						If ($HauteurCourante<$HauteurPrévue) & (Not:C34($Fini))  // pas moyen d'imprimer une ligne sup
							PAGE BREAK:C6(>)
							$HauteurCourante:=$HauteurMax
							$H:=Print form:C5("AntichambreImpression";0;47)
							$HauteurCourante:=$HauteurCourante-$H
							  //$H:=Imprimer ligne("AntichambreImpression";429;534)
							  //$HauteurCourante:=$HauteurCourante-$H
						End if 
						$H:=Print form:C5("AntichambreImpression";$DiaET;$DiaPied)
						$HauteurCourante:=$HauteurCourante-$H
						
					Until ($Fini)
				End if 
			End for 
			
		End if 
		If ($Salé#$FT)
			PAGE BREAK:C6(>)
		Else 
			PAGE BREAK:C6
		End if 
		
	End for 
End if 
