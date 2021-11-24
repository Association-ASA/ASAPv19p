//%attributes = {}

  //  // ----------------------------------------------------
  //  // Nom utilisateur : cgm
  //  // Date et heure : 23/02/19, 10:27:14
  //  // ----------------------------------------------------
  //  // Méthode : AdGibierMFDlgAsaDiaGibier
  //  // Description
  //  // Méthode formulaire de DlgAsaDiaGibier
  //  // ----------------------------------------------------

  //C_ENTIER LONG($Salé;$FT)

  //  // les données du fichier texte
ARRAY TEXT:C222(TbRef;0)
ARRAY TEXT:C222(TbLien;0)
ARRAY TEXT:C222(TbEspèce;0)
ARRAY TEXT:C222(TbOrgane;0)
ARRAY TEXT:C222(TbDescription;0)
ARRAY TEXT:C222(TbNomLésion;0)
ARRAY TEXT:C222(TbÉtiologie;0)
ARRAY TEXT:C222(TbAuteur;0)
ARRAY TEXT:C222(TbDécision;0)
  //  // les données des images
ARRAY TEXT:C222(TbDimensions;0)

DiaACGibierClicDansTb (0)
NbDia:=Size of array:C274(TbRef)
VarCDListePhotos:=""
VarCDDossierPhotos:=""
