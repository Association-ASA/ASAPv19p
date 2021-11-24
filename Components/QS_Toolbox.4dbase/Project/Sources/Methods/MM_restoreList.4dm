//%attributes = {"invisible":true,"preemptive":"indifferent","executedOnServer":false,"publishedSql":false,"shared":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false,"published4DMobile":{"scope":"none"}}
Case of 
		
	: ((OBJECT Get pointer:C1124(Object named:K67:5;"rd50"))->=1)
		Form:C1466.listboxDisplayed:=Storage:C1525.allMethods.filter("CM_displayByType";"Path project method").orderBy("name")
		
	: ((OBJECT Get pointer:C1124(Object named:K67:5;"rd51"))->=1)
		Form:C1466.listboxDisplayed:=Storage:C1525.allMethods.filter("CM_displayByType";"Path project form").orderBy("name")
		
	: ((OBJECT Get pointer:C1124(Object named:K67:5;"rd52"))->=1)
		Form:C1466.listboxDisplayed:=Storage:C1525.allMethods.filter("CM_displayByType";"Path database method").orderBy("name")
		
	: ((OBJECT Get pointer:C1124(Object named:K67:5;"rd53"))->=1)
		Form:C1466.listboxDisplayed:=Storage:C1525.allMethods.filter("CM_displayByType";"Path table form").orderBy("name")
		
	: ((OBJECT Get pointer:C1124(Object named:K67:5;"rd54"))->=1)
		Form:C1466.listboxDisplayed:=Storage:C1525.allMethods.filter("CM_displayByType";"Path trigger").orderBy("name")
		
	: ((OBJECT Get pointer:C1124(Object named:K67:5;"rd55"))->=1)
		Form:C1466.listboxDisplayed:=Storage:C1525.allMethods.filter("CM_displayByType";"Path Class").orderBy("name")
		
End case 
