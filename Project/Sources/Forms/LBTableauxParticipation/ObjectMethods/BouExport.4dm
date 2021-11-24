$Menu:="Export Chrono ASA;Export Chrono ADILVA;Export Chrono Etranger;Export DHL"
$VarChoixUtilisateur:=Pop up menu:C542($Menu)

ARRAY TEXT:C222($TbLaboASA;0)
ARRAY TEXT:C222($TbUUIDPersonne;0)
If (PUMNumCampagneSuivi{PUMNumCampagneSuivi}="@A")
	$RAEMAGel:=True:C214
	$RAEMAPoudre:=False:C215
Else 
	$RAEMAGel:=False:C215
	$RAEMAPoudre:=True:C214
End if 

Case of 
	: $VarChoixUtilisateur=1  // Export Chrono ASA
		QUERY:C277([Personnes:12];[CampagneParticipations:17]NumCampagne:3=PUMNumCampagneSuivi{PUMNumCampagneSuivi};*)
		QUERY BY ATTRIBUTE:C1331([Personnes:12]; & ;[Personnes:12]Arguments:7;"Association";#;"Adilva@";*)  // Pas l'ADILVA
		QUERY BY ATTRIBUTE:C1331([Personnes:12]; & ;[CampagneParticipations:17]Arguments:5;"Transporteur";=;"Chronopost@";*)
		QUERY:C277([Personnes:12]; & [PersonnesAdresses:11]Pays:8="France")
		SELECTION TO ARRAY:C260([Personnes:12]UUID:1;$TbUUIDPersonne)
		$TT:=Size of array:C274($TbUUIDPersonne)
		$Rapport:=""
		For ($Salé;1;$TT)
			$NumLabo:=ASAPTrouveNumeroLaboParUUID ($TbUUIDPersonne{$Salé})
			$IdentifiantParticip:=$NumLabo+"_"+PUMNumCampagneSuivi{PUMNumCampagneSuivi}+"_"
			$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$IdentifiantParticip)
			$BoiteIso:=<>TbLotoBoiteIsotherme{$L}*"BI"
			If (<>TbLotoTransporteur{$L}="Chronopost10")
				$CodeChrono:="2"
			Else 
				$CodeChrono:="1S"
			End if 
			If ($RAEMAPoudre)
				If (<>TbLotoNbColisPoudreSR{$L}>0) | (<>TbLotoNbColisPoudreAR{$L}>0)
					$ColisCS:="CS"
				Else 
					$ColisCS:=""
				End if 
				
				  //Si (<>TbLotoNbColisPoudreSR{$L}>1) | (<>TbLotoNbColisPoudreAR{$L}>1)
				  //$ColisCS:="CSCS"
				  //Sinon 
				  //$ColisCS:=""
				  //Fin de si 
				
				If (<>TbLotoSansPathogene{$L}=True:C214)
					$SansPatho:="SP"
				Else 
					$SansPatho:=""
				End if 
				
				
			End if 
			If ($RAEMAGel)
				$NbrPotsColisP:=Num:C11(<>TbLotoBacillus{$L}="X")+Num:C11(<>TbLotoPseudo{$L}="X")+Num:C11(<>TbLotoLactiques{$L}="X")+Num:C11(<>TbLotoLevMoisEns{$L}="X")+Num:C11(<>TbLotoLevMoisSep{$L}="X")
				Case of 
					: (($NbrPotsColisP+<>TbLotoBacillusNCGSR{$L}+<>TbLotoPseudoNCGSR{$L}+<>TbLotoLactiquesNCGSR{$L}+<>TbLotoLevMoisEnsNCGSR{$L}+<>TbLotoLevMoisSepNCGSR{$L})>7)
						$ColisCS:="CS"
						
					: ((<>TbLotoBacillusNCGAR{$L}+<>TbLotoPseudoNCGAR{$L}+<>TbLotoLactiquesNCGAR{$L}+<>TbLotoLevMoisEnsNCGAR{$L}+<>TbLotoLevMoisSepNCGAR{$L})>0)
						$ColisCS:="CS"
						
					Else 
						$ColisCS:=""
				End case 
				$SansPatho:=""
			End if 
			
			$CodeClientDestinataire:="ASA"+$BoiteIso+$ColisCS+$SansPatho+String:C10($Salé)
			$PoidsColis:=1
			If ($BoiteIso="BI@")
				$PoidsColis:=8
			End if 
			
			If ($ColisCS="CS")
				$PoidsColis:=3
			End if 
			
			  //Si ($ColisCS="CSCS")
			  //$PoidsColis:=5
			  //Fin de si 
			
			$L2:=Find in array:C230(<>TbPerUUID;$TbUUIDPersonne{$Salé})
			$Pays:=<>TbPerAdrLivPays{$L2}
			$L4:=Find in array:C230(<>TbNomPays;$Pays)
			If ($L4>0)
				$VarCodepays:=<>TbCodeIsoASA{$L4}
			Else 
				$VarCodepays:=""
			End if 
			
			
			$Rapport:=$Rapport+$CodeClientDestinataire+<>ZTAB+<>TbPerAdrLivAd1{$L2}+<>ZTAB+<>ZTAB+<>TbPerAdrLivAd2{$L2}+<>ZTAB+<>TbPerAdrLivAd3{$L2}+<>ZTAB+<>TbPerAdrLivCP{$L2}+<>ZTAB+<>TbPerAdrLivVille{$L2}+<>ZTAB+("0"+<>TbPAPhonePro{$L2})+<>ZTAB+<>TbPAEmailLivraison{$L2}+<>ZTAB+<>TbPANomContact{$L2}+<>ZTAB+<>ZTAB+$VarCodepays+<>ZTAB+<>ZTAB+<>ZTAB+<>ZTAB+String:C10($PoidsColis)+<>ZTAB+"1"+<>ZTAB+$CodeChrono+<>ZCR
			
			
		End for 
		SET TEXT TO PASTEBOARD:C523($Rapport)
		ALERT:C41("L'export a été copié dans votre presse papier. Il ne vous reste plus qu'à le coller dans le fichier Chronospost")
		
	: $VarChoixUtilisateur=2  // Export Chrono ADILVA
		QUERY:C277([Personnes:12];[CampagneParticipations:17]NumCampagne:3=PUMNumCampagneSuivi{PUMNumCampagneSuivi};*)
		QUERY BY ATTRIBUTE:C1331([Personnes:12]; & ;[Personnes:12]Arguments:7;"Association";=;"Adilva@";*)  // l'ADILVA
		QUERY BY ATTRIBUTE:C1331([Personnes:12]; & ;[CampagneParticipations:17]Arguments:5;"Transporteur";=;"Chronopost@";*)
		QUERY:C277([Personnes:12]; & [PersonnesAdresses:11]Pays:8="France")
		
		SELECTION TO ARRAY:C260([Personnes:12]UUID:1;$TbUUIDPersonne)
		$TT:=Size of array:C274($TbUUIDPersonne)
		$Rapport:=""
		For ($Salé;1;$TT)
			$NumLabo:=ASAPTrouveNumeroLaboParUUID ($TbUUIDPersonne{$Salé})
			$IdentifiantParticip:=$NumLabo+"_"+PUMNumCampagneSuivi{PUMNumCampagneSuivi}+"_"
			$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$IdentifiantParticip)
			$BoiteIso:=<>TbLotoBoiteIsotherme{$L}*"BI"
			If (<>TbLotoTransporteur{$L}="Chronopost10")
				$CodeChrono:="2"
			Else 
				$CodeChrono:="1S"
			End if 
			
			If ($RAEMAPoudre)
				If (<>TbLotoNbColisPoudreSR{$L}>0) | (<>TbLotoNbColisPoudreAR{$L}>0)
					$ColisCS:="CS"
				Else 
					$ColisCS:=""
				End if 
				  //Si (<>TbLotoNbColisPoudreSR{$L}>1) | (<>TbLotoNbColisPoudreAR{$L}>1)
				  //$ColisCS:="CSCS"
				  //Sinon 
				  //$ColisCS:=""
				  //Fin de si 
			End if 
			
			If ($RAEMAGel)
				Case of 
					: ((<>TbLotoBacillusNCGSR{$L}+<>TbLotoPseudoNCGSR{$L}+<>TbLotoLactiquesNCGSR{$L}+<>TbLotoLevMoisEnsNCGSR{$L}+<>TbLotoLevMoisSepNCGSR{$L})>7)
						$ColisCS:="CS"
						
					: ((<>TbLotoBacillusNCGAR{$L}+<>TbLotoPseudoNCGAR{$L}+<>TbLotoLactiquesNCGAR{$L}+<>TbLotoLevMoisEnsNCGAR{$L}+<>TbLotoLevMoisSepNCGAR{$L})>0)
						$ColisCS:="CS"
						
					Else 
						$ColisCS:=""
				End case 
			End if 
			
			$CodeClientDestinataire:="ADIL"+$BoiteIso+$ColisCS+String:C10($Salé)
			$PoidsColis:=1
			Case of 
				: ($ColisCS="CS") & ($BoiteIso="BI@")
					$PoidsColis:=10
					
				: ($BoiteIso="BI@")
					$PoidsColis:=8
					
					  //: ($ColisCS="CSCS")
					  //$PoidsColis:=5
					
				: ($ColisCS="CS")
					$PoidsColis:=3
			End case 
			
			$L2:=Find in array:C230(<>TbPerUUID;$TbUUIDPersonne{$Salé})
			$Pays:=<>TbPerAdrLivPays{$L2}
			$L4:=Find in array:C230(<>TbNomPays;$Pays)
			If ($L4>0)
				$VarCodepays:=<>TbCodeIsoASA{$L4}
			Else 
				$VarCodepays:=""
			End if 
			$Rapport:=$Rapport+$CodeClientDestinataire+<>ZTAB+<>TbPerAdrLivAd1{$L2}+<>ZTAB+<>ZTAB+<>TbPerAdrLivAd2{$L2}+<>ZTAB+<>TbPerAdrLivAd3{$L2}+<>ZTAB+<>TbPerAdrLivCP{$L2}+<>ZTAB+<>TbPerAdrLivVille{$L2}+<>ZTAB+("0"+<>TbPAPhonePro{$L2})+<>ZTAB+<>TbPAEmailLivraison{$L2}+<>ZTAB+<>TbPANomContact{$L2}+<>ZTAB+<>ZTAB+$VarCodepays+<>ZTAB+<>ZTAB+<>ZTAB+<>ZTAB+String:C10($PoidsColis)+<>ZTAB+"1"+<>ZTAB+$CodeChrono+<>ZCR
			
			
		End for 
		$L3:=Find in array:C230(<>TbPerUUID;"894F58BDDADB445C9B4723EBF222A4B2")
		$Rapport:=$Rapport+"ADIL"+String:C10($TT+1)+<>ZTAB+<>TbPerNomLong{$L3}+<>ZTAB+<>ZTAB+<>TbPerAdrLivAd2{$L3}+<>ZTAB+<>TbPerAdrLivAd3{$L3}+<>ZTAB+<>TbPerAdrLivCP{$L3}+<>ZTAB+<>TbPerAdrLivVille{$L3}+<>ZTAB+("0"+<>TbPAPhonePro{$L3})+<>ZTAB+<>TbPAEmailLivraison{$L3}+<>ZTAB+<>TbPANomContact{$L3}+<>ZTAB+<>ZTAB+"FR"+<>ZTAB+<>ZTAB+<>ZTAB+<>ZTAB+"13"+<>ZTAB+"1"+<>ZTAB+"1S"+<>ZCR
		
		SET TEXT TO PASTEBOARD:C523($Rapport)
		ALERT:C41("L'export a été copié dans votre presse papier. Il ne vous reste plus qu'à le coller dans le fichier Chronospost. Un colis pour l'homogénéité (Inovalys) a été ajouté à l'export")
		
		
	: $VarChoixUtilisateur=3  // Export Chrono Etranger
		
		QUERY:C277([Personnes:12];[CampagneParticipations:17]NumCampagne:3=PUMNumCampagneSuivi{PUMNumCampagneSuivi};*)
		  //CHERCHER PAR ATTRIBUT([Personnes]; & ;[Personnes]Arguments;"Association";#;"Adilva";*)  // Pas l'ADILVA
		QUERY BY ATTRIBUTE:C1331([Personnes:12]; & ;[CampagneParticipations:17]Arguments:5;"Transporteur";=;"Chronopost@";*)
		QUERY:C277([Personnes:12]; & [PersonnesAdresses:11]Pays:8#"";*)
		QUERY:C277([Personnes:12]; & [PersonnesAdresses:11]Pays:8#"FRANCE")
		SELECTION TO ARRAY:C260([Personnes:12]UUID:1;$TbUUIDPersonne)
		$TT:=Size of array:C274($TbUUIDPersonne)
		$Rapport:=""
		For ($Salé;1;$TT)
			$NumLabo:=ASAPTrouveNumeroLaboParUUID ($TbUUIDPersonne{$Salé})
			$IdentifiantParticip:=$NumLabo+"_"+PUMNumCampagneSuivi{PUMNumCampagneSuivi}+"_"
			$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$IdentifiantParticip)
			$BoiteIso:=<>TbLotoBoiteIsotherme{$L}*"BI"
			If ($RAEMAPoudre)
				If (<>TbLotoNbColisPoudreSR{$L}>0) | (<>TbLotoNbColisPoudreAR{$L}>0)
					$ColisCS:="CS"
				Else 
					$ColisCS:=""
				End if 
				  //Si (<>TbLotoNbColisPoudreSR{$L}>1) | (<>TbLotoNbColisPoudreAR{$L}>1)
				  //$ColisCS:="CSCS"
				  //Sinon 
				  //$ColisCS:=""
				  //Fin de si 
			End if 
			
			If ($RAEMAGel)
				Case of 
					: ((<>TbLotoBacillusNCGSR{$L}+<>TbLotoPseudoNCGSR{$L}+<>TbLotoLactiquesNCGSR{$L}+<>TbLotoLevMoisEnsNCGSR{$L}+<>TbLotoLevMoisSepNCGSR{$L})>7)
						$ColisCS:="CS"
						
					: ((<>TbLotoBacillusNCGAR{$L}+<>TbLotoPseudoNCGAR{$L}+<>TbLotoLactiquesNCGAR{$L}+<>TbLotoLevMoisEnsNCGAR{$L}+<>TbLotoLevMoisSepNCGAR{$L})>0)
						$ColisCS:="CS"
						
					Else 
						$ColisCS:=""
				End case 
			End if 
			
			$CodeClientDestinataire:="ETR"+$BoiteIso+$ColisCS+String:C10($Salé)
			$PoidsColis:=1
			Case of 
				: ($ColisCS="CS") & ($BoiteIso="BI@")
					$PoidsColis:=10
					
				: ($BoiteIso="BI@")
					$PoidsColis:=8
					
					  //: ($ColisCS="CSCS")
					  //$PoidsColis:=5
					
				: ($ColisCS="CS")
					$PoidsColis:=3
			End case 
			
			$L2:=Find in array:C230(<>TbPerUUID;$TbUUIDPersonne{$Salé})
			$Pays:=<>TbPerAdrLivPays{$L2}
			$L4:=Find in array:C230(<>TbNomPays;$Pays)
			If ($L4>0)
				$VarCodepays:=<>TbCodeIsoASA{$L4}
			Else 
				$VarCodepays:=""
			End if 
			$Rapport:=$Rapport+$CodeClientDestinataire+<>ZTAB+<>TbPerAdrLivAd1{$L2}+<>ZTAB+<>ZTAB+<>TbPerAdrLivAd2{$L2}+<>ZTAB+<>TbPerAdrLivAd3{$L2}+<>ZTAB+<>TbPerAdrLivCP{$L2}+<>ZTAB+<>TbPerAdrLivVille{$L2}+<>ZTAB+("0"+<>TbPAPhonePro{$L2})+<>ZTAB+<>TbPAEmailLivraison{$L2}+<>ZTAB+<>TbPANomContact{$L2}+<>ZTAB+<>ZTAB+$VarCodepays+<>ZTAB+<>ZTAB+<>ZTAB+<>ZTAB+String:C10($PoidsColis)+<>ZTAB+"1"+<>ZTAB+"17"+<>ZCR
			
			
		End for 
		
		SET TEXT TO PASTEBOARD:C523($Rapport)
		ALERT:C41("L'export a été copié dans votre presse papier. Il ne vous reste plus qu'à le coller dans le fichier Chronospost")
		
	: $VarChoixUtilisateur=4  // Export DHL
		QUERY:C277([Personnes:12];[CampagneParticipations:17]NumCampagne:3=PUMNumCampagneSuivi{PUMNumCampagneSuivi};*)
		  // CHERCHER PAR ATTRIBUT([Personnes]; & ;[Personnes]Arguments;"Association";#;"Adilva";*)  // Pas l'ADILVA
		QUERY BY ATTRIBUTE:C1331([Personnes:12]; & ;[CampagneParticipations:17]Arguments:5;"Transporteur";=;"DHL@")
		SELECTION TO ARRAY:C260([Personnes:12]UUID:1;$TbUUIDPersonne)
		$TT:=Size of array:C274($TbUUIDPersonne)
		$Rapport:=""
		For ($Salé;1;$TT)
			$NumLabo:=ASAPTrouveNumeroLaboParUUID ($TbUUIDPersonne{$Salé})
			$IdentifiantParticip:=$NumLabo+"_"+PUMNumCampagneSuivi{PUMNumCampagneSuivi}+"_"
			$L:=Find in array:C230(<>TbLotoIdentifiantParticipation;$IdentifiantParticip)
			$BoiteIso:=<>TbLotoBoiteIsotherme{$L}*"BI"
			If ($RAEMAPoudre)
				If (<>TbLotoNbColisPoudreSR{$L}>0) | (<>TbLotoNbColisPoudreAR{$L}>0)
					$ColisCS:="CS"
				Else 
					$ColisCS:=""
				End if 
				  //Si (<>TbLotoNbColisPoudreSR{$L}>1) | (<>TbLotoNbColisPoudreAR{$L}>1)
				  //$ColisCS:="CSCS"
				  //Sinon 
				  //$ColisCS:=""
				  //Fin de si 
			End if 
			
			If ($RAEMAGel)
				Case of 
					: ((<>TbLotoBacillusNCGSR{$L}+<>TbLotoPseudoNCGSR{$L}+<>TbLotoLactiquesNCGSR{$L}+<>TbLotoLevMoisEnsNCGSR{$L}+<>TbLotoLevMoisSepNCGSR{$L})>7)
						$ColisCS:="CS"
						
					: ((<>TbLotoBacillusNCGAR{$L}+<>TbLotoPseudoNCGAR{$L}+<>TbLotoLactiquesNCGAR{$L}+<>TbLotoLevMoisEnsNCGAR{$L}+<>TbLotoLevMoisSepNCGAR{$L})>0)
						$ColisCS:="CS"
						
					Else 
						$ColisCS:=""
				End case 
				$SansPatho:=""
			End if 
			
			$CodeClientDestinataire:="ETR"+$BoiteIso+$ColisCS+String:C10($Salé)
			$PoidsColis:=1
			If ($RAEMAPoudre)
				Case of 
					: ($NumLabo="469")
						$PoidsColis:=6
						
					: ($NumLabo="32")
						$PoidsColis:=3
						
					: ($ColisCS="CS") & ($BoiteIso="BI@")
						$PoidsColis:=10
						
						  //: ($ColisCS="CSCS")
						  //$PoidsColis:=5
						
					: ($ColisCS="CS")
						$PoidsColis:=3
						
					: ($BoiteIso="BI@")
						$PoidsColis:=8
						
				End case 
			End if 
			
			If ($RAEMAGel)
				Case of 
					: ($ColisCS="CS") & ($BoiteIso="BI@")
						$PoidsColis:=10
						
					: ($ColisCS="CS")
						$PoidsColis:=3
						
					: ($BoiteIso="BI@")
						$PoidsColis:=8
						
				End case 
			End if 
			
			$L2:=Find in array:C230(<>TbPerUUID;$TbUUIDPersonne{$Salé})
			$Pays:=<>TbPerAdrLivPays{$L2}
			$CompteClient:="223836565"
			If ($Pays="France")
				$CodeProduit:="DOM"
			Else 
				$CodeProduit:="WPX"
				If ($Pays="Madag@")
					$CompteClient:="963511601"
				End if 
			End if 
			$L4:=Find in array:C230(<>TbNomPays;$Pays)
			If ($L4>0)
				$VarCodepays:=<>TbCodeIsoASA{$L4}
			Else 
				$VarCodepays:=""
			End if 
			  //$Rapport:=$Rapport+"Marchandises"+<>ZTAB+$CodeProduit+<>ZTAB+<>ZTAB+<>ZTAB+$CompteClient+<>ZTAB+"ECHANTILLONS POUR ANALYSES"+<>ZTAB+$CodeClientDestinataire+<>ZTAB+<>TbPerAdrLivAd1{$L2}+<>ZTAB+<>TbPANomContact{$L2}+<>ZTAB
			  //$Rapport:=$Rapport+<>TbPerAdrLivAd2{$L2}+<>ZTAB+<>TbPerAdrLivAd3{$L2}+<>ZTAB+<>TbPerAdrLivAd4{$L2}+<>ZTAB+<>TbPerAdrLivVille{$L2}+<>ZTAB+<>TbPerAdrLivCP{$L2}+<>ZTAB+$VarCodepays+<>ZTAB+("0"+<>TbPAPhonePro{$L2})+<>ZTAB+<>TbPAEmailLivraison{$L2}+<>ZTAB
			  //$Rapport:=$Rapport+"10"+<>ZTAB+"EUR"+<>ZTAB+"1"+<>ZTAB+Chaîne($PoidsColis)+<>ZTAB+<>ZTAB+"ECHANTILLONS POUR ANALYSES POUDRE DE LAIT"+<>ZTAB+"10"+<>ZTAB+"FR"+<>ZTAB+"PROFORMA"+<>ZCR
			
			$Rapport:=$Rapport+<>ZTAB+<>ZTAB+"P"+<>ZTAB+"10"+<>ZTAB+"EUR"+<>ZTAB+$CodeClientDestinataire+<>ZTAB+"ECHANTILLONS POUR ANALYSES"+<>ZTAB+<>ZTAB+<>TbPerAdrLivAd1{$L2}+<>ZTAB+<>TbPANomContact{$L2}+<>ZTAB
			$Rapport:=$Rapport+<>TbPerAdrLivAd2{$L2}+<>ZTAB+<>TbPerAdrLivAd3{$L2}+<>ZTAB+<>TbPerAdrLivAd4{$L2}+<>ZTAB+<>TbPerAdrLivCP{$L2}+<>ZTAB+<>TbPerAdrLivVille{$L2}+<>ZTAB+$VarCodepays+<>ZTAB+<>ZTAB+<>ZTAB+<>ZTAB+("0"+<>TbPAPhonePro{$L2})+<>ZTAB+<>TbPAEmailLivraison{$L2}+<>ZTAB
			$Rapport:=$Rapport+"1"+<>ZTAB+String:C10($PoidsColis)+<>ZTAB+<>ZTAB+<>ZTAB+<>ZTAB+"ECHANTILLONS POUR ANALYSES POUDRE DE LAIT"+<>ZTAB+"FR"+<>ZTAB+"10"+<>ZTAB+"EUR"+<>ZTAB+<>ZTAB+"PROFORMA"+<>ZTAB+<>ZTAB+<>ZTAB+"T"+<>ZTAB+<>ZTAB+<>ZTAB+$CompteClient+<>ZTAB+"ASA"+<>ZTAB
			$Rapport:=$Rapport+"ALI MANDJEE"+<>ZTAB+"7 Avenue du Général de Gaulle"+<>ZTAB+"Bâtiment Jean Girard"+<>ZTAB+"ENVA"+<>ZTAB+"94700"+<>ZTAB+"MAISONS-ALFORT"+<>ZTAB+"FR"+<>ZTAB+"0156293630"+<>ZTAB+"+33"+<>ZTAB+"asa-spv@wanadoo.fr"+<>ZTAB+<>ZTAB+<>ZTAB+<>ZTAB+<>ZTAB+<>ZTAB+<>ZCR
		End for 
		
		SET TEXT TO PASTEBOARD:C523($Rapport)
		ALERT:C41("L'export a été copié dans votre presse papier. Il ne vous reste plus qu'à le coller dans le fichier DHL")
		
		
End case 
