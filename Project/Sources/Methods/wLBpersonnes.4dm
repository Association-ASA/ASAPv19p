//%attributes = {"preemptive":"capable"}

$coll:=New collection:C1472
$data:=Storage:C1525.tableaux
For each ($personne; $data)
	$coll.push(New object:C1471("uuid"; $personne; \
		"labo"; $data[$personne].labo; \
		"nom"; $data[$personne].nom; \
		"raema"; $data[$personne].recupMailRAEMA; \
		"fac"; $data[$personne].recupMailFac; \
		"pays"; $data[$personne].pays; \
		"adr"; $data[$personne].adr))
End for each 
Form:C1466.esColl:=$coll.copy()

If (Form:C1466.premiereOuverture)
	Form:C1466.selection:=$es
	Form:C1466.esInitiale:=$es
	Form:C1466.premiereOuverture:=False:C215
End if 