//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 03/12/17, 09:56:57
  // ----------------------------------------------------
  // Méthode : WebDiagnoseF
  // Description
  // Ecrit tout le HTML de la page diagnose en français
  //
  // Paramètres
  // ----------------------------------------------------

ARRAY TEXT:C222($TbN;0)
ARRAY TEXT:C222($TbV;0)
WEB GET VARIABLES:C683($TbN;$TbV)
Varlogin:=DiaWebExtraitValeurTbParNom ("loginasadia";->$TbN;->$TbV)
DiaWebEcritPageDiagnose ("F";True:C214)