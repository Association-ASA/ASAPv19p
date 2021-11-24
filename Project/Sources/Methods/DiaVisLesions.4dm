//%attributes = {"publishedWeb":true,"lang":"fr"}
ALL RECORDS:C47([DiaLesions:44])
ORDER BY:C49([DiaLesions:44]; [DiaLesions:44]NomLesion:1; >)
SELECTION TO ARRAY:C260([DiaLesions:44]NomLesion:1; TbNomLésions)
If (<>Boss)
	DiaGereListe(->[DiaLesions:44]NomLesion:1; "Liste"; "ListImp"; "ListImp"; "Saisie"; "FichImp"; ""; "")
Else 
	DiaGereListe(->[DiaLesions:44]NomLesion:1; "Liste"; "ListImp"; "ListImp"; "Visu"; "FichImp"; ""; "")
End if 