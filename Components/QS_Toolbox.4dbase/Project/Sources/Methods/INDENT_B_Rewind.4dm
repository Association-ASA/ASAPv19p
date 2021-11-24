//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // indent_B_NeedTempRewind
  // <TA-2011-09-05/>

C_BOOLEAN:C305($0)
C_TEXT:C284($1;$T_line;$langage)  // the line is supposed to be cleaned up
ARRAY TEXT:C222($T_indentKWNeutral__R;2)

$langage:=Config_getLanguage 
$T_indentKWNeutral__R{1}:=Choose:C955($langage="fr";"Sinon";"Else")
$T_indentKWNeutral__R{2}:=":"

If (Count parameters:C259>0)
	$T_line:=$1
End if 

$0:=INDENT_B_LineHasControl ($T_line;->$T_indentKWNeutral__R)