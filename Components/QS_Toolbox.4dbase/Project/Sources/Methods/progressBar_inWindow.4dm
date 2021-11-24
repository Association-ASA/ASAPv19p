//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_OBJECT:C1216($1)
C_TEXT:C284($canvas)
C_REAL:C285($value)
C_POINTER:C301($ptr_canvas)

$canvas:=$1.canvas
$value:=$1.value
$type:=$1.type

$ptr_canvas:=OBJECT Get pointer:C1124(Object named:K67:5;$canvas)
$ptr_canvas->:=progressBar_getSvg_object ($ptr_canvas;$value;$type)

If ($value=1)
	OBJECT SET VISIBLE:C603(*;$canvas;False:C215)
End if 