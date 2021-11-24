//%attributes = {"invisible":true}
CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "Saving data -> Start")
var $options : Object
var $blob : Blob
$options:=New object:C1471
$blob:=variables_readyToBeSaved($options)
variables_save($options; $blob)
STO_textToStorage("update"; $option.lastUpdate)
CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "Saving data -> End")