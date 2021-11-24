//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_OBJECT:C1216($param)
C_TEXT:C284($1)
$param:=New object:C1471("language";$1)

$_UIG:=Open form window:C675("_userGuide";Palette form window:K39:9;On the right:K39:3;At the bottom:K39:6)
DIALOG:C40("_userGuide";$param;*)
HIDE WINDOW:C436($_UIG)
SHOW WINDOW:C435($_UIG)