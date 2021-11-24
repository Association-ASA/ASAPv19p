//%attributes = {"publishedWeb":true,"lang":"fr"}
// Visionneuse
ARRAY LONGINT:C221(TbNumDiapoExistantes; 0)
QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1>60000)
SELECTION TO ARRAY:C260([Diapositives:40]NumOrdreDiapos:1; TbNumDiapoExistantes)
<>PermLecteur:=<>Boss
QUERY:C277([Diapositives:40]; [Diapositives:40]Statut:18="var@"; *)
QUERY:C277([Diapositives:40];  | [Diapositives:40]Statut:18="ref@")
If (<>Boss)
	DiaGereListe(->[Diapositives:40]NomLesion:4; "Liste"; "ListImp"; "Liste"; "Saisie"; "FICHIMP"; ""; "")
Else 
	DiaGereListe(->[Diapositives:40]NomLesion:4; "Liste"; "ListImp"; "Liste"; "Visu"; "FICHIMP"; ""; "")
End if 