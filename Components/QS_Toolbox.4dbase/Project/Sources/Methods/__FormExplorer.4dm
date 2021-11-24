//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"lang":"en"}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // date et heure : 08/01/17, 21:26:35
  // ----------------------------------------------------
  // méthode : __FormExplorer
  // description
  //
  //
  // paramètres
  // ----------------------------------------------------

C_OBJECT:C1216($myObj)
$myObj:=New object:C1471
$myObj.objectProperties:=New collection:C1472
$myObj.tableNum:=0
$myObj.formName:=""

$window:=Substring:C12(Current method name:C684;2)
CALL WORKER:C1389("QST_openWindow";"STO_openWindow";$myObj;$window;"FE_build_LH")
