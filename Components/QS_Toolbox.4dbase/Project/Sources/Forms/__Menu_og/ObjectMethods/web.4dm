$mail:=False:C215
$mail:=Shift down:C543

If ($mail)
	OPEN URL:C673("mailto:info@association-qualisoft.eu")
Else 
	OPEN URL:C673("http://www.association-qualisoft.eu")
End if 
