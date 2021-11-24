//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Méthode : __buildCollectionFromCommand
// Description
// Create the code ready to be paste from a list of 4D command
// 
// ----------------------------------------------------
// Nom utilisateur (OS) : Patrick EMANUEL
// Date et heure : 29/10/19, 06:37:03
// Paramètres


C_TEXT:C284($text; $result)
C_COLLECTION:C1488($temp; $ent; $commands)
$temp:=New collection:C1472
$commands:=Storage:C1525.commands4d

$text:=Get text from pasteboard:C524
C_COLLECTION:C1488($coll)
$coll:=New collection:C1472
//$coll:=Split string($text;"\r";sk ignore empty strings+sk trim spaces)
$coll:=Split string:C1554(Replace string:C233($text; "\t"; ""); "\n"; sk ignore empty strings:K86:1+sk trim spaces:K86:2)

If ($coll.length>0)
	CLEAR VARIABLE:C89($text)  // clear text
	For each ($text; $coll)
		
		If (Position:C15("."; $text)=0)  // Avoid member function
			
			$pos:=Position:C15("("; $text)
			If ($pos>0)
				$text:=Substring:C12($text; 1; $pos)
			End if 
			
			$ent:=$commands.query("EN = :1 or FR = :1"; $text)
			If ($ent.length>0)
				$temp.push($ent[0].id)
			End if 
		End if 
		
	End for each 
	
	$result:=":=new collection ("+$temp.orderBy().join(";")+")"
	SET TEXT TO PASTEBOARD:C523($result)
	ALERT:C41("code text is ready to be pasted.")
End if 