//%attributes = {"publishedWeb":true}
  // ZfChercheNuméro 6.0  du 15/09/98 (revue le 2/09/99)
  //  fonction qui renvoie ne N° de consultation
  // $1 = nom de la fiche de [XDonnées] qui contient le numéro à incrémenter
  //$2 = paramètre de non incrémentation (facultatif)
  // A TESTER

C_LONGINT:C283($0)
C_TEXT:C284($1)

READ WRITE:C146([DiaData:45])
QUERY:C277([DiaData:45];[DiaData:45]XNom:1=$1;*)
QUERY:C277([DiaData:45]; & [DiaData:45]XType:5="GNM")

If (Records in selection:C76([DiaData:45])=0)
	CREATE RECORD:C68([DiaData:45])
	[DiaData:45]XNom:1:=$1
	[DiaData:45]XType:5:="GNM"
	SAVE RECORD:C53([DiaData:45])
End if 

If (Count parameters:C259=1)
	ZVerrouAttendre (->[DiaData:45])
	[DiaData:45]XEntier:2:=[DiaData:45]XEntier:2+1
	SAVE RECORD:C53([DiaData:45])
	$0:=[DiaData:45]XEntier:2
Else 
	$0:=[DiaData:45]XEntier:2+1
End if 

UNLOAD RECORD:C212([DiaData:45])
READ ONLY:C145([DiaData:45])
