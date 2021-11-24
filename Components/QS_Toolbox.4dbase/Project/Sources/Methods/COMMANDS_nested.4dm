//%attributes = {"invisible":true,"preemptive":"capable","publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // First part: get the code and clean it

C_OBJECT:C1216($ent)
C_REAL:C285($pas)
C_BOOLEAN:C305($1)
C_COLLECTION:C1488($data)
$data:=Storage:C1525.allMethods

$AllCodeLinesText:=Uppercase:C13($data.extract("clearCode").join("\r"))

  // Nested Part
ARRAY TEXT:C222($Keyword;0x0000)
C_BOOLEAN:C305($find)
  //C_LONGINT($Start;$end;$window)

  //Get all words, set them in uppercase and sort the result.
GET TEXT KEYWORDS:C1141($AllCodeLinesText;$Keyword)  // We want all occurences of each terms
SORT ARRAY:C229($Keyword;>)

  // Use Find in sorted array to count
  //$i:=0
  //$pas:=100/$data.length
  //$step:=0
  //$window:=Storage.windows.mainMenu

For each ($ent;$data)
	  //$step:=$step+$pas
	  //$i:=$i+1
	  //If (Mod($i;25)=0)
	  //  //CALL FORM($window;"CF_myProgress";$step;$1)
	  //PROCESS_sleep 
	  //End if 
	
	$toBeFound:=Uppercase:C13($ent.name)
	$find:=Find in sorted array:C1333($Keyword;$toBeFound;>;$Start;$End)
	If ($find)
		$ent.nbNested:=1+$end-$start
	End if 
	
End for each 