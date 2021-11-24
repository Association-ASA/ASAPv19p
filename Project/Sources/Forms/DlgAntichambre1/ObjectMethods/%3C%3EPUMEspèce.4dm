C_LONGINT:C283($Salé; $FT)
QUERY:C277([Diapositives:40]; [Diapositives:40]Espece:3=<>PUMEspèce{<>PUMEspèce}; *)
QUERY:C277([Diapositives:40];  & [Diapositives:40]Organe:2=<>PUMOrgane{<>PUMOrgane}; *)
QUERY:C277([Diapositives:40];  & [Diapositives:40]NomLesion:4=VarNomLésion)

$FT:=Records in selection:C76([Diapositives:40])
ARRAY PICTURE:C279(TbImagesAsaDia; $FT)
For ($Salé; 1; $FT)
	$CDNomImage:=Get 4D folder:C485(Dossier base:K5:14)+"dossier Photos"+Séparateur dossier:K24:12+String:C10([Diapositives:40]NumOrdreDiapos:1)+".jpg"
	READ PICTURE FILE:C678($CDNomImage; $VarDia)
	TbImagesAsaDia{$Salé}:=$VarDia
	NEXT RECORD:C51([Diapositives:40])
End for 
VarNbDia:=Size of array:C274(TbImagesAsaDia)
