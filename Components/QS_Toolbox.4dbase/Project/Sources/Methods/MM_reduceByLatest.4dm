//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_DATE:C307($limitedDate)
C_COLLECTION:C1488($c; $data)
C_LONGINT:C283($when)

$when:=-1*Form:C1466.fromWhen  // To set it positif
$data:=Storage:C1525.allMethods

If ($data.length>0)
	Case of 
		: ($when>1)
			
			Case of 
				: ((OBJECT Get pointer:C1124(Object named:K67:5; "rd50"))->=1)
					$path:="Path project method"
					
				: ((OBJECT Get pointer:C1124(Object named:K67:5; "rd51"))->=1)
					$path:="Path project form"
					
				: ((OBJECT Get pointer:C1124(Object named:K67:5; "rd52"))->=1)
					$path:="Path database method"
					
				: ((OBJECT Get pointer:C1124(Object named:K67:5; "rd53"))->=1)
					$path:="Path table form"
					
				: ((OBJECT Get pointer:C1124(Object named:K67:5; "rd54"))->=1)
					$path:="Path trigger"
					
				: ((OBJECT Get pointer:C1124(Object named:K67:5; "rd55"))->=1)
					$path:="Path Class"
					
			End case 
			
			$c:=$data.orderBy("lastUpdate desc")
			
			If ($when>=$data.length)  // Bug from Lutz Veith
				$when:=$data.length
			End if 
			
			$limitedDate:=Date:C102($c[$when-1].lastUpdate)  // -1: Bug from Lutz Veith
			Form:C1466.listboxDisplayed:=$data.filter("CM_filterByDate"; $limitedDate; $path)
			
		: ($when<=1)
			MM_restoreList
			
	End case 
End if 
MM_updateInformation
