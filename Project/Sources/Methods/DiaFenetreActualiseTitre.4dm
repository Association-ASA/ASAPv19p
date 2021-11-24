//%attributes = {"publishedWeb":true,"lang":"fr"}
//  ZActualiseTitreFenetre 6.0 du 30/08/98
//   met à jour le bandeau d'une liste

ZNbEnr:=Records in selection:C76(ZPtTable->)
ZVarTotEnr:=Records in table:C83(ZPtTable->)
If (ZIciListeH)  //  gestion des liste hiérarchiques
	$Mess:=ZNomTable+" : Liste hiérarchique de "+String:C10(ZNbEnr)
	$Mess:=$Mess+" enregistrements parmi "+String:C10(ZVarTotEnr)
	EXECUTE FORMULA:C63(ZDerMéthode)  //  permet de mettre la liste hiérarchique à jour
Else 
	Case of 
		: (ZNbEnr=0)
			$Mess:=ZNomTable+" : Aucun enregistrement parmi "+String:C10(ZVarTotEnr)
			
		: (ZNbEnr=1)
			FIRST RECORD:C50(ZPtTable->)
			$ConCerné:=ZPtChamp->
			$Mess:=ZNomTable+" : "+"Le seul enregistrement "
			$Mess:=$Mess+$ConCerné+" parmi "+String:C10(ZVarTotEnr)
			
		Else 
			$Mess:=ZNomTable+" : "+String:C10(ZNbEnr)
			$Mess:=$Mess+" enregistrements parmi "+String:C10(ZVarTotEnr)
	End case 
End if 
SET WINDOW TITLE:C213($Mess)