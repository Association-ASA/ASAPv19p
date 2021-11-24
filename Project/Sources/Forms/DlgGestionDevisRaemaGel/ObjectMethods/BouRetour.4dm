If (TbDevisOK=0)
	ALERT:C41("Merci de sélectionner le devis à dévalider...")
Else 
	$NumLaboN:=TbDevisOK{TbDevisOK}
	$NumLaboA:=String:C10($NumLaboN)
	
	$Message:="ATTENTION : "+<>ZCR+"Vous êtes sur le point de dévalider le devis du laboratoire n°"+$NumLaboA+"."+<>ZCR
	$Message:=$Message+"Cela signifie qu'il reviendra dans la colonne de gauche et que tout le programme RAEMA Gel de "+<>AnCourantDevisRGA
	$Message:=$Message+" sera effacé de sa fiche."+<>ZCR2+" Cliquez sur OK pour décider si telle est bien votre volonté"
	ALERT:C41($Message)
	CONFIRM:C162("Dévalider le devis RAEMA gel pour le labo "+$NumLaboA+" ???")
	If (OK=1)
		//$L1:=Chercher dans tableau(TbDevisOK;$NumLaboN)
		//SUPPRIMER DANS TABLEAU(TbDevisOK;$L1)
		$L:=Find in array:C230(<>TbPerNumLaboRAEMAA; $NumLaboA)
		$UUIDLabo:=<>TbPerUUID{$L}
		READ WRITE:C146([XData:1])
		GOTO RECORD:C242([XData:1]; TbNumEnrOK{TbDevisOK})
		[XData:1]XBool:14:=False:C215
		SAVE RECORD:C53([XData:1])
		ZAmnistiePartielle(->[XData:1]; True:C214)
		
		READ WRITE:C146([CampagneParticipations:17])
		QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=<>CampagneDevisRGMai; *)
		QUERY:C277([CampagneParticipations:17];  | [CampagneParticipations:17]NumCampagne:3=<>CampagneDevisRGDec; *)
		QUERY:C277([CampagneParticipations:17];  & [CampagneParticipations:17]UUIDPersonne:2=$UUIDLabo)
		READ WRITE:C146([CampagneGelGermes:25])
		RELATE MANY SELECTION:C340([CampagneGelGermes:25]UUIDParticipation:2)
		DELETE SELECTION:C66([CampagneGelGermes:25])
		DELETE SELECTION:C66([CampagneParticipations:17])
		
		READ WRITE:C146([PersonnesDevis:30])
		QUERY:C277([PersonnesDevis:30]; [PersonnesDevis:30]UUIDPersonne:6=$UUIDLabo)
		$FT:=Records in selection:C76([PersonnesDevis:30])
		For ($Salé; 1; $FT)
			[PersonnesDevis:30]Valide:8:=False:C215
			SAVE RECORD:C53([PersonnesDevis:30])
			NEXT RECORD:C51([PersonnesDevis:30])
		End for 
		
		ZAmnistiePartielle(->[CampagneGelGermes:25])
		ZAmnistiePartielle(->[CampagneParticipations:17])
		GA15FabriqueTbDevisRAEMAGel
	End if 
End if 