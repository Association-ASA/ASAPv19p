//%attributes = {"executedOnServer":true,"preemptive":"capable"}
// ----------------------------------------------------
// Nom utilisateur : PE 
// Date et heure : 25/11/21, 06:25:32
// ----------------------------------------------------
// Méthode : personnes2storage
// Description
// mets dans le storage le contenu nécessaire à afficher la LB
//
// Paramètres
// ----------------------------------------------------

$table:="Personnes"
$es:=ds:C1482[$table].query("TypePersonne =:1 and Caduc=:2"; "laboratoire"; False:C215)
$formula:="cs.cryptage.new().cracheNumLaboN(This.Identificateur; \"labo\")"
$n:=New object:C1471
For each ($e; $es)
	$n[$e.UUID]:=New object:C1471
	$n[$e.UUID].labo:=Formula from string:C1601($formula).call($e)
	$n[$e.UUID].nom:=$e.NomLong
	$n[$e.UUID].recupMailRAEMA:=$e.recupMail("EmailRAEMA")
	$n[$e.UUID].recupMailFac:=$e.recupMail("EmailCompta")
	$n[$e.UUID].uuid:=$e.UUID
	$n[$e.UUID].adr:=$e.recupAdresse("Livraison"; "Facturation")
	$n[$e.UUID].pays:=$e.recupPays("Livraison"; "Facturation")
End for each 

Use (Storage:C1525)
	Storage:C1525.tableaux:=OB Copy:C1225($n; ck shared:K85:29)
End use 
