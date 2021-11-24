MM_startSearch 
If (Form:C1466.onlyProjectMethod=1)
	Form:C1466.listboxDisplayed:=Storage:C1525.allMethods.filter("CM_displayByType";"Path project method")
End if 