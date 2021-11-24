//%attributes = {"publishedWeb":true}
  // DiaInitTbDiamant 6.0 du 12/8/98
  //Appelé dans ZDebut
C_LONGINT:C283($Salé;$FT;$L;$H)
C_TEXT:C284($Diapo)

  // tableaux interprocess des quizz
QuizzFabriqueTbGeneraux 

  // Tableau des personnes autorisées
ARRAY TEXT:C222(<>TbNomLoginAsaDia;0)

  // tableaux interprocess de variables AsaDia
ARRAY BLOB:C1222($Tb;0)
  // Tableaux généraux de [Diapositives]
ALL RECORDS:C47([Diapositives:40])
SELECTION TO ARRAY:C260([Diapositives:40]Auteur:10;<>TbDiaposAuteur\
;[Diapositives:40]BlobFleches:21;<>TbDiaposBlobFleches\
;[Diapositives:40]CommentaireA:28;<>TbDiaposComA\
;[Diapositives:40]Commentaires:7;<>TbDiaposComF\
;[Diapositives:40]DescriptionTypeLesion:8;<>TbDiaposDescriptionTypeLesion\
;[Diapositives:40]DiapoCommentaire:26;<>TbDiapoCommentaire\
;[Diapositives:40]DiapoFicheReflexe:31;<>TbDiaposDiapoFicheReflexe\
;[Diapositives:40]DiaposLiees:22;<>TbDiaposDiaposLiees\
;[Diapositives:40]Espece:3;<>TbDiaposEspece\
;[Diapositives:40]Frequence:17;<>TbDiaposFréquence\
;[Diapositives:40]GrandTypeLesionnel:5;<>TbDiaposGrandTypeLesionnel\
;[Diapositives:40]JustificationConduite:13;<>TbDiaposJustificationConduite\
;[Diapositives:40]MotifSaisie:12;<>TbDiaposMotifSaisie\
;[Diapositives:40]MotifSaisieDGAL:23;<>TbDiaposMotifSaisieDGAL\
;[Diapositives:40]NomLesion:4;<>TbDiaposNomLesion\
;[Diapositives:40]NPC:14;<>TbDiaposNPC\
;[Diapositives:40]NumOrdreDiapos:1;<>TbDiaposNumOrdreDiapos\
;[Diapositives:40]ObjetDiapo:32;<>TbDiaposObjetDiapo\
;[Diapositives:40]Organe:2;<>TbDiaposOrgane\
;[Diapositives:40]OrientationPhotoH:30;<>TbDiaposOrientationPhotoH\
;[Diapositives:40]Origine:11;<>TbDiaposOrigine\
;[Diapositives:40]RefCD:24;<>TbDiaposRéférenceCD\
;[Diapositives:40]ReferenceReglementaireFrance:19;<>TbDiaposReferenceReglementaireF\
;[Diapositives:40]ReferenceReglementaireUE:27;<>TbDiaposReferenceReglementaireU\
;[Diapositives:40]RemarqueExpertNPC:29;<>TbDiaposRemarqueExpertNPC\
;[Diapositives:40]Statut:18;<>TbDiaposStatut\
;[Diapositives:40]Synonymes:15;<>TbDiaposSynonymes\
;[Diapositives:40]TypeLesionnelPrecis:6;<>TbDiaposTypeLesionnelPrecis\
;[Diapositives:40]TypeProduction:16;<>TbDiaposTypeProduction)
LONGINT ARRAY FROM SELECTION:C647([Diapositives:40];<>TbNumEnrDiapos)

  // les tableaux pour AsaDia Gibier et AsaDia en Russe
$FT:=Size of array:C274(<>TbDiaposObjetDiapo)
ARRAY TEXT:C222(<>TbDiaposRefPhotoPrincipaleGibie;$FT)
ARRAY TEXT:C222(<>TbDiaposRefPhotoLiéesGibier;$FT)
ARRAY TEXT:C222(<>TbDiaposComR;$FT)
  // tableau des recherches composites : nom lésion + espèce + organe + commentaire
ARRAY TEXT:C222(<>TbDiaposRechercheA;$FT)  // version anglaise
ARRAY TEXT:C222(<>TbDiaposRechercheR;$FT)  // version russe
If (Application type:C494=4D Server:K5:6)
	$Diapo:=""
	For ($Salé;1;$FT)
		$Diapo:=OB Get:C1224(<>TbDiaposObjetDiapo{$Salé};"RefPhotoPrincipaleGibier";Est un texte:K8:3)
		<>TbDiaposRefPhotoPrincipaleGibie{$Salé}:=$Diapo
		
		$Diapo:=OB Get:C1224(<>TbDiaposObjetDiapo{$Salé};"RefPhotoLiéesGibier";Est un texte:K8:3)
		<>TbDiaposRefPhotoLiéesGibier{$Salé}:=$Diapo
		
		$TradR:=OB Get:C1224(<>TbDiaposObjetDiapo{$Salé};"TraducRU";Est un texte:K8:3)
		<>TbDiaposComR{$Salé}:=$TradR
		
		$Les:=DiaWebTraduitLesion (<>TbDiaposNomLesion{$Salé};"A")+" "
		$Esp:=DiaWebTraduitTexte (<>TbDiaposEspece{$Salé};"A")+" "
		$0rg:=DiaWebTraduitTexte (<>TbDiaposOrgane{$Salé};"A")+" "
		$Com:=OB Get:C1224(<>TbDiaposObjetDiapo{$Salé};"TraducEN";Est un texte:K8:3)
		<>TbDiaposRechercheA{$Salé}:=$Les+$Esp+$0rg+$Com
		
		
		$Les:=DiaWebTraduitLesion (<>TbDiaposNomLesion{$Salé};"R")+" "
		$Esp:=DiaWebTraduitTexte (<>TbDiaposEspece{$Salé};"R")+" "
		$0rg:=DiaWebTraduitTexte (<>TbDiaposOrgane{$Salé};"R")+" "
		$Com:=$TradR
		<>TbDiaposRechercheR{$Salé}:=$Les+$Esp+$0rg+$Com
		
	End for 
	
End if 
  // Tableaux généraux de [Lesions]
ALL RECORDS:C47([DiaLesions:44])
SELECTION TO ARRAY:C260([DiaLesions:44]DescriptionTypeMacro:4;<>TbLesionsDescriptionTypeMacro\
;[DiaLesions:44]Etiologie:6;<>TbLesionsEtiologie\
;[DiaLesions:44]FicheReflexe:12;<>TbLesionsFicheReflexe\
;[DiaLesions:44]Frequence:11;<>TbLesionsFrequence\
;[DiaLesions:44]MotifSaisie:7;<>TbLesionsMotifSaisie\
;[DiaLesions:44]MotifSaisieDGAL:15;<>TbLesionsMotifSaisieDGAL\
;[DiaLesions:44]NomLesion:1;<>TbLesionsNomLesion\
;[DiaLesions:44]NPC:9;<>TbLesionsNPC\
;[DiaLesions:44]NumLesion:18;<>TbLesionsNumLesion\
;[DiaLesions:44]ReferenceReglementaireFr:13;<>TbLesionsReferenceReglementai\
;[DiaLesions:44]ReferenceReglementaireUE:17;<>TbLesionsReglementUE\
;[DiaLesions:44]TypeLesionnelPrecis:3;<>TbLesionsTypeLesionnelPrecis\
;[DiaLesions:44]GrandTypeLesionnel:2;<>TbLesionsGrandTypeLesionnel\
;[DiaLesions:44]ObjetLesion:19;<>TbLesionsObjetLesion\
;[DiaLesions:44]JustificationConduite:8;<>TbLesionsJustificationConduit)
LONGINT ARRAY FROM SELECTION:C647([DiaLesions:44];<>TbNumEnrLes)


  // Tableaux généraux de [MotifSaisieDGAL]
QUERY:C277([DiaMotifSaisieDGAL:42];[DiaMotifSaisieDGAL:42]TypeListe:8="A")
SELECTION TO ARRAY:C260([DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1;<>TbMotifLibelleMotifSaisieDGAL\
;[DiaMotifSaisieDGAL:42]ClassementNonConsoHumaine:6;<>TbMotifClassementNonConsoHumain\
;[DiaMotifSaisieDGAL:42]InformationEleveurs:11;<>TbMotifInformationEleveurs\
;[DiaMotifSaisieDGAL:42]PrecisionsEleveur:7;<>TbMotifPrecisions\
;[DiaMotifSaisieDGAL:42]InformationChasseurs:15;<>TbMotifInfoChasseur\
;[DiaMotifSaisieDGAL:42]PrecisionsGibier:14;<>TbMotifPrecisionsGibier\
;[DiaMotifSaisieDGAL:42]QualificatifEtiopatho:3;<>TbMotifQualificatifEtiopatho)

  // Tableaux généraux de [Atlas]
  //TOUT SÉLECTIONNER([Atlas])
  //$FT:=Enregistrements trouvés([Atlas])
  //TABLEAU BOOLÉEN(<>TbAtlasH;$FT)
  //Boucle ($Salé;1;$FT)
  //$CDNomImage:=Dossier 4D(Dossier base)+"dossier Photos"+Séparateur dossier+Chaîne([Atlas]NumOrdreDiapo)+".jpg"
  //LIRE FICHIER IMAGE($CDNomImage;$VarPhoto)
  //PROPRIÉTÉS IMAGE($VarPhoto;$L;$H)  // l'orientation de la photo
  //<>TbAtlasH{$Salé}:=($L>$H)
  //ENREGISTREMENT SUIVANT([Atlas])
  //Fin de boucle
  //SÉLECTION VERS TABLEAU([Atlas]NumOrdreDiapo;<>TbAtlasNumOrdreDiapo)
