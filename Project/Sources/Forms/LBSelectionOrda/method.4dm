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
		SET DATABASE PARAMETER:C642(Client log recording:K37:44; 2)
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
		
		SET TIMER:C645(1)
		
		
	: ($event=On Unload:K2:2)
		SET DATABASE PARAMETER:C642(Client log recording:K37:44; 0)
		ds:C1482.stopRequestLog()
		SHOW ON DISK:C922(Get 4D folder:C485(Logs folder:K5:19))
		
		
	: ($event=On Timer:K2:25)
		SET TIMER:C645(0)
		
		// $es : issu de la fonction menu de la classe interface
		// orda_affLBpersonnes($es)  //ZFenetreActualiseTitre
		// 
		Form:C1466.esColl:=ds:C1482[Form:C1466.table].query("TypePersonne =:1 and Caduc=:2"; "laboratoire"; False:C215).orderBy(Form:C1466["Champ significatif"]+" "+Form:C1466.tri)
		
		If (Form:C1466.premiereOuverture)
			Form:C1466.selection:=$es
			Form:C1466.esInitiale:=$es
			Form:C1466.premiereOuverture:=False:C215
		End if 
		
		
	: ($event=On Clicked:K2:4)
		$objetName:=$objet.objectName
		
		If (Form:C1466.current#Null:C1517)
			// TRACE
		End if 
		
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
		
		If (Form:C1466.current#Null:C1517)
			$workerName:=String:C10(Form:C1466.current.entity.UUID)
			
			
			
			
		End if 
		
End case 