C_OBJECT:C1216($form)
C_LONGINT:C283($win)

If (Form event code:C388=On Double Clicked:K2:5)
	Case of 
		: (Form:C1466.field.kind=Null:C1517)
			  // nothing
			
		: (Form:C1466.field.kind="storage")
			  // field, do nothing
			
		: (Form:C1466.field.kind="relatedEntity")
			$form:=New object:C1471
			$form.ds:=Form:C1466.ds
			$form.table:=Form:C1466.ds[Form:C1466.field.content]
			$form.tablename:=Form:C1466.field.content
			$form.entity:=Form:C1466.entity[Form:C1466.field.name]
			
			$win:=Open form window:C675("_dataByOrda_detail")
			DIALOG:C40("_dataByOrda_detail";$form;*)
			
		: (Form:C1466.field.kind="relatedEntities")
			$form:=New object:C1471
			$form.ds:=Form:C1466.ds
			$form.table:=Form:C1466.ds[Form:C1466.field.content]
			$form.tablename:=Form:C1466.field.content
			$form.list:=Form:C1466.entity[Form:C1466.field.name]
			
			$win:=Open form window:C675("_dataByOrda")
			DIALOG:C40("_dataByOrda";$form;*)
	End case 
End if 