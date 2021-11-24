//%attributes = {"lang":"fr"}
// AfficheTripletteSlash
$esp:=Substring:C12([Diapositives:40]Espece:3; 1; Length:C16([Diapositives:40]Espece:3)-1)
$esp:=Lowercase:C14(Substring:C12($esp; 1; 1))+Substring:C12($esp; 2)

If (PermRetrait)
	$0:=[Diapositives:40]MotifSaisieDGAL:23+" / "+[Diapositives:40]Organe:2+" / "+$esp
Else 
	$NL:=Uppercase:C13(Substring:C12([Diapositives:40]NomLesion:4; 1; 1))+Substring:C12([Diapositives:40]NomLesion:4; 2)
	$0:=$NL+" / "+[Diapositives:40]Organe:2+" / "+$esp
End if 

If (Count parameters:C259=1)  // on ajoute le n° de diapo
	$0:="n° "+String:C10([Diapositives:40]NumOrdreDiapos:1)+" : "+$0
End if 