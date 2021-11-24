  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 06/07/20, 18:45:44
  // ----------------------------------------------------
  // Méthode : [Diapositives].Planche contact
  // Description
  //
  //
  // Paramètres
  // ----------------------------------------------------
C_PICTURE:C286(VarImageDia)
VarT:=DiaAfficheTriplette 
$CDNomImage:=<>PermCheDossierAsaDiaWeb+String:C10([Diapositives:40]NumOrdreDiapos:1)+"i.jpg"
READ PICTURE FILE:C678($CDNomImage;VarImageDia)
VarNR:=String:C10([Diapositives:40]NumOrdreDiapos:1)
