//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 22/06/20, 08:53:39
// ----------------------------------------------------
// Méthode : QuizzAfficheGestionPhotosSup
// Description
// Méthode qui permet de gérer les photos ajoutées
//   pour les quizz à partir de l'interface 4D
// ----------------------------------------------------
QUERY:C277([DiaData:45]; [DiaData:45]XType:5="QuizzPhoto"; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XAlpha:14=TbSigleInstitution{TbSigleInstitution})
LISTBOX SELECT ROW:C912(*; "ListBoxPhotosSup"; 0; lk supprimer de sélection:K53:3)
VarPhotoSup:=[DiaData:45]XImage:6
