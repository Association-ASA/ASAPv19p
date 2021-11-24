//%attributes = {"publishedWeb":true}
  // ClicDansPhotoFleche
If (MCE)
	DiaDeplaceLaFleche (VarImageFleche)
Else 
	DiaAgranditRatatinePhoto 
	OnMontreLesFleches:=(Not:C34(JAiGrandit) & (VarUneFleche))
	OnMontreLesOrientations:=(Not:C34(JAiGrandit) & (VarUneOrientation))
	OBJECT SET VISIBLE:C603(*;"FlecheBouton2";OnMontreLesFleches)
	OBJECT SET VISIBLE:C603(*;"OrientationBouton3";OnMontreLesOrientations)
End if 