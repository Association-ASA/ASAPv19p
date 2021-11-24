//%attributes = {"invisible":true,"preemptive":"capable"}
// emoji
// Parameters:
// $1: string
// ----------------------------------------------------
// Description:
// 
// ----------------------------------------------------
//

//Emoji method
//Emoji Char := Emoji (Unicode Code Point in Hex)
//Ex : ALERT("Don't do that "+Emoji("270B")+" if you care!")

C_REAL:C285($real; $valueR)
C_LONGINT:C283($l; $i; $long; $sign)

$unicode:=$1

$unicode:=Replace string:C233($unicode; "U+"; "")
$char:=""
If (Length:C16($unicode)>2)
	
	//Converts a Hex string into a real one
	$valueR:=0
	$l:=Length:C16($unicode)
	If ($l>0)
		$unicode:=Uppercase:C13($unicode)
		$digit:=0
		$sign:=1
		For ($i; 1; $l)
			$asc:=Character code:C91($unicode[[$i]])
			$good:=True:C214
			If (($asc>47) & ($asc<58))
				$digit:=$asc-48
			Else 
				If (($asc>64) & ($asc<71))
					$digit:=$asc-55
				Else 
					$good:=False:C215
				End if 
			End if 
			If (($l=8) & ($i=1))  //uLong8  -> Have to test the sign bit
				If ($digit>7)
					$sign:=-1
					$digit:=$digit-8
				End if 
			End if 
			If ($good)
				$real:=($digit*(16^($l-$i)))
				$valueR:=$valueR+$real
			End if 
		End for 
		If ($sign=-1)
			$valueR:=($valueR-MAXLONG:K35:2-1)
		End if 
	End if 
	
	$char:=""
	Case of 
		: (($valueR>0) & ($valueR<=55295))  //U+0000 to U+D7FF
			$char:=Char:C90($valueR)
			
		: (($valueR>=55296) & ($valueR<=57343))  //U+D800 to U+DFFF
			//No encoding
			
		: (($valueR>=57344) & ($valueR<=65535))  //U+E000 to U+FFFF
			$char:=Char:C90($valueR)
			
		: (($valueR>=65536) & ($valueR<=1114111))  //U+10000 to U+10FFFF
			$valueR:=$valueR-0x00010000  //because this is the way it works...
			$high:=($valueR >> 10)+0xD800  //top 10 bits for for the high char + 0xD800
			$low:=($valueR & 0x03FF)+0xDC00  //56320 or 0xDC00 or 1101 1100 0000 0000 for the low char
			$char:=Char:C90($high)+Char:C90($low)
			
		Else   //No encoding
			
	End case 
End if 
$0:=$char