//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 03/12/17, 11:08:28
  // ----------------------------------------------------
  // Méthode : WebListeLesionA
  // Description
  // Ecrit le html entier d'une page affichant
  //  la liste de lésion en anglais
  // Paramètres
  // ----------------------------------------------------
ARRAY TEXT:C222($TbN;0)
ARRAY TEXT:C222($TbV;0)
WEB GET VARIABLES:C683($TbN;$TbV)
$Langue:="A"
Varlogin:=DiaWebExtraitValeurTbParNom ("loginasadia";->$TbN;->$TbV)
$THTML:=DiaWebCreationHTMLDebutPage ($Langue;Varlogin;"List of lesions")
$THTML:=$THTML+DiaWebAbouleListeLesion ($Langue;False:C215)
$THTML:=$THTML+DiaWebCreationHTMLPiedPage ($Langue)
WEB SEND TEXT:C677($THTML)
