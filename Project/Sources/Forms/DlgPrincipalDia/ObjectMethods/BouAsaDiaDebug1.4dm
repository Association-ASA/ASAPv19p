READ WRITE:C146([DiaData:45])
QUERY:C277([DiaData:45];[DiaData:45]XType:5="debug";*)
QUERY:C277([DiaData:45]; & [DiaData:45]XNom:1="débuggage")
If ([DiaData:45]XBool:9)
	SET DATABASE PARAMETER:C642(Enreg événements debogage:K37:34;0)
	OBJECT SET TITLE:C194(*;"BouAsaDiaDebug";"Débuggage arrêté")
	[DiaData:45]XBool:9:=False:C215
Else 
	OBJECT SET TITLE:C194(*;"BouAsaDiaDebug";"Débuggage lancé")
	SET DATABASE PARAMETER:C642(Enreg événements debogage:K37:34;4+2)
	[DiaData:45]XBool:9:=True:C214
End if 
SAVE RECORD:C53([DiaData:45])
ZAmnistiePartielle (->[DiaData:45])