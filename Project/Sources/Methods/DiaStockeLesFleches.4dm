//%attributes = {"publishedWeb":true,"lang":"fr"}
// StockeLesFleches
//repère des fleches
// {$1} présent si image verticale
$L:=VarImageFleche+1
$NomFleche:=String:C10(VarImageFleche+1)+"1"+(Num:C11(VarImageVerticale)*"V")

$Pt:=Get pointer:C304("VarC"+$NomFleche)
$PtA:=Get pointer:C304("VarC"+$NomFleche+"A")
OBJECT GET COORDINATES:C663(*; $NomFleche; Fgauche; Fhaut; Fdroite; Fbas)
//Si (VarImageVerticale)
//OBJET LIRE COORDONNÉES(VarImageV;FgaucheI;FhautI;FdroiteI;FbasI)
//Sinon
OBJECT GET COORDINATES:C663(VarImage; FgaucheI; FhautI; FdroiteI; FbasI)
//Fin de si
$LargeurPhoto:=FdroiteI-FgaucheI
$HauteurPhoto:=FbasI-FhautI
//déduisons les proportions des coordonnées du bout de la fleche
If (FBas<FbasI)
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
	$ComA:=Num:C11($PtA->#"")*("£"+$PtA->)
	TbTb{$L}:=$NomFleche+" "+String:C10(X)+" "+String:C10(Y)+" "+$Pt->+$ComA
	If (TbTCa{$L}=0)
		TbTCa{$L}:=10
	End if 
	ZVariableVersBlob(->[Diapositives:40]BlobFleches:21; ->TbTb; ->TbLHT; ->TbTCa)
	[Diapositives:40]DiapoCommentaire:26:=(BLOB size:C605([Diapositives:40]BlobFleches:21)>0)
	SAVE RECORD:C53([Diapositives:40])
End if 