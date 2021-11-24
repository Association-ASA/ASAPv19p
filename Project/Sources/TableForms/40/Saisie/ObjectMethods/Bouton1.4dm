If (ZdDNL#0)
	$NL:=ZdDNL{ZdDNL}
	If (Find in array:C230(ZdDNLR;$NL)<0) & ([Diapositives:40]NomLesion:4#$NL)
		ZAjoutLigne (->ZdDNLR;$NL)
		SORT ARRAY:C229(ZdDNLR;>)
	Else 
		ALERT:C41("Le libellé "+$NL+" existe déjà")
	End if 
	VarSaisieNomLésion:=""
	GOTO OBJECT:C206(VarSaisieNomLésion)
	
Else 
	ALERT:C41("Désignez la lésion à insérer")
End if 