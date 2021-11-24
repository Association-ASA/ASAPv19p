//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // indent_T_DoIndent
  // <TA-2011-09-05/>

C_TEXT:C284($T_rawCode;$T_DestCode)
C_TEXT:C284($0;$1)
C_TEXT:C284($T_line;$T_Space;$T_EndLine)
C_LONGINT:C283($i;$L_indentLevel;$L_nextIndentLevel;$L_indentLevelUpdate)
ARRAY TEXT:C222($rT_lines;0x0000)
C_COLLECTION:C1488($Coll)

If (Count parameters:C259>0)
	$T_rawCode:=$1
End if 

$T_rawCode:=Replace string:C233($T_rawCode;"\r\n";"\r")
$T_rawCode:=Replace string:C233($T_rawCode;"\n";"\r")
$Coll:=Split string:C1554($T_rawCode;"\r")
COLLECTION TO ARRAY:C1562($Coll;$rT_lines)

$T_DestCode:=""
$L_indentLevel:=0
$L_nextIndentLevel:=0

$T_Space:=Choose:C955(Count parameters:C259=2;"&nbsp;";" ")
$T_EndLine:=Choose:C955(Count parameters:C259=2;"<br/>";"\r")

For ($i;1;Size of array:C274($rT_lines))
	
	$T_line:=$rT_lines{$i}
	$L_indentLevelUpdate:=0
	
	If (INDENT_B_Rewind ($T_line))
		
		If ($L_indentLevel>=4)
			$L_indentLevel:=$L_indentLevel-4
			$L_indentLevelUpdate:=4
		End if 
		
	End if 
	
	$L_nextIndentLevel:=INDENT_L_GetNextIndentLevel ($T_line)
	
	If ($L_nextIndentLevel<0)
		$L_indentLevel:=$L_indentLevel+$L_nextIndentLevel
		
		If ($L_indentLevel<0)
			$L_indentLevel:=0
		End if 
		
	End if 
	
	$T_DestCode:=$T_DestCode+($L_indentLevel*$T_Space)+$T_line+$T_EndLine
	
	If ($L_nextIndentLevel>0)
		$L_indentLevel:=$L_indentLevel+$L_nextIndentLevel
	End if 
	
	$L_indentLevel:=$L_indentLevel+$L_indentLevelUpdate
	
End for 

$0:=$T_DestCode