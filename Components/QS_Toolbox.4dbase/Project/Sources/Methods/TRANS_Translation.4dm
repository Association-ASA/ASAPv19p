//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 04/03/19, 15:39:55
// ----------------------------------------------------
// Méthode : TRANS_Translation
// ----------------------------------------------------
// $0 : Code  translated
// $1 : Code to translate
// ----------------------------------------------------
// Description
// Translate a method from 1 language to another one
// Currently, use only EN & FR, but could be developed to use more languages

#DECLARE($code_t : Text)->$out_t : Text

var $code_t; $commentFrom_t; $from_t; $to_t : Text
var $collCommands; $colLines : Collection
var $txtIndent; $txtLine : Text
var $length; $pos : Integer
var $hasIndent : Boolean

$from_t:=Form:C1466.mySelectFrom
$to_t:=Form:C1466.mySelectTo
(OBJECT Get pointer:C1124(Object named:K67:5; "codeTo"))->:=""

$colLines:=New collection:C1472
$colLines:=Split string:C1554($code_t; Char:C90(13))  // create a code-lines-collection from my method-text
$code_t:=""
For each ($txtLine; $colLines)
	$hasIndent:=Match regex:C1019("^\\t+"; $txtLine; 1; $pos; $length)
	If ($hasIndent)
		$txtIndent:="\t"*$length
	Else 
		$txtIndent:=""
	End if 
	$code_t:=$code_t+$txtIndent+Parse formula:C1576($txtLine; Formula out with tokens:K88:3)+Char:C90(13)
End for each 
$isToken:=Bool:C1537(Position:C15(":C"; $code_t)>0)

If (Position:C15("//%attributes ="; $code_t)>0)
	$code_t:=Substring:C12($code_t; Position:C15("\r"; $code_t)+1)
End if 

If (Match regex:C1019("11"; $from_t; 1))
	$commentFrom_t:="`"  // 0x0060 // Very old method
Else   // v12 or 13
	$commentFrom_t:="//"  // 0x005C 0x005C
End if 

// *** SET ARRAYS FOR CONVERSION ***
var $ent : Object
ARRAY TEXT:C222($fromCommands; Form:C1466.command.length+1)
ARRAY TEXT:C222($fromKonstants; Form:C1466.konstante.length+1)
ARRAY TEXT:C222($toCommands; Form:C1466.command.length+1)
ARRAY TEXT:C222($toKonstants; Form:C1466.konstante.length+1)
ARRAY TEXT:C222($fromKeywords; Form:C1466.keyword.length+1)
ARRAY TEXT:C222($toKeywords; Form:C1466.keyword.length+1)

$a:=0
$collCommands:=Form:C1466.command.orderBy("name desc")
For each ($ent; $collCommands)
	$a:=$a+1
	$fromCommands{$a}:=$ent[Uppercase:C13($from_t)]+Choose:C955($isToken=True:C214; $ent.token; "")
	$toCommands{$a}:=$ent[Uppercase:C13($to_t)]+Choose:C955($isToken=True:C214; $ent.token; "")
End for each 

$a:=0
For each ($ent; Form:C1466.konstante)
	$a:=$a+1
	If (Position:C15(":"; $ent.token; 2)>1)
		$fromKonstants{$a}:=$ent[Uppercase:C13($from_t)]+Choose:C955($isToken=True:C214; $ent.token; "")
		$toKonstants{$a}:=$ent[Uppercase:C13($to_t)]+Choose:C955($isToken=True:C214; $ent.token; "")
	End if 
End for each 

COLLECTION TO ARRAY:C1562(Form:C1466.keyword; $fromKeywords; Uppercase:C13($from_t); $toKeywords; Uppercase:C13($to_t))
SORT ARRAY:C229($fromCommands; $toCommands; <)
SORT ARRAY:C229($fromKonstants; $toKonstants; <)
SORT ARRAY:C229($fromKeywords; $toKeywords; <)

var $line : Collection
$line:=Split string:C1554($code_t; "\r"; sk ignore empty strings:K86:1+sk trim spaces:K86:2)
$out_t:=$line.join("\r")

// Replace Commands
For ($a; 1; Size of array:C274($fromCommands))
	$out_t:=Replace string:C233($out_t; $fromCommands{$a}; $toCommands{$a}; *)
End for 

// Replace Konstants
For ($a; 1; Size of array:C274($fromKonstants))
	$out_t:=Replace string:C233($out_t; $fromKonstants{$a}; $toKonstants{$a}; *)
End for 

var $controlFlow_c : Collection
$controlFlow_c:=MM_controlFlows

For each ($controlFlow_o; $controlFlow_c)
	$chercher_t:=$controlFlow_o[$from_t]
	$remplacer_t:=$controlFlow_o[$to_t]
	$out_t:=Replace string:C233($out_t; $chercher_t; $remplacer_t; *)
End for each 

$FenetreInformation:="Translation finished. Check result before using it."
displayInfo($FenetreInformation)