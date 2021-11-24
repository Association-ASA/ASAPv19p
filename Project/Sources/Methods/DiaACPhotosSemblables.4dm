//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 09/04/20, 17:55:29
  // ----------------------------------------------------
  // Méthode : Ad3AfficheLePhotosSemblables
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)
QUERY:C277([Diapositives:40];[Diapositives:40]Espece:3=<>PUMEspèce{<>PUMEspèce};*)
QUERY:C277([Diapositives:40]; & [Diapositives:40]Organe:2=<>PUMOrgane{<>PUMOrgane};*)
QUERY:C277([Diapositives:40]; & [Diapositives:40]NomLesion:4=VarNomLésion)

$FT:=Records in selection:C76([Diapositives:40])
VarNbDia:=$FT
ARRAY PICTURE:C279(TbImagesAsaDia;$FT)
If (Count parameters:C259=0)
	For ($Salé;1;$FT)
		$CDNomImage:=<>CDPhotosSauveAsaDia+String:C10([Diapositives:40]NumOrdreDiapos:1)+"i.jpg"
		READ PICTURE FILE:C678($CDNomImage;$VarDia)
		TbImagesAsaDia{$Salé}:=$VarDia
		NEXT RECORD:C51([Diapositives:40])
	End for 
Else 
	ARRAY PICTURE:C279(TbImagesAsaDia;0)
End if 