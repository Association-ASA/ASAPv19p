//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 16/06/20, 13:58:37
  // ----------------------------------------------------
  // Méthode : QuizzScruteNouvellesPhotos
  // Description
  // Méthode qui scrute les dossiers des différentes écoles
  //  pour savoir s'il n'y a rien de nouveau
  // Paramètre : $1=sigle de l'école
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT;$Largeur;$Hauteur;$ProchIndexPhoto)
C_PICTURE:C286($VarImage;$Imagette)
ARRAY TEXT:C222($TbNomsDoc;0)
$SigleEcole:=$1
$CD:=<>PermCheDropBox+"Photosquizz"+Séparateur dossier:K24:12+"Photos quizz"+$SigleEcole+Séparateur dossier:K24:12
If (Test path name:C476($CD)=Est un dossier:K24:2)
	DOCUMENT LIST:C474($CD;$TbNomsDoc;Ignorer invisibles:K24:16)
	$FT:=Size of array:C274($TbNomsDoc)
	For ($Salé;1;$FT)
		$Source:=$CD+$TbNomsDoc{$Salé}
		$CDCible:=<>PermCheDossierAsaDiaWeb
		$Cible:=$CDCible+$TbNomsDoc{$Salé}
		If (Test path name:C476($Cible)=Est un document:K24:1)
			DELETE DOCUMENT:C159($Cible)
		End if 
		If (Is picture file:C1113($Source))
			READ PICTURE FILE:C678($Source;$VarImage)
			PICTURE PROPERTIES:C457($VarImage;$Largeur;$Hauteur)
			$TailleImage:=Picture size:C356($VarImage)
			$H:=($Largeur>$Hauteur)
			$DimMax:=(Num:C11($H)*$Largeur)+(Num:C11(Not:C34($H))*$Hauteur)
			If ($DimMax>3000)  // 2835 x 1871 idéalement pour AsaDia
				$Rapport:=2835/$DimMax
				TRANSFORM PICTURE:C988($VarImage;Redimensionnement:K61:2;$Rapport;$Rapport)
				$TailleImage:=Picture size:C356($VarImage)
				If ($TailleImage>800000)
					$Compteur:=1
					While ($TailleImage>900000) & ($Compteur<4)
						CONVERT PICTURE:C1002($VarImage;"jpeg";0.6)
						$TailleImage:=Picture size:C356($VarImage)
						$Compteur:=$Compteur+1
					End while 
				End if 
			End if 
			  // L'image est identifiée et mise aux normes 
			
			  // création de la [XDonnees]
			QUERY:C277([DiaData:45];[DiaData:45]XAlpha:14=$SigleEcole;*)
			QUERY:C277([DiaData:45]; & [DiaData:45]XType:5="QuizzPhoto")
			If (Records in selection:C76([DiaData:45])>0)
				$ProchIndexPhoto:=Max:C3([DiaData:45]XEntier:2)+1
			Else 
				$ProchIndexPhoto:=1
			End if 
			CREATE RECORD:C68([DiaData:45])
			[DiaData:45]XNom:1:=$TbNomsDoc{$Salé}
			[DiaData:45]XAlpha:14:=$SigleEcole
			[DiaData:45]XType:5:="QuizzPhoto"
			[DiaData:45]XEntier:2:=$ProchIndexPhoto
			[DiaData:45]XDate:3:=Current date:C33
			[DiaData:45]XValeur:4:=Num:C11($H)
			SAVE RECORD:C53([DiaData:45])
			  // Création de l'image et de l'imagette
			
			  // l'image
			$CDNomImage:=<>PermCheDossierAsaDiaWeb+"Q"+[DiaData:45]XAlpha:14+String:C10([DiaData:45]XEntier:2;"00000")+".jpg"
			If (Test path name:C476($CDNomImage)=Est un document:K24:1)
				DELETE DOCUMENT:C159($CDNomImage)
			End if 
			WRITE PICTURE FILE:C680($CDNomImage;$VarImage;".jpg")
			$CDDBNomImage:=<>CDPhotosSauveAsaDia+"Q"+[DiaData:45]XAlpha:14+String:C10([DiaData:45]XEntier:2;"00000")+".jpg"
			If (Test path name:C476($CDDBNomImage)=Est un document:K24:1)
				DELETE DOCUMENT:C159($CDDBNomImage)
			End if 
			COPY DOCUMENT:C541($CDNomImage;$CDDBNomImage)
			
			  // l'imagette
			If ($H)
				CREATE THUMBNAIL:C679($VarImage;$Imagette;300;200)
			Else 
				CREATE THUMBNAIL:C679($VarImage;$Imagette;200;300)
			End if 
			$CDNomImage:=<>PermCheDossierAsaDiaWeb+"Q"+[DiaData:45]XAlpha:14+String:C10([DiaData:45]XEntier:2;"00000")+"i.jpg"
			If (Test path name:C476($CDNomImage)=Est un document:K24:1)
				DELETE DOCUMENT:C159($CDNomImage)
			End if 
			WRITE PICTURE FILE:C680($CDNomImage;$Imagette;".jpg")
			$CDDBNomImage:=<>CDPhotosSauveAsaDia+"Q"+[DiaData:45]XAlpha:14+String:C10([DiaData:45]XEntier:2;"00000")+"i.jpg"
			If (Test path name:C476($CDDBNomImage)=Est un document:K24:1)
				DELETE DOCUMENT:C159($CDDBNomImage)
			End if 
			COPY DOCUMENT:C541($CDNomImage;$CDDBNomImage)
		End if 
		MOVE DOCUMENT:C540($Source;$Cible)
	End for 
End if 