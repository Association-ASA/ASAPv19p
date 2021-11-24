If (CaCGibier=1)
	OBJECT SET TITLE:C194(*; "TexteCom"; "Eléments de communication :")
Else 
	OBJECT SET TITLE:C194(*; "TexteCom"; "Communication aux éleveurs :")
End if 
OBJECT SET VISIBLE:C603(*; "boucherie@"; (CaCGibier=0))
OBJECT SET VISIBLE:C603(*; "gibier@"; (CaCGibier=1))