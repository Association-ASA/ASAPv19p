C_OBJECT:C1216($form)
C_LONGINT:C283($win)

If (Form event code:C388=On Double Clicked:K2:5)
	$form:=New object:C1471
	$form.ds:=Form:C1466.ds
	$form.table:=Form:C1466.table
	$form.entity:=Form:C1466.detail
	
	$win:=Open form window:C675("_dataByOrda_detail")
	DIALOG:C40("_dataByOrda_detail";$form;*)
End if 