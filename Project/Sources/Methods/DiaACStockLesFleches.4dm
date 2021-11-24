//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 19/04/20, 09:18:17
// ----------------------------------------------------
// Méthode : AntichambreStockLesFleches
// Description
// Méthode qui stocke les changements opérés
//  sur la page 2 de Antichambre 2
// Paramètre : aucun
// ----------------------------------------------------
CONFIRM:C162("Désirez-vous enregistrer les modifications ????"; "Oui c'est bien ça"; "Mais, non")
If (OK=1)
	// Stockage des flèches
	//repérage des flèches
	For ($Salé; 1; 4)
		TbTb{$Salé}:=""
		$NomFleche:=String:C10($Salé)+"1"
		$Pt:=Get pointer:C304("VarC"+$NomFleche)
		$PtA:=Get pointer:C304("VarC"+$NomFleche+"A")
		OBJECT GET COORDINATES:C663(*; $NomFleche; Fgauche; Fhaut; Fdroite; Fbas)
		OBJECT GET COORDINATES:C663(VarImage; FgaucheI; FhautI; FdroiteI; FbasI)
		$LargeurPhoto:=FdroiteI-FgaucheI
		$HauteurPhoto:=FbasI-FhautI
		//déduisons les proportions des coordonnées du bout de la fleche
		If (FBas<Bas)  // La flèche est dans le cadre
			Case of 
				: (VarImageFleche=0)  // Flèche pointe à droite
					X:=(Fdroite-FgaucheI)/$LargeurPhoto
					Y:=(Fhaut+((Fbas-Fhaut)/2)-FhautI)/$HauteurPhoto
					
				: (VarImageFleche=1)  // Flèche la pointe en bas
					X:=(Fgauche-FgaucheI+((Fdroite-Fgauche)/2)/$LargeurPhoto)
					Y:=(Fbas-FhautI)/$HauteurPhoto
					
				: (VarImageFleche=2)  // Flèche la pointe à gauche
					X:=(Fgauche-FgaucheI)/$LargeurPhoto
					Y:=(Fhaut-FhautI+((Fbas-Fhaut)/2))/$HauteurPhoto
					
				: (VarImageFleche=3)  // Flèche la pointe en haut
					X:=(Fgauche-FgaucheI+((Fdroite-Fgauche)/2)/$LargeurPhoto)
					Y:=(Fhaut-FhautI)/$HauteurPhoto
					
			End case 
			$Val:=$Pt->+(Num:C11($PtA->#"")*("£"+$PtA->))
			If (Length:C16($Val)>0)
				TbTb{$Salé}:=$NomFleche+" "+String:C10(X)+" "+String:C10(Y)+" "+$Val
			End if 
		End if 
		
	End for 
	ZVariableVersBlob(->[Diapositives:40]BlobFleches:21; ->TbTb; ->TbLHT; ->TbTCa)
	[Diapositives:40]DiapoCommentaire:26:=(BLOB size:C605([Diapositives:40]BlobFleches:21)>0)
	
	// le commentaire de la photographie
	[Diapositives:40]Commentaires:7:=VarComDia
	SAVE RECORD:C53([Diapositives:40])
	
End if 