//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 25/03/20, 11:08:52
// ----------------------------------------------------
// Méthode : StatsEtatAnnuelPleinePage
// Description
// Méthode qui permet de faire le bilan annuel par mois
//  du visonnage en pleine page des photos.
// ----------------------------------------------------
$Dem:=Request:C163("Quelle année"; String:C10(Year of:C25(Current date:C33)-1))
If (OK=1)
	$DateDeb:=Date:C102("01/01/"+$Dem)
	$DateFin:=Date:C102("01/01/"+String:C10(Num:C11($Dem)+1))
	QUERY:C277([DiaPistePhotos:41]; [DiaPistePhotos:41]DateAffichage:3>=$DateDeb; *)
	QUERY:C277([DiaPistePhotos:41];  & [DiaPistePhotos:41]IDVisiteur:5="@.gouv.fr"; *)
	QUERY:C277([DiaPistePhotos:41];  & [DiaPistePhotos:41]DateAffichage:3<$DateFin)
	SELECTION TO ARRAY:C260([DiaPistePhotos:41]DateAffichage:3; $TbDate)
	ARRAY LONGINT:C221($TbNbVisio; 0)
	ARRAY LONGINT:C221($TbNbVisio; 12)
	$FT:=Size of array:C274($TbDate)
	For ($Salé; 1; $FT)
		$Mois:=Month of:C24($TbDate{$Salé})
		$TbNbVisio{$Mois}:=$TbNbVisio{$Mois}+1
	End for 
	$Rapport:=ZTableauVersTexte(->$TbNbVisio; <>ZTab)
	SET TEXT TO PASTEBOARD:C523($Rapport)
End if 