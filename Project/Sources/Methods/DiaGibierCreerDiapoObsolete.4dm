//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 23/02/19, 09:13:16
  // ----------------------------------------------------
  // Méthode : AdGibierCréerDiapositives
  // Description
  // Méthode de création des enregistrements
  //  de [Diapositives] pour AsaDia Gibier 
  //  à partir des tableaux affichés
  //  dans le formulaire projet "DlgAsaDiaGibier"
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)
$CDLogo:=<>PermCheDropBox+"AsaDia"+Séparateur dossier:K24:12+"Tags"+Séparateur dossier:K24:12
$CDPhotosAvant:=VarCDPhotos
$CDPhotosApres:=$CDPhotosAvant+"Photos Web"+Séparateur dossier:K24:12
If (Test path name:C476($CDPhotosApres)#Est un dossier:K24:2)
	CREATE FOLDER:C475($CDPhotosApres)
End if 


READ WRITE:C146([Diapositives:40])
QUERY:C277([Diapositives:40];[Diapositives:40]NumOrdreDiapos:1>80000)
SELECTION TO ARRAY:C260([Diapositives:40]NumOrdreDiapos:1;TbNumDiapoExistantes)
$FT:=Size of array:C274(TbRef)
For ($Salé;1;$FT)  // autant que de ligne dans le tableau
	QUERY BY ATTRIBUTE:C1331([Diapositives:40];[Diapositives:40]ObjetDiapo:32;"RefPhotoPrincipaleGibier";=;TbRef{$Salé})
	If (Records in selection:C76([Diapositives:40])=0)
		CREATE RECORD:C68([Diapositives:40])
		$NumD:=80000
		Repeat 
			$NumD:=$NumD+1
			$L:=Find in array:C230(TbNumDiapoExistantes;$NumD)
		Until ($L<0)
		[Diapositives:40]NumOrdreDiapos:1:=$NumD
		APPEND TO ARRAY:C911(TbNumDiapoExistantes;$NumD)
	End if 
	$NumD:=[Diapositives:40]NumOrdreDiapos:1
	[Diapositives:40]CheminAccesPhoto:9:=TbChemin{$Salé}
	[Diapositives:40]Auteur:10:="ZACHARIE"
	
	$OC:=True:C214
	QUERY:C277([DiaLesions:44];[DiaLesions:44]NomLesion:1=TbNomLésion{$Salé})
	If (Records in selection:C76([DiaLesions:44])=1)
		[Diapositives:40]NomLesion:4:=[DiaLesions:44]NomLesion:1
		[Diapositives:40]ReferenceReglementaireUE:27:=[DiaLesions:44]ReferenceReglementaireUE:17
		[Diapositives:40]ReferenceReglementaireFrance:19:=[DiaLesions:44]ReferenceReglementaireFr:13
	Else 
		TRACE:C157
		$OC:=False:C215
	End if 
	[Diapositives:40]GrandTypeLesionnel:5:=[DiaLesions:44]GrandTypeLesionnel:2
	[Diapositives:40]TypeLesionnelPrecis:6:=[DiaLesions:44]TypeLesionnelPrecis:3
	[Diapositives:40]DescriptionTypeLesion:8:=[DiaLesions:44]DescriptionTypeMacro:4
	[Diapositives:40]DiapoFicheReflexe:31:=[DiaLesions:44]FicheReflexe:12
	[Diapositives:40]Frequence:17:=[DiaLesions:44]Frequence:11
	[Diapositives:40]JustificationConduite:13:=[DiaLesions:44]JustificationConduite:8
	[Diapositives:40]MotifSaisieDGAL:23:=[DiaLesions:44]MotifSaisieDGAL:15
	[Diapositives:40]NombreGraphe:20:=1
	[Diapositives:40]NPC:14:=[DiaLesions:44]NPC:9
	[Diapositives:40]Exporte:25:=True:C214
	
	If (Find in array:C230(<>TbOrgane;TbOrgane{$Salé})<0)
		TRACE:C157
		$OC:=False:C215
	Else 
		[Diapositives:40]Organe:2:=TbOrgane{$Salé}
	End if 
	[Diapositives:40]Espece:3:=TbEspèce{$Salé}
	[Diapositives:40]Commentaires:7:=TbDescription{$Salé}
	[Diapositives:40]Statut:18:="Référence"
	
	  // La photo
	  //CHERCHER([Atlas];[Atlas]NumOrdreDiapo=[Diapositives]NumOrdreDiapos)
	  //Si (Enregistrements trouvés([Atlas])=0)
	  //CRÉER ENREGISTREMENT([Atlas])
	  //[Atlas]NumOrdreDiapo:=[Diapositives]NumOrdreDiapos
	  //Fin de si 
	
	  // L'image asadia-isée pour 4D
	$CDi:=TbChemin{$Salé}
	If (Test path name:C476($CDi)#Est un document:K24:1)
		TRACE:C157
		$OC:=False:C215
	End if 
	READ PICTURE FILE:C678($CDi;$PhotoAvant)
	  //[Atlas]Photo:=$PhotoAvant
	PICTURE PROPERTIES:C457($PhotoAvant;$La;$Ha)
	  //[Atlas]Rotation:=Chaîne(Num($La<$Ha)*100;"000")
	
	[Diapositives:40]OrientationPhotoH:30:=($La>$Ha)
	[Diapositives:40]CheminAccesPhoto:9:=$CDi
	$MaxDim:=(Num:C11($La>=$Ha)*$La)+(Num:C11($La<$Ha)*$Ha)
	OB SET:C1220([Diapositives:40]ObjetDiapo:32;"MaxDim";$MaxDim)
	
	  // La grande imagette
	If ([Diapositives:40]OrientationPhotoH:30)
		CREATE THUMBNAIL:C679($PhotoAvant;$GrandeImagette;300;200)
	Else 
		CREATE THUMBNAIL:C679($PhotoAvant;$GrandeImagette;200;300)
	End if 
	$CDImagette:=$CDPhotosApres+String:C10($NumD)+"i.jpg"
	If (Test path name:C476($CDImagette)=Est un document:K24:1)
		DELETE DOCUMENT:C159($CDImagette)
	End if 
	WRITE PICTURE FILE:C680($CDImagette;$GrandeImagette;".jpg")
	
	  // La petite imagette
	If ([Diapositives:40]OrientationPhotoH:30)
		CREATE THUMBNAIL:C679($PhotoAvant;$PetiteImagette;75;50)
	Else 
		CREATE THUMBNAIL:C679($PhotoAvant;$PetiteImagette;50;75)
	End if 
	$CDImagette:=$CDPhotosApres+String:C10($NumD)+"is.jpg"
	If (Test path name:C476($CDImagette)=Est un document:K24:1)
		DELETE DOCUMENT:C159($CDImagette)
	End if 
	WRITE PICTURE FILE:C680($CDImagette;$PetiteImagette;".jpg")
	
	  // incrustation du logo
	  // Choix du bon logo
	ARRAY TEXT:C222($TbFichierIncrust;0)
	DOCUMENT LIST:C474($CDLogo;$TbFichierIncrust)
	
	
	  // Le logo
	If ($MaxDim>2000)  // Photo AsaDia-isée
		$Test:="@"+[Diapositives:40]Auteur:10+"@"
		$L2:=Find in array:C230($TbFichierIncrust;$Test)
		If ($L2<0)
			$OC:=False:C215
			TRACE:C157
		End if 
		$CDi:=$CDLogo+$TbFichierIncrust{$L2}
		READ PICTURE FILE:C678($CDi;$Logo)
		PICTURE PROPERTIES:C457($Logo;$Lb;$Hb)
		  // Incrustation
		COMBINE PICTURES:C987($ImageFinale;$PhotoAvant;Superposition:K61:10;$Logo;30;$Ha-30-$Hb)
		
		  // Tags
		  // Plaçons les métadonnées dans $Image
		ARRAY TEXT:C222($TbMC;7)
		$TbMC{1}:=[Diapositives:40]Auteur:10
		$TbMC{2}:=[Diapositives:40]Origine:11
		$TbMC{3}:=[Diapositives:40]Espece:3
		$TbMC{4}:=[Diapositives:40]Organe:2
		$TbMC{5}:=Lowercase:C14(Uppercase:C13([Diapositives:40]NomLesion:4))
		$TbMC{6}:="AsaDia Gibier"
		$TbMC{7}:="Photo "+String:C10([Diapositives:40]NumOrdreDiapos:1)
		$Meta:="Photo n°"+String:C10([Diapositives:40]NumOrdreDiapos:1)
		$Meta:=$Meta+"       "+$TbMC{1}
		$Meta:=$Meta+"       "+$TbMC{2}+<>ZCR
		$esp:=[Diapositives:40]Espece:3
		$esp:=Substring:C12($esp;1;Length:C16($esp)-1)
		$esp:=Lowercase:C14(Substring:C12($esp;1;1))+Substring:C12($esp;2)
		$NL:=Uppercase:C13(Substring:C12([Diapositives:40]NomLesion:4;1;1))+Substring:C12([Diapositives:40]NomLesion:4;2)
		$NL:=Lowercase:C14($NL)
		$Meta:=$Meta+$NL+" sur "+[Diapositives:40]Organe:2+" chez un "+$esp+"+"+Char:C90(10)
		$Meta:=$Meta+"Commentaire : "+Lowercase:C14(Uppercase:C13([Diapositives:40]Commentaires:7))
		SET PICTURE METADATA:C1121($ImageFinale;IPTC caption abstract:K68:100;$Meta)
		  // FIXER MÉTADONNÉES IMAGE($ImageFinale;IPTC copyright notice;"ASA : tous droits réservés")
		SET PICTURE METADATA:C1121($ImageFinale;IPTC Keywords:K68:118;$TbMC)
		
		ARRAY TEXT:C222($tTkeywords;0)
		GET PICTURE METADATA:C1122($ImageFinale;IPTC Keywords:K68:118;$tTkeywords)
		
	Else   // image trop petite, on conserve l'original sans changement
		$ImageFinale:=$PhotoAvant  // on mettra le nom de l'auteur dans le HTML
	End if 
	$CDPhotoFinale:=$CDPhotosApres+String:C10($NumD)+".jpg"
	
	If (Test path name:C476($CDPhotoFinale)=Est un document:K24:1)
		DELETE DOCUMENT:C159($CDPhotoFinale)
	End if 
	WRITE PICTURE FILE:C680($CDPhotoFinale;$ImageFinale;".jpg")
	ARRAY TEXT:C222($tTkeywords;0)
	If ($OC)
		OB SET:C1220([Diapositives:40]ObjetDiapo:32;"RefPhotoPrincipaleGibier";TbRef{$Salé})
		If (TbLien{$Salé}#"")
			OB SET:C1220([Diapositives:40]ObjetDiapo:32;"RefPhotoLiéesGibier";TbLien{$Salé})
		End if 
		SAVE RECORD:C53([Diapositives:40])
		  //STOCKER ENREGISTREMENT([Atlas])
	End if 
End for 
