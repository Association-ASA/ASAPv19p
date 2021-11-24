//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 14/09/21, 08:02:02
  // ----------------------------------------------------
  // Méthode : DiaGibierImportOrganesSainsTbPZ
  // Description
  // Méthode de création des enregistrements de DiaData 
  //  hérités du tableau foruni par PZ
  // Nom du fichier / Espèce / Précision espèce / Organe / Précision organe / Description
  // ----------------------------------------------------
USE CHARACTER SET:C205("Macintosh";1)
$Doc:=Open document:C264("";Mode lecture:K24:5)
RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
If ($Ligne#"Nom du fichier@")
	ALERT:C41("Désolé, le fichier choisi ne semble pas être le bon...")
Else 
	READ WRITE:C146([DiaData:45])
	QUERY:C277([DiaData:45];[DiaData:45]XType:5="OrganeSainGibier")
	If (Records in selection:C76([DiaData:45])>0)
		DELETE SELECTION:C66([DiaData:45])
	End if 
	
	$Fini:=False:C215
	Repeat 
		RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
		$ligne:=Replace string:C233($Ligne;Char:C90(10);"")
		If ($Ligne="")
			$Fini:=True:C214
		Else 
			ARRAY TEXT:C222($Tb;0)
			ZTexteVersTableau ($Ligne;->$Tb;<>ZTab)
			CREATE RECORD:C68([DiaData:45])
			[DiaData:45]XType:5:="OrganeSainGibier"
			[DiaData:45]XNom:1:=$Tb{1}  // Nom du fichier
			[DiaData:45]XAlpha:14:=$Tb{2}  // espèce
			[DiaData:45]XTexte:7:=$Tb{4}  // organe
			[DiaData:45]XTexteSup:8:=$Tb{6}  // commentaire
			OB SET:C1220([DiaData:45]XObjet:15;"PrécisionEspèce";$Tb{3})
			OB SET:C1220([DiaData:45]XObjet:15;"PrécisionOrgane";$Tb{5})
			SAVE RECORD:C53([DiaData:45])
		End if 
	Until ($Fini)
End if 
USE CHARACTER SET:C205(*;1)