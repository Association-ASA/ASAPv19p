//%attributes = {}
ARRAY TEXT:C222($TbN;0)
ARRAY TEXT:C222($TbV;0)
WEB GET VARIABLES:C683($TbN;$TbV)
Varlogin:=DiaWebExtraitValeurTbParNom ("loginasadia";->$TbN;->$TbV)
$THTML:=DiaWebCreationHTMLDebutPage ("F";Varlogin;"Liste des photos")
$THTML:=$THTML+DiaWebAbouleListeLesion ("F";False:C215)
$THTML:=$THTML+DiaWebCreationHTMLPiedPage ("F")
WEB SEND TEXT:C677($THTML)