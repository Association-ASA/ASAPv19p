
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		C_PICTURE:C286(VarPhotoI)
		//$LDia:=Chercher dans tableau(<>TbDiaposNumOrdreDiapos;Num([QuizzPhotos]NumPhotoA))
		//Si ($LDia>0)  // photo de la collection
		$DocSource:=<>CDPhotosSauveAsaDia+[QuizzPhotos:36]NumPhotoA:3+"i.jpg"
		$OK:=Test path name:C476($DocSource)
		READ PICTURE FILE:C678($DocSource; VarPhotoI)
		//Sinon   // Photo ajoutée pour le Quizz
		//$LDia:=Chercher dans tableau(<>TbQuizzNumPhotoA;$TbPhotoNumPhotoA{$Salé})
		//$THTML:=$THTML+"             <img src="+<>ZGuil+"PhotosAsaDia/"+<>TbQuizzNumPhotoWA{$LDia}+"i.jpg"+<>ZGuil
		//Fin de si 
		
End case 
