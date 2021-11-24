//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // Method: "progressBar_getSvg_LB" written by Olivier Grimbert
  // Date and time: 22/03/20, 13:21:40
  // ----------------------------------------------------
  // Description: display a progress bar for a LB cell
  //
  // ----------------------------------------------------

C_POINTER:C301($ptr_LB;$ptr_LB_column)
C_REAL:C285($value;$3)
C_LONGINT:C283($type)
$ptr_LB:=$1
$ptr_LB_column:=$2
$value:=$3
If (Count parameters:C259>=4)
	$type:=$4
Else 
	$type:=0
End if 


C_LONGINT:C283($height;$width;$minWidth;$maxWidth)
$height:=LISTBOX Get rows height:C836($ptr_LB->;lk pixels:K53:22)
$width:=LISTBOX Get column width:C834($ptr_LB_column->;$minWidth;$maxWidth)+1

$0:=progressBar_getSvg ($width;$height;$value;$type)


