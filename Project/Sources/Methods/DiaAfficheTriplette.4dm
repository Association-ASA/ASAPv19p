//%attributes = {"publishedWeb":true}

  // AfficheTriplette
$Esp:=[Diapositives:40]Espece:3
If ($Esp[[Length:C16($Esp)]]="s")
	$esp:=Substring:C12($esp;1;Length:C16($esp)-1)
End if 
$esp:=Lowercase:C14($esp)
If (PermRetrait)
	$0:=[Diapositives:40]MotifSaisieDGAL:23+" sur "+[Diapositives:40]Organe:2+" chez un "+$esp
Else 
	$NL:=Uppercase:C13(Substring:C12([Diapositives:40]NomLesion:4;1;1))+Substring:C12([Diapositives:40]NomLesion:4;2)
	$0:=$NL+" sur "+[Diapositives:40]Organe:2+" chez un "+$esp
End if 