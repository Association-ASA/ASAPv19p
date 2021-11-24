//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 27/12/15, 07:14:38
  // ----------------------------------------------------
  // Méthode : WebTextesListesLesions
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
$Rech:=(Count parameters:C259=0)
If (PUMListe=1)  // DGAL
	If ($Rech)
		QUERY:C277([DiaMotifSaisieDGAL:42];[DiaMotifSaisieDGAL:42]TypeListe:8="a")
	End if 
	SELECTION TO ARRAY:C260([DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1;Colonne2)
Else   // ENV
	If ($Rech)
		ALL RECORDS:C47([DiaLesions:44])
	End if 
	SELECTION TO ARRAY:C260([DiaLesions:44]NomLesion:1;Colonne2)
End if 
SORT ARRAY:C229(Colonne2;>)
