C_OBJECT:C1216($status; $email)

$Menu:="Mail confirmation colis supp;Mail confirmation boîtes iso"
$VarChoixUtilisateur:=Pop up menu:C542($Menu)


Case of 
	: $VarChoixUtilisateur=1  // Envoi confirmation colis supp
		$Année:=Year of:C25(Current date:C33)
		$NumCampagneMars:=RaemaTrouveNumCampagneParAn($Année; 1)
		$NumCampagneOctobre:=RaemaTrouveNumCampagneParAn($Année; 3)
		
		QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1; *)
		QUERY:C277([CampagneParticipations:17];  & [CampagneParticipations:17]NumCampagne:3=$NumCampagneMars)
		$NumColisSuppARMars:=Num:C11(OB Get:C1224([CampagneParticipations:17]Arguments:5; "NbreColisSupAvecRapport"))
		$NumColisSuppSRMars:=Num:C11(OB Get:C1224([CampagneParticipations:17]Arguments:5; "NbreColisSupSansRapport"))
		
		QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1; *)
		QUERY:C277([CampagneParticipations:17];  & [CampagneParticipations:17]NumCampagne:3=$NumCampagneOctobre)
		$NumColisSuppAROctobre:=Num:C11(OB Get:C1224([CampagneParticipations:17]Arguments:5; "NbreColisSupAvecRapport"))
		$NumColisSuppSROctobre:=Num:C11(OB Get:C1224([CampagneParticipations:17]Arguments:5; "NbreColisSupSansRapport"))
		
		If ($NumColisSuppARMars+$NumColisSuppSRMars+$NumColisSuppAROctobre+$NumColisSuppSROctobre)>0
			$MailDevis:=""
			$MailDevis:=$MailDevis+"Cher laboratoire,"+<>ZCR2+"Nous accusons réception de votre bon de commande de colis supplémentaire pour l'année "+String:C10($Année)+" et vous en remercions :"+<>ZCR
			If ($NumColisSuppARMars>0)
				$S:=""
				$S:=Num:C11($NumColisSuppARMars>1)*"s"
				$MailDevis:=$MailDevis+"- "+String:C10($NumColisSuppARMars)+" colis supplémentaire"+$S+" avec édition de rapport pour la campagne "+$NumCampagneMars+" du mois de Mars."+<>ZCR
			End if 
			If ($NumColisSuppAROctobre>0)
				$S:=""
				$S:=Num:C11($NumColisSuppAROctobre>1)*"s"
				$MailDevis:=$MailDevis+"- "+String:C10($NumColisSuppAROctobre)+" colis supplémentaire"+$S+" avec édition de rapport pour la campagne "+$NumCampagneOctobre+" du mois de Octobre."+<>ZCR
			End if 
			If ($NumColisSuppSRMars>0)
				$S:=""
				$S:=Num:C11($NumColisSuppSRMars>1)*"s"
				$MailDevis:=$MailDevis+"- "+String:C10($NumColisSuppSRMars)+" colis supplémentaire"+$S+" sans édition de rapport pour la campagne "+$NumCampagneMars+" du mois de Mars."+<>ZCR
			End if 
			If ($NumColisSuppSROctobre>0)
				$S:=""
				$S:=Num:C11($NumColisSuppSROctobre>1)*"s"
				$MailDevis:=$MailDevis+"- "+String:C10($NumColisSuppSROctobre)+" colis supplémentaire"+$S+" sans édition de rapport pour la campagne "+$NumCampagneOctobre+" du mois de Octobre."+<>ZCR
			End if 
			$MailDevis:=$MailDevis+<>ZCR+"Restant à votre disposition."+<>ZCR+"Cordialement,"+<>ZCR2+"L'équipe de l'ASA"
			
			$AdEmail:=OB Get:C1224([Personnes:12]Arguments:7; "EMail"; Est un texte:K8:3)
			$AdEmails:=Request:C163("Le mail va être envoyé à "+$AdEmail+". Ajouter des destinataires ou laisser cette case vide. Séparer les adresses par une virgule. Si vous annulez, le texte sera copié dans le press papier.")
			If (OK=1)
				$Sujet:="Confirmation de commande de colis supplémentaires"
				$email:=New object:C1471
				$transporter:=ASAPCreationtransporter
				$email.from:="asa-spv@wanadoo.fr"
				$email.subject:=$Sujet
				$email.to:="asa-spv@wanadoo.fr,"+$AdEmail+","+$AdEmails
				//$email.to:="riouall.eloise@orange.fr"
				$email.textBody:=$MailDevis
				$status:=$transporter.send($email)  // Envoi du message
				MailOK:=($status.success)
				
			Else 
				SET TEXT TO PASTEBOARD:C523($MailDevis)
			End if 
			
		Else 
			ALERT:C41("Le Laboratoire sélectionné n'a pas commandé de colis supplémentaires")
		End if 
		
	: $VarChoixUtilisateur=2  // Envoi confirmation boîtes isothermes
		
		$Année:=Year of:C25(Current date:C33)
		$NumCampagneMars:=RaemaTrouveNumCampagneParAn($Année; 1)
		$NumCampagneOctobre:=RaemaTrouveNumCampagneParAn($Année; 3)
		
		QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1; *)
		QUERY:C277([CampagneParticipations:17];  & [CampagneParticipations:17]NumCampagne:3=$NumCampagneMars)
		$BoiteIsoMars:=Num:C11(OB Get:C1224([CampagneParticipations:17]Arguments:5; "BoîteIsotherme"))
		
		QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1; *)
		QUERY:C277([CampagneParticipations:17];  & [CampagneParticipations:17]NumCampagne:3=$NumCampagneOctobre)
		$BoiteIsoOctobre:=Num:C11(OB Get:C1224([CampagneParticipations:17]Arguments:5; "BoîteIsotherme"))
		
		If ($BoiteIsoMars+$BoiteIsoOctobre)>0
			$MailDevis:=""
			$MailDevis:=$MailDevis+"Cher laboratoire,"+<>ZCR2+"Nous accusons réception de votre bon de commande de boîte isotherme pour l'année "+String:C10($Année)+" et vous en remercions :"+<>ZCR
			If ($BoiteIsoMars>0)
				$S:=""
				$S:=Num:C11($BoiteIsoMars>1)*"s"
				$MailDevis:=$MailDevis+"- "+String:C10($BoiteIsoMars)+" boîte"+$S+" isotherme"+$S+" pour la campagne "+$NumCampagneMars+" du mois de Mars."+<>ZCR
			End if 
			If ($BoiteIsoOctobre>0)
				$S:=""
				$S:=Num:C11($BoiteIsoOctobre>1)*"s"
				$MailDevis:=$MailDevis+"- "+String:C10($BoiteIsoOctobre)+" boîte"+$S+" isotherme"+$S+" pour la campagne "+$NumCampagneOctobre+" du mois de Octobre."+<>ZCR
			End if 
			
			$MailDevis:=$MailDevis+<>ZCR+"Restant à votre disposition."+<>ZCR+"Cordialement,"+<>ZCR2+"L'équipe de l'ASA"
			
			$AdEmail:=OB Get:C1224([Personnes:12]Arguments:7; "EMail"; Est un texte:K8:3)
			$AdEmails:=Request:C163("Le mail va être envoyé à "+$AdEmail+". Ajouter des destinataires ou laisser cette case vide. Séparer les adresses par une virgule. Si vous annulez, le texte sera copié dans le press papier.")
			If (OK=1)
				$Sujet:="Confirmation de commande de colis supplémentaires"
				$email:=New object:C1471
				$transporter:=ASAPCreationtransporter
				$email.from:="asa-spv@wanadoo.fr"
				$email.subject:=$Sujet
				$email.to:="asa-spv@wanadoo.fr,"+$AdEmail+","+$AdEmails
				//$email.to:="riouall.eloise@orange.fr"
				$email.textBody:=$MailDevis
				$status:=$transporter.send($email)  // Envoi du message
				MailOK:=($status.success)
				
			Else 
				SET TEXT TO PASTEBOARD:C523($MailDevis)
			End if 
			
		Else 
			ALERT:C41("Le Laboratoire sélectionné n'a pas commandé de colis supplémentaires")
		End if 
		
End case 
