//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
//De base :$0:=progressBar_getSvg ($width;$height;$value;$type)

#DECLARE($param : Object)

var $canvas : Text
var $value : Real
var $ptr_canvas : Pointer

$canvas:=$param.canvas
$value:=$param.value
$type:=$param.type

Case of 
	: ($value>=0)
		SET TIMER:C645(0)
		
		$ptr_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; $canvas)
		$ptr_canvas->:=progressBar_getSvg_object($ptr_canvas; $value; $type)
		
		$ptr_canvas:=OBJECT Get pointer:C1124(Object named:K67:5; "content")
		$ptr_canvas->:=$param.content
		
		//Pour objets :$ptr_canvas->:=progressBar_getSvg_object ($ptr_canvas;$value/100;1)
		// 0 : ligne
		// 1 : camembert
		
		//Pour une listbox : $ptr_LB_progressImg->{$line}:=progressBar_getSVG_LB ($ptr_LB;$ptr_LB_progressImg;$nb_records/$ptr_LB_maxi->{$line})
		PROCESS_sleep(5)
		
	: ($value=-1)
		SET TIMER:C645(10)
		
End case 
