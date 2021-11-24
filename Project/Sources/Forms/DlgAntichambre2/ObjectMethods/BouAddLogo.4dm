

DOCUMENT LIST:C474(<>CDTags; $TbFichierIncrust)
// Le logo
$Test:="@"+[Diapositives:40]Auteur:10+"@"
$L2:=Find in array:C230($TbFichierIncrust; $Test)
If ($L2<0)
	TRACE:C157
Else 
	$CDi:=<>CDTags+$TbFichierIncrust{$L2}
	READ PICTURE FILE:C678($CDi; $Logo)
	PICTURE PROPERTIES:C457($Logo; $Lb; $Hb)
	$CDImage:=<>CDPhotosSauveAsaDia+String:C10([Diapositives:40]NumOrdreDiapos:1)+".jpg"
	READ PICTURE FILE:C678($CDImage; $ImageDansSauveAsaDia)
	PICTURE PROPERTIES:C457($ImageDansSauveAsaDia; $La; $Ha)
	$Taux:=1
	If ($La*$Ha<5000000)  // Image réduite / AsaDia 2835 x 1871 = 5 304 285 px
		$Taux:=(($La*$Ha)/5304285)^0.5
		$LargeurImagette:=Int:C8($Lb*$Taux)
		$HauteurImagette:=Int:C8($Hb*$Taux)
		CREATE THUMBNAIL:C679($Logo; $Logo; $LargeurImagette; $HauteurImagette)
	End if 
	// Incrustation
	$HauteurLogo:=Int:C8($Ha-30-($Hb*$Taux))
	COMBINE PICTURES:C987($ImageResultante; $ImageDansSauveAsaDia; Superposition:K61:10; $Logo; 30; $HauteurLogo)
	If (Test path name:C476($CDImage)=Est un document:K24:1)
		DELETE DOCUMENT:C159($CDImage)
	End if 
	WRITE PICTURE FILE:C680($CDImage; $ImageResultante)
	$Pr:=Execute on server:C373("DiaACServeurCopiePhoto"; 0; "CopiePhoto"; [Diapositives:40]NumOrdreDiapos:1; <>CDPhotosSauveAsaDia)
	READ PICTURE FILE:C678($CDImage; VarImage)
End if 
