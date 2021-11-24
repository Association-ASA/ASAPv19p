//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_TEXT:C284($0;$path)

$path:=Get 4D folder:C485(Current resources folder:K5:16)+"XSLT"+Folder separator:K24:12

Case of 
	: (Is macOS:C1572)
		$path:=$path+"MacOS"
		
	: (Is Windows:C1573)
		  //I know, this is the app architecture, not the OS; no big deal
		If (Version type:C495 ?? 64 bit version:K5:25)
			$path:=$path+"Windows64"
		Else 
			$path:=$path+"Windows"
		End if 
End case 

$0:=$path+Folder separator:K24:12