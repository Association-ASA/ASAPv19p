//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // indent_B_LineHasControl
  // <TA-2011-09-05/>

C_TEXT:C284($1;$T_line)
C_POINTER:C301($2;$W_toArray)

C_BOOLEAN:C305($0)

C_TEXT:C284($T_instruction;$T_reminder;$T_nextChar;$T_insecable)
C_LONGINT:C283($i)

If (Is nil pointer:C315($2))
	
	$T_line:=$1
	$W_toArray:=$2
	
	$T_insecable:=Char:C90(0x00A0)
	
	For ($i;1;Size of array:C274($W_toArray->))
		
		$T_instruction:=$W_toArray->{$i}
		
		If (Position:C15($T_instruction;$T_line)=1)
			
			$T_reminder:=Substring:C12($T_line;Length:C16($T_instruction)+1)
			
			If ($T_reminder="")
				
				$0:=True:C214
				
			Else 
				
				$T_nextChar:=$T_reminder[[1]]
				$0:=True:C214
				
				Case of 
						
					: ($T_nextChar="\r")
						
					: ($T_nextChar="\n")
						
					: ($T_nextChar=" ")
						
					: ($T_nextChar=$T_insecable)
						
					Else 
						
						$0:=False:C215
						
				End case 
			End if 
			
			If ($0)
				$i:=Size of array:C274($W_toArray->)
			End if 
			
		End if 
	End for 
End if 