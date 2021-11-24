//%attributes = {"lang":"fr"}
// DiaPipeletteTraitement <- ZPipelette


// Traitement des investigations
// Les courriels
//<>PermCourrielOK:=Vrai
//Si (<>PermCourrielOK) & (<>ZIC)



READ WRITE:C146([DiaData:45])
QUERY:C277([DiaData:45]; [DiaData:45]XType:5="IDMesRecAD")
If (Records in selection:C76([DiaData:45])=0)
	CREATE RECORD:C68([DiaData:45])
	[DiaData:45]XType:5:="IDMesRecAD"
	[DiaData:45]XNom:1:="Id des messages reçus"
	SAVE RECORD:C53([DiaData:45])
End if 
ARRAY TEXT:C222($TbIDMessages; 0)
ARRAY TEXT:C222($TbDeMessages; 0)
OB SET ARRAY:C1227([DiaData:45]XObjet:15; "DeMesRecAD"; $TbDeMessages)  // Tableau des destinataires
OB SET ARRAY:C1227([DiaData:45]XObjet:15; "IDMesRecAD"; $TbIDMessages)  // Tableau des ID

$Erreur:=POP3_Login("pop.orange.fr"; "asadiaweb"; "1Asa2Raema"; 0; RC)  // ouverture de session et relevé du courrier
If ($Erreur=0)
	$Erreur:=POP3_BoxInfo(RC; FT; $Message_Taille)
	If ($Erreur=0)
		If (FT>0)  // il existe un nouveau courrier
			DiaPipeletteNouveauxCourriels  // création des enregistrements de [Courriels] et [PJ]
		End if 
		
		OB GET ARRAY:C1229([DiaData:45]XObjet:15; "DeMesRecAD"; $TbDeMessages)  // Tableau des destinataires
		OB GET ARRAY:C1229([DiaData:45]XObjet:15; "IDMesRecAD"; $TbIDMessages)  // Tableau des ID
		$FT:=Size of array:C274($TbIDMessages)
		For ($salé; 1; $FT)  // envoi des informations sur AsaDia
			DiaSuiviConnexions
			PUMTypeAsaDia:=1
			$Rapport:=DiaEditeConnexions(True:C214)
			$Objet:="Réponse d'AsaDia sur son avancement"
			$Dest:=$TbDeMessages{$salé}+",cegeheme@wanadoo.fr"
			$Corps:="Bonjour,"+<>ZCR2+"Suite à votre demande, veuillez trouver le rapport d'avancement d'AsaDia"+<>ZCR2+$Rapport
			$Erreur:=SMTP_Charset(1; 1)
			$Erreur:=SMTP_QuickSend("smtp.orange.fr"; "asadiaweb@orange.fr"; $Dest; $Objet; $Corps; 1; 465; "asadiaweb"; "1Asa2Raema")
			// $Erreur:=SMTP_QuickSend ("mail.ajar.ch";"asadiaweb@orange.fr";$Dest;$Objet;$Corps)
			If ($Erreur=0)
				DELETE FROM ARRAY:C228($TbIDMessages; $salé)
				DELETE FROM ARRAY:C228($TbDeMessages; $salé)
				OB SET ARRAY:C1227([DiaData:45]XObjet:15; "DeMesRecAD"; $TbDeMessages)  // Tableau des destinataires
				OB SET ARRAY:C1227([DiaData:45]XObjet:15; "IDMesRecAD"; $TbIDMessages)  // Tableau des ID
				SAVE RECORD:C53([DiaData:45])
			End if 
		End for 
	End if 
	$Erreur:=POP3_Logout(RC)
End if 

ZAmnistiePartielle(->[DiaData:45])
DiaWebScrutePJCourriels
