//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
$Search:=(OBJECT Get pointer:C1124(Object named:K67:5; "searchMethod"))->

If ($Search="")
	
Else 
	C_COLLECTION:C1488($data)
	$data:=Storage:C1525.allMethods.copy()
	
	Case of 
		: (Form:C1466.searchInMethod=0)
			If (Current form name:C1298="_MethodManager")
				MM_restoreList
			End if 
			
			Form:C1466.listboxDisplayed:=Form:C1466.listboxDisplayed.filter("CM_search"; $Search)
			
		: (Form:C1466.searchInMethod=1)
			If (Position:C15(";"; $Search)=0)  // Simple search
				$toSearch:="@"+$search+"@"
				Form:C1466.listboxDisplayed:=$data.query("code = :1"; $toSearch)
				
			Else   // Complex search
				
				C_COLLECTION:C1488($col)
				$toSearch:=""
				$col:=New collection:C1472
				$col:=Split string:C1554($Search; ";"; sk ignore empty strings:K86:1)
				$argument:="code = "
				For each ($i; $col)
					$argument:=$argument+"@"+$i+"@"
					If ($i#$col[$col.length-1])
						$argument:=$argument+" and code = "
					End if 
				End for each 
				
				If (Form:C1466.onlyProjectMethod=0)
					Form:C1466.listboxDisplayed:=$data.query($argument)
				Else 
					Form:C1466.listboxDisplayed:=$data.query($argument).filter("CM_displayByType"; "Path project method")
				End if 
				
			End if 
			
	End case 
	MM_updateInformation
End if 