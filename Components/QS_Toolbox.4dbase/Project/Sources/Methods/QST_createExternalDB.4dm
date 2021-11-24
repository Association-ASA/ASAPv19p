//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 22/12/15, 20:57:42
// ----------------------------------------------------
// méthode : QST_createExternalDB
// description
//
// paramètres
// ----------------------------------------------------

var $chemin; $path; $Text : Text
var $Obj : Object

$file:=Folder:C1567(fk documents folder:K87:21; *).file("QS_Toolbox/QS_TOOLBOX_VCS.ini")
$COMP_DB_PATH:=$file.parent.platformPath
$QS_VCS_COMP_DB_PATH:=$COMP_DB_PATH+"QST_External_DB.4DD"

Use (Storage:C1525)
	If (Storage:C1525.QS_TBX_SHARED_DATA=Null:C1517)
		Storage:C1525.QS_TBX_SHARED_DATA:=New shared object:C1526
	End if 
	$SharedData:=Storage:C1525.QS_TBX_SHARED_DATA
	
	Use ($SharedData)
		$SharedData.QS_TBX_ExternalDB:=$QS_VCS_COMP_DB_PATH  // On the server
	End use 
End use 

If (Test path name:C476($QS_VCS_COMP_DB_PATH)#Is a document:K24:1)
	
	// QS - Patrick EMANUEL, 03/09/21 - 16:06:55
	CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "External DB Creation start")
	
	$sourceFolder:=$file.parent.file("QST_External_DB.4DB")
	If ($sourceFolder.exists=False:C215)
		$sourceFolder:=Folder:C1567(fk resources folder:K87:11).folder("emptyDB")
		$files:=$sourceFolder.files()
		For each ($oneFile; $files)
			$destinationFolder:=$oneFile.copyTo($file.parent; fk overwrite:K87:5)
		End for each 
	End if 
	
	PROCESS_sleep(3*60)
	CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "External DB Creation end")
	
	$signal:=New signal:C1641
	signal_setNew($signal; 1)
	CALL WORKER:C1389("QST_DB_SetUp"; "QST_DB_SetUp"; $signal)
	$signal.wait()
	
End if 

If ($file.exists=False:C215)
	
	If (Test path name:C476($COMP_DB_PATH)#Is a folder:K24:2)
		CREATE FOLDER:C475($COMP_DB_PATH; *)
	End if 
	
	OB SET:C1220($Obj; "BDD"; $COMP_DB_PATH)
	$Text:=JSON Stringify:C1217($Obj)
	
	If ($file.exists)  // Just in case of the file exist, but empty
		$file.delete()
	End if 
	
	$file.create()
	$file.setText($text)
	PROCESS_sleep
	
Else   // ini File exists
	
	$text:=$file.getText("UTF-8")
	$Obj:=JSON Parse:C1218($Text)
	
	If (OB Is defined:C1231($Obj; "BDD"))
		$COMP_DB_PATH:=$Obj.BDD
	End if 
End if 