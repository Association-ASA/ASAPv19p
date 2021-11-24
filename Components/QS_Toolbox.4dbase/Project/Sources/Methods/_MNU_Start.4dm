//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
#DECLARE($form : Text)
var $Win : Integer

ON ERR CALL:C155("BASE_noERROR")
BRING TO FRONT:C326(Current process:C322)

$Win:=Open form window:C675($form; Palette form window:K39:9; On the right:K39:3; At the top:K39:5+100)
OB_windowNumberToStorage("mainMenu"; $Win)
DIALOG:C40($form)