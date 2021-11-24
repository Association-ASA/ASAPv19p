$A:=PUMLésions{PUMLésions}
$CR:=Char:C90(13)
If ([DiaMotifSaisieDGAL:42]LesionsLiees:12="")
	[DiaMotifSaisieDGAL:42]LesionsLiees:12:=$A
Else 
	[DiaMotifSaisieDGAL:42]LesionsLiees:12:=[DiaMotifSaisieDGAL:42]LesionsLiees:12+$CR+$A
End if 