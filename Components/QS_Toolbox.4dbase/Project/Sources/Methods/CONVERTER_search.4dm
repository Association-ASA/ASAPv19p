//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
$Search:=(OBJECT Get pointer:C1124(Object named:K67:5;OBJECT Get name:C1087(Object current:K67:2)))->

If ($Search="")
	If (Form:C1466.display#Null:C1517)
		If (Form:C1466.konstant=True:C214)
			Form:C1466.display:=Form:C1466.konstante
		Else 
			Form:C1466.display:=Form:C1466.command
		End if 
	End if 
	
Else 
	
	$toSearch:="@"+$search+"@"
	If (Form:C1466.konstant=True:C214)
		Form:C1466.display:=Form:C1466.konstante.query("EN = :1 | FR = :1 | token =:1";$toSearch)
	Else 
		Form:C1466.display:=Form:C1466.command.query("EN = :1 | FR = :1 | token =:1";$toSearch)
	End if 
End if 

$txt:="Found "+String:C10(Form:C1466.display.length)+" references."
displayInfo ($txt;"blue")