//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// Méthode : METHOD_simplifyCodeText
// ----------------------------------------------------
// Paramètres
//  $1 : pointer (text)
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 07/05/19, 13:14:53
// ----------------------------------------------------
// Description
// Remove all part of code which is
// - a command
// - a konstant
// - a keyword
// - a SQL part except variable (start by ':' sign )
// - collection / member functions
// - a componant command listed into the 4D documentation

C_POINTER:C301($1)
C_TEXT:C284($MethText; $toCheck; $Language)
C_OBJECT:C1216($word)

$MethText:=$1->
$Language:=Config_getLanguage
$pattern_exceptionList:="Storage;Form;ds;File,Folder;cs;4D"

// remove table name used as parameter or pointer
For each ($word; Storage:C1525.structureTable)
	$MethText:=Replace string:C233($MethText; "["+$word.name+"]"; "")
End for each 

// remove all commands used by 4D compnants or Plug-in declared in the documentation
For each ($word; Storage:C1525.componantsMethods)
	$toCheck:=$word.method
	$MethText:=Replace string:C233($MethText; $toCheck; "")
End for each 

// remove all commands & konstants
For each ($word; Storage:C1525.commands4d)
	$toCheck:=$word[$Language]+$word.token
	$MethText:=Replace string:C233($MethText; $toCheck; ";")
End for each 

For each ($word; Storage:C1525.constants)
	$toCheck:=$word[$Language]+$word.token
	$MethText:=Replace string:C233($MethText; $toCheck; ";")
End for each 

//For each ($word;Storage.systemKeywords)
//$MethText:=Replace string($MethText;$word.name;";")
//End for each 

For each ($word; Storage:C1525.allMethods)
	$MethText:=Replace string:C233($MethText; $word.name; ";")
End for each 

$pos:=1  // To enter into the loop
While ($pos>0)
	// remove text between quotes
	$pos:=Position:C15(Char:C90(Double quote:K15:41); $MethText)
	If ($pos>0)
		$pos2:=Position:C15(Char:C90(Double quote:K15:41); $MethText; $pos+1)
		If ($pos2>0)
			$MethText:=Substring:C12($MethText; 1; $pos-1)+Substring:C12($MethText; $pos2+1)
		Else 
			$MethText:=Substring:C12($MethText; 1; $pos-1)
		End if 
	End if 
End while 

$MethText:=Replace string:C233($MethText; "End if"; "")
$MethText:=Replace string:C233($MethText; "Fin de si"; "")
$MethText:=Replace string:C233($MethText; "if ("; "(")
$MethText:=Replace string:C233($MethText; "si ("; "(")
$MethText:=Replace string:C233($MethText; "else"; "")
$MethText:=Replace string:C233($MethText; "End case"; "")
$MethText:=Replace string:C233($MethText; "Fin de cas"; "")
$MethText:=Replace string:C233($MethText; "case of"; "")
$MethText:=Replace string:C233($MethText; "au cas ou"; "")
$MethText:=Replace string:C233($MethText; "End for each"; "")
$MethText:=Replace string:C233($MethText; "End for"; "")
$MethText:=Replace string:C233($MethText; "for each"; "")
$MethText:=Replace string:C233($MethText; "Pour chaque"; "")
$MethText:=Replace string:C233($MethText; "Fin de boucle"; "")
$MethText:=Replace string:C233($MethText; "Début SQL("; "")
$MethText:=Replace string:C233($MethText; "Begin SQL"; "")
$MethText:=Replace string:C233($MethText; "Fin SQL("; "")
$MethText:=Replace string:C233($MethText; "End SQL"; "")
$MethText:=Replace string:C233($MethText; "For ("; ";(")
$MethText:=Replace string:C233($MethText; "boucle "; "")
$MethText:=Replace string:C233($MethText; "end while"; "")
$MethText:=Replace string:C233($MethText; "while"; "")
$MethText:=Replace string:C233($MethText; "fin tant que"; "")
$MethText:=Replace string:C233($MethText; "tant que"; "")
$MethText:=Replace string:C233($MethText; "repeat"; "")
$MethText:=Replace string:C233($MethText; "until "; "")
$MethText:=Replace string:C233($MethText; "Repeter"; "")
$MethText:=Replace string:C233($MethText; "Jusque "; "")
$MethText:=Replace string:C233($MethText; "OK="; "")

$MethText:=Replace string:C233($MethText; "[["; "")
$MethText:=Replace string:C233($MethText; "]]"; "")
$MethText:=Replace string:C233($MethText; "/t"; "")
$MethText:=Replace string:C233($MethText; "/r"; "")
$MethText:=Replace string:C233($MethText; "/n"; "")
$MethText:=Replace string:C233($MethText; "\r"; "")
$MethText:=Replace string:C233($MethText; "\n"; "")
$MethText:=Replace string:C233($MethText; "\t"; "")

// Remove all keywords for Collection
$MethText:=Replace string:C233($MethText; ".length"; "(")
$MethText:=Replace string:C233($MethText; ".average("; "(")  // common with EntitySelection
$MethText:=Replace string:C233($MethText; ".clear("; "")
$MethText:=Replace string:C233($MethText; ".combine("; "(")
$MethText:=Replace string:C233($MethText; ".concat("; "(")
$MethText:=Replace string:C233($MethText; ".copy("; "(")
$MethText:=Replace string:C233($MethText; ".countValues("; "(")
$MethText:=Replace string:C233($MethText; ".count("; "(")  // common with EntitySelection
$MethText:=Replace string:C233($MethText; ".distinct("; "(")  // common with entitySelection
$MethText:=Replace string:C233($MethText; ".equal("; "(")
$MethText:=Replace string:C233($MethText; ".every("; "(")
$MethText:=Replace string:C233($MethText; ".extract("; "(")  // common with 
$MethText:=Replace string:C233($MethText; ".fill("; "(")
$MethText:=Replace string:C233($MethText; ".filter("; "(")
$MethText:=Replace string:C233($MethText; ".find("; "(")
$MethText:=Replace string:C233($MethText; ".findIndex("; "(")
$MethText:=Replace string:C233($MethText; ".IndexOf("; "(")  // common with Entity
$MethText:=Replace string:C233($MethText; ".lastIndexOf("; "(")
$MethText:=Replace string:C233($MethText; ".indices("; "(")
$MethText:=Replace string:C233($MethText; ".insert("; "(")
$MethText:=Replace string:C233($MethText; ".join("; "(")
$MethText:=Replace string:C233($MethText; ".map("; "(")
$MethText:=Replace string:C233($MethText; ".max("; "(")  // Common with EntitySelection
$MethText:=Replace string:C233($MethText; ".min("; "(")  // Common with EntitySelection
$MethText:=Replace string:C233($MethText; ".orderBy("; "(")  // Common with EntitySelection
$MethText:=Replace string:C233($MethText; ".orderByMethod("; "(")
$MethText:=Replace string:C233($MethText; ".pop("; "(")
$MethText:=Replace string:C233($MethText; ".push("; "(")
$MethText:=Replace string:C233($MethText; ".query("; "(")  // Common with EntitySelection & DataClass
$MethText:=Replace string:C233($MethText; ".reduce("; "(")
$MethText:=Replace string:C233($MethText; ".remove("; "(")
$MethText:=Replace string:C233($MethText; ".resize("; "(")
$MethText:=Replace string:C233($MethText; ".reverse("; "(")
$MethText:=Replace string:C233($MethText; ".shift("; "(")
$MethText:=Replace string:C233($MethText; ".slice("; "(")  // Common with EntitySelection
$MethText:=Replace string:C233($MethText; ".some("; "(")  // Common with EntitySelection
$MethText:=Replace string:C233($MethText; ".sort("; "(")
$MethText:=Replace string:C233($MethText; ".sum("; "(")
$MethText:=Replace string:C233($MethText; ".unshift("; "(")

// Remove all keywords for DataStore
$MethText:=Replace string:C233($MethText; "ds.encryptionStatus("; "")
$MethText:=Replace string:C233($MethText; "ds.getInfo("; "")
$MethText:=Replace string:C233($MethText; "ds.provideDataKey("; "")

// Remove all keywords for Entity
$MethText:=Replace string:C233($MethText; ".clone("; "(")
$MethText:=Replace string:C233($MethText; ".diff("; "(")
$MethText:=Replace string:C233($MethText; ".drop("; "(")  // Common with EntitySelection
$MethText:=Replace string:C233($MethText; ".first("; "(")  // Common with EntitySelection
$MethText:=Replace string:C233($MethText; ".fromObject("; "(")
$MethText:=Replace string:C233($MethText; ".getKey("; "(")
$MethText:=Replace string:C233($MethText; ".getDataClass("; "(")  // Common with EntitySelection
$MethText:=Replace string:C233($MethText; ".getSelection("; "(")
$MethText:=Replace string:C233($MethText; ".getStamp("; "(")
$MethText:=Replace string:C233($MethText; ".isNew("; "(")
$MethText:=Replace string:C233($MethText; ".last("; "(")  // Common with EntitySelection
$MethText:=Replace string:C233($MethText; ".lock("; "(")
$MethText:=Replace string:C233($MethText; ".next("; "(")
$MethText:=Replace string:C233($MethText; ".previous("; "(")
$MethText:=Replace string:C233($MethText; ".reload("; "(")
$MethText:=Replace string:C233($MethText; ".save("; "(")
$MethText:=Replace string:C233($MethText; ".toObject("; "(")
$MethText:=Replace string:C233($MethText; ".touchedAttributes("; "(")
$MethText:=Replace string:C233($MethText; ".touched("; "(")
$MethText:=Replace string:C233($MethText; ".unlock("; "(")

// Remove all keywords for EntitySelection
$MethText:=Replace string:C233($MethText; ".add("; "(")
$MethText:=Replace string:C233($MethText; ".and("; "(")
$MethText:=Replace string:C233($MethText; ".contains("; "(")
$MethText:=Replace string:C233($MethText; ".isAlterable("; "(")
$MethText:=Replace string:C233($MethText; ".isOrdered("; "(")
$MethText:=Replace string:C233($MethText; ".refresh("; "(")
$MethText:=Replace string:C233($MethText; ".minus("; "(")
$MethText:=Replace string:C233($MethText; ".or("; "(")
$MethText:=Replace string:C233($MethText; ".toSelection("; "(")

// Remove all keyword for DataStore
$MethText:=Replace string:C233($MethText; ".cancelTransaction("; "(")
$MethText:=Replace string:C233($MethText; ".encryptionStatus("; "(")
$MethText:=Replace string:C233($MethText; ".getInfo("; "(")
$MethText:=Replace string:C233($MethText; ".getRequestLog("; "(")
$MethText:=Replace string:C233($MethText; ".makeSelectionsAlterable("; "(")
$MethText:=Replace string:C233($MethText; ".provideDataKey("; "(")
$MethText:=Replace string:C233($MethText; ".startRequestLog("; "(")
$MethText:=Replace string:C233($MethText; ".startTransaction("; "(")
$MethText:=Replace string:C233($MethText; ".stopRequestLog("; "(")
$MethText:=Replace string:C233($MethText; ".validateTransaction("; "(")


// Remove all keyword for DataClass
$MethText:=Replace string:C233($MethText; ".all("; "(")
$MethText:=Replace string:C233($MethText; ".fromCollection("; "(")
$MethText:=Replace string:C233($MethText; ".get("; "(")
$MethText:=Replace string:C233($MethText; ".getDataStore("; "(")
$MethText:=Replace string:C233($MethText; ".getInfo("; "(")
$MethText:=Replace string:C233($MethText; ".new("; "(")
$MethText:=Replace string:C233($MethText; ".newSelection("; "(")

// Remove all keyword for DataClassAttribute
$MethText:=Replace string:C233($MethText; ".autoFilled"; "")
$MethText:=Replace string:C233($MethText; ".fieldNumber"; "")
$MethText:=Replace string:C233($MethText; ".fieldType"; "")
$MethText:=Replace string:C233($MethText; ".indexed"; "")
$MethText:=Replace string:C233($MethText; ".inverseName"; "")
$MethText:=Replace string:C233($MethText; ".keyWordIndexed"; "")
$MethText:=Replace string:C233($MethText; ".kind"; "")
$MethText:=Replace string:C233($MethText; ".mandatory"; "")
$MethText:=Replace string:C233($MethText; ".name"; "")
$MethText:=Replace string:C233($MethText; ".relatedDataClass"; "")
$MethText:=Replace string:C233($MethText; ".type"; "")
$MethText:=Replace string:C233($MethText; ".unique"; "")

// Now, it should stay only variables, signs and bracket, parenthesis....
$1->:=$MethText
