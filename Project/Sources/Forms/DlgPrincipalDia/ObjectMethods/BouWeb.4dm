$Web_PortTCP:=Get database parameter:C643(15)  //Numéro du port
If ($Web_PortTCP#80)
	OPEN URL:C673("HTTP://127.0.0.1:"+String:C10($Web_PortTCP))
Else 
	OPEN URL:C673("HTTP://127.0.0.1")
End if 