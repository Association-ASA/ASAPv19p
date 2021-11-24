//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 18/06/19, 06:53:22
  // ----------------------------------------------------
  // Méthode : Ad3SuiviConnexions
  // Description
  // Méthode qui permet le suivi des connexions Web pour AsaDia
  //
  // Paramètre {$1} existe si gibier
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT;$TT)
$Deb:=Date:C102("01/"+String:C10(Month of:C24(Current date:C33)+1;"00")+"/"+String:C10(Year of:C25(Current date:C33)-1))
If (Count parameters:C259=0)  // Autres que gibier
	$NbJours:=Current date:C33-$Deb
	QUERY:C277([DiaData:45];[DiaData:45]XType:5="Wad3";*)
	QUERY:C277([DiaData:45]; & [DiaData:45]XDate:3>=$Deb)
	SELECTION TO ARRAY:C260([DiaData:45]XNom:1;$TbLogin;[DiaData:45]XDate:3;$TbDate)
Else   // Gibier
	$NbJours:=!2019-04-16!-$Deb
	QUERY:C277([DiaPistePhotos:41];[DiaPistePhotos:41]DateAffichage:3>=$Deb;*)
	If (Count parameters:C259=0)  // Autres que gibier
		QUERY:C277([DiaPistePhotos:41]; & [DiaPistePhotos:41]NumOrdreDiapo:2<80000;*)
	Else   // Gibier
		QUERY:C277([DiaPistePhotos:41]; & [DiaPistePhotos:41]NumOrdreDiapo:2>=80000;*)
	End if 
	QUERY:C277([DiaPistePhotos:41]; & [DiaPistePhotos:41]TypeVisiteur:6="abattoirs")
	SELECTION TO ARRAY:C260([DiaPistePhotos:41]IDVisiteur:5;$TbLogin;[DiaPistePhotos:41]DateAffichage:3;$TbDate)
End if 
SORT ARRAY:C229($TbDate;$TbLogin;>)
$FT:=Size of array:C274($TbDate)
DerDate:=$TbDate{$FT}
$NbJours:=Round:C94($NbJours-(2*$NbJours/7);0)

$Mess:="Fréquentation Web"+<>ZCR
$Compteur:=1

  // initialisation des tableaux de Fréquentation
  // Les visiteurs
$FT:=8  // les 8 visiteurs souhaités
ARRAY TEXT:C222(TbVisiteur;$FT)
TbVisiteur{1}:="Abattoirs"
TbVisiteur{2}:="ENVA"
TbVisiteur{3}:="ENVL"
TbVisiteur{4}:="ENVN"
TbVisiteur{5}:="ENVT"
TbVisiteur{6}:="ULG"
TbVisiteur{7}:="CGM"
TbVisiteur{8}:="Autres"

  // Les tableaux mensuels
ARRAY LONGINT:C221(TbNbJanvier;0)
ARRAY LONGINT:C221(TbNbFevrier;0)
ARRAY LONGINT:C221(TbNbMars;0)
ARRAY LONGINT:C221(TbNbAvril;0)
ARRAY LONGINT:C221(TbNbMai;0)
ARRAY LONGINT:C221(TbNbJuin;0)
ARRAY LONGINT:C221(TbNbJuillet;0)
ARRAY LONGINT:C221(TbNbAoût;0)
ARRAY LONGINT:C221(TbNbSeptembre;0)
ARRAY LONGINT:C221(TbNbOctobre;0)
ARRAY LONGINT:C221(TbNbNovembre;0)
ARRAY LONGINT:C221(TbNbDécembre;0)


ARRAY LONGINT:C221(TbNbJanvier;$FT)
ARRAY LONGINT:C221(TbNbFevrier;$FT)
ARRAY LONGINT:C221(TbNbMars;$FT)
ARRAY LONGINT:C221(TbNbAvril;$FT)
ARRAY LONGINT:C221(TbNbMai;$FT)
ARRAY LONGINT:C221(TbNbJuin;$FT)
ARRAY LONGINT:C221(TbNbJuillet;$FT)
ARRAY LONGINT:C221(TbNbAoût;$FT)
ARRAY LONGINT:C221(TbNbSeptembre;$FT)
ARRAY LONGINT:C221(TbNbOctobre;$FT)
ARRAY LONGINT:C221(TbNbNovembre;$FT)
ARRAY LONGINT:C221(TbNbDécembre;$FT)

ARRAY POINTER:C280($TbPtMois;12)
$TbPtMois{1}:=->TbNbJanvier
$TbPtMois{2}:=->TbNbFevrier
$TbPtMois{3}:=->TbNbMars
$TbPtMois{4}:=->TbNbAvril
$TbPtMois{5}:=->TbNbMai
$TbPtMois{6}:=->TbNbJuin
$TbPtMois{7}:=->TbNbJuillet
$TbPtMois{8}:=->TbNbAoût
$TbPtMois{9}:=->TbNbSeptembre
$TbPtMois{10}:=->TbNbOctobre
$TbPtMois{11}:=->TbNbNovembre
$TbPtMois{12}:=->TbNbDécembre
  // Initialisation du comptage des Autres
ARRAY TEXT:C222($TbMailAutres;0)
ARRAY LONGINT:C221($TbOccAutre;0)

ARRAY LONGINT:C221($TbOccurence;0)
ARRAY LONGINT:C221($TbOccurence;8)


$OC:=True:C214
$TT:=Size of array:C274($TbLogin)
For ($Salé;1;$TT)
	$Mois:=Month of:C24($TbDate{$Salé})
	$PtMoisCourant:=$TbPtMois{$Mois}
	$login:=$TbLogin{$Salé}
	$Visiteur:=DiaTrouveVisiteur ($login)
	If ($Visiteur="Autres")
		$L:=Find in array:C230($TbMailAutres;$login)
		If ($L<0)
			APPEND TO ARRAY:C911($TbMailAutres;$login)
			APPEND TO ARRAY:C911($TbOccAutre;1)
		Else 
			$TbOccAutre{$L}:=$TbOccAutre{$L}+1
		End if 
	End if 
	$L:=Find in array:C230(TbVisiteur;$visiteur)
	$PtMoisCourant->{$L}:=$PtMoisCourant->{$L}+1
End for 

$Mess:=$Mess+<>ZCR2+"Liste des autres"+<>ZCR
SORT ARRAY:C229($TbMailAutres;$TbOccAutre;<)
$TT:=Size of array:C274($TbMailAutres)
For ($salé;1;$TT)
	$Mess:=$Mess+$TbMailAutres{$Salé}+<>ZTab+String:C10($TbOccAutre{$Salé})+<>ZCR
End for 
$Sup:=Num:C11(Month of:C24(Current date:C33)#12)*(String:C10(Year of:C25(Current date:C33)-1)+" -")
VarDateJour:="Fréquentation en "+$Sup+" 20"+<>ZPermMille+" au "+String:C10(DerDate;3)

If (Count parameters:C259=0)  // Autres que gibier
	QUERY:C277([DiaPistePhotos:41];[DiaPistePhotos:41]DateAffichage:3>=$Deb;*)
	QUERY:C277([DiaPistePhotos:41]; & [DiaPistePhotos:41]NumOrdreDiapo:2<80000;*)
	QUERY:C277([DiaPistePhotos:41]; & [DiaPistePhotos:41]TypeVisiteur:6="abattoirs")
End if 
SELECTION TO ARRAY:C260([DiaPistePhotos:41]IDVisiteur:5;$TbLoginMail;[DiaPistePhotos:41]NumOrdreDiapo:2;$TbNumDiaN)
ARRAY LONGINT:C221(TbLoginOcc;0)
ARRAY TEXT:C222(TbLoginMail;0)
ARRAY LONGINT:C221(TbTTOccurence;0)
ARRAY LONGINT:C221(TbTTNumPhotoN;0)
ARRAY TEXT:C222(TbTTTriplette;0)

$FT:=Size of array:C274($TbLoginMail)
For ($Salé;1;$FT)
	  // top ten
	$L:=Find in array:C230(TbTTNumPhotoN;$TbNumDiaN{$Salé})
	$L2:=Find in array:C230(<>TbNumDia;$TbNumDiaN{$Salé})
	If ($L<0) & ($L2>0)
		$Triplette:=DiaWebAfficheTriplette ($L2;"F")
		APPEND TO ARRAY:C911(TbTTNumPhotoN;$TbNumDiaN{$Salé})
		APPEND TO ARRAY:C911(TbTTTriplette;$Triplette)
		APPEND TO ARRAY:C911(TbTTOccurence;1)
	Else 
		If ($L2>0)
			TbTTOccurence{$L}:=TbTTOccurence{$L}+1
		End if 
	End if 
	VarNbPPE:=Size of array:C274(TbTTOccurence)
	
	  // Nbre de photos en grand
	$L:=Find in array:C230(TbLoginMail;$TbLoginMail{$Salé})
	If ($L<0)
		APPEND TO ARRAY:C911(TbLoginMail;$TbLoginMail{$Salé})
		APPEND TO ARRAY:C911(TbLoginOcc;1)
	Else 
		TbLoginOcc{$L}:=TbLoginOcc{$L}+1
	End if 
End for 
SORT ARRAY:C229(TbLoginOcc;TbLoginMail;<)
SORT ARRAY:C229(TbTTOccurence;TbTTTriplette;TbTTNumPhotoN;<)
VarNbLPE:=Size of array:C274(TbLoginOcc)
VarPCPPE:=Round:C94(Sum:C1(TbTTOccurence)/$NbJours;0)
QUERY WITH ARRAY:C644([Diapositives:40]NumOrdreDiapos:1;TbTTNumPhotoN)
CREATE SET:C116([Diapositives:40];"vues")
If (Count parameters:C259=0)  // Autres que gibier
	QUERY:C277([Diapositives:40]; & [Diapositives:40]NumOrdreDiapos:1<80000)
Else   // Gibier
	QUERY:C277([Diapositives:40]; & [Diapositives:40]NumOrdreDiapos:1>=80000)
End if 
$TLD:=Records in selection:C76([Diapositives:40])
CREATE SET:C116([Diapositives:40];"toutes")
DIFFERENCE:C122("toutes";"vues";"non vues")
USE SET:C118("non vues")
SELECTION TO ARRAY:C260([Diapositives:40]NumOrdreDiapos:1;TbJVNumPhotoN)
VarNbJV:=Size of array:C274(TbJVNumPhotoN)
VarPCJV:=Round:C94(VarNbJV*100/$TLD;0)