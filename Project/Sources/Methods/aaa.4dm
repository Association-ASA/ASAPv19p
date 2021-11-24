//%attributes = {"executedOnServer":true}
// 1 - A executer au démarrage du serveur

$table:="Personnes"
$es:=ds:C1482[$table].query("TypePersonne =:1 and Caduc=:2"; "laboratoire"; False:C215)
$formula:="cs.cryptage.new().cracheNumLaboN(This.Identificateur; \"labo\")"
$n:=New object:C1471
For each ($e; $es)
	$n[$e.UUID]:=New object:C1471
	$n[$e.UUID].labo:=Formula from string:C1601($formula).call($e)
	$n[$e.UUID].nom:=$e.NomLong
	$n[$e.UUID].recupMailRAEMA:=$e.recupMail("EmailRAEMA")
	$n[$e.UUID].recupMailFac:=$e.recupMail("EmailCompta")
	$n[$e.UUID].uuid:=$e.UUID
	$n[$e.UUID].adr:=$e.recupAdresse("Livraison"; "Facturation")
	$n[$e.UUID].pays:=$e.recupPays("Livraison"; "Facturation")
End for each 

Use (Storage:C1525)
	Storage:C1525.tableaux:=OB Copy:C1225($n; ck shared:K85:29)
End use 


/* --------------------
Au démarrge d'un client, il faut interroger le serveur qui renvoie 'Storage.tableaux' dans une variable
pour être stocké dans le storage du client
*/


/* --------------------
Création de la structure de LB sous forme de collection

*/








/* --------------------
Utilisateur sélectionne un labo, on récupère l'UUID et on charge l'entité de cet UUID
$table:="Personnes"
sur clic => $e:=ds[$table].get($myUUID) // $myUUID = Form.current.UUID -> $myUUID = Primary Key

*/



$myUUID:="3F3F3540B75D423BA2D066084B5549B7"
$table:="Personnes"
$es:=ds:C1482[$table].query("UUID =:1"; $myUUID)


$tt1:=Milliseconds:C459

For ($a; 1; 1000)
	
	//$myUUID:="01A06FAAD70445FFBC68AEA181444114"
	$table:="CampagneParticipations"
	
	
	////Placeholders nommés pour les chemins d'attributs
	//$querySettings:=New object
	//$querySettings.attributes:=New object("attName"; "UUIDPersonne")
	//// boucle
	
	
	//// fin de boucle
	
	
	$querySettings.parameters:=New object:C1471("givenName"; $myUUID)
	$es:=ds:C1482.Employee.query(":attName= :givenName"; $querySettings)
	
	
	$es:=ds:C1482[$table].query("UUIDPersonne =:1 and NumCampagne in :2"; $myUUID; New collection:C1472("71"; "72"; "71A"; "72A"))
	$n:=$es.length
	If ($n>0)
		$i:=-1
		For each ($e; $es)
			$i:=$i+1
			$compagne:=$e.NumCampagne
			If ($e.NumCampagne="71")
				$x:=$i
				$t1:=$e.Arguments.Transporteur
			End if 
			
			If ($e.NumCampagne="72")
				$y:=$i
				$t2:=$e.Arguments.Transporteur
			End if 
		End for each 
		
		
		//For ($salé; 0; $n-1)
		//$e:=$es[$salé]
		//$compagne:=$e.NumCampagne
		//If ($e.NumCampagne="71")
		//$t3:=$e.Arguments.Transporteur
		//End if 
		
		//If ($e.NumCampagne="72")
		//$t4:=$e.Arguments.Transporteur
		//End if 
		//End for 
		
		$neededRelations:=ob_getByPath($es; "Personnes_CampagneParticipations.Factures_Personnes.Ventes_Factures")
		
		
		
	Else 
		$table:="Personnes"
		$es:=ds:C1482[$table].query("UUID =:1"$myUUID)
	End if 
	
End for 

$tt2:=Milliseconds:C459
ALERT:C41(String:C10($tt2-$tt1))
/* --------------------
Utilisateur mets à jour une info
1 -> demander au serveur après la sauvegarde de recalculer l'objet initial (client -> serveur)
Execute on server
$process:=Execute on server("updateStorageTableaux";0;$myUUID)

// Exemple de mise à jour d'une info
$e:=ds[$table].get($UUID)
Use (Storage.tableaux)
Storage.tableaux[$e.UUID]:=New object
Storage.tableaux[$e.UUID].labo:=Formula from string($formula).call($e)
Storage.tableaux[$e.UUID].nom:=$e.NomLong
Storage.tableaux[$e.UUID].recupMailRAEMA:=$e.recupMail("EmailRAEMA")
Storage.tableaux[$e.UUID].recupMailFac:=$e.recupMail("EmailCompta")
Storage.tableaux[$e.UUID].uuid:=$e.UUID
Storage.tableaux[$e.UUID].adr:=$e.recupAdresse("Livraison"; "Facturation")
Storage.tableaux[$e.UUID].pays:=$e.recupPays("Livraison"; "Facturation")
End use 

2 -> le serveur informe tous les clients de la mise (uniquement de l'entité) (serveur -> clients)
EXECUTE ON CLIENT("@"; "nomMethodeToExecute"; $UUID; $n[$UUID])

*/

$tt1:=Milliseconds:C459

For ($a; 1; 1000)
	
	//$myUUID:="01A06FAAD70445FFBC68AEA181444114"
	$table:="Personnes"
	$es:=ds:C1482[$table].query("UUID =:1"; $myUUID)
	$es2:=$es.CampagneParticipations_Personnes
	
	$n:=$es2.length
	If ($n>0)
		$i:=-1
		For each ($e; $es2)
			$i:=$i+1
			$compagne:=$e.NumCampagne
			If ($e.NumCampagne="71")
				$x:=$i
				$t1:=$e.Arguments.Transporteur
			End if 
			
			If ($e.NumCampagne="72")
				$y:=$i
				$t2:=$e.Arguments.Transporteur
			End if 
		End for each 
		
		
		//For ($salé; 0; $n-1)
		//$e:=$es[$salé]
		//$compagne:=$e.NumCampagne
		//If ($e.NumCampagne="71")
		//$t3:=$e.Arguments.Transporteur
		//End if 
		
		//If ($e.NumCampagne="72")
		//$t4:=$e.Arguments.Transporteur
		//End if 
		//End for 
		
		$neededRelations:=ob_getByPath($es; "Factures_Personnes.Ventes_Factures")
		
		
		
	Else 
		$table:="Personnes"
		$es:=ds:C1482[$table].query("UUID =:1"$myUUID)
	End if 
End for 
$tt2:=Milliseconds:C459
ALERT:C41(String:C10($tt2-$tt1))