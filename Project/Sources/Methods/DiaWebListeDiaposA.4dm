//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 03/12/17, 11:08:28
// ----------------------------------------------------
// Méthode : WebListeDiaposA
// Description
// Ecrit le html entier d'une page affichant
//  la liste de lésion en anglais
// Paramètres
// ----------------------------------------------------

C_TEXT:C284($THTML)
ARRAY TEXT:C222($TbN; 0)
ARRAY TEXT:C222($TbV; 0)
WEB GET VARIABLES:C683($TbN; $TbV)
$THTML:=""
Varlogin:=DiaWebExtraitValeurTbParNom("loginasadia"; ->$TbN; ->$TbV)
// $THTML:=WebCreationHTMLDebutPage ("A";Varlogin)
$THTML:=$THTML+DiaWebAbouleListeDiapo("A"; True:C214)
// $THTML:=$THTML+WebCreationHTMLPiedPage
// FIXER TEXTE DANS CONTENEUR($THTML)