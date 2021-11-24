C_LONGINT:C283($C;$L)
LISTBOX GET CELL POSITION:C971(*;"ListBoxPhotosNPC";$C;$L)
If ($L=0)
	ALERT:C41("Merci de désigner une photo en cliquant sur son n°")
Else 
	$CDNomImage:=Get 4D folder:C485(Dossier base:K5:14)+"dossier Photos"+Séparateur dossier:K24:12+TbNumDiaNPC{$L}+".jpg"
	READ PICTURE FILE:C678($CDNomImage;VarImageNPC)
End if 