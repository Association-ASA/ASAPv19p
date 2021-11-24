//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 11/10/17, 16:54:06
  // ----------------------------------------------------
  // Méthode : VCS_ManageAllProjects
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------

Form:C1466.oldVersion:=""
Form:C1466.currentVersion:=""
Form:C1466.exportList.clear()
Form:C1466.exported.clear()
Form:C1466.allVersionTemp.clear()
(OBJECT Get pointer:C1124(Object named:K67:5;"searchInAllMethods"))->:=""
(OBJECT Get pointer:C1124(Object named:K67:5;"searchInAllProjects"))->:=""

Form:C1466.allProjects:=VCS_GetAllProjects 
FORM GOTO PAGE:C247(3)