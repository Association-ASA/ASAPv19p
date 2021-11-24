//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 07/12/18, 09:10:35
  // ----------------------------------------------------
  // Méthode : AntichambreSupprimePhotos
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

$FT:=Records in set:C195("$ListboxVisuAC")
USE SET:C118("$ListboxVisuAC")
If ($FT>0)
	If ($FT=1)
		CONFIRM:C162("Supprimer la photo")
	Else 
		CONFIRM:C162("Supprimer "+String:C10($FT)+" photos")
	End if 
	If (OK=1)
		READ WRITE:C146([DiaData:45])
		APPLY TO SELECTION:C70([DiaData:45];[DiaData:45]XAlpha:14:="Ecartée")
		ZAmnistiePartielle (->[DiaData:45])
		$Type:="AjoutDia"+(Num:C11(VarPOD=1)*"POD")+(Num:C11(PUMTypePhoto=2)*"G")
		QUERY:C277([DiaData:45];[DiaData:45]XType:5=$Type;*)
		QUERY:C277([DiaData:45]; & [DiaData:45]XAlpha:14="A traiter")
		NbDia:=Records in selection:C76([DiaData:45])
		SELECTION TO ARRAY:C260([DiaData:45]XTexte:7;TbCheminsDiaFaites)
	End if 
End if 