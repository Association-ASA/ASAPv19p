  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 06/07/20, 18:27:25
  // ----------------------------------------------------
  // Méthode : AdV17MetsLesFleches
  // Description
  //
  //
  // Paramètres
  // ----------------------------------------------------
$Evt:=Form event code:C388

Case of 
	: ($evt=Sur chargement:K2:1)
		ARRAY LONGINT:C221(TbNumDAF;0)
		ARRAY LONGINT:C221(TbNumDF;0)
		Bas:=800
		ARRAY INTEGER:C220(PUMTC;12)
		PUMTC{1}:=8
		PUMTC{2}:=9
		PUMTC{3}:=10
		PUMTC{4}:=11
		PUMTC{5}:=12
		PUMTC{6}:=13
		PUMTC{7}:=14
		PUMTC{8}:=15
		PUMTC{9}:=16
		PUMTC{10}:=17
		PUMTC{11}:=18
		PUMTC{12}:=24
		PUMTC:=3
		
		$CDImage:=<>PermCheDossierAsaDiaWeb+String:C10([Diapositives:40]NumOrdreDiapos:1)+".jpg"
		READ PICTURE FILE:C678($CDImage;VarImage)
		If (FlechesDirectes)
			RELATE MANY:C262([Diapositives:40]NumOrdreDiapos:1)
			PICTURE PROPERTIES:C457(VarImage;$L;$H)
			If ($H<$L)
				VarImageVerticale:=False:C215
				FORM GOTO PAGE:C247(1)
				VarComDia:=[Diapositives:40]Commentaires:7
				DiaInitChargementFleches (True:C214)
				OBJECT GET COORDINATES:C663(VarImage;PG;PH;PD;PB)
				CasePlacerFleche:=0
				CaseSaisie:=0
				OBJECT SET VISIBLE:C603(BouPlaceFleche;False:C215)
			Else 
				VarImageVerticale:=True:C214
				VarImageV:=VarImage
				VarComDia:=[Diapositives:40]Commentaires:7
				FORM GOTO PAGE:C247(2)
				DiaInitChargementFleches (True:C214)
				OBJECT GET COORDINATES:C663(VarImageV;PG;PH;PD;PB)
				CasePlacerFlecheV:=0
				CaseSaisieV:=0
				OBJECT SET VISIBLE:C603(BouPlaceFlecheV;False:C215)
			End if 
			$NomLésion:=Uppercase:C13(Substring:C12([Diapositives:40]NomLesion:4;1;1))+Substring:C12([Diapositives:40]NomLesion:4;2)
			$espece:=Substring:C12([Diapositives:40]Espece:3;1;(Length:C16([Diapositives:40]Espece:3)-1))
			$espece:=Lowercase:C14(Substring:C12($espece;1;1))+Substring:C12($espece;2)
			VarAfficheTriplette:=$NomLésion+" / "+[Diapositives:40]Organe:2+" / "+$espece
			VarDesType:=[Diapositives:40]DescriptionTypeLesion:8
			DiaReplaceLesFleches 
			OBJECT SET VISIBLE:C603(*;"cgm@";False:C215)
			
		Else 
			OBJECT SET VISIBLE:C603(*;"cgm@";True:C214)
			  //CHERCHER([Atlas];[Atlas]MAJ="Faite")
			QUERY:C277([Diapositives:40];[Diapositives:40]DiapoCommentaire:26=False:C215;*)
			QUERY:C277([Diapositives:40]; & [Diapositives:40]Origine:11="ENVA")
			SELECTION TO ARRAY:C260([Diapositives:40]NumOrdreDiapos:1;TbNumDAF)
			SORT ARRAY:C229(TbNumDAF;>)
			VarImageVerticale:=False:C215
			VarNb:=Size of array:C274(TbNumDAF)
			VarImage:=<>VarImageVide
			VarOrientation:=""
			VarTaillePhoto:=String:C10(Int:C8(Picture size:C356(VarImage)/1000))+" Mo"
			DiaVideTbEtCommentaires 
			PUMEcole:=0
			VarAfficheTriplette:=""
			VarDesType:=""
			VarImageFleche:=0
			$NomFleche:=String:C10(VarImageFleche+1)+"1"+(Num:C11(VarImageVerticale)*"V")
			PtChampCourant:=Get pointer:C304("VarC"+$NomFleche)
			
		End if 
End case 