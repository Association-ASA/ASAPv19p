//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 06/09/18, 07:36:37
  // ----------------------------------------------------
  // Méthode : AntichambreCreationDiapo
  // Description
  // Transforme l'enregistrement courant de [XDonnees]
  //  en enregistrement de [Diapositives]
  //  Création si non existant, Modification sinon
  // ----------------------------------------------------

C_LONGINT:C283($L;$L2;$Ha;$Hb;$La;$Lb;$NumCas)
C_PICTURE:C286($Logo;$PhotoAvant;$ImageFinale;$GrandeImagette;$PetiteImagette)
C_TEXT:C284($Commémoratifs)
$OC:=True:C214
  // Données de description de la photo
$Lésion:=OB Get:C1224([DiaData:45]XObjet:15;"Lésion";Est un texte:K8:3)
$Organe:=OB Get:C1224([DiaData:45]XObjet:15;"Organe";Est un texte:K8:3)
$Espèce:=OB Get:C1224([DiaData:45]XObjet:15;"Espèce";Est un texte:K8:3)
$Auteur:=OB Get:C1224([DiaData:45]XObjet:15;"Auteur";Est un texte:K8:3)
$Délai:=OB Get:C1224([DiaData:45]XObjet:15;"Délai";Est un texte:K8:3)
$Commémoratifs:=OB Get:C1224([DiaData:45]XObjet:15;"Commémoratifs";Est un texte:K8:3)
$Commentaires:=OB Get:C1224([DiaData:45]XObjet:15;"Commentaires";Est un texte:K8:3)
$Technique:=[DiaData:45]XTexteSup:8
  // Données du fichier de la photo initialement prévue (ni asadiaisée, ni logotée)
$CheminPhotoAntichambre:=[DiaData:45]XTexte:7  // Chemin complet
$NomFichier:=[DiaData:45]XNom:1  // Type IMG_0540.jpg
$NumCas:=[DiaData:45]XValeur:4
  // Données du fichier de la photo asadia-isée non logotée)
DOCUMENT LIST:C474(<>CDPhotosATraiter;$TbTphotosAvant)
$L2:=Find in array:C230($TbTphotosAvant;$NomFichier)
If ($L2<0)
	$L2:=Find in array:C230($TbTphotosAvant;("T_"+$NomFichier))
	If ($L2<0)
		TRACE:C157
		$OC:=False:C215
	End if 
End if 
If ($OC)
	$CDi:=<>CDPhotosATraiter+$TbTphotosAvant{$L2}
	  // Données du dossier des photos Web et de son contenu
	$CDPhotosApres:=<>CDPhotosWeb
	DOCUMENT LIST:C474($CDPhotosApres;$TbTphotosApres;Ignorer invisibles:K24:16)
	
	  // la diapo
	READ WRITE:C146([Diapositives:40])
	QUERY BY ATTRIBUTE:C1331([Diapositives:40]; & ;[Diapositives:40]ObjetDiapo:32;"NomFichier";=;$NomFichier)
	If (Records in selection:C76([Diapositives:40])=0)
		CREATE RECORD:C68([Diapositives:40])
		$NumD:=60000+(Num:C11(PUMTypePhoto=2)*20000)
		Repeat 
			$NumD:=$NumD+1
			$L:=Find in array:C230(TbNumDiapoExistantes;$NumD)
		Until ($L<0)
		[Diapositives:40]NumOrdreDiapos:1:=$NumD
		APPEND TO ARRAY:C911(TbNumDiapoExistantes;$NumD)
	End if 
	$NumD:=[Diapositives:40]NumOrdreDiapos:1
	[Diapositives:40]CheminAccesPhoto:9:=$CDi
	OB SET:C1220([Diapositives:40]ObjetDiapo:32;"NomFichier";[DiaData:45]XNom:1)
	[Diapositives:40]Auteur:10:=$Auteur
	QUERY:C277([DiaLesions:44];[Diapositives:40]NomLesion:4=$Lésion)
	If (Records in selection:C76([DiaLesions:44])=1)
		[Diapositives:40]NomLesion:4:=[DiaLesions:44]NomLesion:1
		[Diapositives:40]ReferenceReglementaireUE:27:=[DiaLesions:44]ReferenceReglementaireUE:17
		[Diapositives:40]ReferenceReglementaireFrance:19:=[DiaLesions:44]ReferenceReglementaireFr:13
	Else 
		QUERY:C277([DiaMotifSaisieDGAL:42];[DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1=$Lésion)
		If (Records in selection:C76([DiaMotifSaisieDGAL:42])=0)
			TRACE:C157
		Else 
			[Diapositives:40]MotifSaisieDGAL:23:=$Lésion
			[Diapositives:40]ReferenceReglementaireUE:27:=[DiaMotifSaisieDGAL:42]RefRegEuropeenne:5
			QUERY:C277([DiaLesions:44];[DiaLesions:44]MotifSaisieDGAL:15=[DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1)
			[Diapositives:40]NomLesion:4:=[DiaLesions:44]NomLesion:1
		End if 
		[Diapositives:40]GrandTypeLesionnel:5:=[DiaLesions:44]GrandTypeLesionnel:2
		[Diapositives:40]TypeLesionnelPrecis:6:=[DiaLesions:44]TypeLesionnelPrecis:3
	End if 
	[Diapositives:40]DescriptionTypeLesion:8:=[DiaLesions:44]DescriptionTypeMacro:4
	[Diapositives:40]DiapoFicheReflexe:31:=[DiaLesions:44]FicheReflexe:12
	[Diapositives:40]Frequence:17:=[DiaLesions:44]Frequence:11
	[Diapositives:40]JustificationConduite:13:=[DiaLesions:44]JustificationConduite:8
	[Diapositives:40]MotifSaisieDGAL:23:=[DiaLesions:44]MotifSaisieDGAL:15
	[Diapositives:40]NombreGraphe:20:=1
	[Diapositives:40]NPC:14:=[DiaLesions:44]NPC:9
	[Diapositives:40]Exporte:25:=True:C214
	
	If (Find in array:C230(TbNomOrgane;$Organe)<0)
		TRACE:C157
		$OC:=False:C215
	Else 
		[Diapositives:40]Organe:2:=$Organe
	End if 
	If (Find in array:C230(TbNomEspece;$Espèce)<0)
		TRACE:C157
		$OC:=False:C215
	Else 
		[Diapositives:40]Espece:3:=$Espèce
	End if 
	
	If ($Délai#"")
		$Commentaires:=$Commentaires+<>ZCR+$Délai
	End if 
	[Diapositives:40]Commentaires:7:=$Commentaires
	[Diapositives:40]Statut:18:="Référence"
	
	
	  // L'orientation de l'image asadia-isée pour 4D
	READ PICTURE FILE:C678($CDi;$PhotoAvant)
	PICTURE PROPERTIES:C457($PhotoAvant;$La;$Ha)
	[Diapositives:40]OrientationPhotoH:30:=($La>$Ha)
	
	  // Fabrication de la grande imagette
	If ([Diapositives:40]OrientationPhotoH:30)
		CREATE THUMBNAIL:C679($PhotoAvant;$GrandeImagette;300;200)
	Else 
		CREATE THUMBNAIL:C679($PhotoAvant;$GrandeImagette;200;300)
	End if 
	$CDImagette:=<>CDPhotosWeb+String:C10($NumD)+"i.jpg"
	If (Test path name:C476($CDImagette)=Est un document:K24:1)
		DELETE DOCUMENT:C159($CDImagette)
	End if 
	CONVERT PICTURE:C1002($GrandeImagette;".jpg";0.6)
	WRITE PICTURE FILE:C680($CDImagette;$GrandeImagette)
	
	  // La petite imagette
	If ([Diapositives:40]OrientationPhotoH:30)
		CREATE THUMBNAIL:C679($PhotoAvant;$PetiteImagette;75;50)
	Else 
		CREATE THUMBNAIL:C679($PhotoAvant;$PetiteImagette;50;75)
	End if 
	$CDImagette:=<>CDPhotosWeb+String:C10($NumD)+"is.jpg"
	If (Test path name:C476($CDImagette)=Est un document:K24:1)
		DELETE DOCUMENT:C159($CDImagette)
	End if 
	CONVERT PICTURE:C1002($PetiteImagette;".jpg";0.6)
	WRITE PICTURE FILE:C680($CDImagette;$PetiteImagette)
	
	  // incrustation du logo
	  // Choix du bon logo
	DOCUMENT LIST:C474(<>CDTags;$TbFichierIncrust)
	  // Le logo
	$Test:="@"+$Auteur+"@"
	$L2:=Find in array:C230($TbFichierIncrust;$Test)
	If ($L2<0)
		$OC:=False:C215
		TRACE:C157
	End if 
	$CDit:=<>CDTags+$TbFichierIncrust{$L2}
	READ PICTURE FILE:C678($CDit;$Logo)
	PICTURE PROPERTIES:C457($Logo;$Lb;$Hb)
	  // Incrustation
	COMBINE PICTURES:C987($ImageFinale;$PhotoAvant;Superposition:K61:10;$Logo;30;$Ha-30-$Hb)
	
	
	$CDPhotoFinale:=<>CDPhotosWeb+String:C10($NumD)+".jpg"
	If (Test path name:C476($CDPhotoFinale)=Est un document:K24:1)
		DELETE DOCUMENT:C159($CDPhotoFinale)
	End if 
	CONVERT PICTURE:C1002($ImageFinale;".jpg";0.6)
	WRITE PICTURE FILE:C680($CDPhotoFinale;$ImageFinale;".jpg")
	
	[DiaData:45]XEntier:2:=[Diapositives:40]NumOrdreDiapos:1
	If ($OC)
		SAVE RECORD:C53([DiaData:45])
		SAVE RECORD:C53([Diapositives:40])
		$Destination:=<>CDPhotosTraitées+String:C10($NumD)+"_"+[DiaData:45]XNom:1
		If (Test path name:C476($Destination)=Est un document:K24:1)
			DELETE DOCUMENT:C159($Destination)
		End if 
		MOVE DOCUMENT:C540($CDi;$Destination)
		$Pr:=Execute on server:C373("DiaACServeurCopiePhoto";0;"CopiePhotos";[Diapositives:40]NumOrdreDiapos:1)
		
		  // Actualisation du dossier <>CDPhotosSauveAsaDia
		  // Copie de la photo principale
		$Cible:=<>CDPhotosSauveAsaDia+String:C10($NumD)+".jpg"
		If (Test path name:C476($Cible)=Est un document:K24:1)
			DELETE DOCUMENT:C159($Cible)
		End if 
		$SourceIG:=<>CDPhotosWeb+String:C10($NumD)+".jpg"  // l'image en grand
		COPY DOCUMENT:C541($SourceIG;$Cible)
		
		  // Copie de la grande imagette
		$Cible:=<>CDPhotosSauveAsaDia+String:C10($NumD)+"i.jpg"
		If (Test path name:C476($Cible)=Est un document:K24:1)
			DELETE DOCUMENT:C159($Cible)
		End if 
		$SourceGI:=<>CDPhotosWeb+String:C10($NumD)+"i.jpg"  // la grande imagette
		COPY DOCUMENT:C541($SourceGI;$Cible)
		
		  // Copie de la petite imagette
		$Cible:=<>CDPhotosSauveAsaDia+String:C10($NumD)+"is.jpg"
		If (Test path name:C476($Cible)=Est un document:K24:1)
			DELETE DOCUMENT:C159($Cible)
		End if 
		$SourcePI:=<>CDPhotosWeb+String:C10($NumD)+"is.jpg"  // la petite imagette
		COPY DOCUMENT:C541($SourcePI;$Cible)
		
	Else 
		$Destination:=<>CDPhotosIgnorées+[DiaData:45]XNom:1
		MOVE DOCUMENT:C540($CDi;$Destination)
	End if 
	$0:=$NumCas
Else 
	$0:=-1
End if 
