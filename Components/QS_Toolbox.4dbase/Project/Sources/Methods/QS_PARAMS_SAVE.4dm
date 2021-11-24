//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 04/10/17, 08:13:25
// ----------------------------------------------------
// Méthode : QS_PARAM_SAVE
// Description
//  Update table SETUP in External Database
//
// Paramètres
// ----------------------------------------------------

#DECLARE($blob : Blob)

var $Ref : Integer
var $QS_VCS_COMP_DB_PATH; $Value : Text
var $param : Collection

ARRAY TEXT:C222($QS_SETUP_MODULE; 0x0000)
ARRAY TEXT:C222($QS_SETUP_PARAM; 0x0000)
ARRAY TEXT:C222($QS_SETUP_VALUE; 0x0000)
ARRAY LONGINT:C221($QS_SETUP_REF; 0x0000)

$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB
$param:=New collection:C1472
BLOB TO VARIABLE:C533($blob; $param)
COLLECTION TO ARRAY:C1562($param; \
$QS_SETUP_MODULE; "module"; \
$QS_SETUP_PARAM; "param"; \
$QS_SETUP_VALUE; "value"; \
$QS_SETUP_REF; "ref")

Begin SQL
	
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	
End SQL

For ($Ref; 1; Size of array:C274($QS_SETUP_VALUE))
	
	$Value:=String:C10($QS_SETUP_VALUE{$Ref})
	
	Begin SQL
		
		UPDATE SETUP
		SET MOD_VALUE = :[$Value]
		WHERE MOD_REF = :[$Ref];
		
	End SQL
	
End for 

Begin SQL
	
	USE DATABASE SQL_INTERNAL;
	
End SQL

QS_PARAM_AFFECTATION($blob)