//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 12/09/21, 06:50:45
  // ----------------------------------------------------
  // Méthode : QuizzSupPhotoSup
  // Description
  // Méthode qui supprime de la liste les photos 
  //   hors AsaDia des questionnaires
  // Paramètre : $1=message AJAX  type supphotosupAsa2
  // ----------------------------------------------------
$Mess:=Substring:C12($1;12)
READ WRITE:C146([DiaData:45])
QUERY:C277([DiaData:45];[DiaData:45]ID:12=$Mess)
[DiaData:45]XBool:9:=True:C214
$NomImage:=[DiaData:45]XAlpha:14+String:C10([DiaData:45]XEntier:2)
SAVE RECORD:C53([DiaData:45])
ZAmnistiePartielle (->[DiaData:45])
WEB SEND TEXT:C677($NomImage)