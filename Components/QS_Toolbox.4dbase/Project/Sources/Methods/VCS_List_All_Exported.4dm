//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 21/02/19, 22:49:01
  // Paramètres
  // ----------------------------------------------------
  // Méthode : VCS_List_All_Exported
  // Description
  // 

C_TEXT:C284($1)
Form:C1466.exported:=VCS_Get_Exported_Info ($1)
Form:C1466.exported:=Form:C1466.exported.orderBy("path asc, dateStamp asc, timeStamp asc")