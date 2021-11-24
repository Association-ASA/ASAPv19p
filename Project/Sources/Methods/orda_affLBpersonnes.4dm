//%attributes = {"executedOnServer":true}
#DECLARE($es : Object)

var $coll : Collection
$coll:=New collection:C1472

If ($es#Null:C1517)
	var $num : cs:C1710.cryptage
	
	For each ($e; $es)
		$ob:=New object:C1471
		//$ob.num:=cs.cryptage.new().cracheNumLaboN($e.Identificateur; "labo")
		$ob.num:=Formula from string:C1601(Form:C1466.formula).call($e)
		$ob.recupAdr:=$e.recupAdresse("Livraison"; "Facturation")
		$ob.recupMailRAEMA:=$e.recupMail("EmailRAEMA")
		$ob.recupMailFac:=$e.recupMail("EmailCompta")
		$ob.entity:=$e
		$coll.push($ob)
	End for each 
	
End if 
