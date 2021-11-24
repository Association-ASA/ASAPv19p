FlechesDirectes:=True:C214
$F:=Open form window:C675("AdV17MetsLesFleches")
DIALOG:C40("AdV17MetsLesFleches")
CLOSE WINDOW:C154
If (BLOB size:C605([Diapositives:40]BlobFleches:21)>0)
	VarComLa:="Photo commentée"
Else 
	VarComLa:="Photo non commentée"
End if 