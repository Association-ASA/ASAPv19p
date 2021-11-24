
$evt:=Form event code:C388
Case of 
	: ($evt=Sur clic:K2:4)
		ARRAY TEXT:C222($TbNomComplet;0)
		$CDListePhotos:=Select document:C905("";"*";"Où se trouve la liste des photos ?";0;$TbNomComplet)
		If (OK=1)
			VarCDListePhotos:=$TbNomComplet{1}
		Else 
			VarCDListePhotos:=""
		End if 
End case 
