//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 11/10/17, 21:48:19
  // ----------------------------------------------------
  // Méthode : METHODS_GetCodeToDisplay
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------
C_TEXT:C284($1;$Chemin;$methodComment)

$Chemin:=$1

If ($Chemin#"")
	METHOD GET CODE:C1190($Chemin;$codePreview;*)
	METHOD GET COMMENTS:C1189($chemin;$methodComment;*)
	
	(OBJECT Get pointer:C1124(Object named:K67:5;"comment_txt"))->:=$methodComment
	
	$firstNL:=Position:C15("\r";$codePreview)
	If ($firstNL>0)
		$codePreview:=Substring:C12($codePreview;$firstNL+1)
		Content_t:=$codePreview
		METHOD_codeMirror_display 
	End if 
	
End if 