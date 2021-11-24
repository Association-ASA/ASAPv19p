//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 06/05/20, 14:46:17
  // ----------------------------------------------------
  // Méthode : Ad3SupprimePhoto
  // Description
  // Méthode qui supprime la photo dont le n° est passé en paramètre
  //   ainsi que les fichiers des photos dans PhotosAsaDia (DB et dossier racine HTML)
  // Paramètre : N° de la diapo (entier long)
  // ----------------------------------------------------
C_LONGINT:C283($1;$NumPhotoN)
$NumPhotoN:=$1
  // TRACE
READ WRITE:C146([Diapositives:40])
QUERY:C277([Diapositives:40];[Diapositives:40]NumOrdreDiapos:1=$NumPhotoN)

  // Suppression des fichiers des photos dans PhotosAsaDia (DB et dossier racine HTML)
  // PhotosAsaDia dans DB
For ($Fumé;1;3)
	$ext:=(Num:C11($Fumé=1)*".jpg")+(Num:C11($Fumé=2)*"i.jpg")+(Num:C11($Fumé=3)*"is.jpg")
	$CDPhotosAsaDiaDB:=<>CDPhotosSauveAsaDia+String:C10([Diapositives:40]NumOrdreDiapos:1)+$ext
	If (Test path name:C476($CDPhotosAsaDiaDB)=Est un document:K24:1)
		DELETE DOCUMENT:C159($CDPhotosAsaDiaDB)
	End if 
End for 

  // PhotosAsaDia dans DB
For ($Fumé;1;3)
	$ext:=(Num:C11($Fumé=1)*".jpg")+(Num:C11($Fumé=2)*"i.jpg")+(Num:C11($Fumé=3)*"is.jpg")
	$CDPhotosAsaDiaDB:=<>PermCheDossierAsaDiaWeb+String:C10([Diapositives:40]NumOrdreDiapos:1)+$ext
	If (Test path name:C476($CDPhotosAsaDiaDB)=Est un document:K24:1)
		DELETE DOCUMENT:C159($CDPhotosAsaDiaDB)
	End if 
End for 

  // Suppression de [Diapositives]

DELETE RECORD:C58([Diapositives:40])
