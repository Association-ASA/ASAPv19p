//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 16/06/18, 09:58:24
  // ----------------------------------------------------
  // Paramètres
  // $1 = Pointer to text variable which contains code
  // ----------------------------------------------------
  // Méthode : METHOD_GetCleanCode
  // Description
  //  

C_POINTER:C301($1)
C_TEXT:C284($lineCode;$code)
C_COLLECTION:C1488($Collect;$newCode)
C_BOOLEAN:C305($keep)
$newCode:=New collection:C1472

$code:=$1->

  // Beginning of cleaning
$Collect:=Split string:C1554(Replace string:C233($code;"\t";"");"\r";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
$Collect.shift()  // Remove the first line

$level:=0
If ($Collect.length>0)  // Some code still exists
	$keep:=True:C214
	$count:=0
	
	For each ($text;$Collect)
		$posStart:=Position:C15("/*";$text)
		$posEnd:=Position:C15("*/";$text)
		
		Case of 
			: ($posStart=1)
				$keep:=False:C215
				$text:=""
				$level:=$level+1
				
			: ($posStart>1) & ($posEnd=0)
				$text:=Substring:C12($text;1;$posStart-1)
				$newCode.push($text)
				$keep:=False:C215
				$level:=$level+1
				
			: ($posEnd=1)
				$level:=$level-1
				$text:=""
				
			: ($posStart=0) & ($posEnd>1)
				$text:=Substring:C12($text;$posEnd+2)
				$newCode.push($text)
				$level:=$level-1
				
			: ($posStart>1) & ($posEnd>1) & ($posEnd>$posStart)
				$fullText:=$text
				$text:=Substring:C12($text;1;$posStart-1)+" "+Substring:C12($fullText;$posEnd+2)
				
		End case 
		
		If ($level=0)
			$keep:=True:C214
		End if 
		
		If ($keep=False:C215)
			$text:=""
			$count:=$count+1
		End if 
		
		$newCode.push($text)
		
	End for each 
End if 

  //$Collect.clear()  // Will be used for the second part
  //For each ($lineCode;$newCode)
  //$keep:=True

  //Case of 
  //: ($lineCode="//@")  // full comment line
  //$keep:=False

  //Else 
  //$pos:=Position("//";$lineCode)
  //If ($pos>0)  // is a comment at the end of line Manage other things that http://
  //  //$lineCode:=Substring($lineCode;1;$pos-1)
  //$lineCode:=Substring($lineCode;1;Position("//";$lineCode)-1)

  //End if 
  //End case 

  //  //If (Position("//";$lineCode)>1)  // is a comment at the end of line Manage other things that http://
  //  //$lineCode:=Substring($lineCode;1;Position("//";$lineCode)-1)
  //  //End if 

  //If ($keep=True)
  //$Collect.push($lineCode)
  //End if 

  //End for each 

  // Just remove inapropriate spaces or empty lines
$1->:=$newCode.join("\r";ck ignore null or empty:K85:5)  // Add $Collect to the end of $AllCodeLines
$0:=$count