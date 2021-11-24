//%attributes = {"invisible":true,"executedOnServer":true}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 02/10/17, 17:39:49
// ----------------------------------------------------
// Méthode : QS_DB_SetUp
// Description
// Initial Setup
//
// Paramètres
// ----------------------------------------------------

var $param : Collection
var $Count; $LastParamNumber : Integer
var $QS_VCS_COMP_DB_PATH : Text

CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684)
ON ERR CALL:C155("BASE_noERROR")

// Need to be updated if a new param is added
$LastParamNumber:=15
$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB

Begin SQL
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	
	SELECT count(*)
	from SETUP
	INTO :[$Count];
	USE DATABASE SQL_INTERNAL;
	
End SQL

If ($count=0)
	// Need to populate initial Setup
	
	Begin SQL
		USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
		
		INSERT INTO SETUP
		(MOD_NAME, MOD_PARAM, MOD_VALUE, MOD_REF)
		VALUES
		('Method Explorer','Not enough comment (>=)','15',1),
		('Method Explorer','A little bit to much comment (>=)','30',2),
		('Method Explorer','Very too much comment level (>=)','50',3),
		('Method Explorer','A little bit to much complex (>=)','15',4),
		('Method Explorer','High level of complexity (>=)','30',5),
		('Method Explorer','Very too much complex (>=)','50',6),
		('Magik Comments','Number of parameters before linefeed','4',7),
		('All','Max test to export a file before exit of the loop','30',8),
		('Analysis and Update','Log Type (1 to 4)','4',9),
		('Version Control System','Check new Method every (in s)','120',10),
		('Magik Comments','list variables name found with the $x (0/1)','1',11),
		('Magik Comments','list variable assignments (0/1)','1',12),
		('4DPop','automatic start analysis (0/1)','0',13),
		('All','Max workers in parallel (<=8)','4',14),
		('All','Execute Callees/Callers during DB Analysis  (0/1)','0',15)
		;
		
		USE DATABASE SQL_INTERNAL;
	End SQL
	
End if 

ARRAY TEXT:C222($QS_SETUP_MODULE; 0x0000)
ARRAY TEXT:C222($QS_SETUP_PARAM; 0x0000)
ARRAY TEXT:C222($QS_SETUP_VALUE; 0x0000)
ARRAY LONGINT:C221($QS_SETUP_REF; 0x0000)

Begin SQL
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	
	SELECT *
	FROM SETUP
	ORDER BY MOD_REF
	INTO :[$QS_SETUP_MODULE], :[$QS_SETUP_PARAM], :[$QS_SETUP_VALUE], :[$QS_SETUP_REF];
	
	USE DATABASE SQL_INTERNAL;
End SQL

$param:=New collection:C1472
ARRAY TO COLLECTION:C1563($param; $QS_SETUP_MODULE; "module"; $QS_SETUP_PARAM; "param"; $QS_SETUP_VALUE; "value"; $QS_SETUP_REF; "ref")

var $blob : Blob
VARIABLE TO BLOB:C532($param; $blob)
EXECUTE ON CLIENT:C651("@"; "QS_PARAM_AFFECTATION"; $blob)  // all

If ($param.length#$LastParamNumber) & ($param.length>0)
	QS_DB_Restore_Param
	$blob:=QST_DB_SetUp
End if 
$0:=$blob

If (Count parameters:C259=1)
	var $1 : Object
	signal_addResult($1; Current method name:C684)
End if 