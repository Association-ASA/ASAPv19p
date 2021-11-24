//%attributes = {"publishedWeb":true}
  // InsèreLésion
$NL:=ZdDNL{ZdDNL}
If (Find in array:C230(ZdDNLR;$NL)<0) & ([DiaLesions:44]NomLesion:1#$NL)
	INSERT IN ARRAY:C227(ZdDNLR;Size of array:C274(ZdDNLR)+1)
	ZdDNLR{Size of array:C274(ZdDNLR)}:=$NL
	  // ZAjoutLigne (->ZdDNLR;$NL)
	SORT ARRAY:C229(ZdDNLR;>)
Else 
	ALERT:C41("Le libellé "+$NL+" existe déjà")
End if 
VarSaisieNomLésion:=""
GOTO OBJECT:C206(VarSaisieNomLésion)