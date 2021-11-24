//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // XXXX - Need to be evaluate
  // method: Sort_Array_By_Length
  // parameters
  // $1 - Pointer to array to be sorted
  // $2 - (1) to sort by increasing order, (-1) to sort by decreasing order
  // http://kb.4d.com/assetid=77203
  // ----------------------------------------------------

C_POINTER:C301($arr;$1)
C_LONGINT:C283($i;$order;$2)
$arr:=$1

If (Count parameters:C259>1)
	
	$order:=$2
	
	If ($order#1) & ($order#-1)
		$order:=1
	End if 
	
Else 
	
	$order:=1
	
End if 

$arrSize:=Size of array:C274($arr->)
ARRAY LONGINT:C221($arrL;0x0000)

For ($i;1;$arrSize)
	APPEND TO ARRAY:C911($arrL;Length:C16(String:C10($arr->{$i})))
End for 

ARRAY POINTER:C280($ptrArr;2)
ARRAY LONGINT:C221($srtArr;2)
$ptrArr{1}:=$arr
$srtArr{1}:=0
$ptrArr{2}:=->$arrL
$srtArr{2}:=$order
MULTI SORT ARRAY:C718($ptrArr;$srtArr)
