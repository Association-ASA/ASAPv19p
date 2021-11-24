//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 
  // ----------------------------------------------------
  // Méthode : MM_createComment
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------

C_COLLECTION:C1488($Methods)
If (Form:C1466.methodSelected.length>0)
	$Methods:=Form:C1466.methodSelected
Else 
	$Methods:=Storage:C1525.allMethods.filter("CM_displayByType";"Path project method")
End if 

$n:=$Methods.length
CONFIRM:C162("Are you sure to want to replace method comments by Header comments  and Variable types for each method selected ("+String:C10($n)+")?")
If (OK=1)
	C_LONGINT:C283($MaxComment)
	C_TEXT:C284($Comment;$code)
	C_OBJECT:C1216($ent)
	C_COLLECTION:C1488($list)
	
	$MaxComment:=Storage:C1525.QS_TBX_SHARED_DATA.QS_SETUP_MAX_COMMENT_LINES
	
	ARRAY TEXT:C222($T_comments;$n)
	ARRAY TEXT:C222($T_methodNames;$n)
	$a:=0
	
	For each ($ent;$Methods)
		
		If ($ent.path="Path project method")
			
			$a:=$a+1
			$T_methodNames{$a}:=$ent.name
			$code:=$ent.code
			MM_removeFirstLine (->$code)
			
			$Comment:=$list[0].syntax+("\r"*2)
			$Comment:=Replace string:C233($Comment;":";" -> ")
			
			C_COLLECTION:C1488($coll)
			C_TEXT:C284($text)
			$coll:=New collection:C1472
			METHOD GET CODE:C1190($ent.name;$sourceText;*)
			
			  // General type
			ARRAY TEXT:C222($tableau2D;0x0000;0x0000)
			$rxPatternGeneral:="(?mi-s)(^.*:=\\$[0-9])|(^[\\t]\\$[0-9]:=.*)$"
			$rxPatternPointer:="(?mi-s)^(.*\\(\\$[0-9]->;.*\\))"
			
			  // How manage this kind of line
			If (REGEX_ExtractText ($rxPatternGeneral;$sourceText;"1 2";->$tableau2D;0)=0)
				$Comment:=$Comment+"\n"
				$text:=""
				
				For ($z;1;Size of array:C274($tableau2D))
					$coll.push(Replace string:C233($tableau2D{$z}{1};"\t";""))
					$coll.push(Replace string:C233($tableau2D{$z}{2};"\t";""))
					
				End for 
				
			End if 
			
			  // Pointer case & Array case
			CLEAR VARIABLE:C89($tableau2D)
			If (REGEX_ExtractText ($rxPatternPointer;$sourceText;"1 2";->$tableau2D;0)=0)
				$text:=""
				For ($z;1;Size of array:C274($tableau2D))
					$text:=$tableau2D{$z}{1}
					$coll.push(Replace string:C233($text;"\t";""))
					
					$text:=$tableau2D{$z}{2}
					$coll.push(Replace string:C233($text;"\t";""))
					
				End for 
				
			End if 
			
			If ($coll.length>0)
				$coll:=$coll.distinct().orderBy(ck descending:K85:8)
				
				For each ($text;$coll)
					$text:=Substring:C12($text;Position:C15("//";$text)+2)
				End for each 
				$Comment:=$Comment+$coll.join("\n")
			End if 
			$Comment:=$Comment+("\n"*2)
			
			$coll:=Split string:C1554($sourceText;"\r")
			$coll.resize($MaxComment+1;"").shift()  // Reduce the number of line to the $MaxComment lines required
			
			For each ($text;$coll)
				$n:=Position:C15("//";$text)
				If ($n<=3) & ($n>0)
					$Comment:=$Comment+Substring:C12($text;Position:C15("//";$text)+2)+"\n"
				End if 
			End for each 
			
			$T_comments{$a}:=$Comment
		End if 
	End for each 
	
	METHOD SET COMMENTS:C1193($T_methodNames;$T_comments;*)
	If (Form:C1466.currentElement#Null:C1517)
		MM_getCodeToDisplay (Form:C1466.currentElement)
	End if 
	displayInfo ("Method comments have been updated.")
	
End if 
