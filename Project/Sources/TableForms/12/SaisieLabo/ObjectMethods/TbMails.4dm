
$evt:=Form event code:C388
Case of 
	: ($evt=Sur données modifiées:K2:15)
		$Adresse:=TbMails{TbMails}
		  //$L:=Chercher dans tableau(TbMails;$Adresse)
		
		  //Si (Chercher dans tableau(TbMails;$Adresse;($L+1))>0)
		  //ALERTE("Désolé, l'adresse "+$Adresse+" existe déjà...")
		  //LISTBOX SUPPRIMER LIGNES(*;"ListBoxMail";TbMails)
		
		  //Sinon 
		$pattern:="^([-a-zA-Z0-9_]+(?:\\.[-a-zA-Z0-9_]+)*)(?:@)([-a-zA-Z0-9\\._]+(?:\\.[a-zA-Z0-9]{2,4})+)$"
		If (Match regex:C1019($pattern;$Adresse;1)=False:C215)
			CONFIRM:C162("L'adresse "+$Adresse+" que vous avez renseignée ne ressemble pas à une adresse mail classique. Souhaitez-vous quand même l'ajouter ?")
			If (OK=1)
				
			Else 
				LISTBOX DELETE ROWS:C914(*;"ListBoxMail";TbMails)
			End if 
			  //ALERTE("Désolé, l'adresse "+$Adresse+" n'est pas de type mail...")
			  //LISTBOX SUPPRIMER LIGNES(*;"ListBoxMail";TbMails)
		End if 
		  //Fin de si 
		
End case 

