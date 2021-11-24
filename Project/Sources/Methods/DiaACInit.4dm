//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 02/04/18, 07:55:04
  // ----------------------------------------------------
  // Méthode : DiaACInit
  // Description
  // Met à vide l'ensemble des variables du dialogue DlgAntichambre
  // ----------------------------------------------------

VarComImage:=""
VarComImageP2:=""
VarDelaiAbattage:=""
VarCommemoratif:=""
VarCommentaires:=""
VarDelaiAbattageP2:=""
VarCommemoratifP2:=""
VarCommentairesP2:=""
$NbL:=LISTBOX Get number of rows:C915(*;"ListBoxCDFichiers")
LISTBOX DELETE ROWS:C914(*;"ListBoxCDFichiers";1;$NbL)
ZViderSelectionCourante (->[DiaData:45])
VarImage:=[DiaData:45]XImage:6
VarNbDia:=0
ARRAY PICTURE:C279(TbImagesAsaDia;0)
ARRAY TEXT:C222(PUMTypePhoto;2)
PUMTypePhoto{1}:="Boucherie"
PUMTypePhoto{2}:="Gibier"
PUMTypePhoto:=1
CDCourant:=""