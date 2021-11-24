//%attributes = {}
  // Ad3ExpurgeNomLesion
$T:=$1
$T:=Replace string:C233($T;"£";"")
$T:=Replace string:C233($T;Char:C90(10);"")
$T:=Replace string:C233($T;<>ZCR;"")
$DerCar:=Substring:C12($T;Length:C16($T);1)
While ($DerCar=" ")
	$T:=Substring:C12($T;1;(Length:C16($T)-1))
	$DerCar:=Substring:C12($T;Length:C16($T);1)
End while 
$PremCar:=Substring:C12($T;1;1)
While ($PremCar=" ")
	$T:=Substring:C12($T;2)
	$PremCar:=Substring:C12($T;1;1)
End while 
$0:=$T
