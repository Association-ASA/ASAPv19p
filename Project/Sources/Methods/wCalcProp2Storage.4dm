//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 22/11/21, 10:42:52
// ----------------------------------------------------
// Méthode : wCalcProp2Storage
// Description
// Calcul et positionne la liste des propriétés du champ objet de tous les entités d'une entité sélection dans le storage
//
// Paramètres
// ----------------------------------------------------

var $coll : Collection

$es:=ds:C1482.Personnes.all()
$coll:=cs:C1710.z.new().extractionProp($es; "Arguments")
$n:=cs:C1710.tools.new($coll).toStorage("prop"; "personnes")

$es:=ds:C1482.CampagneParticipations.all()
$coll:=cs:C1710.z.new().extractionProp($es; "Arguments")
$n:=cs:C1710.tools.new($coll).toStorage("prop"; "CampagneParticipations")


// A positionner en fin de toutes les méthodes 'Worker'
// Adapter le numéro du paramètre (au cas où)
If (Count parameters:C259=1)
	C_OBJECT:C1216($1)
	signal_addResult($1; Current method name:C684)
End if 
