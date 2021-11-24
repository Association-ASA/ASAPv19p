//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_TEXT:C284($title)
C_OBJECT:C1216($1)
C_LONGINT:C283($_progress)

$title:=$1.title
$_progress:=Open form window:C675("_progress";Palette form window:K39:9;On the right:K39:3;At the bottom:K39:6)
SET WINDOW TITLE:C213($title;$_progress)
OB_windowNumberToStorage ("progress";$_progress)
DIALOG:C40("_progress";$1;*)
HIDE WINDOW:C436($_progress)
SHOW WINDOW:C435($_progress)