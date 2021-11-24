//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 19/02/19, 11:35:19
// ----------------------------------------------------
// Méthode : MM_getCodeToDisplay
// Description
// Affecte les informations "Commentaires" et "Code"
//  ----------------------------------------------------

C_TEXT:C284($CommentMethod)
C_OBJECT:C1216($1; $currentElement)
$currentElement:=$1
$CommentMethod:=""
ON ERR CALL:C155("base_noError")

$host:=Bool:C1537(Storage:C1525.QS_TBX_SHARED_DATA.QS_hostInProjectMode)
If (gerror=0)
	
	$temp:=Form:C1466.currentElement.code
	MM_removeFirstLine(->$temp)
	Content_MM:=$temp
	
	METHOD_codeMirror_display
	
	If (Not:C34($host))  // DB in Binary mode
		If ($currentElement.path="Path project method")
			METHOD GET COMMENTS:C1189($currentElement.name; $CommentMethod; *)
		End if 
		(OBJECT Get pointer:C1124(Object named:K67:5; "comment_txt"))->:=$CommentMethod
		
	Else   //  DB in project mode
		
		MM_commentInMarkdown($currentElement.name)
		
	End if 
	
End if 
ON ERR CALL:C155("")
