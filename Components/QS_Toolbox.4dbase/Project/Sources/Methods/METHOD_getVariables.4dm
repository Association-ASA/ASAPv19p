//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 09/05/19, 18:49:54
  // Paramètres
  // ----------------------------------------------------
  // $1 : Pointer to the collection
  // $2 : Text of the code
  // ----------------------------------------------------
  // Méthode : METHOD_getVariables
  // Description
  // 

ASSERT:C1129(Count parameters:C259=2;Current method name:C684+" expect 2 parameters (Collection & Text)")
  //ASSERT(Type($1)=Is collection;"First parameter must be a collection")
  //ASSERT(Type($2)=Is text;"Second parameter must be a text")

C_COLLECTION:C1488($collVariables;$uniqueVariables;$collTemp;$Coll)
C_COLLECTION:C1488($variablesCollection)
ARRAY TEXT:C222($tableau2D;0x0000;0x0000)
ARRAY TEXT:C222($OldVariables;0x0000)
C_TEXT:C284($MethText)

$Coll:=New collection:C1472
$collVariables:=New collection:C1472
$uniqueVariables:=New collection:C1472
$collTemp:=New collection:C1472

$variablesCollection:=$1
$MethText:=$2

  // *** Patterns
  //$PatternVariables:="(?mi-s)[\\W]?([<>|\\$]?[a-zA-Z0-9_.]*\\b)[\\W]?"
  //$PatternVariables:="([\\W]?([<]?[>|\\$]?[a-zA-Z0-9_.]*\\b)[\\W]?"
$PatternVariables:="(\\$\\w+|\\<\\>\\w+)*"

$pattern_delimitors:="({[≤<:=-+#*/\\%&|^?;!§†>≥]})"+Char:C90(Space:K15:42)+Char:C90(44)  // :
$pattern_otherDelimitors:="≤<>≥:=-+#*/\\%&|^?;!§†"
$start_delimitors:="({[\""
$end_delimitors:=")}]\""

$MethText:=Replace string:C233($MethText;"->";"")  // Remove all pointer references
  // The method is now "clean"
  // ------------------------

CLEAR VARIABLE:C89($tableau2D)
$regexMotif:="\"\\w+\""
$erreur:=REGEX_SubstituteText ($regexMotif;"\\1";->$MethText)

$x:=REGEX_ExtractText ($PatternVariables;$MethText;"1 2";->$tableau2D;0)

For ($a;1;Size of array:C274($tableau2D))
	
	Case of 
		: ($tableau2D{$a}{1}#"")
			If (Substring:C12($tableau2D{$a}{1};1;1)#".")
				APPEND TO ARRAY:C911($OldVariables;$tableau2D{$a}{1})
			End if 
			
		: ($tableau2D{$a}{2}#"")
			If (Substring:C12($tableau2D{$a}{2};1;1)#".")
				APPEND TO ARRAY:C911($OldVariables;$tableau2D{$a}{2})
			End if 
	End case 
	
End for 

ARRAY TO COLLECTION:C1563($collVariables;$OldVariables)
$collTemp:=$collVariables.distinct()

For each ($xcoll;$collTemp)
	
	  // Start delimitors
	For ($a;1;Length:C16($start_delimitors))
		$pos:=Position:C15($start_delimitors[[$a]];$xcoll)
		If ($pos>0)
			$collTemp.push(Substring:C12($xcoll;$pos+1))  // It could be another variable
			$xcoll:=Substring:C12($xcoll;1;$pos-1)
		End if 
		
		  // End delimitors
		$pos:=Position:C15($end_delimitors[[$a]];$xcoll)
		If ($pos>0)
			$xcoll:=Substring:C12($xcoll;1;$pos-1)
		End if 
	End for 
	
	  // Other delimitors
	For ($a;1;Length:C16($pattern_otherDelimitors))
		$pos:=Position:C15($pattern_otherDelimitors[[$a]];$xcoll)
		If ($pos>0)
			Case of   //
				: ($xcoll[[$pos]]=":")
					If ($xcoll[[$pos+1]]="=")
						$collTemp.push(Substring:C12($xcoll;$pos+2))  // It could be another variable
					End if 
					
				: ($xcoll[[$pos]]="\"")
					If ($xcoll[[$pos+1]]="\"")
						$collTemp.push(Substring:C12($xcoll;$pos+2))  // It could be another variable
					End if 
					
				: ($xcoll[[$pos]]="<")
					If ($xcoll[[$pos+1]]=">")
						$collTemp.push(Substring:C12($xcoll;$pos))  // It could be another variable
					End if 
					
			End case 
			$xcoll:=Substring:C12($xcoll;1;$pos-1)
		End if 
	End for 
End for each 

  // A collection of potential candidate is filled.
  // Check inside if some exceptions exist
For each ($xcoll;$collTemp)
	
	$pos:=Position:C15("{";$xcoll)
	If ($pos>0)
		$xcoll:=Substring:C12($xcoll;1;$pos-1)
		$collTemp.push(Substring:C12($xcoll;$pos+1))
	End if 
	
	$pos:=Position:C15("}";$xcoll)
	If ($pos>0)
		$xcoll:=Substring:C12($xcoll;1;$pos-1)
	End if 
	
	$pos:=Position:C15("(";$xcoll)
	If ($pos>0)
		$xcoll:=Substring:C12($xcoll;1;$pos-1)
		$collTemp.push(Substring:C12($xcoll;$pos+1))
	End if 
	
	$pos:=Position:C15(")";$xcoll)
	If ($pos>0)
		$xcoll:=Substring:C12($xcoll;1;$pos-1)
	End if 
	
	  // Pointer sign
	$pos:=Position:C15("->";$xcoll)
	Case of 
		: ($pos=1)
			$xcoll:=Substring:C12($xcoll;$pos+2)
		: ($pos=(Length:C16($xcoll)-1)) & ($pos>0)
			$xcoll:=Substring:C12($xcoll;1;$pos-1)
	End case 
	
	If (Position:C15(".";$xcoll)>0)
		$xcoll:=Substring:C12($xcoll;1;Position:C15(".";$xcoll)-1)
	End if 
	
	If ($xcoll#"")  // There is still have something to check
		Case of   // Exclusion cases
			: ($xcoll[[1]]=Char:C90(Quote:K15:44)) | ($xcoll[[1]]=">") | ($xcoll[[1]]=Char:C90(Double quote:K15:41)) & ($xcoll[[Length:C16($xcoll)]]=Char:C90(Quote:K15:44)) | ($xcoll[[Length:C16($xcoll)]]=Char:C90(Double quote:K15:41))
			: (Length:C16($xcoll)<2)
			: (String:C10(Num:C11($xcoll))=$xcoll)
			: (Position:C15(Char:C90(Space:K15:42);$xcoll)>0)
			: (Substring:C12($xcoll;1;2)="0x")
			: ($xcoll="OK=@")
			: (Substring:C12($xcoll;1;1)=">") & (((Num:C11(Substring:C12($xcoll;2;Length:C16($xcoll))))-(Num:C11(Substring:C12($xcoll;2;Length:C16($xcoll)))))=0)
				
			Else   // May be it is a Variable
				$variablesCollection.push($xcoll)  // No typed yet, may be later
		End case 
	End if 
	
End for each 

$temp:=$variablesCollection.distinct()

$variablesCollection.clear()
For each ($t;$temp)
	$variablesCollection.push(New object:C1471("variable";$t;"declaration";"Not declared"))
End for each 


