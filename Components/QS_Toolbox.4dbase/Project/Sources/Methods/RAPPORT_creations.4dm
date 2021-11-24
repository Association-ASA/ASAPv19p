//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 17/08/14, 17:03:27
// Refactorized on 25/03/2020

// ----------------------------------------------------
// méthode : RAPPORT_creations
// description
//
//
// paramètres
// ----------------------------------------------------
#DECLARE($FormParam : Object)

var $formulare; $methods; $Structure; $withGraphviz : Boolean
var $fileType; $any : Integer
var $Path : 4D:C1709.Folder

$Structure:=Bool:C1537($FormParam.Structure)
$methods:=Bool:C1537($FormParam.Methodes)
$formulare:=Bool:C1537($FormParam.Formulaire)
$withGraphviz:=Bool:C1537($FormParam.WithGraphviz)
$fileType:=$FormParam.FileFormat

$Path:=Folder:C1567(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Reports; fk platform path:K87:2).folder("Reports")
If ($Path.exists=False:C215)
	$Path.create()
End if 

$subPath:=$Path.folder("Forms")
If ($subPath.exists=False:C215)
	$subPath.create()
End if 

$subPath:=$Path.folder("Methods")
If ($subPath.exists=False:C215)
	$subPath.create()
End if 

$subPath:=$Path.folder("DB Structure")
If ($subPath.exists=False:C215)
	$subPath.create()
End if 

$graphvizPicturePath:=Folder:C1567(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Reports; fk platform path:K87:2).folder("All Project Methods")
If ($graphvizPicturePath.exists=False:C215)
	$graphvizPicturePath.create()
End if 

// Work only if any
$any:=(Num:C11($Structure)+Num:C11($methods)+Num:C11($formulare))
If ($any>0)
	
	If (Shift down:C543)
		SET DATABASE PARAMETER:C642(Debug log recording:K37:34; 2+4)
	End if 
	
	var $signal : Object
	$signal:=New signal:C1641
	signal_setNew($signal; $any)
	
	// --------------------------------------------------------------------------------------------------------
	// export -Forms (screenshots + widget information)
	// --------------------------------------------------------------------------------------------------------
	If ($formulare)
		CALL WORKER:C1389("QST_exportForms"; "RAPPORT_exportForms"; $signal)
	End if 
	
	// --------------------------------------------------------------------------------------------------------
	// export - Methods -> all objects
	// --------------------------------------------------------------------------------------------------------
	If ($methods)
		$option:=New object:C1471("withGraphviz"; $withGraphviz; "format"; $fileType)
		CALL WORKER:C1389("QST_exportMethods"; "RAPPORT_exportMethods"; $option; $signal)
	End if 
	
	// --------------------------------------------------------------------------------------------------------
	// export - Structure information
	// --------------------------------------------------------------------------------------------------------
	If ($Structure)
		CALL WORKER:C1389("QST_exportStructure"; "RAPPORT_exportStructure"; $signal)
	End if 
	
	$signal.wait()
	KILL WORKER:C1390("QST_Progress")
	KILL WORKER:C1390("QST_exportForms")
	KILL WORKER:C1390("QST_exportMethods")
	KILL WORKER:C1390("QST_exportStructure")
	
	SHOW ON DISK:C922($Path.platformPath)
End if 