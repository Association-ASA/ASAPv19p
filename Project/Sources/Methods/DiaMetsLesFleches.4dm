//%attributes = {"publishedWeb":true}
  // MetsLesFleches
VarC11:=""
VarC21:=""
VarC31:=""
VarC41:=""
VarD11:=""
VarD21:=""
VarD31:=""
VarD41:=""
VarC11V:=""
VarC21V:=""
VarC31V:=""
VarC41V:=""
VarD11V:=""
VarD21V:=""
VarD31V:=""
VarD41V:=""
For ($salé;1;4)
	  // où les placer : décompactons le tableau
	If (VarImageVerticale)
		OBJECT GET COORDINATES:C663(VarImageV;FgaucheI;FhautI;FdroiteI;FbasI)
	Else 
		OBJECT GET COORDINATES:C663(VarImage;FgaucheI;FhautI;FdroiteI;FbasI)
	End if 
	$LargeurPhoto:=FdroiteI-FgaucheI
	$HauteurPhoto:=FbasI-FhautI
	$Fleche:=TbTb{$salé}
	$Pos:=Position:C15(" ";$Fleche)
	$NomFleche:=Substring:C12($Fleche;1;($Pos-1))
	$Fleche:=Substring:C12($Fleche;($pos+1))
	$Pos:=Position:C15(" ";$Fleche)
	$PCXPC:=Num:C11(Substring:C12($Fleche;1;($Pos-1)))
	$PCXr:=Round:C94($PCXPC*$LargeurPhoto;0)+FgaucheI
	XClic:=$PCXr
	$Fleche:=Substring:C12($Fleche;$pos+1)
	$Pos:=Position:C15(" ";$Fleche)
	If ($Pos>0)
		YClic:=Round:C94(-Num:C11(Substring:C12($Fleche;1;($Pos-1)))*$HauteurPhoto;0)-FhautI
		$Pt:=Get pointer:C304("VarC"+$NomFleche)
		$LibelFleche:=Substring:C12($Fleche;$pos+1)
		$Pos2:=Position:C15("£";$LibelFleche)
		If ($pos2>0)
			$Pt->:=Substring:C12($LibelFleche;1;$Pos2-1)
		Else 
			$Pt->:=Substring:C12($Fleche;$pos+1)
		End if 
		OBJECT GET COORDINATES:C663(*;$NomFleche;Fgauche;Fhaut;Fdroite;Fbas)
		OBJECT SET ENTERABLE:C238($Pt->;(CaseSaisie=1))
		Case of 
			: ($Salé=1)  // fleche à droite
				YBF:=-(Fhaut+((Fbas-Fhaut)/2))
				XBF:=Fdroite
				YBC:=YBF
				XBC:=XBF-(FDroite-FGauche)
				
			: ($Salé=2)  // fleche en bas
				YBF:=-Fbas
				XBF:=(Fgauche+((Fdroite-Fgauche)/2))
				YBC:=-Fhaut
				XBC:=XBF+(Fdroite-Fgauche)
				
			: ($Salé=3)  // fleche à gauche
				YBF:=-(Fhaut+((Fbas-Fhaut)/2))
				XBF:=Fgauche
				YBC:=YBF
				XBC:=XBF+(FGauche-FDroite)
				
			: ($Salé=4)  // fleche en haut
				YBF:=-Fhaut
				XBF:=(Fgauche+((Fdroite-Fgauche)/2))
				YBC:=YBF-(Fbas-Fhaut)
				XBC:=XBF
		End case 
		XDep:=XClic-XBF
		YDep:=YBF-YClic
		OBJECT MOVE:C664(*;"C"+$NomFleche;XDep;YDep)
		OBJECT SET FONT SIZE:C165(*;"C"+$NomFleche;TbTCa{$Salé})
		OBJECT MOVE:C664(*;$NomFleche;XDep;YDep)
		OBJECT GET COORDINATES:C663(*;"B"+$NomFleche;Fgauche;Fhaut;Fdroite;Fbas)
		If (Fhaut+YDep)>0
			OBJECT MOVE:C664(*;"B"+$NomFleche;XDep;YDep)
		End if 
	End if 
End for 
LesFlechesSontLà:=True:C214
OBJECT SET TITLE:C194(BouPlaceF;"Cacher les explications")