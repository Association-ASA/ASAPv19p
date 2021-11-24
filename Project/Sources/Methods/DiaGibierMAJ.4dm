//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 04/08/19, 06:19:28
  // ----------------------------------------------------
  // Méthode : AdGibierMAJ
  // Description
  //   Méthode qui intègre le travail des experts
  //   de juillet 2019 dans la base de donnée
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$Pos)
C_TEXT:C284($LesionDescriptionGibier)

READ WRITE:C146(*)
USE CHARACTER SET:C205("macintosh";1)
$Doc:=Open document:C264("";Mode lecture:K24:5)
RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
If ($Ligne#"N°@")
	ALERT:C41("Désolé, le fichier désigné n'est pas le bon...")
Else 
	ARRAY TEXT:C222($TbDescriptif;15)  // les 15 colonnes du tableau EXCEL (cf infra)
	RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
	While ($Ligne#"")
		$Ligne:=Replace string:C233($Ligne;Char:C90(10);"")
		For ($Salé;1;14)
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$TbDescriptif{$Salé}:=Substring:C12($Ligne;1;($Pos-1))
			$ligne:=Substring:C12($Ligne;($Pos+1))
		End for 
		$TbDescriptif{15}:=$Ligne
		
		QUERY:C277([Diapositives:40];[Diapositives:40]NumOrdreDiapos:1=Num:C11($TbDescriptif{1}))
		If (Records in selection:C76([Diapositives:40])=0)
			TRACE:C157
		Else 
			  // MAJ de [Diapositives]
			$NPC:=Replace string:C233($TbDescriptif{10};", ";<>ZCR)
			$NPC:=Replace string:C233($NPC;",";<>ZCR)
			[Diapositives:40]NPC:14:=$NPC
			$FR:=Replace string:C233($TbDescriptif{8};"^p";<>ZCR)
			[Diapositives:40]DiapoFicheReflexe:31:=DiaLavePlusBlanc ($FR)
			SAVE RECORD:C53([Diapositives:40])
			
			  // MAJ de [MotifSaisieDGAL]
			QUERY:C277([DiaMotifSaisieDGAL:42];[DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1=$TbDescriptif{3})
			  //Si ([MotifSaisieDGAL]PrecisionsGibier="")
			$Precision:=Replace string:C233($TbDescriptif{15};"^p";<>ZCR)
			[DiaMotifSaisieDGAL:42]PrecisionsGibier:14:=DiaLavePlusBlanc ($Precision)
			SAVE RECORD:C53([DiaMotifSaisieDGAL:42])
			  //Fin de si
			  //Si ([MotifSaisieDGAL]InformationChasseurs="")
			$Information:=Replace string:C233($TbDescriptif{13};"^p";<>ZCR)
			[DiaMotifSaisieDGAL:42]InformationChasseurs:15:=DiaLavePlusBlanc ($Information)
			SAVE RECORD:C53([DiaMotifSaisieDGAL:42])
			  //Fin de si
			
			  // MAJ de [Lesions]
			QUERY:C277([DiaLesions:44];[DiaLesions:44]NomLesion:1=$TbDescriptif{2})
			  // $LesionDescriptionGibier:=OB Lire([Lesions]ObjetLesion;"DescriptionGibier";Est un texte)
			  //Si ($LesionDescriptionGibier="")
			$Description:=Replace string:C233($TbDescriptif{13};"^p";<>ZCR)
			OB SET:C1220([DiaLesions:44]ObjetLesion:19;"DescriptionGibier";DiaLavePlusBlanc ($Description))
			SAVE RECORD:C53([DiaLesions:44])
			  //Fin de si
		End if 
		
		RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
		
	End while 
	CLOSE DOCUMENT:C267($Doc)
	USE CHARACTER SET:C205(*;1)
	ZAmnistieInternationale 
	If (False:C215)
		  // les données du fichier texte
		  // 1 N°
		  // 2 Nom de la lésion
		  // 3 Motifs de saisie
		  // 4 Description-type de la lésion
		  // 5 Description de la lésion gibier
		  // 6 Motivation de la saisie
		  // 7 Étiologie lésion
		  // 8 Fiche réflexe photo
		  // 9 Fiche réflexe lésion
		  // 10 NPC photo
		  // 11 NPC lésion
		  // 12 Communication Boucherie
		  // 13 Communication Gibier
		  // 14 Précisions Boucherie
		  // 15 Précisions Gibier
	End if 
End if 
