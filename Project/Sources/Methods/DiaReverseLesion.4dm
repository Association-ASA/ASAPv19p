//%attributes = {"publishedWeb":true,"lang":"fr"}
// ReverseLésion
If (ZdDNLR=0)
	ALERT:C41("Désignez la lésion à ôter de la liste SVP")
Else 
	CONFIRM:C162("vous désirez bien ôter la lésion "+ZdDNLR{ZdDNLR}+" de la liste des lésions NPC?")
	If (OK=1)
		DELETE FROM ARRAY:C228(ZdDNLR; ZdDNLR)
	End if 
End if 