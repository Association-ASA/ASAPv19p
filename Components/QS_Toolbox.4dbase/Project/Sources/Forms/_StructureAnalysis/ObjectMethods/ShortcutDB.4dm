Case of 
	: (Form event code:C388=On Selection Change:K2:29)
		C_LONGINT:C283($Change)
		
		$Continue:=True:C214
		$Change:=(OBJECT Get pointer:C1124(Object named:K67:5;"ChangeDetected"))->
		
		If ($Change=1)
			CONFIRM:C162("A change has been detected. Are you sure to continue without saving before?")
			If (OK#1)
				$Continue:=False:C215
			End if 
		End if 
		
		If ($Continue)
			LINKS_InitOptions 
			LINKS_ReadInitValues 
			(OBJECT Get pointer:C1124(Object named:K67:5;"ChangeDetected"))->:=0
		End if 
		
End case 