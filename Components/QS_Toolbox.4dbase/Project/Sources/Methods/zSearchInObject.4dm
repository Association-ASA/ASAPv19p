//%attributes = {"invisible":true,"preemptive":"capable"}
C_OBJECT:C1216($obj)
$obj:=New object:C1471
  // --- your data-exaple ---
$obj["Method1"]:=New object:C1471("callers";New collection:C1472;"callees";New collection:C1472;"isVisible";True:C214;"isTreadSafe";True:C214)
$obj["Method2"]:=New object:C1471("callers";New collection:C1472;"callees";New collection:C1472;"isVisible";False:C215;"isTreadSafe";True:C214)
$obj["Method3"]:=New object:C1471("callers";New collection:C1472;"callees";New collection:C1472;"isVisible";True:C214;"isTreadSafe";False:C215)
$obj["Method4"]:=New object:C1471("callers";New collection:C1472;"callees";New collection:C1472;"isVisible";False:C215;"isTreadSafe";False:C215)
$obj["Method5"]:=New object:C1471("callers";New collection:C1472;"callees";New collection:C1472;"isVisible";True:C214;"isTreadSafe";False:C215)
TRACE:C157
C_COLLECTION:C1488($colIsVisible;$colIsTreadSafe)
  // ==========
  // variant 1: Result Collections with only method names
$colIsVisible:=New collection:C1472
$colIsTreadSafe:=New collection:C1472

For each ($methName;$obj)
	If ($obj[$methName].isVisible)
		$colIsVisible.push($methName)
	End if 
	If ($obj[$methName].isTreadSafe)
		$colIsTreadSafe.push($methName)
	End if 
End for each 
TRACE:C157
  // ==========
If (False:C215)  // just a alternativ, step in with debugger if you like to test this
	  // Alternativ result Collections with name+refOrgObj...
	  // you have a ref to orginal object but this not contains its name
	  // ...so i add name as new object leading prop name (but contains orginal obj)
	$colIsVisible:=New collection:C1472
	$colIsTreadSafe:=New collection:C1472
	For each ($methName;$obj)
		If ($obj[$methName].isVisible)
			$colIsVisible.push(New object:C1471($methName;$obj[$methName]))
		End if 
		If ($obj[$methName].isTreadSafe)
			$colIsTreadSafe.push(New object:C1471($methName;$obj[$methName]))
		End if 
	End for each 
End if 
TRACE:C157
  // ==========
If (False:C215)  // just a alternativ, step in with debugger if you like to test this
	  // Alternativ result Objects
	C_OBJECT:C1216($objIsVisible;$objIsTreadSafe)
	$objIsVisible:=New object:C1471
	$objIsTreadSafe:=New object:C1471
	For each ($methName;$obj)
		If ($obj[$methName].isVisible)
			$objIsVisible[$methName]:=$obj[$methName]
			  // when objOrgRef not needed, can set too True is enough to be #Null(what means prop is notUndefined)
			  // $objIsVisible[$methName]:=True
		End if 
		If ($obj[$methName].isTreadSafe)
			$objIsTreadSafe[$methName]:=$obj[$methName]
			  // when objOrgRef not needed, can set too True is enough to be #Null(what means prop is notUndefined)
			  // $objIsTreadSafe[$methName]:=True
		End if 
	End for each 
End if 
TRACE:C157
  // - EOF -