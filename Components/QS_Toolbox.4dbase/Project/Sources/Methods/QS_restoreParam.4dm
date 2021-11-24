//%attributes = {"invisible":true}
var $blob : Blob
var $c : Collection
$c:=New collection:C1472
QS_DB_Restore_Param
$blob:=QST_DB_SetUp
BLOB TO VARIABLE:C533($blob; $c)
Form:C1466.setup:=$c.copy()
Form:C1466.stup:=Form:C1466.setup
