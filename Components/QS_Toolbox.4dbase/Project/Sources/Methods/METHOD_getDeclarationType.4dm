//%attributes = {"invisible":true,"shared":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 11/05/19, 07:51:44
// Paramètres
// ----------------------------------------------------
// $1 : Pointer to the collection
// $2 : Text of the code
// ----------------------------------------------------
// Méthode : METHOD_getDeclarationType
// Description
//

#DECLARE($varDeclare : Collection; $MethText : Text)
var $Coll; $collVariables; $myText : Collection
var $len_l; $pos_l : Integer
var $var_t : Text

$Pattern_array:="(^ARRAY\\s\\w*)\\((.*);"
$Pattern_C:="(^C_\\w*)\\((.*)\\)"
$Pattern_var:="(^var\\s\\w*)(.*)"
$MethText:=Replace string:C233($MethText; "\t"; "")
$collVariables:=New collection:C1472
$Coll:=New collection:C1472
$myText:=Split string:C1554($MethText; "\r")
$start_l:=1

For each ($MethText; $myText)
	
	// ARRAY
	If (Match regex:C1019($Pattern_array; $MethText; 1; $pos_l; $len_l))
		$type:=Substring:C12($MethText; 1; Position:C15("("; $MethText)-1)
		$var_t:=Substring:C12($MethText; Position:C15("("; $MethText)+1)
		$var_t:=Substring:C12($var_t; 1; Position:C15(";"; $var_t)-1)
		$var_t:=ZCapitalizeString($var_t; 3)
		$varDeclare.push(New object:C1471("declare"; $type; "label"; $var_t))
	End if 
	
	// C_
	If (Match regex:C1019($Pattern_C; $MethText; 1; $pos_l; $len_l))
		$Coll.clear()
		$type:=Substring:C12($MethText; 1; Position:C15("("; $MethText)-1)
		$pos:=Position:C15("("; $MethText)+1
		$MethText:=Substring:C12($MethText; $pos; Position:C15(")"; $MethText)-$pos)
		$Coll:=Split string:C1554($MethText; ";")
		For each ($var_t; $Coll)
			$var_t:=ZCapitalizeString($var_t; 3)
			$varDeclare.push(New object:C1471("declare"; $type; "label"; $var_t))
		End for each 
	End if 
	
	// var
	If (Match regex:C1019($Pattern_var; $MethText; 1; $pos_l; $len_l))
		$Coll.clear()
		$MethText:=Substring:C12($MethText; 4)
		$type:=Substring:C12($MethText; Position:C15(":"; $MethText)+2)
		$MethText:=Substring:C12($MethText; 1; Position:C15(":"; $MethText)-1)
		$Coll:=Split string:C1554($MethText; ";"; sk ignore empty strings:K86:1)
		For each ($var_t; $Coll)
			$var_t:=ZCapitalizeString($var_t; 3)
			$varDeclare.push(New object:C1471("declare"; $type; "label"; $var_t))
		End for each 
	End if 
	
	// DECLARE
	If ($MethText="#DECLARE@")
		$Coll.clear()
		$MethText:=Substring:C12($MethText; 9)
		$pos:=Position:C15("->"; $MethText)
		// if a -> is set
		$return:=""
		If ($pos>0)
			$return:=Substring:C12($MethText; $pos+2)  // )->
			$type:=ZCapitalizeString(Substring:C12($return; Position:C15(":"; $return)+1); 3)
			$var_t:=ZCapitalizeString(Substring:C12($return; 1; Position:C15(":"; $return)-1); 3)
			$varDeclare.push(New object:C1471("declare"; $type; "label"; $var_t))
			$MethText:=Substring:C12($MethText; 1; $pos-2)  // In case of no parenthesis 
		End if 
		
		
		//cleaning part
		$pos:=Position:C15("("; $MethText)
		If ($pos>0)
			$MethText:=Substring:C12($MethText; $pos+1)  // Remove the first parenthesis and the last one
		End if 
		$pos:=Position:C15(")"; $MethText)
		If ($pos>0)
			$MethText:=Substring:C12($MethText; 1; $pos-1)  // Remove the last parenthesis and the last one
		End if 
		
		// Work on Declare statement that could be:
		// #DECLARE($Declare; $leSecond : Collection; $MethText : Text)->$result:object
		// #DECLARE($Declare: collection ; $leSecond : Collection; $MethText : Text)->$result:object
		$pos:=Position:C15(":"; $MethText)
		While ($pos>0)
			$variables:=Substring:C12($MethText; 1; $pos-1)
			$nextType:=Substring:C12($MethText; $pos+1)
			$semiColumnPos:=Position:C15(";"; $nextType)
			
			If ($semiColumnPos>0)  // There is another variable to check
				$type:=ZCapitalizeString(Substring:C12($nextType; 1; $semiColumnPos-1); 3)
			Else   // This is the last one
				$type:=ZCapitalizeString($nextType; 3)
			End if 
			$MethText:=Substring:C12($nextType; $semiColumnPos+1)
			$pos:=Position:C15(":"; $MethText)
			
			$Coll:=Split string:C1554($variables; ";"; sk ignore empty strings:K86:1)
			For each ($var_t; $Coll)
				$var_t:=ZCapitalizeString($var_t; 3)
				$varDeclare.push(New object:C1471("declare"; $type; "label"; $var_t))
			End for each 
		End while 
	End if 
	
End for each 