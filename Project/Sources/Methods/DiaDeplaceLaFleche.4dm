//%attributes = {"publishedWeb":true,"lang":"fr"}
// DéplaceLaFleche

Case of 
	: (PUMAction=1)  // flèches d'orientation
		//DeplaceFlecheOrientation
		
	: (PUMAction=2)  // flèches de diagnose
		//DeplaceFlecheDiagnose (VarImageFlecheD)
		
	: (PUMAction=3)  // flèches d'explication de la lésion
		DiaDeplaceFlecheLesion($1)
End case 