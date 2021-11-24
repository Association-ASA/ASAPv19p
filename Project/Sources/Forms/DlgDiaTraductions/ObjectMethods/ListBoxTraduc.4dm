
  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 31/03/19, 12:03:49
  // ----------------------------------------------------
  // Méthode : DlgTraductions.ListBoxTraduc
  // Description
  //   méthode de gestion des modifications apportées 
  //   à la liste des textes
  // ----------------------------------------------------

$L:=Colonne1
If (Colonne1{$L}#"") & (Colonne4{$L}="")
	Colonne4{$L}:=Colonne1{$L}
End if 