  // FM: "webAreaForm" (new LV 25.08.20, 15:54:44)
  // Last change: LV 25.08.20, 15:54:44

Case of 
	: (Form event code:C388=On Load:K2:1)
		  // CodeMirror
		WA SET PREFERENCE:C1041(*;"_webParseForm";WA enable Web inspector:K62:7;True:C214)
		$path:=Path to object:C1547(Application file:C491).name+Path to object:C1547(Application file:C491).extension+Replace string:C233("/Contents/Resources/codemirror/mp/min4dRunParse.html";"/";Folder separator:K24:12)
		WA OPEN URL:C1020(*;"_webParseForm";$path)
		
	: (Form event code:C388=On Outside Call:K2:11)
		CANCEL:C270
		
	: (Form event code:C388=On Unload:K2:2)
		
End case 

  // - EOF -