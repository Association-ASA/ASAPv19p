//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // method: TOGBTN_HANDLE_MOVE
  // handle on Mouse Move event for toggle button
  // $1 (Object) - Toggle Object

C_OBJECT:C1216($1;$togObj)
C_BOOLEAN:C305($vTracking)
C_LONGINT:C283($pos)
C_PICTURE:C286($pic)
$togObj:=$1

TOGOBJ_GET_VAL ($togObj;"Tracking";->$vTracking)

If ($vTracking)  // we are in tracking mode
	
	  // -- V16
	  // if (Not(Is waiting mouse up))
	  //$vTracking:=False  // stop the tracking mode
	  // TOGOBJ_SET_VAL ($togObj;"Tracking";->$vTracking)
	
	  //Else   // the object is still waiting for a mouse up
	
	$pos:=TOGBTN_MOVE ($togObj)
	$pic:=TOGOBJ_GET_PIC ($togObj;$pos)
	TOGCTN_SET_IMAGE ($togObj;$pic)
	
	  // end if
	
End if 
