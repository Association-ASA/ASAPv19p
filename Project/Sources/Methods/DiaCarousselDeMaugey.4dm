//%attributes = {"publishedWeb":true}
  // CarousselDeMaugey
DuPrem:=True:C214
While (ZXCarLaProc#"PasDePaniqueLesFemmesEtLesEnfantsDabord")
	  //on entre tant qu'on ne veut pas sortir!!!
	ZAmnistieInternationale 
	DISABLE MENU ITEM:C150(1;0)
	If (ZXCarLaProc="")  //Comme il n'y a rien à foutre, allons toujours dans le dialogue
		  //Creer fenetre(6;40;1000;710;8;"";"YFinirEnBeauté")  ` 14 pouces fillette
		DiaZCréerMaFenêtre 
		SET WINDOW TITLE:C213("Choix de l'action :")
		DIALOG:C40("DlgPrincipalDia")
		ZPleinEcran:=ZCochPleinEcran
		CLOSE WINDOW:C154
	Else   // Ah, tiens, du boulot
		ZLaProCour:=ZXCarLaProc
		ZXCarLaProc:=""  // Ben ouais, on va pas recommencer 107 ans
		EXECUTE FORMULA:C63(ZLaProCour)
	End if 
	  //  Doute affreux: et si ...
	  //  la procédure"PasDePaniqueLesFemmesEtLesEnfantsDabord" avait été appelée???
	  //  en clair, l'utilisateur se serait lassé et demande à partir
	If (ZXCarLaProc="PasDePaniqueLesFemmesEtLesEnfantsDabord")
		If (Current user:C182="Concepteur") | (Current user:C182="Administrateur")
			  //  On suppose qu'il veut aller en structure
			ENABLE MENU ITEM:C149(1;0)
		Else 
			CONFIRM:C162("Désirez-vous VRAIMENT quitter le programme  ?")
			If (OK=1)
				ZFinirEnBeauté   //il fallait bien le faire une jour
			Else 
				ZXCarLaProc:=""  // on retournera derechef dans le dialogue
			End if   //  OK=1 : il veut vraiment sortir
		End if   //    Utilisateur courant="Concepteur"
	End if   //      XCarLaProc="PasDePaniqueLesFemmesEtLesEnfantsDabord"
End while 