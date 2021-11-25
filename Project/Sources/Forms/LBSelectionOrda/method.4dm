// ----------------------------------------------------
// Nom utilisateur (OS) : Patrick
// Date et heure : 24/08/11
// ----------------------------------------------------
// Méthode : ZLBMFListes
// Description
// Méthode du formulaire projet LBSelection 
//  qui permet de gérer de façon standard 
//  la sélection d'une table (ZLBGèreListe)
// ----------------------------------------------------

$event:=Form event code:C388
$objet:=FORM Event:C1606
$lbName:="Lb_Selection"

Case of 
	: ($event=On Load:K2:1)
		var $file : 4D:C1709.file
		$file:=File:C1566("/LOGS/request.json")
		SET DATABASE PARAMETER:C642(Client log recording:K37:44; 3)
		ds:C1482.startRequestLog($file)
		
		var $image : Picture
		READ PICTURE FILE:C678(Form:C1466["Chemin logo"]; $image)
		OBJECT SET VALUE:C1742("VarLogoTable"; $image)
		
		//OBJECT SET VISIBLE(*; "imp@"; ZImprime)
		//OBJECT SET VISIBLE(*; "sup@"; ZSupprime)
		//OBJECT SET VISIBLE(*; "ens@"; ZGereEnsemble)
		
		OBJECT SET VISIBLE:C603(*; "lapin@"; Form:C1466["Méthode lapin"].length>0)
		Form:C1466.tableNumber:=ds:C1482[Form:C1466.table].getInfo().tableNumber
		Form:C1466.formula:="cs.cryptage.new().cracheNumLaboN(This.Identificateur; \"labo\")"
		
		Form:C1466.quickView:=False:C215
		OBJECT GET COORDINATES:C663(*; $lbName; $gauche; $haut; $droit; $bas)
		OBJECT GET COORDINATES:C663(*; "quickView"; $g; $ht; $dr; $bs)
		OBJECT SET COORDINATES:C1248(*; "quickView"; $g; $haut; $droit; $bas)
		OBJECT SET SUBFORM:C1138(*; "quickView"; Table:C252(Form:C1466.tableNumber)->; "quickView")
		FORM GET PROPERTIES:C674(Table:C252(Form:C1466.tableNumber)->; "quickView"; $largeur; $hauteur)
		CALL FORM:C1391(Current form window:C827; "wLBpersonnes")
		
		//SET TIMER(1)
		
		//: ($event=On Timer)
		//SET TIMER(0)
		
/*
// $es : issu de la fonction menu de la classe interface
 // orda_affLBpersonnes($es)  //ZFenetreActualiseTitre 
Ancienne version, ne pas utiliser car génère un trafique important sur le réseau
*/
		
		
	: ($event=On Unload:K2:2)
		SET DATABASE PARAMETER:C642(Client log recording:K37:44; 0)
		ds:C1482.stopRequestLog()
		SHOW ON DISK:C922(Get 4D folder:C485(Logs folder:K5:19))
		
		
	: ($event=On Selection Change:K2:29)
		$objetName:=$objet.objectName
		
		If (Form:C1466.current#Null:C1517)
			$val:=Form:C1466.current.uuid
			OBJECT SET VALUE:C1742("combien"; $val)
			
			Form:C1466.overview:=ds:C1482[Form:C1466.table].get($val)
		End if 
		
		
	: ($event=On Clicked:K2:4)
		$objetName:=$objet.objectName
		
		Case of 
			: ($objetName="LapinZBouLapin")
				var $menu : cs:C1710.interface
				$menu:=cs:C1710.interface.new().menu(Form:C1466["Méthode lapin"])
				
			: ($objetName="ZBouModifieSelection")
				ZLBModifierSelectionOrda
				
				
			: ($objetName="export")
				$coll:=New collection:C1472
				$coll.push(New object:C1471("titre"; "HTML"; "methode"; "Collection_toHTML"; "param"; Form:C1466.esColl))
				$coll.push(New object:C1471("titre"; "CSV"; "methode"; "Collection_toCSV"; "param"; Form:C1466.esColl))
				$coll.push(New object:C1471("titre"; "JSON"; "methode"; "Collection_toJSON"; "param"; Form:C1466.esColl))
				$coll.push(New object:C1471("titre"; "TXT"; "methode"; "Collection_toTXT"; "param"; Form:C1466.esColl))
				$coll.push(New object:C1471("titre"; "XML"; "methode"; "Collection_toXML"; "param"; Form:C1466.esColl))
				
				var $menu : cs:C1710.interface
				$menu:=cs:C1710.interface.new().menu($coll)
				
				
			: ($objetName="toggleQuickView")
				Form:C1466.quickView:=Not:C34(Form:C1466.quickView)
				OBJECT SET VISIBLE:C603(*; "quickView"; Form:C1466.quickView)
				
		End case 
		
		
	: ($event=On Double Clicked:K2:5)
		$objetName:=$objet.objectName
		
		If (Form:C1466.overview#Null:C1517)
			
			$_Data:=New object:C1471
			$_Data.entity:=Form:C1466.overview
			
			$statusLock:=$_Data.entity.lock()  // Lock entity
			If ($statusLock.success)
				$_Data.changed:=False:C215
				$PtrTable:=Table:C252(Form:C1466.tableNumber)
				$Win:=Open form window:C675($PtrTable->; "SaisieOrda"; *)
				DIALOG:C40($PtrTable->; "SaisieOrda"; $_Data)
				CLOSE WINDOW:C154($Win)
				
				If ($_Data.changed)
					entity_enregistrement(Form:C1466.table)
					personnes2storage  // va très très vite
					sendStorageDataToAllClients("tableaux")  // Execute sendStorageDataToAllClients depuis le serveur pour le paramètre Tableaux
				End if 
				$statusUnLock:=$_Data.entity.unlock()  // Unlock entity
				
			Else 
				C_TEXT:C284($machine; $qui)
				
				$qui:=$statusLock.lockInfo.user_name
				$machine:=$statusLock.lockInfo.host_name
				
				$txt:="L'enregistrement est déjà en cours d'édition par '"+$qui+"' sur l'ordinateur '"+$machine+"'."
				$txt:=$txt+"\nRéessayer l'édition dans quelques minutes."
				ALERT:C41($txt)
				
			End if 
			
			
		End if 
		
End case 