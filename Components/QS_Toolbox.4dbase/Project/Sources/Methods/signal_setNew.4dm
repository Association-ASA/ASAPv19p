//%attributes = {"invisible":true,"preemptive":"capable"}
#DECLARE($signal : Object; $expected : Integer)

Use ($signal)
	$signal.nbResult:=$expected
	$signal.resultats:=New shared collection:C1527()
End use 