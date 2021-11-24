DiaSimuleLienAlpha (->[DiaLesions:44]NomLesion:1;->[Diapositives:40]NomLesion:4;False:C215;"")
[Diapositives:40]GrandTypeLesionnel:5:=[DiaLesions:44]GrandTypeLesionnel:2
[Diapositives:40]TypeLesionnelPrecis:6:=[DiaLesions:44]TypeLesionnelPrecis:3
[Diapositives:40]DescriptionTypeLesion:8:=[DiaLesions:44]DescriptionTypeMacro:4
[Diapositives:40]MotifSaisie:12:=[DiaLesions:44]MotifSaisie:7
[Diapositives:40]JustificationConduite:13:=[DiaLesions:44]JustificationConduite:8
[Diapositives:40]NPC:14:=[DiaLesions:44]NPC:9
[Diapositives:40]ReferenceReglementaireFrance:19:=[DiaLesions:44]ReferenceReglementaireFr:13
_O_ARRAY STRING:C218(80;ZdDNLR;0)
$NPC:=[DiaLesions:44]NPC:9
$Rang:=Position:C15(<>ZCR;$NPC)
While ($Rang>0)
	APPEND TO ARRAY:C911(ZdDNLR;Substring:C12($NPC;1;$Rang-1))
	$NPC:=Substring:C12($NPC;$Rang+1;10000)
	$Rang:=Position:C15(<>ZCR;$NPC)
End while 
VarSaisieNomLésion:=""
[Diapositives:40]Frequence:17:=[DiaLesions:44]Frequence:11
[Diapositives:40]Synonymes:15:=[DiaLesions:44]LesionsApparentees:10

  // cherchons le motif de saisie
ARRAY TEXT:C222(PUMSDGAL;0)
$MSDGAL:=[DiaLesions:44]MotifSaisieDGAL:15
$Pos:=Position:C15(<>ZCR;$MSDGAL)
While ($Pos>0)
	APPEND TO ARRAY:C911(PUMSDGAL;Substring:C12($MSDGAL;1;($pos-1)))
	$MSDGAL:=Substring:C12($MSDGAL;($Pos+1))
	$Pos:=Position:C15(<>ZCR;$MSDGAL)
End while 
APPEND TO ARRAY:C911(PUMSDGAL;$MSDGAL)
If ([Diapositives:40]MotifSaisieDGAL:23=""\
) & (Size of array:C274(PUMSDGAL)>0)
	[Diapositives:40]MotifSaisieDGAL:23:=PUMSDGAL{1}
End if 
If ([Diapositives:40]ReferenceReglementaireUE:27=""\
)
	QUERY:C277([DiaMotifSaisieDGAL:42];[DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1=[Diapositives:40]MotifSaisieDGAL:23)
	[Diapositives:40]ReferenceReglementaireUE:27:=[DiaMotifSaisieDGAL:42]RefRegEuropeenne:5
End if 

  // plaçons le PUM Hiérarchique sur la valeur choisie
For ($salé;1;1000)
	GET LIST ITEM:C378(LTL;$Salé;NumElément;TextElément;RefSousListe)
	If ([Diapositives:40]GrandTypeLesionnel:5=TextElément)
		For ($fumé;1;1000)
			GET LIST ITEM:C378(RefSousListe;$fumé;NumSElément;TextSElément)
			If ([Diapositives:40]TypeLesionnelPrecis:6=TextSElément)
				$fumé:=1000
			End if 
		End for 
		$salé:=1000
	End if 
End for 
SELECT LIST ITEMS BY REFERENCE:C630(LTL;NumSElément)
REDRAW:C174(LTL)