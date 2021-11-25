//%attributes = {"executedOnServer":true,"preemptive":"capable"}
#DECLARE($type : Text)->$result : Variant

Case of 
	: (Value type:C1509(Storage:C1525[$type])=Is collection:K8:32)
		$result:=New collection:C1472
		$result:=Storage:C1525[$type].copy()
		
	: (Value type:C1509(Storage:C1525[$type])=Is object:K8:27)
		$result:=New object:C1471
		$result:=OB Copy:C1225(Storage:C1525[$type])
		
End case 