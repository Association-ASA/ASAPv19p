CONFIRM:C162("Apply update?")
Form:C1466.confirm:=False:C215
If (OK=1)  // Massive update
	
	Form:C1466.att1:=(OBJECT Get pointer:C1124(Object named:K67:5; "cbAtt1"))->
	Form:C1466.att2:=(OBJECT Get pointer:C1124(Object named:K67:5; "cbAtt2"))->
	Form:C1466.att3:=(OBJECT Get pointer:C1124(Object named:K67:5; "cbAtt3"))->
	Form:C1466.att4:=(OBJECT Get pointer:C1124(Object named:K67:5; "cbAtt4"))->
	Form:C1466.att5:=(OBJECT Get pointer:C1124(Object named:K67:5; "cbAtt5"))->
	Form:C1466.att6:=(OBJECT Get pointer:C1124(Object named:K67:5; "cbAtt6"))->
	Form:C1466.att7:=(OBJECT Get pointer:C1124(Object named:K67:5; "cbAtt7"))->
	Form:C1466.confirm:=True:C214
End if 