C_LONGINT:C283($Salé; $FT)

QUERY:C277([DiaData:45]; [DiaData:45]XType:5="Wad3"; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XNom:1="@gouv.fr"; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XDate:3>=VarDateDeb; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XDate:3<=VarDateFin)
SELECTION TO ARRAY:C260([DiaData:45]XDate:3; $TbDateWeb)

QUERY:C277([DiaPistePhotos:41];  & [DiaPistePhotos:41]NumOrdreDiapo:2<80000; *)
QUERY:C277([DiaPistePhotos:41];  & [DiaPistePhotos:41]DateAffichage:3>=VarDateDeb; *)
QUERY:C277([DiaPistePhotos:41];  & [DiaPistePhotos:41]DateAffichage:3<=VarDateFin; *)
QUERY:C277([DiaPistePhotos:41];  & [DiaPistePhotos:41]TypeVisiteur:6="abattoirs")
SELECTION TO ARRAY:C260([DiaPistePhotos:41]DateAffichage:3; $TbDatePhotos)

// Remplissons les tableaux de la LB : TbNomMois, TbNbWeb, TbNbPhoto
COPY ARRAY:C226(<>ZTbNomDuMois; TbNomMois)
ARRAY LONGINT:C221(TbNbWeb; 0)
ARRAY LONGINT:C221(TbNbWeb; 12)
$FT:=Size of array:C274($TbDateWeb)
For ($Salé; 1; $FT)
	$Mois:=Month of:C24($TbDateWeb{$Salé})
	TbNbWeb{$Mois}:=TbNbWeb{$Mois}+1
End for 

ARRAY LONGINT:C221(TbNbPhoto; 0)
ARRAY LONGINT:C221(TbNbPhoto; 12)
$FT:=Size of array:C274($TbDatePhotos)
For ($Salé; 1; $FT)
	$Mois:=Month of:C24($TbDatePhotos{$Salé})
	TbNbPhoto{$Mois}:=TbNbPhoto{$Mois}+1
End for 

