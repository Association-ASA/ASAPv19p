//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // indent_T_CleanupString
  // <TA-2011-09-05/>

C_TEXT:C284($1;$T_text)
C_TEXT:C284($0)

C_LONGINT:C283($i;$L_pos;$L_code)

$0:=""

If (Count parameters:C259>0)
	$T_text:=$1
End if 

If ($T_text#"")
	
	  // strip at begin of string
	$L_pos:=0
	
	For ($i;1;Length:C16($T_text))
		
		$L_code:=Character code:C91($T_text[[$i]])
		
		If (($L_code>31) & ($L_code#0x00A0))
			$L_pos:=$i
			$i:=Length:C16($T_text)
		End if 
		
	End for 
	
	  //
	
	If ($L_pos>0)
		$0:=Substring:C12($T_text;$L_pos)
	End if 
	
	  // strip at end of string
	$L_pos:=0
	
	For ($i;Length:C16($0);1;-1)
		
		$L_code:=Character code:C91($0[[$i]])
		
		If (($L_code>31) & ($L_code#0x00A0))
			$L_pos:=$i
			$i:=0
		End if 
		
	End for 
	
	  //
	$0:=Substring:C12($0;1;$L_pos)
	
End if 

  // --EOF--
