//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false}
C_OBJECT:C1216($licence;$1)
C_TEXT:C284($key;$type)
C_BOOLEAN:C305($0)
C_LONGINT:C283($iteration;$total;$numKey)

$licence:=$1
$0:=False:C215
$iteration:=Num:C11(Substring:C12($licence.key;1;Position:C15("-";$licence.key)-1))
$key:=Substring:C12($licence.key;Position:C15("-";$licence.key)+1)

  // Remove the licence type
$key:=Substring:C12($key;0;$iteration)+Substring:C12($key;$iteration+2)
$isServer:=Bool:C1537(Num:C11(Substring:C12($licence.key;$iteration;$iteration))=1)

Case of 
	: (Application type:C494=4D Local mode:K5:1) | (Application type:C494=4D Remote mode:K5:5)
		$type:="Monopost"
		
	: (Application type:C494=4D Server:K5:6) & ($isServer=False:C215)
		$type:="Invalid"
		
	: (Application type:C494=4D Server:K5:6) & ($isServer=True:C214)
		$type:="Server"
		
	Else 
		$type:="Invalid"
		
End case 

If ($iteration<=9) & (Length:C16($key)=15)  // Structure of $licence.key is correct
	$numkey:=Num:C11($key)
	
	Repeat 
		$iteration:=$iteration-1
		$numKey:=$numKey-16
	Until ($iteration=0)
	
	$total:=$numKey/25
	$End:=!1969-11-17!+$total
	
	If ($end>=Current date:C33) & ($type#"Invalid")
		$0:=True:C214
	End if 
End if 