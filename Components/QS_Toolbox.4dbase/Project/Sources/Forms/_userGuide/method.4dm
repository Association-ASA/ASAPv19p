  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // ----------------------------------------------------
  // Méthode : userGuide
  // Description
  //
  // Paramètres
  // ----------------------------------------------------


If (Form event code:C388=On Load:K2:1)
	
	C_TEXT:C284($wa_htmlEditor_path_t)
	C_POINTER:C301($wa_p)
	Case of 
		: (Form:C1466.language="us")
			$userGuide:="QS_Toobox - User Guide 4"
			
		: (Form:C1466.language="fr")
			$userGuide:="QS_Toobox - Guide Utilisateur 4"
			
		: (Form:C1466.language="markdown")
			$userGuide:="Markdown Guide"
			
	End case 
	  //$file:=Get 4D folder(Current resources folder)+"documentation"+Folder separator+$userGuide+".pdf"
	$file:=Convert path system to POSIX:C1106(File:C1566("/RESOURCES/documentation/"+$userGuide+".pdf").platformPath)
	$wa_p:=OBJECT Get pointer:C1124(Object named:K67:5;"wa_userGuide")
	WA OPEN URL:C1020($wa_p->;"file:///"+$file)
End if 