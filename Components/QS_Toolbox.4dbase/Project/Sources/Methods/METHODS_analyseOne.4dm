//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 18/03/19, 13:18:06
  // ----------------------------------------------------
  // Méthode : METHODS_analyseOne
  // Description
  //  $1 = Object equal to the method to analyse
  // Paramètres
  // ----------------------------------------------------
  // Analysis all methods to get statistics data

C_COLLECTION:C1488($Collect)
C_OBJECT:C1216($ent;$1)

ASSERT:C1129(Count parameters:C259=1;Current method name:C684+" expect 1 parameter (Object).")
ASSERT:C1129(Type:C295($1)=Is object:K8:27;"First parameter must be an object.")
$ent:=$1
If ($ent#Null:C1517)
	
	If ($ent.code#"")  // code is already in uppercase
		
		  //$language:=Config_getLanguage 
		$counter:=0
		
		  // ***************************************
		$Collect:=New collection:C1472
		
		  // commands and functions use in complexity determination
		$beginSql:="@"+Command name:C538(948)+"@"
		$query:="@"+Command name:C538(277)+" (@"
		$distinctValue:="@"+Command name:C538(339)+" (@"
		$distinctValueByAttribut:="@"+Command name:C538(1397)+" (@"
		$distinctValueByPath:="@"+Command name:C538(1395)+" (@"
		$queryByArray:="@"+Command name:C538(644)+" (@"
		$queryByArrayInSelection:="@"+Command name:C538(1050)+" (@"
		$queryByFormula:="@"+Command name:C538(300)+" (@"
		$queryByFormulaInSelection:="@"+Command name:C538(207)+" (@"
		$queryInSelection:="@"+Command name:C538(341)+" (@"
		$queryByAttribut:="@"+Command name:C538(1331)+" (@"
		$executeSql:="@"+Command name:C538(820)+" (@"
		$findInField:="@:="+Command name:C538(653)+" (@"
		$sum:="@:="+Command name:C538(1)+" (@"
		$max:="@:="+Command name:C538(3)+" (@"
		$min:="@:="+Command name:C538(4)+" (@"
		$findRegex:="@:="+Command name:C538(1019)+" (@"
		
		  // Just remove inapropriate spaces and  Need to keep all comment and empty lines for their analysis.
		$Collect:=Split string:C1554($ent.code;"\r";sk trim spaces:K86:2)
		
		  // **** Determination of the COMPLEXITY *****
		  // -- Keyword --
		$n:=1
		$n:=$n+$Collect.countValues("@Si (@")+$Collect.countValues("@If (@")
		$n:=$n+$Collect.countValues("@Utiliser (@")+$Collect.countValues("@Use (@")
		$n:=$n+$Collect.countValues("@Au cas ou@")+$Collect.countValues("@Case of@")
		$n:=$n+$Collect.countValues("@: (@")
		$n:=$n+$Collect.countValues("@Tant que@")+$Collect.countValues("@While (@")
		$n:=$n+$Collect.countValues("@Boucle (@")+$Collect.countValues("@For (@")
		$n:=$n+$Collect.countValues("@For each (@")  // V17
		$n:=$n+$Collect.countValues("@Répéter (@")+$Collect.countValues("@Until (@")
		$n:=$n+$Collect.countValues("@Sinon@")+$Collect.countValues("@Else@")
		$n:=$n+$Collect.countValues("@Use (@")
		
		$n:=$n+$Collect.countValues($beginSql)  // début SQL
		$n:=$n+$Collect.countValues($query)  // CHERCHER
		$n:=$n+$Collect.countValues($distinctValue)  // VALEURS DISTINCTES
		$n:=$n+$Collect.countValues($distinctValueByAttribut)  // VALEURS DISTINCTES ATTRIBUT
		$n:=$n+$Collect.countValues($distinctValueByPath)  // VALEURS DISTINCTES CHEMINS
		$n:=$n+$Collect.countValues($queryByArray)  // CHERCHER PAR TABLEAU
		$n:=$n+$Collect.countValues($queryByArrayInSelection)  // CHERCHER PAR TABLEAU DANS SELECTION
		$n:=$n+$Collect.countValues($queryByFormula)  // CHERCHER PAR FORMULE
		$n:=$n+$Collect.countValues($queryByFormulaInSelection)  // CHERCHER PAR FORMULE DANS SELECTION
		$n:=$n+$Collect.countValues($queryInSelection)  // CHERCHER DANS SELECTION
		$n:=$n+$Collect.countValues($queryByAttribut)  // CHERCHER PAR ATTRIBUT
		$n:=$n+$Collect.countValues($executeSql)  // SQL EXECUTER
		$n:=$n+$Collect.countValues($findInField)  // trouver dans champ
		$n:=$n+$Collect.countValues($sum)  // somme
		$n:=$n+$Collect.countValues($max)  // max
		$n:=$n+$Collect.countValues($min)  // min
		$n:=$n+$Collect.countValues($findRegex)  // trouver regex
		
		$ent.Complexity:=$n
		$ent.nbLines:=$Collect.length-1
		$ent.nbEmpty:=$Collect.countValues("")
		$ent.nbComment:=$ent.nbComment+$Collect.countValues("//@")-1  // First attempt
		
	End if 
	
End if 