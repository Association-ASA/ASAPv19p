//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 04/09/15, 20:52:59
  // ----------------------------------------------------
  // Méthode : WebAfficheImage
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
$Mess:=$1
$NumImageN:=Num:C11(Substring:C12($Mess;10))
$NumImageA:=String:C10($NumImageN)
$CDNomImage:=<>PermCheDossierAsaDiaWeb+$NumImageA+".jpg"
READ PICTURE FILE:C678($CDNomImage;$VarImage)

CREATE THUMBNAIL:C679($VarImage;$Imagette;300;200;Proportionnelle centrée:K6:6)
$CDI:=Get 4D folder:C485(Dossier racine HTML:K5:20)+"PhotosAsaDia"+Séparateur dossier:K24:12
$NomCourtI:=$NumImageA+"i.jpg"
$CD:=$CDI+$NomCourtI
DOCUMENT LIST:C474($CDI;$TbPhot)
If (Find in array:C230($TbPhot;$NomCourtI)<0)
	WRITE PICTURE FILE:C680($CD;$Imagette)
End if 
$CDFC:=$CDI+$NumImageA+".jpg"
  //ECRIRE FICHIER IMAGE($CDFC;[Atlas]Photo)
$CDDI:="PhotosAsaDia/"+$NomCourtI
QUERY:C277([Diapositives:40];[Diapositives:40]NumOrdreDiapos:1=$NumImageN)
$Rep:="<img src="+<>ZGuil+$CDDI+<>ZGuil+" alt="+<>ZGuil+$NomCourtI+<>ZGuil\
+" id="+<>ZGuil+"imagette"+<>ZGuil+" class="+<>ZGuil+"imageenliste"+<>ZGuil\
+" name="+<>ZGuil+$NumImageA+<>ZGuil+" />"
$esp:=Substring:C12([Diapositives:40]Espece:3;1;Length:C16([Diapositives:40]Espece:3)-1)
If ($esp="equin")
	$esp:="é"+Substring:C12($esp;2)
Else 
	$esp:=Lowercase:C14(Substring:C12($esp;1;1))+Substring:C12($esp;2)
End if 
$Description:="Photo n°"+$NumImageA+<>ZCR+"<br />"+[Diapositives:40]NomLesion:4+" sur "+[Diapositives:40]Organe:2+" d'un "+$esp
$Rep:=$Rep+<>ZCR+"<br />"+$Description
WEB SEND TEXT:C677($Rep)
ZAmnistieInternationale 
