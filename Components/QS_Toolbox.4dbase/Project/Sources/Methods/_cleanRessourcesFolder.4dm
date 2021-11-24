//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
ARRAY TEXT:C222($lproj;0x0000)
FOLDER LIST:C473(Get 4D folder:C485(Current resources folder:K5:16);$lproj)

For ($a;1;Size of array:C274($lproj))
	If ($lproj{$a}="@.lproj") | ($lproj{$a}="RTA4D") | ($lproj{$a}="Cache")
		DELETE FOLDER:C693(Get 4D folder:C485(Current resources folder:K5:16)+$lproj{$a};Delete with contents:K24:24)
	End if 
End for 