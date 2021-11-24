//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 26/02/21, 13:49:25
  // ----------------------------------------------------
  // Méthode : ASAPLaboCreePdfProformaServeur
  // Description
  // Méthode exécutée par le serveur pour créer les pdf
  //
  // Paramètres
  // ----------------------------------------------------
$NumCampagne:=$1

C_LONGINT:C283($Salé;$FT)

QUERY:C277([RAEMACampagnes:20];[RAEMACampagnes:20]NumCampagne:2=$NumCampagne)
VarDate:=[RAEMACampagnes:20]DateEnvoiColis:3
QUERY:C277([Personnes:12];[CampagneParticipations:17]NumCampagne:3=$NumCampagne;*)
QUERY BY ATTRIBUTE:C1331([Personnes:12]; & ;[Personnes:12]Arguments:7;"Proforma";#;Null:C1517)

$FT:=Records in selection:C76([Personnes:12])

For ($Salé;1;$FT)
	$NumLaboN:=Num:C11(ASAPTrouveNumeroLaboParUUID ([Personnes:12]UUID:1))
	$L:=Find in array:C230(<>TbPerNumLaboRAEMA;$NumLaboN)  // Rang dans tableaux généraux personnes
	$identifiantParticipation:=String:C10($NumLaboN)+"_"+$NumCampagne+"_"
	$LP:=Find in array:C230(<>TbLotoIdentifiantParticipation;$identifiantParticipation)  // Rang dans tableaux généraux participation
	$Proforma:=<>TbLotoProformaPoudre{$LP}
	
	If ($Proforma#"") & (<>TbPAAssociation{$L}#"LRAR-M")
		Case of 
			: ($NumLaboN=469)
				  //(<>TbPAAssociation{$L}="ASA - LRAR-M")  // si "Marocain"  = 6 Kg     45 cm x 37 cm x 25 cm
				VarPoids:="6 Kg"
				VarDim:="40cm x 37cm x 25cm"
				
			: ($NumLaboN=32)
				VarPoids:="3 Kg"
				VarDim:="30cm x 30cm x 30cm"
				
			: (<>TbLotoBoiteIsotherme{$LP}=0) & ((<>TbLotoNbColisPoudreSR{$LP}+<>TbLotoNbColisPoudreAR{$LP})=0)  // si pas isotherme et pas de colis sup = 1 Kg     24 cm x 24 cm x 10 cm
				VarPoids:="1 Kg"
				VarDim:="24cm x 24cm x 10cm"
				
			: (<>TbLotoBoiteIsotherme{$LP}=0) & ((<>TbLotoNbColisPoudreSR{$LP}+<>TbLotoNbColisPoudreAR{$LP})=1)  // si pas isotherme et 1 colis sup = 3 Kg     25 cm x 25 cm x 25 cm
				VarPoids:="3 Kg"
				VarDim:="25cm x 25cm x 25cm"
				
			: (<>TbLotoBoiteIsotherme{$LP}=0) & ((<>TbLotoNbColisPoudreSR{$LP}+<>TbLotoNbColisPoudreAR{$LP})=2)  // si pas isotherme et 2 colis sup = 3 Kg    30 cm x 30 cm x 30 cm
				VarPoids:="3 Kg"
				VarDim:="30cm x 30cm x 30cm"
				
			: (<>TbLotoBoiteIsotherme{$LP}>0) & ((<>TbLotoNbColisPoudreSR{$LP}+<>TbLotoNbColisPoudreAR{$LP})=0)  // si isotherme  = 8 Kg     386 mm x 286 mm x 297 mm
				VarPoids:="8 Kg"
				VarDim:="386mm x 286mm x 297mm"
				
			: (<>TbLotoBoiteIsotherme{$LP}>0) & ((<>TbLotoNbColisPoudreSR{$LP}+<>TbLotoNbColisPoudreAR{$LP})>0)  // si isotherme  = 10 Kg     386 mm x 376 mm x 337 mm
				VarPoids:="10 Kg"
				VarDim:="386mm x 376mm x 337mm"
				
				
			Else 
				
				VarPoids:=""
				VarDim:=""
		End case 
		
		$TypeRaema:=(Num:C11($NumCampagne="@A")*"Gel")+(Num:C11($NumCampagne#"@A")*"Poudre")
		Case of 
			: ($Proforma="Facture") | ($Proforma="Commercial")
				$Format:="FacCom"+$TypeRaema
				
			: ($Proforma="Proforma")
				$Format:="Proforma"+$TypeRaema
		End case 
		
		$UUIDLabo:=[Personnes:12]UUID:1
		
		<>PermCheDosProforma:=<>PermCheDosPdf+"Proforma"+Séparateur dossier:K24:12
		If (Test path name:C476(<>PermCheDosProforma)<0)  // c'est le chemin de dossier de téléchargement des proforma
			CREATE FOLDER:C475(<>PermCheDosProforma)
		End if 
		$ChemCible:=<>PermCheDosProforma+String:C10($NumLaboN)+"_"+$UUIDLabo+Séparateur dossier:K24:12
		$DocProforma:=$ChemCible+"ProformaRAEMA.pdf"
		$NomProforma:="ProformaRAEMA.pdf"
		
		If (Test path name:C476($ChemCible)#Est un dossier:K24:2)
			CREATE FOLDER:C475($ChemCible)
		End if 
		If (Test path name:C476($DocProforma)=Est un document:K24:1)
			DELETE DOCUMENT:C159($DocProforma)
		End if 
		
		NumCampagne:=$NumCampagne
		ZPDFImprimer ($NomProforma;$ChemCible;"ASAPImprimeFacture";$Format)
		
		READ WRITE:C146([Personnes:12])
		  //$URL:=Remplacer chaîne($DocProforma;Séparateur dossier;"/")
		$URLProforma:="https://association.asa-spv.fr/pdf/Proforma/"+String:C10($NumLaboN)+"_"+$UUIDLabo+"/ProformaRAEMA.pdf"
		  //https://association.asa-spv.fr/PJCourriels/POUVOIR_POUR_AG_2021.pdf
		
		
		OB SET:C1220([Personnes:12]Arguments:7;"URLProforma";$URLProforma)
		SAVE RECORD:C53([Personnes:12])
	End if 
	NEXT RECORD:C51([Personnes:12])
End for 
ZAmnistieInternationale 

