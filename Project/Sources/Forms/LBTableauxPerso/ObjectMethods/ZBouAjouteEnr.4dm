
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 14/07/19, 07:04:58
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : LBTableauxPerso.ZBouAjouteEnr
  // Description  : Ajout d'un enregistrement de [Personnes]
  // 
If (Test semaphore:C652("Ajout personne"))
	ALERT:C41("Désolé, quelqu'un est en train d'ajouter une personne sur un autre poste...")
Else 
	  // Initialisation des Tb des n° d'adhérent et de labo
	ARRAY LONGINT:C221($TbNumPersonne;0)
	COPY ARRAY:C226(<>TbPerNumPersonne;$TbNumPersonne)
	SORT ARRAY:C229($TbNumPersonne;<)
	DerNumPersonne:=$TbNumPersonne{1}
	ARRAY LONGINT:C221($TbNumRAEMA;0)
	COPY ARRAY:C226(<>TbPerNumLaboRAEMA;$TbNumRAEMA)
	SORT ARRAY:C229($TbNumRAEMA;<)
	DerNumRAEMA:=ASAPCalculDerNumLabo 
	  //ZLBZNouveau ("*")
	CREATE SELECTION FROM ARRAY:C640(ZPtTable->;TbNumEnr)
End if 
CREATE SET:C116(ZPtTable->;"SélectionEnCours")
If (Count parameters:C259>0)
	$Transac:=True:C214
Else 
	$Transac:=False:C215
End if 
START TRANSACTION:C239
ADD RECORD:C56(ZPtTable->;*)
If (OK=1)
	VALIDATE TRANSACTION:C240
Else 
	CANCEL TRANSACTION:C241
End if 
ADD TO SET:C119(ZPtTable->;"SélectionEnCours")
USE SET:C118("SélectionEnCours")
CLEAR SET:C117("SélectionEnCours")

CLEAR SEMAPHORE:C144("Ajout personne")
ASAPFabriqueTbPersonnes (True:C214)  // execute en local
EXECUTE METHOD:C1007(ZMethodeTableaux)
ASAPFabriqueTbPersonnes 
