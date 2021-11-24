//%attributes = {"publishedWeb":true,"lang":"fr"}
// RepereLesObjets
For ($salé; 1; 4)
	$NomFleche:=String:C10($Salé)+"1"
	OBJECT GET COORDINATES:C663(*; $NomFleche; Fgauche; Fhaut; Fdroite; Fbas)
	Case of 
		: ($Salé=1)  // fleche à droite
			YBF:=-(Fhaut+((Fbas-Fhaut)/2))
			XBF:=Fdroite
			
			
		: ($Salé=2)  // fleche en bas
			YBF:=-Fbas
			XBF:=(Fgauche+((Fdroite-Fgauche)/2))
			
		: ($Salé=3)  // fleche à gauche
			YBF:=-(Fhaut+((Fbas-Fhaut)/2))
			XBF:=Fgauche
			
			
		: ($Salé=4)  // fleche en haut
			YBF:=-Fhaut
			XBF:=(Fgauche+((Fdroite-Fgauche)/2))
			
	End case 
	TbO{$Salé}:=String:C10(XBF)+" "+String:C10(YBF)
End for 

For ($salé; 1; 4)
	$NomFleche:=String:C10($Salé)+"1V"
	OBJECT GET COORDINATES:C663(*; $NomFleche; Fgauche; Fhaut; Fdroite; Fbas)
	Case of 
		: ($Salé=1)  // fleche à droite
			YBF:=-(Fhaut+((Fbas-Fhaut)/2))
			XBF:=Fdroite
			
			
		: ($Salé=2)  // fleche en bas
			YBF:=-Fbas
			XBF:=(Fgauche+((Fdroite-Fgauche)/2))
			
		: ($Salé=3)  // fleche à gauche
			YBF:=-(Fhaut+((Fbas-Fhaut)/2))
			XBF:=Fgauche
			
			
		: ($Salé=4)  // fleche en haut
			YBF:=-Fhaut
			XBF:=(Fgauche+((Fdroite-Fgauche)/2))
			
	End case 
	TbO{4+$Salé}:=String:C10(XBF)+" "+String:C10(YBF)
End for 