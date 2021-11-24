//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 16/05/18, 20:49:52
  // ----------------------------------------------------
  // Paramètres
  // $1 = (TEXT) - String of data
  // $0 = (TEXT) - HEX DUMP String
  // ----------------------------------------------------
  // Méthode : HEXDUMP
  // Description: Method will take in a string and extract it as a HEX DUMP string
  // --------------------------------------------------------------------------------
  // http://kb.4d.com/assetid=77981


C_TEXT:C284($1;$str;$strHexAddr;$strChr;$strAChar;$strHexDump;$CR;$LF)
C_TEXT:C284($0;$output)
C_LONGINT:C283($hexCnt;$bytesCnt;$charCode;$i;$j)


If (Count parameters:C259=1)
	
	$str:=$1
	
	$hexCnt:=0
	$bytesCnt:=0
	$strHexAddr:=""
	$strChr:=""
	$strAChar:=""
	$strHexDump:=""
	$CR:=Char:C90(Carriage return:K15:38)
	$LF:=Char:C90(Line feed:K15:40)
	
	For ($i;1;Length:C16($str))
		If ($hexCnt=0)
			$hexCnt:=1
			$strHexAddr:=Substring:C12(String:C10($i-1;"&$00000000");2)+" "
		End if 
		
		$charCode:=Character code:C91($str[[$i]])
		$strChr:=$strChr+Substring:C12(String:C10(Character code:C91($str[[$i]]);"&$");2)+" "
		
		If (($charCode>32) & ($charCode<127))
			$strAChar:=$strAChar+$str[[$i]]
		Else 
			$strAChar:=$strAChar+"."
		End if 
		
		$bytesCnt:=$bytesCnt+1
		
		If ($bytesCnt=16)
			$hexCnt:=0
			$bytesCnt:=0
			$strHexDump:=$strHexDump+$strHexAddr+" "+$strChr+" "+$strAChar+$CR+$LF
			$strHexAddr:=""
			$strChr:=""
			$strAChar:=""
		End if 
		
		If ($i=Length:C16($str))
			For ($j;$bytesCnt+1;16)
				$strChr:=$strChr+"00"+" "
				$strAChar:=$strAChar+"."
			End for 
			
			$strHexDump:=$strHexDump+$strHexAddr+" "+$strChr+" "+$strAChar+$CR+$LF
		End if 
		
	End for 
	
	$output:="Offset(h) 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F"+$CR+$LF
	$output:=$output+"=========================================================="+$CR+$LF
	$0:=$output+$strHexDump
	
End if 