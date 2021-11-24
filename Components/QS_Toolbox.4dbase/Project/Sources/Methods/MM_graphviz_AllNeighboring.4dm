//%attributes = {"invisible":true,"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 11/06/19, 07:02:03
// Paramètres
// ----------------------------------------------------
// Méthode : METHODS_AllCreateNeighboringGra
// Description
//

Graphviz_check

If (Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Graphviz)
	
	C_COLLECTION:C1488($col; $data)
	C_COLLECTION:C1488($methodList)
	C_LONGINT:C283($n; $max; $window)
	
	// Modifié par : PE (22/10/2019)
	$NumMethod:=0
	$col:=New collection:C1472(".png"; ".pdf"; ".jpg"; ".svg")
	$Extension:=Choose:C955(Pop up menu:C542($col.join(";")); ""; ".png"; ".pdf"; ".jpg"; ".svg")
	If ($extension="")
		$Extension:=".pdf"  // by default
	End if 
	
	$data:=Storage:C1525.allMethods
	// First at all, we work only fon Prohect Method
	$methodList:=$data.filter("CM_displayByType"; "Path project method")
	
	$txt:="Creation of graphviz document is in progress. Do not close the window."
	displayInfo($txt; "red")
	
	$chemin:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DestinationPath+"All Project Methods"+Folder separator:K24:12
	
	// Initialisation
	C_OBJECT:C1216($param)
	$param:=New object:C1471("title"; "Closer neighbors schema"; "icon"; "btn_attributes.png"; "type"; 0)
	QST_progress_start($param)
	$window:=$param.window
	
	$n:=0
	$max:=$methodList.length
	
	For each ($method; $methodList)
		$n:=$n+1
		$param.value:=$n/$max
		$param.content:=$method.name
		CALL FORM:C1391($window; "progressBar_update"; $param)
		
		$method.ext:=$Extension
		$method.path:=$chemin
		Graphviz_neightbouring($method)
	End for each 
	KILL WORKER:C1390("QST_Progress")
	
	displayInfo("Neighbors graphviz creation ended. Check 'All Project Methods' to get schemas.")
	
Else   // <>QS_TBX_Graphviz = False
	
	displayInfo("Graphviz command line is missing."; "red")
	
End if 
