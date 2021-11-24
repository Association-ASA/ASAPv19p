//%attributes = {"invisible":true,"executedOnServer":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 07/04/18, 08:59:41
  // ----------------------------------------------------
  // Méthode : VCS_BuildArrays
  // Description
  //  $1 : collection
  //
  // Paramètres
  // ----------------------------------------------------

C_LONGINT:C283($LatestExport_l;$LatestStamp_l)
ARRAY TEXT:C222($Path_at;0x0000)
ARRAY DATE:C224($Date_at;0x0000)
ARRAY LONGINT:C221($Time_at;0x0000)

ARRAY TEXT:C222($PathModified_at;0x0000)
ARRAY DATE:C224($DateModified_at;0x0000)
ARRAY LONGINT:C221($TimeModified_at;0x0000)

C_TEXT:C284($ToSearch;$QS_TBX_DBName)
C_TEXT:C284($QS_VCS_COMP_DB_PATH)

C_COLLECTION:C1488($coll;$0)
$coll:=New collection:C1472

$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB
  //$QS_TBX_DBName:=Storage.QS_TBX_SHARED_DATA.VCS_QS_TBX_DBName
$QS_TBX_DBName:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName
$LatestExport_l:=Form:C1466.VCS_LatestExport
$LatestStamp_l:=$LatestExport_l
VCS_MethodPaths (->$PathModified_at;->$DateModified_at;->$TimeModified_at;Path all objects:K72:16;->$LatestStamp_l)

Begin SQL
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	
	SELECT VCS_PATH, VCS_DATE, VCS_TIME
	FROM VCS
	WHERE VCS_APPLICATION = :[$QS_TBX_DBName]
	INTO :[$Path_at], :[$Date_at], :[$Time_at];
	
	USE DATABASE SQL_INTERNAL;
	
End SQL

  // Compilation
For ($a;1;Size of array:C274($Path_at))
	$Path_at{$a}:=$Path_at{$a}+String:C10($Date_at{$a})+String:C10($Time_at{$a})
End for 

SORT ARRAY:C229($path_at;>)

For ($a;Size of array:C274($PathModified_at);1;-1)
	$path:=$PathModified_at{$a}
	$time:=String:C10($TimeModified_at{$a})
	$date:=String:C10($DateModified_at{$a})
	
	$ToSearch:=$path+$date+$time
	
	If (Find in sorted array:C1333($Path_at;$ToSearch;>))
		DELETE FROM ARRAY:C228($PathModified_at;$a;1)
		DELETE FROM ARRAY:C228($TimeModified_at;$a;1)
		DELETE FROM ARRAY:C228($DateModified_at;$a;1)
	End if 
	
End for 

ARRAY TO COLLECTION:C1563($coll;$PathModified_at;"path";$DateModified_at;"dateStamp";$TimeModified_at;"timeStamp")
$0:=$coll.copy()