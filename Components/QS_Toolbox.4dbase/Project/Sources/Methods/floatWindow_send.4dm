//%attributes = {"invisible":true}
  // floatwindow_send

C_TEXT:C284($1;$2)
C_OBJECT:C1216($message)

$message:=New object:C1471("timeStamp";String:C10(Current time:C178)+" ("+String:C10(Milliseconds:C459)+")";"process";$1;"message";$2)
$ref_window:=Num:C11(Storage:C1525.windows.floatwindow)
If ($ref_window>0)
	CALL FORM:C1391($ref_window;"floatWindow_update";$message)
End if 