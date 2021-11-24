
$evt:=Form event code:C388
Case of 
	: ($evt=Sur nouvelle sélection:K2:29)
		C_LONGINT:C283($C; $L)
		LISTBOX GET CELL POSITION:C971(*; "ListBoxFleches"; $C; $L)
		GOTO SELECTED RECORD:C245([Diapositives:40]; $L)
		VarNumEnrDia:=Record number:C243([Diapositives:40])
		VarComDia:=[Diapositives:40]Commentaires:7
		VarDesType:=[Diapositives:40]DescriptionTypeLesion:8
		ARRAY TEXT:C222(TbTb; 0)
		ZBlobVersVariable(->[Diapositives:40]BlobFleches:21; ->TbTb)
		If (Size of array:C274(TbTb)=0)
			ARRAY TEXT:C222(TbTb; 4)
		End if 
		LesFlechesSontLà:=True:C214
		DiaACReplaceLesFleches
		
		VarMotsclefs:=""
		VarCarPhoto:="Auteur : "+[Diapositives:40]Auteur:10+<>ZCR
		VarCarPhoto:=VarCarPhoto+"Origine : "+[Diapositives:40]Origine:11+<>ZCR
		$esp:=[Diapositives:40]Espece:3
		$esp:=Substring:C12($esp; 1; Length:C16($esp)-1)
		$esp:=Lowercase:C14(Substring:C12($esp; 1; 1))+Substring:C12($esp; 2)
		$NL:=Uppercase:C13(Substring:C12([Diapositives:40]NomLesion:4; 1; 1))+Substring:C12([Diapositives:40]NomLesion:4; 2)
		VarCarPhoto:=VarCarPhoto+$NL+" sur "+[Diapositives:40]Organe:2+" chez un "+$esp+"."
		
		$CDWeb:=<>CDPhotosSauveAsaDia+String:C10([Diapositives:40]NumOrdreDiapos:1)+".jpg"
		If (Test path name:C476($CDWeb)=Est un document:K24:1)
			READ PICTURE FILE:C678($CDWeb; VarImage)
			PICTURE PROPERTIES:C457(VarImage; $LargeurPhoto; $HauteurPhoto)
			If ($LargeurPhoto>$HauteurPhoto)
				$Droite:=DroiteInitial
				$Bas:=HautInitial+((DroiteInitial-GaucheInitial)*($HauteurPhoto/$LargeurPhoto))
			Else 
				$Bas:=HautInitial+DroiteInitial-GaucheInitial
				$Droite:=GaucheInitial+((DroiteInitial-GaucheInitial)*($LargeurPhoto/$HauteurPhoto))
			End if 
			OBJECT SET COORDINATES:C1248(VarImage; GaucheInitial; HautInitial; $Droite; $Bas)
			VarCarPhoto:=VarCarPhoto+<>ZCR+"Dimensions : L="+String:C10($LargeurPhoto)+" H="+String:C10($HauteurPhoto)+" Ratio="+String:C10($LargeurPhoto/$HauteurPhoto)
		End if 
		DiaAC2MetsLesFleches
		
	: ($evt=Sur double clic:K2:5)
		
End case 
