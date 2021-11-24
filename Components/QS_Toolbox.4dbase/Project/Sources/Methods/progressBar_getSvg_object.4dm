//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // Method: "progressBar_getSvg_object" written by Olivier Grimbert
  // Date and time: 22/03/20, 13:23:08
  // ----------------------------------------------------
  // Description: display a progress bar for a form object
  //   
  // ----------------------------------------------------

C_POINTER:C301($ptr_object)
C_REAL:C285($value;$2)
C_LONGINT:C283($type)
$ptr_object:=$1
$value:=$2
If (Count parameters:C259>=3)
	$type:=$3
Else 
	$type:=0
End if 

C_LONGINT:C283($left;$top;$right;$bottom)
OBJECT GET COORDINATES:C663($ptr_object->;$left;$top;$right;$bottom)
C_LONGINT:C283($height;$width)
$height:=$bottom-$top
$width:=$right-$left

$0:=progressBar_getSvg ($width;$height;$value;$type)