//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
var $lastUpdate : Text

STO_textToStorage("update"; "Initialisation in progress")

var $options : Object
var $blob : Blob
$options:=New object:C1471
$blob:=variables_restore($options)

savingDataRestore($options; $blob)

If (Count parameters:C259=1)
	var $1 : Object
	signal_addResult($1; Current method name:C684)
End if 