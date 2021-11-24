
$NomImage:=[DiaData:45]XAlpha:14+String:C10([DiaData:45]XEntier:2)
CONFIRM:C162("Voulez-vous détruire l'image "+<>ZGuil+$NomImage+<>ZGuil+"???")
If (OK=1)
	$Proc:=Execute on server:C373("QuizzDetruitPhotoSup"; 0; "SuppressionImageSup"; Record number:C243([DiaData:45]))
	DELAY PROCESS:C323(Current process:C322; 450)
	QuizzAfficheGestionPhotosSup
End if 