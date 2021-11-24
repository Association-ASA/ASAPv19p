//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 25/03/21, 15:52:32
  // ----------------------------------------------------
  // Méthode : ASAPExportRAEMAGel
  // Description
  // Permet d'obtenir l'export des germes du RAEMA Gel
  //
  // Paramètres
  // $1 = Mois du RAEMA Gel
  // ----------------------------------------------------
$NumCampagne:=PUMNumCampagneSuivi{PUMNumCampagneSuivi}
If ($NumCampagne="@A")
	$TT:=Size of array:C274(TbNumLaboA)
	$Export:="Données du RAEMA Gel pour l'année "+String:C10(Year of:C25(Current date:C33))+" extraites le "+String:C10(Current date:C33)+<>ZCR
	For ($Salé;1;$TT)
		$UUIDLabo:=ASAPTrouveUUIDLaboParNumero (Num:C11(TbNumLaboA{$Salé}))
		$L:=Find in array:C230(<>TBPERUUID;$UUIDLabo)
		$Association:=(Num:C11(<>TbPAAssociation{$L}="ADILVA@")*"1")+(Num:C11(<>TbPAAssociation{$L}="ADILVA@")*"")
		$IdentifiantPart:=TbNumLaboA{$Salé}+"_"+$NumCampagne+"_"
		If (Length:C16($IdentifiantPart)>9)
			$pos:=Position:C15("-";$IdentifiantPart)
			$LaboLié:=Substring:C12($IdentifiantPart;1;($pos-1))
			$CodeLabo:=<>TbLotoCodeRaemaLié{$L}
			$IdentifiantPart:=$LaboLié+"_"+$NumCampagne+"_"+$CodeLabo
		End if 
		$L2:=Find in array:C230(<>TbLotoIdentifiantParticipation;$IdentifiantPart)
		  //$Test:=(Num(<>TbLotoBacillusNCGSR{$L2}>0)*<>TbLotoBacillusNCGSR{$L2})+(Num(<>TbLotoBacillusNCGSR{$L2}>0)*""))
		  //$Test2:=(Num(<>TbLotoBacillusNCGSR{$L2}>0)*Chaîne(<>TbLotoBacillusNCGSR{$L2}))+(Num(<>TbLotoBacillusNCGSR{$L2}>0)*"")
		$Export:=$Export+String:C10($Association)+<>ZTAB+TbNumLaboA{$Salé}+<>ZTAB+<>TbPerNomLong{$L}+<>ZTAB+<>TbPerAdrLivAd1{$L}+<>TbPerAdrLivAd2{$L}+<>TbPerAdrLivAd3{$L}+<>TbPerAdrLivAd4{$L}+<>ZTAB
		$Export:=$Export+<>TbPerAdrLivCP{$L}+<>ZTAB+<>TbPerAdrLivVille{$L}+<>ZTAB+<>TbPerAdrLivPays{$L}+<>ZTAB
		$Export:=$Export+(Num:C11(<>TbLotoBacillus{$L2}="X")*"1")+(Num:C11(<>TbLotoBacillus{$L2}="X")*"")+<>ZTAB
		$Export:=$Export+(Num:C11(<>TbLotoBacillusNCGSR{$L2}>0)*String:C10(<>TbLotoBacillusNCGSR{$L2}))+(Num:C11(<>TbLotoBacillusNCGSR{$L2}>0)*"")+<>ZTAB
		$Export:=$Export+(Num:C11(<>TbLotoBacillusNCGAR{$L2}>0)*String:C10(<>TbLotoBacillusNCGAR{$L2}))+(Num:C11(<>TbLotoBacillusNCGAR{$L2}>0)*"")+<>ZTAB
		$Export:=$Export+(Num:C11(<>TbLotoPseudo{$L2}="X")*"1")+(Num:C11(<>TbLotoPseudo{$L2}="X")*"")+<>ZTAB
		$Export:=$Export+(Num:C11(<>TbLotoPseudoNCGSR{$L2}>0)*String:C10(<>TbLotoPseudoNCGSR{$L2}))+(Num:C11(<>TbLotoPseudoNCGSR{$L2}>0)*"")+<>ZTAB
		$Export:=$Export+(Num:C11(<>TbLotoPseudoNCGAR{$L2}>0)*String:C10(<>TbLotoPseudoNCGAR{$L2}))+(Num:C11(<>TbLotoPseudoNCGAR{$L2}>0)*"")+<>ZTAB
		$Export:=$Export+(Num:C11(<>TbLotoLactiques{$L2}="X")*"1")+(Num:C11(<>TbLotoLactiques{$L2}="X")*"")+<>ZTAB
		$Export:=$Export+(Num:C11(<>TbLotoLactiquesNCGSR{$L2}>0)*String:C10(<>TbLotoLactiquesNCGSR{$L2}))+(Num:C11(<>TbLotoLactiquesNCGSR{$L2}>0)*"")+<>ZTAB
		$Export:=$Export+(Num:C11(<>TbLotoLactiquesNCGAR{$L2}>0)*String:C10(<>TbLotoLactiquesNCGAR{$L2}))+(Num:C11(<>TbLotoLactiquesNCGAR{$L2}>0)*"")+<>ZTAB
		$Export:=$Export+(Num:C11(<>TbLotoLevMoisEns{$L2}="X")*"1")+(Num:C11(<>TbLotoLevMoisEns{$L2}="X")*"")+<>ZTAB
		$Export:=$Export+(Num:C11(<>TbLotoLevMoisEnsNCGSR{$L2}>0)*String:C10(<>TbLotoLevMoisEnsNCGSR{$L2}))+(Num:C11(<>TbLotoLevMoisEnsNCGSR{$L2}>0)*"")+<>ZTAB
		$Export:=$Export+(Num:C11(<>TbLotoLevMoisEnsNCGAR{$L2}>0)*String:C10(<>TbLotoLevMoisEnsNCGAR{$L2}))+(Num:C11(<>TbLotoLevMoisEnsNCGAR{$L2}>0)*"")+<>ZTAB
		$Export:=$Export+(Num:C11(<>TbLotoLevMoisSep{$L2}="X")*"1")+(Num:C11(<>TbLotoLevMoisSep{$L2}="X")*"")+<>ZTAB
		$Export:=$Export+(Num:C11(<>TbLotoLevMoisSepNCGSR{$L2}>0)*String:C10(<>TbLotoLevMoisSepNCGSR{$L2}))+(Num:C11(<>TbLotoLevMoisSepNCGSR{$L2}>0)*"")+<>ZTAB
		$Export:=$Export+(Num:C11(<>TbLotoLevMoisSepNCGAR{$L2}>0)*String:C10(<>TbLotoLevMoisSepNCGAR{$L2}))+(Num:C11(<>TbLotoLevMoisSepNCGAR{$L2}>0)*"")+<>ZCR
	End for 
	SET TEXT TO PASTEBOARD:C523($Export)
	ALERT:C41("L'export des données du RAEMA Gel de la campagne "+$NumCampagne+" a été ajouté à votre press papier.")
Else 
	ALERT:C41("Merci de sélectionner une campagne RAEMA Gel")
End if 
