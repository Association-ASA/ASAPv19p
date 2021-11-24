

If (Form event code:C388=On Clicked:K2:4)
	If (Form:C1466.entity.previous()#Null:C1517)
		Form:C1466.entity:=Form:C1466.entity.previous()
		DATA_displayDetail 
	End if 
End if 

If (Form:C1466.entity.previous()=Null:C1517)
	OBJECT SET ENABLED:C1123(*;"bPrevious";False:C215)
Else 
	OBJECT SET ENABLED:C1123(*;"bPrevious";True:C214)
End if 
If (Form:C1466.entity.next()=Null:C1517)
	OBJECT SET ENABLED:C1123(*;"bNext";False:C215)
Else 
	OBJECT SET ENABLED:C1123(*;"bNext";True:C214)
End if 