If (Form:C1466.obsolete=Null:C1517)
	Form:C1466.obsolete:=False:C215
End if 

If (Not:C34(Form:C1466.obsolete))
	Form:C1466.display:=Form:C1466.display.query("EN = :1 | FR = :1";"_o@")
	Form:C1466.obsolete:=True:C214
	
Else 
	If (Form:C1466.konstant=True:C214)
		Form:C1466.display:=Form:C1466.konstante
	Else 
		Form:C1466.display:=Form:C1466.command
	End if 
	Form:C1466.obsolete:=False:C215
End if 

$txt:="Found "+String:C10(Form:C1466.display.length)+" references."
displayInfo ($txt;"blue")