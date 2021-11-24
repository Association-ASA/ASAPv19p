//%attributes = {}
  // On recopie les participation des labos de l'année n pour l'année n+1
C_OBJECT:C1216($entSel)
  // On cherche la campagne Mars concernée
READ WRITE:C146([CampagneParticipations:17])
$Année:=Num:C11(Year of:C25(Current date:C33)+1)
$CampagneMarsActuel:=RaemaTrouveNumCampagneParAn (Num:C11(<>PUMAnRaemaPoudre{2});1)
QUERY:C277([Personnes:12];[CampagneParticipations:17]NumCampagne:3=$CampagneMarsActuel;*)
QUERY BY ATTRIBUTE:C1331([Personnes:12]; | ;[Personnes:12]Arguments:7;"ProchParticipe";=;$Année;*)
QUERY:C277([Personnes:12]; & [Personnes:12]Caduc:8=False:C215;*)
QUERY BY ATTRIBUTE:C1331([Personnes:12]; & ;[Personnes:12]Arguments:7;"ProchParticipe";=;Null:C1517)

$CampagneMarsSuivante:=String:C10(Num:C11($CampagneMarsActuel)+2)
ARRAY TEXT:C222($TbNumCampagne;0)
$FT:=Records in selection:C76([Personnes:12])
  //Transporteur utiliser les tableaux généraux en utilisant l'identifiant

For ($Salé;1;$FT)
	$entSel:=ds:C1482.CampagneParticipations.query("NumCampagne = :1  and UUIDPersonne = :2";$CampagneMarsActuel;[Personnes:12]UUID:1)
	$Argument:=$entSel[0].Arguments
	$Transporteur:=""
	$BoiteIso:=0
	$SansPatho:=False:C215
	If ($Argument=Null:C1517)
		$Transporteur:=OB Get:C1224([Personnes:12]Arguments:7;"ModeEnvoiColis")
		$SansPatho:=OB Get:C1224([Personnes:12]Arguments:7;"SansPathogene";Est un booléen:K8:9)
		$BoiteIso:=Num:C11(OB Get:C1224([Personnes:12]Arguments:7;"BoiteIsotherme"))
	Else 
		$Transporteur:=$entSel[0].Arguments.Transporteur
		$BoiteIso:=$entSel[0].Arguments.BoîteIsotherme
		$SansPatho:=$entSel[0].Arguments.SansPathogene
	End if 
	If ($Transporteur="")
		$Transporteur:=OB Get:C1224([Personnes:12]Arguments:7;"ModeEnvoiColis")
	End if 
	If ($SansPatho=False:C215)
		$SansPatho:=OB Get:C1224([Personnes:12]Arguments:7;"SansPathogene")
	End if 
	If ($BoiteIso=0)
		$BoiteIso:=Num:C11(OB Get:C1224([Personnes:12]Arguments:7;"BoiteIsotherme"))
	End if 
	If ($BoiteIso=2)
		$BoiteIso:=0
	End if 
	CREATE RECORD:C68([CampagneParticipations:17])
	[CampagneParticipations:17]UUIDPersonne:2:=[Personnes:12]UUID:1
	[CampagneParticipations:17]NumCampagne:3:=$CampagneMarsSuivante
	OB SET:C1220([CampagneParticipations:17]Arguments:5;"Transporteur";$Transporteur;"BoîteIsotherme";$BoiteIso)
	If ($SansPatho=True:C214)
		OB SET:C1220([CampagneParticipations:17]Arguments:5;"SansPathogene";$SansPatho)
	End if 
	SAVE RECORD:C53([CampagneParticipations:17])
	  //ENREGISTREMENT SUIVANT([CampagneParticipations])
	NEXT RECORD:C51([Personnes:12])
End for 

  // On cherche la campagne Octobre concernée
$CampagneOctobreActuel:=RaemaTrouveNumCampagneParAn (Num:C11(<>PUMAnRaemaPoudre{2});3)
QUERY:C277([Personnes:12];[CampagneParticipations:17]NumCampagne:3=$CampagneOctobreActuel;*)
QUERY:C277([Personnes:12]; & [Personnes:12]Caduc:8=False:C215;*)
QUERY BY ATTRIBUTE:C1331([Personnes:12]; & ;[Personnes:12]Arguments:7;"ProchParticipe";=;Null:C1517;*)
QUERY BY ATTRIBUTE:C1331([Personnes:12]; | ;[Personnes:12]Arguments:7;"ProchParticipe";=;$Année)
$CampagneOctobreSuivante:=String:C10(Num:C11($CampagneOctobreActuel)+2)
ARRAY TEXT:C222($TbNumCampagne;0)
$FT:=Records in selection:C76([Personnes:12])
  //Transporteur utiliser les tableaux généraux en utilisant l'identifiant
For ($Salé;1;$FT)
	$entSel:=ds:C1482.CampagneParticipations.query("NumCampagne = :1  and UUIDPersonne = :2";$CampagneOctobreActuel;[Personnes:12]UUID:1)
	$Argument:=$entSel[0].Arguments
	$Transporteur:=""
	$BoiteIso:=0
	$SansPatho:=False:C215
	If ($Argument=Null:C1517)
		$Transporteur:=OB Get:C1224([Personnes:12]Arguments:7;"ModeEnvoiColis")
		$SansPatho:=OB Get:C1224([Personnes:12]Arguments:7;"SansPathogene";Est un booléen:K8:9)
		$BoiteIso:=Num:C11(OB Get:C1224([Personnes:12]Arguments:7;"BoiteIsotherme"))
	Else 
		$Transporteur:=$entSel[0].Arguments.Transporteur
		$BoiteIso:=$entSel[0].Arguments.BoîteIsotherme
		$SansPatho:=$entSel[0].Arguments.SansPathogene
	End if 
	If ($Transporteur="")
		$Transporteur:=OB Get:C1224([Personnes:12]Arguments:7;"ModeEnvoiColis")
	End if 
	If ($SansPatho=False:C215)
		$SansPatho:=OB Get:C1224([Personnes:12]Arguments:7;"SansPathogene")
	End if 
	If ($BoiteIso=0)
		$BoiteIso:=Num:C11(OB Get:C1224([Personnes:12]Arguments:7;"BoiteIsotherme"))
	End if 
	If ($BoiteIso=2)
		$BoiteIso:=0
	End if 
	CREATE RECORD:C68([CampagneParticipations:17])
	[CampagneParticipations:17]UUIDPersonne:2:=[Personnes:12]UUID:1
	[CampagneParticipations:17]NumCampagne:3:=$CampagneOctobreSuivante
	OB SET:C1220([CampagneParticipations:17]Arguments:5;"Transporteur";$Transporteur;"BoîteIsotherme";$BoiteIso)
	If ($SansPatho=True:C214)
		OB SET:C1220([CampagneParticipations:17]Arguments:5;"SansPathogene";$SansPatho)
	End if 
	SAVE RECORD:C53([CampagneParticipations:17])
	  //ENREGISTREMENT SUIVANT([CampagneParticipations])
	NEXT RECORD:C51([Personnes:12])
End for 
ZAmnistieInternationale 
