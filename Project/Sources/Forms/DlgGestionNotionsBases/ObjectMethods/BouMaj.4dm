  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 25/12/15, 07:57:07
  // ----------------------------------------------------
  // Méthode : DlgGestionNotionsBases.BouCreerEnr
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------

C_LONGINT:C283($débutSél;$finSél)
GET HIGHLIGHT:C209(VarTexte;$débutSél;$finSél)
$Chaine:=VarTexte
$Debut:=Substring:C12($Chaine;1;($débutSél-1))
$Milieu:=Uppercase:C13(Substring:C12($Chaine;$débutSél;($finSél-$débutSél)))
$fin:=Substring:C12($Chaine;$finSél)
VarTexte:=$Debut+$Milieu+$Fin