//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 14/01/16, 14:30:16
// ----------------------------------------------------
// Méthode : WebAsaContact
// Description
// Reçoit une requete AJAX de type "Aco"+[XData]UUID
//  
// Paramètre : $1 = requête
// ----------------------------------------------------

<>WebAsaContact:=""
$UUIDAC:=Substring:C12($1; 4)
READ WRITE:C146([XData:1])
ARRAY TEXT:C222(<>TbAsaContactIP; 0)
ARRAY DATE:C224(<>TbAsaContactDate; 0)
QUERY:C277([XData:1]; [XData:1]UUID:1=$UUIDAC)
$Cible:="PDF/AsaContact/Aco"+[XData:1]UUID:1+".pdf"
$Test:="WebAsaContact"+String:C10([XData:1]XEntier:6)

QUERY:C277([XData:1]; [XData:1]XType:3="ACo"; *)
QUERY:C277([XData:1];  & [XData:1]XNom:2=$Test)

If (Records in selection:C76([XData:1])=0)
	CREATE RECORD:C68([XData:1])
	[XData:1]XNom:2:=$Test
	[XData:1]XType:3:="ACo"
	[XData:1]XValeur:7:=Num:C11($Test)
	[XData:1]XDate:4:=Current date:C33
	ZVariableVersBlob(->[XData:1]XBlob:13; -><>TbAsaContactIP; -><>TbAsaContactDate)
	SAVE RECORD:C53([XData:1])
Else 
	ZBlobVersVariable(->[XData:1]XBlob:13; -><>TbAsaContactIP; -><>TbAsaContactDate)
End if 
If (Find in array:C230(<>TbAsaContactIP; IP)<0)
	[XData:1]XEntier:6:=[XData:1]XEntier:6+1
	APPEND TO ARRAY:C911(<>TbAsaContactIP; IP)
	APPEND TO ARRAY:C911(<>TbAsaContactDate; Current date:C33)
	ZVariableVersBlob(->[XData:1]XBlob:13; -><>TbAsaContactIP; -><>TbAsaContactDate)
	SAVE RECORD:C53([XData:1])
	<>WebAsaContact:=AsaContactCompte
End if 
// APPELER PROCESS(-1)
ZAmnistiePartielle(->[XData:1]; True:C214)

WEB SEND HTTP REDIRECT:C659($Cible)