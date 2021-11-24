//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
#DECLARE($type : Text)->$typeName : Text

Case of 
	: ($type="D")
		$typeName:="Date"
	: ($type="H")
		$typeName:="Time"
	: ($type="I")
		$typeName:="Integer"
	: ($type="L")
		$typeName:="Long"
	: ($type="O")
		$typeName:="Blob"
	: ($type="P")
		$typeName:="Picture"
	: ($type="Z")
		$typeName:="Pointer"
	: ($type="8") | ($type="R")
		$typeName:="Real"
	: ($type="T") | ($type="S")
		$typeName:="Text"
	: ($type="X") | ($type="Y")
		$typeName:="Array"
	: ($type="V")  // without any certitude
		$typeName:="Variant"
	Else 
		$typeName:="None"
End case 
