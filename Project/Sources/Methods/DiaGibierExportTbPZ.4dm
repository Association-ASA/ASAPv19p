//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 09/03/19, 19:50:43
  // ----------------------------------------------------
  // Méthode : AdGibierExportTbPZ
  // Description
  // Méthode qui exporte les tableaux
  //  des photos retenues pour comparer les 
  //  les informations des deux peirre avec AsaDia
  // ----------------------------------------------------

C_LONGINT:C283($Pos;$Salé;$FT)

USE CHARACTER SET:C205("macintosh";1)
$Doc:=Open document:C264("";Mode lecture:K24:5)
RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
If ($Ligne#"Ref@")
	ALERT:C41("Désolé, le fichier désigné n'est pas le bon...")
Else 
	  // les données du fichier texte
	ARRAY TEXT:C222($TbRef;0)
	ARRAY TEXT:C222($TbLien;0)
	ARRAY TEXT:C222($TbEspèce;0)
	ARRAY TEXT:C222($TbOrgane;0)
	ARRAY TEXT:C222($TbDescriptionPhoto;0)
	ARRAY TEXT:C222($TbNomLésion;0)
	ARRAY TEXT:C222($TbDescriptionLésion;0)
	ARRAY TEXT:C222($TbNPCLésion;0)
	ARRAY TEXT:C222($TbFicheRéflexeLésion;0)
	ARRAY TEXT:C222($TbEtiologieLésion;0)
	ARRAY TEXT:C222($TbFicheRéflexePhoto;0)
	ARRAY TEXT:C222($TbNPCPhoto;0)
	ARRAY TEXT:C222($TbEtiologiePhoto;0)
	ARRAY TEXT:C222($TbDécision;0)
	
	RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
	While ($Ligne#"")
		$Ligne:=Replace string:C233($Ligne;Char:C90(10);"")
		$Pos:=Position:C15(<>ZTab;$Ligne)
		$Ref:=Substring:C12($Ligne;1;4)
		$ligne:=Substring:C12($Ligne;($Pos+1))
		
		$Pos:=Position:C15(<>ZTab;$Ligne)
		$Lien:=Substring:C12($Ligne;1;($Pos-1))
		$ligne:=Substring:C12($Ligne;($Pos+1))
		
		If ($Lien#"")
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$Espèce:=Substring:C12($Ligne;1;($Pos-1))
			$ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$Organe:=Substring:C12($Ligne;1;($Pos-1))
			$ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$DescriptionPhoto:=Substring:C12($Ligne;1;($Pos-1))
			$ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$NomLésion:=Substring:C12($Ligne;1;($Pos-1))
			$ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$Étiologie:=Substring:C12($Ligne;1;($Pos-1))
			$ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$FicheRéflexePhoto:=Substring:C12($Ligne;1;($Pos-1))
			$ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$NPCPhoto:=Substring:C12($Ligne;1;($Pos-1))
			$ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15(<>ZTab;$Ligne)
			$Décision:=Substring:C12($Ligne;1;($Pos-1))
			
			QUERY:C277([DiaLesions:44];[DiaLesions:44]NomLesion:1=$NomLésion)
			If (Records in selection:C76([DiaLesions:44])=0)
				TRACE:C157
			Else 
				
				APPEND TO ARRAY:C911($TbRef;$Ref)
				APPEND TO ARRAY:C911($TbLien;$Lien)
				APPEND TO ARRAY:C911($TbEspèce;$Espèce)
				APPEND TO ARRAY:C911($TbOrgane;$Organe)
				APPEND TO ARRAY:C911($TbDescriptionPhoto;$DescriptionPhoto)
				APPEND TO ARRAY:C911($TbNomLésion;$NomLésion)
				APPEND TO ARRAY:C911($TbÉtiologiePhoto;$Étiologie)
				APPEND TO ARRAY:C911($TbFicheRéflexePhoto;$FicheRéflexePhoto)
				APPEND TO ARRAY:C911($TbNPCPhoto;$NPCPhoto)
				APPEND TO ARRAY:C911($TbDécision;$Décision)
				APPEND TO ARRAY:C911($TbDescriptionLésion;Replace string:C233([DiaLesions:44]DescriptionTypeMacro:4;<>ZCR;". "))
				APPEND TO ARRAY:C911($TbNPCLésion;Replace string:C233([DiaLesions:44]NPC:9;<>ZCR;". "))
				APPEND TO ARRAY:C911($TbFicheRéflexeLésion;Replace string:C233([DiaLesions:44]FicheReflexe:12;<>ZCR;". "))
				APPEND TO ARRAY:C911($TbEtiologieLésion;[DiaLesions:44]Etiologie:6)
			End if 
		End if 
		RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
	End while 
	
	$Rapport:="Ref"+<>ZTab+"Lien"+<>ZTab+"Espèce"+<>ZTab+"Organe"+<>ZTab+"Description anatomo-pathologique photo"+<>ZTab
	$Rapport:=$Rapport+"Nom de la lésion"+<>ZTab+"Description-type de la lésion"+<>ZTab+"Étiologie photo"+<>ZTab+"Étiologie lésion"
	$Rapport:=$Rapport+<>ZTab+"Fiche réflexe photo"+<>ZTab+"Fiche réflexe lésion"+<>ZTab+"NPC photo"+<>ZTab+"NPC lésion"+<>ZTab
	$Rapport:=$Rapport+"Décision"+<>ZCR
	
	$FT:=Size of array:C274($TbRef)
	For ($Salé;1;$FT)
		$Rapport:=$Rapport+$TbRef{$Salé}+<>ZTab+$TbLien{$Salé}+<>ZTab+$TbEspèce{$Salé}+<>ZTab+$TbOrgane{$Salé}+<>ZTab+$TbDescriptionPhoto{$Salé}+<>ZTab
		$Rapport:=$Rapport+$TbNomLésion{$Salé}+<>ZTab+$TbDescriptionLésion{$Salé}+<>ZTab+$TbEtiologiePhoto{$Salé}+<>ZTab+$TbEtiologieLésion{$Salé}+<>ZTab
		$Rapport:=$Rapport+$TbFicheRéflexePhoto{$Salé}+<>ZTab+$TbFicheRéflexeLésion{$Salé}+<>ZTab+$TbNPCPhoto{$Salé}+<>ZTab+$TbNPCLésion{$Salé}+<>ZTab
		$Rapport:=$Rapport+$TbDécision{$Salé}+<>ZCR
	End for 
	  // FIXER TEXTE DANS CONTENEUR($Rapport)
End if 

USE CHARACTER SET:C205(*;1)