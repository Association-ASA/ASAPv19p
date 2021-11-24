//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 19/02/19, 05:49:55
  // ----------------------------------------------------
  // Méthode : AdGibierImporteListe
  // Description
  // Importe du fichier des experts la liste des photos 
  //  et note le chemin des photos correspondantes 
  // avant de mettre tout cela dans l'enregistrement de [XDonnees]
  // pour traitement ultérieur
  // ----------------------------------------------------

C_LONGINT:C283($L;$Pos;$HauteurN;$LargeurN;$TailleFichier;$Salé;$FT)
C_PICTURE:C286($Image)
If (VarCDDossierPhotos="")
	$CDPhotos:=Select folder:C670("Où se trouvent les images ?")
Else 
	$CDPhotos:=VarCDDossierPhotos
End if 
  // Repérage des tag existants
DOCUMENT LIST:C474(<>CDTags;TbNomTag;Ignorer invisibles:K24:16)
VarCDDossierPhotos:=$CDPhotos
  //$CDPhotosEcartées:=$CDPhotos+"Ecartées"+Séparateur dossier
  //$CDPhotosRetenues:=$CDPhotos+"Retenues"+Séparateur dossier
  //$CDPhotosIgnorées:=$CDPhotos+"Ignorées"+Séparateur dossier
  // listons les images
DOCUMENT LIST:C474($CDPhotos;TbNomFichiersImage;Ignorer invisibles:K24:16)
  //COPIER TABLEAU(TbNomFichiersImage;TbNomImagesIgnorées)
USE CHARACTER SET:C205("macintosh";1)
If (VarCDListePhotos="")
	$Doc:=Open document:C264("";Mode lecture:K24:5)
Else 
	$Doc:=Open document:C264(VarCDListePhotos;Mode lecture:K24:5)
End if 
RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
If ($Ligne#"Ref@")
	ALERT:C41("Désolé, le fichier désigné n'est pas le bon...")
Else 
	VarCDListePhotos:=Document
	  // les données du fichier texte
	  // Ref Lien Espèce Auteur Organe Description anatomo-pathologique Nom de la lésion Étiologie Décision
	ARRAY TEXT:C222(TbRef;0)
	ARRAY TEXT:C222(TbLien;0)
	ARRAY TEXT:C222(TbEspèce;0)
	ARRAY TEXT:C222(TbAuteur;0)
	ARRAY TEXT:C222(TbOrgane;0)
	ARRAY TEXT:C222(TbDescription;0)
	ARRAY TEXT:C222(TbNomLésion;0)
	ARRAY TEXT:C222(TbÉtiologie;0)
	ARRAY TEXT:C222(TbChemin;0)
	ARRAY TEXT:C222(TbDécision;0)
	  // les données des images
	ARRAY TEXT:C222(TbDimensions;0)
	
	RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
	While ($Ligne#"")
		$Ligne:=Replace string:C233($Ligne;Char:C90(10);"")
		$Pos:=Position:C15(<>ZTab;$Ligne)
		$Ref:=Substring:C12($Ligne;1;($Pos-1))
		While ($Ref[[1]]=" ")
			$Ref:=Substring:C12($Ref;2)
		End while 
		While ($Ref[[Length:C16($Ref)]]=" ")
			$Ref:=Substring:C12($Ref;1;Length:C16($Ref)-1)
		End while 
		If ($ref#"")
			$ligne:=Substring:C12($Ligne;($Pos+1))
			$Test:=$Ref+"@"
			$L:=Find in array:C230(TbNomFichiersImage;$Test)
			If ($L<0)
				TRACE:C157
			Else 
				$Pos:=Position:C15(<>ZTab;$Ligne)
				$Lien:=Substring:C12($Ligne;1;($Pos-1))
				$ligne:=Substring:C12($Ligne;($Pos+1))
				
				$CDPhotoEnCours:=$CDPhotos+TbNomFichiersImage{$L}
				APPEND TO ARRAY:C911(TbChemin;$CDPhotoEnCours)
				  //$L2:=Chercher dans tableau(TbNomImagesIgnorées;TbNomFichiersImage{$L})
				  //Si ($L2>0)
				  //SUPPRIMER DANS TABLEAU(TbNomImagesIgnorées;$L2)
				  //Fin de si 
				  //Au cas ou 
				
				  //: (($Lien="") & (PUMTypePhotoG=1) | (($Lien#"") & (PUMTypePhotoG=2)))  // non retenue dans le contexte des retenues
				  //$CDPhotoEcartées:=$CDPhotosEcartées+TbNomFichiersImage{$L}
				  //Si (Tester chemin acces($CDPhotoEcartées)#Est un document) & (Nombre de paramètres=0)
				  //COPIER DOCUMENT($CDPhotoEnCours;$CDPhotoEcartées)
				  //Fin de si 
				
				  //: (($Lien#"") & (PUMTypePhotoG=1) | (($Lien="") & (PUMTypePhotoG=2)))
				  //$CDPhotoRetenues:=$CDPhotosRetenues+TbNomFichiersImage{$L}
				If (Test path name:C476($CDPhotoEnCours)#Est un document:K24:1)
					TRACE:C157
				Else 
					READ PICTURE FILE:C678($CDPhotoEnCours;$Image)
					PICTURE PROPERTIES:C457($Image;$LargeurN;$HauteurN)
					$TailleFichier:=Get document size:C479($CDPhotoEnCours)/1000  // en Ko
					$Dimension:="L:"+String:C10($LargeurN)+"  H:"+String:C10($HauteurN)+"  P:"+String:C10(Round:C94($TailleFichier/1000;2))+"Mo"
					APPEND TO ARRAY:C911(TbDimensions;$Dimension)
				End if 
				
				
				$Pos:=Position:C15(<>ZTab;$Ligne)
				$Espèce:=Substring:C12($Ligne;1;($Pos-1))
				$Ajout:=Num:C11(Find in array:C230(<>TbDiaposEspece;$Espèce)<0)*" (non trouvé)"
				$Espèce:=$Espèce+$Ajout
				$ligne:=Substring:C12($Ligne;($Pos+1))
				
				$Pos:=Position:C15(<>ZTab;$Ligne)
				$Auteur:=Substring:C12($Ligne;1;($Pos-1))
				$NomTag:="TagPhoto"+$Auteur+"@"
				$Ajout:=Num:C11(Find in array:C230(TbNomTag;$NomTag)<0)*" (A créer)"
				$Auteur:=$Auteur+$Ajout
				$ligne:=Substring:C12($Ligne;($Pos+1))
				
				$Pos:=Position:C15(<>ZTab;$Ligne)
				$Organe:=Substring:C12($Ligne;1;($Pos-1))
				$Ajout:=Num:C11(Find in array:C230(<>TbDiaposOrgane;$Organe)<0)*" (non trouvé)"
				$Organe:=$Organe+$Ajout
				$ligne:=Substring:C12($Ligne;($Pos+1))
				
				$Pos:=Position:C15(<>ZTab;$Ligne)
				$Description:=Substring:C12($Ligne;1;($Pos-1))
				$ligne:=Substring:C12($Ligne;($Pos+1))
				
				$Pos:=Position:C15(<>ZTab;$Ligne)
				$NomLésion:=Substring:C12($Ligne;1;($Pos-1))
				$Ajout:=Num:C11(Find in array:C230(<>TbDiaposNomLesion;$NomLésion)<0)*" (non trouvé)"
				$NomLésion:=$NomLésion+$Ajout
				$ligne:=Substring:C12($Ligne;($Pos+1))
				
				$Pos:=Position:C15(<>ZTab;$Ligne)
				$Étiologie:=Substring:C12($Ligne;1;($Pos-1))
				$ligne:=Substring:C12($Ligne;($Pos+1))
				
				$Pos:=Position:C15(<>ZTab;$Ligne)
				$Décision:=Substring:C12($Ligne;1;($Pos-1))
				
				
				APPEND TO ARRAY:C911(TbRef;$Ref)
				APPEND TO ARRAY:C911(TbLien;$Lien)
				APPEND TO ARRAY:C911(TbEspèce;$Espèce)
				APPEND TO ARRAY:C911(TbOrgane;$Organe)
				APPEND TO ARRAY:C911(TbAuteur;$Auteur)
				APPEND TO ARRAY:C911(TbDescription;$Description)
				APPEND TO ARRAY:C911(TbNomLésion;$NomLésion)
				APPEND TO ARRAY:C911(TbÉtiologie;$Étiologie)
				APPEND TO ARRAY:C911(TbDécision;$Décision)
			End if 
		End if 
		RECEIVE PACKET:C104($Doc;$Ligne;<>ZCR)
	End while 
	If (False:C215)
		  //  // occupons-nous des ignorées
		
		  //C_ENTIER LONG($Salé;$FT)
		  //$FT:=Taille tableau(TbNomImagesIgnorées)
		  //Boucle ($Salé;1;$FT)
		  //$PhotoIgnorée:=TbNomImagesIgnorées{$Salé}
		  //$CDPhotoIgnorée:=$CDPhotos+$PhotoIgnorée
		  //$CD:=$CDPhotosIgnorées+$PhotoIgnorée
		  //Si (Tester chemin acces($CD)#Est un document)
		  //COPIER DOCUMENT($CDPhotoIgnorée;$CD)
		  //Fin de si 
		  //Fin de boucle 
		
		  //$Rapport:="Ref"+<>ZTab+"Lien"+<>ZTab+"Espèce"+<>ZTab+"Auteur"+<>ZTab+"Organe"+<>ZTab
		  //$Rapport:=$Rapport+"Description anatomo-pathologique"+<>ZTab+"Nom de la lésion"+<>ZTab+"Étiologie"<>ZTab
		  //$Rapport:=$Rapport+"Décision"+<>ZTab+"Largeur"+<>ZTab+"Hauteur"+<>ZTab+"Poids"+<>ZTab+"Chemin"+<>ZCR
		
		  //$FT:=Taille tableau(TbRef)
		  //Boucle ($Salé;1;$FT)
		  //$Rapport:=$Rapport+TbRef{$Salé}+<>ZTab+TbLien{$Salé}+<>ZTab+TbEspèce{$Salé}+<>ZTab+TbOrgane{$Salé}+<>ZTab+TbDescription{$Salé}+<>ZTab
		  //$Rapport:=$Rapport+TbNomLésion{$Salé}+<>ZTab+TbÉtiologie{$Salé}+<>ZTab+TbFicheRéflexe{$Salé}+<>ZTab+TbNPC{$Salé}+<>ZTab
		  //$Rapport:=$Rapport+TbDécision{$Salé}+<>ZTab+TbDimensions{$Salé}+<>ZTab+TbHaut{$Salé}+<>ZTab+TbPoids{$Salé}+<>ZTab+TbChemin{$Salé}+<>ZCR
		  //Fin de boucle 
		  //  //FIXER TEXTE DANS CONTENEUR($Rapport)
		  //  //LECTURE ÉCRITURE([XDonnees])
		  //  //CHERCHER([XDonnees];[XDonnees]XType="AsaDiaG";*)
		  //  //CHERCHER([XDonnees];[XDonnees]XNom="Liste AsaDia Gibier")
		  //  //Si (Enregistrements trouvés([XDonnees])=0)
		  //  //CRÉER ENREGISTREMENT([XDonnees])
		  //  //[XDonnees]XType:="AsaDiaG"
		  //  //[XDonnees]XNom:="Liste AsaDia Gibier"
		  //  //Fin de si 
		  //  //VariableVersBlob (->[XDonnees]XBlob;->TbRef;->TbLien;->TbEspèce;->TbOrgane;->TbAuteur;->TbDescription;->TbNomLésion;->TbÉtiologie;->TbDécision;->TbLargeur;->TbHaut;->TbPoids;->TbChemin)
		  //  //STOCKER ENREGISTREMENT([XDonnees])
		  //  //ZAmnistiePartielle (->[XDonnees])
		  //  //Fin de si 
	End if 
End if 

USE CHARACTER SET:C205(*;1)