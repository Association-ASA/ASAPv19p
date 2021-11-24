//%attributes = {"publishedWeb":true}
  // DiaDémarre 6.0 du 30/08/98
  // lance le process majeur
  // lance les méthodes : ZMAJinitPopUp, ZMAJInitEnumération ,ZMAJVersion
  // ZTestUtil ,ZTestCode ,ZCréerMaFenêtre, COMPILERZ


ON EVENT CALL:C190("BaseEvenement")
  //  initialisation des variables standard
ZXCarLaProc:=""
ZLaProcCour:=""
ZIciListeH:=False:C215
ZInitSaintsCalendrier 
MESSAGES OFF:C175
  //  MAJ de la base
DiaMAJDéclareVar 
DiaMAJInitPopUp 
ZMAJVersion 
  // ZInitSaintsCalendrier
SET MENU BAR:C67(1)
ENABLE MENU ITEM:C149(1;0)


  //  gestion des mots de passe
ZDuPrem:=True:C214  // Vrai au premier passage, faux après
  // utilisé dans la FF de "DlgPrincipal"

ZToutNeuf:=True:C214  //  ouvre grand les portes
<>ZToutNeuf:=ZToutNeuf
ZPleinEcran:=1  //  permet d'initialiser la case à cocher avec les menus
DiaCarousselDeMaugey 
CLOSE WINDOW:C154
MESSAGES ON:C181