$Dem:=Num:C11(Request:C163("Quel n° de diapo, SVP..."; "11981"))
If (OK=1) & ($dem#0)
	QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1=$dem)
	If (Records in selection:C76([Diapositives:40])=0)
		ALERT:C41("Désolé, aucune photographie 'a ce n°")
	End if 
End if 
DiaFenetreActualiseTitre