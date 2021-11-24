//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 22/06/20, 09:30:56
  // ----------------------------------------------------
  // Méthode : QuizzDetruitPhotoSup
  // Description
  // Méthode executée sur le serveur qui détruit les photos 
  //   ajoutées pour les questionnaires
  // Paramètre : $1=numéro d'enregistrement dans [XDonnees]
  // ----------------------------------------------------
$NumEnr:=$1
READ WRITE:C146([DiaData:45])
GOTO RECORD:C242([DiaData:45];$NumEnr)
$NomFichierImage:="Q"+[DiaData:45]XAlpha:14+String:C10([DiaData:45]XEntier:2;"00000")+"i.jpg"
$cd:=<>CDPhotosSauveAsaDia+$NomFichierImage
If (Test path name:C476($cd)=Est un document:K24:1)
	DELETE DOCUMENT:C159($cd)
End if 
$cd:=<>PermCheDossierAsaDiaWeb+$NomFichierImage
If (Test path name:C476($cd)=Est un document:K24:1)
	DELETE DOCUMENT:C159($cd)
End if 
$NomFichierImage:="Q"+[DiaData:45]XAlpha:14+String:C10([DiaData:45]XEntier:2;"00000")+".jpg"
$cd:=<>CDPhotosSauveAsaDia+$NomFichierImage
If (Test path name:C476($cd)=Est un document:K24:1)
	DELETE DOCUMENT:C159($cd)
End if 
$cd:=<>PermCheDossierAsaDiaWeb+$NomFichierImage
If (Test path name:C476($cd)=Est un document:K24:1)
	DELETE DOCUMENT:C159($cd)
End if 
DELETE RECORD:C58([DiaData:45])