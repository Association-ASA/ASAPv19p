//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 15/11/18, 11:53:31
  // ----------------------------------------------------
  // Méthode : WebCryptageDemandeCertificat
  // Description
  // Méthode qui permet de générer les cles de cryptages
  //   si ce n'est déjà fait et de créer la demande de certificat
  // ----------------------------------------------------

C_BLOB:C604($BcléPrivée;$BcléPublique;$BDemandeCert)
C_LONGINT:C283($NumTable)
ARRAY LONGINT:C221($tLCodes;6)
ARRAY TEXT:C222($tAInfos;6)
If (VarNom="") | (VarPays="") | (VarVille="") | (VarDépartement="") | (VarRS="") | (VarService="")
	ALERT:C41("Il faut remplir tous les champs...")
Else 
	  //  Génération des clés de cryptage
	QUERY:C277([DiaData:45];[DiaData:45]XType:5="ddj";*)
	QUERY:C277([DiaData:45]; & [DiaData:45]XNom:1="connexion")
	If (Records in selection:C76([DiaData:45])=0)
		CREATE RECORD:C68([DiaData:45])
		[DiaData:45]XType:5:="ddj"
		[DiaData:45]XNom:1:="connexion"
		GENERATE ENCRYPTION KEYPAIR:C688($BcléPrivée;$BcléPublique;2048)
		ZVariableVersBlob (->[DiaData:45]XBlob:11;->$BcléPrivée;->$BcléPublique)
		SAVE RECORD:C53([DiaData:45])
		BLOB TO DOCUMENT:C526("cléPublique.txt";$BcléPublique)
		BLOB TO DOCUMENT:C526("cléPrivée.txt";$BcléPrivée)
	End if 
	ZBlobVersVariable (->[DiaData:45]XBlob:11;->$BcléPrivée;->$BcléPublique)
	  //ALERTE("Sélectionnez votre clé privée.")
	  //$vhRefDoc:=Ouvrir document("")
	  //Si (OK=1)
	$Rang:=1
	$tAInfos{1}:=VarNom
	$tLCodes{1}:=13
	
	$Rang:=$Rang+1
	$tAInfos{$Rang}:=VarPays
	$tLCodes{$Rang}:=$tLCodes{$Rang-1}+1
	
	$Rang:=$Rang+1
	$tAInfos{$Rang}:=VarVille
	$tLCodes{$Rang}:=$tLCodes{$Rang-1}+1
	
	
	$Rang:=$Rang+1
	$tAInfos{$Rang}:=VarDépartement
	$tLCodes{$Rang}:=$tLCodes{$Rang-1}+1
	
	$Rang:=$Rang+1
	$tAInfos{$Rang}:=VarRS
	$tLCodes{$Rang}:=$tLCodes{$Rang-1}+1
	
	$Rang:=$Rang+1
	$tAInfos{$Rang}:=VarService
	$tLCodes{$Rang}:=$tLCodes{$Rang-1}+1
	
	  //FERMER DOCUMENT($vhRefDoc)
	  //DOCUMENT VERS BLOB(Document;$vbcléPrivée)
	GENERATE CERTIFICATE REQUEST:C691($BcléPrivée;$BDemandeCert;$tLCodes;$tAInfos)
	$Doc:=Create document:C266("")
	$CD:=Document
	CLOSE DOCUMENT:C267($Doc)
	BLOB TO DOCUMENT:C526($CD;$BDemandeCert)
	SHOW ON DISK:C922($CD)
End if 