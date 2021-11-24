C_OBJECT:C1216($ent)
VarCode:=""
VarNom:=""
[Factures:15]AdresseFacturation:5:=""
If (RadAdh=1)
	PUMTypeFacture:=1
	$Test:=<>ZPermMille+"/C@"
	$ent:=ds:C1482.Factures.query("NumFacture = :1"; $Test).orderBy("NumFacture desc")
	If ($ent.length>0)
		$ProchNumFacture:=Num:C11(Substring:C12($ent[0].NumFacture; 4))+1
	Else 
		$ProchNumFacture:=1
	End if 
	[Factures:15]NumFacture:3:=Substring:C12($test; 1; (Length:C16($test)-1))+String:C10($ProchNumFacture; "0000")
	
Else 
	PUMTypeFacture:=0
End if 