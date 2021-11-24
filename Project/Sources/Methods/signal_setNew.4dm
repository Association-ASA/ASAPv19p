//%attributes = {"lang":"fr"}
#DECLARE($signal : Object; $expected : Integer)

Use ($signal)
	$signal.nbResult:=$expected
	$signal.resultats:=New shared collection:C1527()
End use 