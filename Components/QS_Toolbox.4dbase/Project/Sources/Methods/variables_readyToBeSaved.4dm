//%attributes = {"invisible":true}
#DECLARE($options : Object)->$blob : Blob

var $commands; $data : Collection
var $calleesCallers : Boolean
var $index : Object
var $lastUpdate : Text

$options:=$1
SET BLOB SIZE:C606($blob; 0)

$lastUpdate:="last update:\n"+String:C10(Current date:C33)+" @ "+String:C10(Current time:C178)
$data:=Storage:C1525.allMethods.copy()
$commands:=Storage:C1525.commands4d
$calleesCallers:=Storage:C1525.QS_TBX_SHARED_DATA.calleesCallersDone
$index:=Storage:C1525.index

VARIABLE TO BLOB:C532($lastUpdate; $blob; *)
VARIABLE TO BLOB:C532($data; $blob; *)
VARIABLE TO BLOB:C532($commands; $blob; *)
VARIABLE TO BLOB:C532($calleesCallers; $blob; *)
VARIABLE TO BLOB:C532($index; $blob; *)

$options.curentDate:=Current date:C33
$options.path:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB
$options.dbName:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName
$options.lastUpdate:=$lastUpdate
