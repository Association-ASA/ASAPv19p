//%attributes = {"invisible":true,"preemptive":"capable"}
  // ----------------------------------------------------
  // $0 : Collection
  // ----------------------------------------------------
  // Méthode : stats_parseMethodsAttributes
  // Description
  // 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 24/10/19, 15:53:43
  // Paramètres

CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> Start")

C_TEXT:C284($name)
C_LONGINT:C283($indifferent;$capable;$capable;$incapable;$on)
C_COLLECTION:C1488($methodAttributes;$counts;$count;$names;$0)

$methodAttributes:=New collection:C1472
$counts:=New collection:C1472
$count:=New collection:C1472
$names:=New collection:C1472

$methodAttributes:=Storage:C1525.allMethods.query("path = :1";"Path project method").extract("attributes")

For each ($name;$methodAttributes[0])
	$names.push($name)
End for each 

For each ($name;$names)
	
	Case of 
		: ($name="preemptive")
			$capable:=$methodAttributes.countValues("capable";$name)
			$indifferent:=$methodAttributes.countValues("indifferent";$name)
			$incapable:=$methodAttributes.countValues("incapable";$name)
			$counts.push(New object:C1471("name";$name+"-capable";"on";$capable;"off";0))
			$counts.push(New object:C1471("name";$name+"-indifferent";"on";$indifferent;"off";0))
			$counts.push(New object:C1471("name";$name+"-incapable";"on";$incapable;"off";0))
			
		Else 
			$on:=$methodAttributes.countValues(True:C214;$name)
			$counts.push(New object:C1471("name";$name;"on";$on;"off";$methodAttributes.length-$on))
	End case 
	
End for each 

$0:=$counts
CALL WORKER:C1389("QST_debug";"floatWindow_send";Current process name:C1392;Current method name:C684+" -> End")
