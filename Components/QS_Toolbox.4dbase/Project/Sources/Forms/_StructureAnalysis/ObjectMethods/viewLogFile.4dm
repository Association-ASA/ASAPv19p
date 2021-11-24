  // ----------------------------------------------------
  // Nom utilisateur : Association QuualiSoft 
  // Date et heure : 06/09/19, 10:10:17
  // ----------------------------------------------------
  // Méthode : _StructureAnalysis.viewLogFile
  // Description
  //  Display in Web navigator the Log file
  //
  // Paramètres
  // ----------------------------------------------------

  // %W-533.3
If ((BASE_NewSelf #"") & (BASE_NewSelf #"-"))
	  // %W+533.3
	C_LONGINT:C283($option)
	
	$lang:=Config_getLanguage 
	$option:=(Num:C11(OBJECT Get pointer:C1124(Object current:K67:2)->)+3)
	
	Case of 
		: ($option<8)
			$path:=Get 4D file:C1418($option;*)
			
		: ($option=8)
			$path:=Get 4D folder:C485(Logs folder:K5:19;*)+"BuildApp_html.xml"
	End case 
	
	
	If (Test path name:C476($path)=Is a document:K24:1)
		$html:=Get_html_verify_log ($path;$lang)
		$file:=Path to object:C1547($path)
		$path:=Temporary folder:C486+$file.name+".html"
		TEXT TO DOCUMENT:C1237($path;$html;"utf-8")
		OPEN URL:C673($path)
		
	Else 
		$txt:="No file has been found for the option selected."
		displayInfo ($txt;"red")
		
	End if 
	
End if 