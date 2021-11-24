//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 18/04/20, 07:00:15
  // ----------------------------------------------------
  // Méthode : DiaServeurCopiePhoto
  // Description
  // Méthode qui fait copier par le serveur 
  //  la photo dont le n° est passé en paramètre
  // Paramètres : N° de la photo (numérique)
  // ----------------------------------------------------
C_LONGINT:C283($1;$NumPhotoN)
If (Application type:C494=4D mode distant:K5:5)
	ALERT:C41("Cette méthode est à exécuter sur le serveur...")
Else 
	$NumPhotoN:=$1
	$SourceIG:=<>CDPhotosWeb+String:C10($NumPhotoN)+".jpg"  // l'image en grand
	$OK:=(Test path name:C476($SourceIG)=Est un document:K24:1)
	If ($OK)
		$SourceGI:=<>CDPhotosWeb+String:C10($NumPhotoN)+"i.jpg"  // la grande imagette
		$OK:=(Test path name:C476($SourceGI)=Est un document:K24:1)
	End if 
	
	If ($OK)
		$SourcePI:=<>CDPhotosWeb+String:C10($NumPhotoN)+"is.jpg"  // la petite imagette
		$OK:=(Test path name:C476($SourcePI)=Est un document:K24:1)
	End if 
	
	If ($OK)  // toutes les images sont en place
		
		
		
		  // Copie de la photo principale
		$Cible:=<>PermCheDossierAsaDiaWeb+String:C10($1)+".jpg"
		If (Test path name:C476($Cible)=Est un document:K24:1)
			DELETE DOCUMENT:C159($Cible)
		End if 
		COPY DOCUMENT:C541($SourceIG;$Cible)
		
		  // Copie de la grande imagette
		$Cible:=<>PermCheDossierAsaDiaWeb+String:C10($1)+"i.jpg"
		If (Test path name:C476($Cible)=Est un document:K24:1)
			DELETE DOCUMENT:C159($Cible)
		End if 
		COPY DOCUMENT:C541($SourceGI;$Cible)
		
		  // Copie de la petite imagette
		$Cible:=<>PermCheDossierAsaDiaWeb+String:C10($1)+"is.jpg"
		If (Test path name:C476($Cible)=Est un document:K24:1)
			DELETE DOCUMENT:C159($Cible)
		End if 
		COPY DOCUMENT:C541($SourcePI;$Cible)
	End if 
End if 
