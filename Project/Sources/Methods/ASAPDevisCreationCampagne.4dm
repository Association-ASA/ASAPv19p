//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 15/07/19, 06:34:16
  // ----------------------------------------------------
  // Paramètres : $1 = N° de la campagne
  // ----------------------------------------------------
  // Méthode : ASAPDevisCreationCampagne
  // Description
  // // Méthode qui crée les éléments nécessaires à une campagne Gel

$NumCampagne:=$1
READ WRITE:C146([CampagneParticipations:17])
READ WRITE:C146([CampagneGelGermes:25])
QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]NumCampagne:3=$NumCampagne;*)
QUERY:C277([CampagneParticipations:17]; & [CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1)
RELATE MANY SELECTION:C340([CampagneGelGermes:25]UUIDParticipation:2)  // sélection des [CampagneGelGermes]
DELETE SELECTION:C66([CampagneGelGermes:25])
DELETE SELECTION:C66([CampagneParticipations:17])
  //Déduisons le mois du n°
$Mois:=(Num:C11(Num:C11($NumCampagne)%2=0)*"Mai")+(Num:C11(Num:C11($NumCampagne)%2=1)*"Dec")
$PtNomGerme:=Get pointer:C304("TbNomGerme"+$Mois)
$PtColisSupAvecRapport:=Get pointer:C304("TbPSAR"+$Mois)
$PtColisSupSansRapport:=Get pointer:C304("TbPSSR"+$Mois)

CREATE RECORD:C68([CampagneParticipations:17])
[CampagneParticipations:17]NumCampagne:3:=$NumCampagne
[CampagneParticipations:17]UUIDPersonne:2:=[Personnes:12]UUID:1
SAVE RECORD:C53([CampagneParticipations:17])

$Ft:=Size of array:C274($PtNomGerme->)
For ($Salé;1;$FT)
	CREATE RECORD:C68([CampagneGelGermes:25])
	[CampagneGelGermes:25]NomDuGerme:3:=$PtNomGerme->{$Salé}
	[CampagneGelGermes:25]NumCampagne:6:=$NumCampagne
	[CampagneGelGermes:25]UUIDParticipation:2:=[CampagneParticipations:17]UUID:1
	[CampagneGelGermes:25]NbreColisSupAvecRapport:5:=Num:C11($PtColisSupAvecRapport->{$Salé})
	[CampagneGelGermes:25]NbreColisSupSansRapport:4:=Num:C11($PtColisSupSansRapport->{$Salé})
	SAVE RECORD:C53([CampagneGelGermes:25])
	
	MailDevis:=MailDevis+"- Campagnes RAEMA Gel "+$NumCampagne+" = "+$PtNomGerme->{$Salé}
	If ([CampagneGelGermes:25]NbreColisSupAvecRapport:5>0)
		$S:=Num:C11([CampagneGelGermes:25]NbreColisSupAvecRapport:5>1)*"s"
		MailDevis:=MailDevis+" + "+String:C10([CampagneGelGermes:25]NbreColisSupAvecRapport:5)+" pot"+$S+" supplémentaire"+$S+" avec rapport."+<>ZCR
	End if 
	
	If ([CampagneGelGermes:25]NbreColisSupSansRapport:4>0)
		$S:=Num:C11([CampagneGelGermes:25]NbreColisSupSansRapport:4>1)*"s"
		MailDevis:=MailDevis+" + "+String:C10([CampagneGelGermes:25]NbreColisSupSansRapport:4)+" pot"+$S+" supplémentaire"+$S+" sans rapport."+<>ZCR
	End if 
	
	If ([CampagneGelGermes:25]NbreColisSupSansRapport:4=0) & ([CampagneGelGermes:25]NbreColisSupAvecRapport:5=0)
		MailDevis:=MailDevis+"."+<>ZCR
	End if 
	
End for 
  // traitement des RAEMA liés
If ([CampagneGelGermes:25]NbreColisSupAvecRapport:5>0)
	$NumEnrCampagneRef:=Record number:C243([CampagneParticipations:17])
	QUERY:C277([CampagneGelGermes:25];[CampagneGelGermes:25]NumCampagne:6=$NumCampagne;*)
	QUERY:C277([CampagneGelGermes:25]; & [CampagneGelGermes:25]UUIDParticipation:2=[CampagneParticipations:17]UUID:1)
	LONGINT ARRAY FROM SELECTION:C647([CampagneGelGermes:25];$TbProgramme)
	  // Tableau des n° de RAEMA Liés déja attribués dans le passé à ce laboratoire
	ARRAY TEXT:C222($TbNumRAEMALiés;0)
	OB GET ARRAY:C1229([Personnes:12]Arguments:7;"TbNumRAEMALié";$TbNumRAEMALiés)
	QUERY:C277([CampagneParticipations:17];[CampagneParticipations:17]UUIDPersonne:2=[Personnes:12]UUID:1;*)
	QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17]; & ;[CampagneParticipations:17]Arguments:5;"CodeRaemaLié";#;Null:C1517)
	ARRAY OBJECT:C1221($TbArgument;0)
	SELECTION TO ARRAY:C260([CampagneParticipations:17]Arguments:5;$TbArgument)
	$FT:=Size of array:C274($TbArgument)
	For ($Salé;1;$FT)
		$Code:=OB Get:C1224($TbArgument{$Salé};"CodeRaemaLié";Est un texte:K8:3)
		$NumLaboN:=RAEMADemoduleMdPWeb ($Code)
		$NumLaboA:=String:C10($NumLaboN)
		If (Find in array:C230($TbNumRAEMALiés;$NumLaboA)<0) & ($NumLaboN#0)
			APPEND TO ARRAY:C911($TbNumRAEMALiés;$NumLaboA)
		End if 
	End for 
	$TT:=Size of array:C274($TbNumRAEMALiés)
	$FT:=[CampagneGelGermes:25]NbreColisSupAvecRapport:5
	$L:=Find in array:C230(<>TbPerUUID;[Personnes:12]UUID:1)
	VarNumPersonne:=<>TbPerNumLaboRAEMA{$L}
	For ($Salé;1;$FT)
		If ($Salé<=$TT)
			VarNumLaboRAEMA:=Num:C11($TbNumRAEMALiés{$Salé})
			$Code:=GAInitIdentificateurPersonne 
		Else 
			  //LECTURE ÉCRITURE([XData])
			  //CHERCHER([XData];[XData]XNom="Compteur N° de RAEMA liés";*)
			  //CHERCHER([XData]; & [XData]XType="CompteurRAEMAliés")
			  //[XData]XEntier:=[XData]XEntier+1
			  //[XData]XDate:=Date du jour
			  //VarNumLaboRAEMA:=[XData]XEntier
			CREATE SET:C116([Personnes:12];"LaboDevis")
			VarNumLaboRAEMA:=ASAPCalculDerNumLabo 
			$Code:=GAInitIdentificateurPersonne 
			USE SET:C118("LaboDevis")
			  //STOCKER ENREGISTREMENT([XData])
		End if 
		GOTO RECORD:C242([CampagneParticipations:17];$NumEnrCampagneRef)
		DUPLICATE RECORD:C225([CampagneParticipations:17])
		OB SET:C1220([CampagneParticipations:17]Arguments:5;"CodeRaemaLié";$Code)
		SAVE RECORD:C53([CampagneParticipations:17])
		$ST:=Size of array:C274($TbProgramme)
		For ($Fumé;1;$ST)
			GOTO RECORD:C242([CampagneGelGermes:25];$TbProgramme{$Fumé})
			DUPLICATE RECORD:C225([CampagneGelGermes:25])
			[CampagneGelGermes:25]UUIDParticipation:2:=[CampagneParticipations:17]UUID:1
			SAVE RECORD:C53([CampagneGelGermes:25])
		End for 
	End for 
End if 