//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // indent_L_getIndentLevel(aLine)
  // => 0/positive/negative
  // <TA-2011-09-05/>

  // Modifié par : Association QualiSoft (19/04/2018)
  // Update to add For each

C_TEXT:C284($1;$T_line)
C_LONGINT:C283($0)
ARRAY TEXT:C222($T_indentKWStart__R;0x0000)
ARRAY TEXT:C222($T_indentKWEnd__R;0x0000)
ARRAY TEXT:C222($T_indentKWNeutral__R;0x0000)

INDENT_StartUp (->$T_indentKWStart__R;->$T_indentKWEnd__R;->$T_indentKWNeutral__R)

If (Count parameters:C259>0)
	$T_line:=INDENT_T_CleanupString ($1)
End if 

  //
$0:=0

Case of 
		
	: (INDENT_B_LineHasControl ($T_line;->$T_indentKWStart__R))
		$0:=4
		
	: (INDENT_B_LineHasControl ($T_line;->$T_indentKWEnd__R))
		$0:=-4
		
End case 
