//%attributes = {"invisible":true,"shared":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 30/01/17, 20:23:58
// ----------------------------------------------------
// méthode : LB_Init_Start
// description
//
//
// paramètres
// ----------------------------------------------------

#DECLARE($Listbox_Name : Text)

LB_Clear_Columns($Listbox_Name)
LB_setHeights($Listbox_Name; 1; 1)
LISTBOX SET HIERARCHY:C1098(*; $Listbox_Name; False:C215)
