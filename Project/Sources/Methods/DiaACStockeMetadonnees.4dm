//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 20/04/20, 04:56:50
// ----------------------------------------------------
// Méthode : AntichambreStockeMetadonnees
// Description
// Méthode qui stocke les métadonnées de la photo
//   de l'enregistrement courant de [Diapositives]
// ----------------------------------------------------

$CDImage:=<>CDPhotosSauveAsaDia+String:C10([Diapositives:40]NumOrdreDiapos:1)+".jpg"
If (Test path name:C476($CDImage)=Est un document:K24:1)
	DELETE DOCUMENT:C159($CDImage)
End if 
WRITE PICTURE FILE:C680($CDImage; VarImage)
$Pr:=Execute on server:C373("DiaACServeurCopiePhoto"; 0; "CopiePhoto"; [Diapositives:40]NumOrdreDiapos:1; <>CDPhotosSauveAsaDia)
