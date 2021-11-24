  // FM: "webAreaForm" (new LV 25.08.20, 15:54:44)
  // Last change: LV 25.08.20, 15:54:44

Case of 
	: (Form event code:C388=On Load:K2:1)
		  // CodeMirror
		WA SET PREFERENCE:C1041(*;"oWebArea";WA enable Web inspector:K62:7;True:C214)
		  //$path:=Replace string(Get 4D folder(Current resources folder)+"codemirror/mp/min4dRunParse.html";"/";Folder separator)
		$path:=File:C1566("/RESOURCES/codemirror/mp/min4dRunParse.html").platformPath
		WA OPEN URL:C1020(*;"oWebArea";$path)
		
	: (Form event code:C388=On Outside Call:K2:11)
		CANCEL:C270
		
	: (Form event code:C388=On Unload:K2:2)
		
End case 

  // - EOF -