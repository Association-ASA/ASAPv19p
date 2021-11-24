//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 11/10/17, 16:47:21
  // ----------------------------------------------------
  // Méthode : VCS_DisplayAllVersions
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------

(OBJECT Get pointer:C1124(Object named:K67:5;"searchInAllMethods"))->:=""
(OBJECT Get pointer:C1124(Object named:K67:5;"searchInAllProjects"))->:=""
Form:C1466.currentVersion:=""
Form:C1466.oldVersion:=""

Form:C1466.allVersion:=VCS_SearchAllVersions 
Form:C1466.allVersionTemp:=Form:C1466.allVersion.copy()
(OBJECT Get pointer:C1124(Object named:K67:5;"Compteur"))->:=Form:C1466.allVersion.length
FORM GOTO PAGE:C247(2)