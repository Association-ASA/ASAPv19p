//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 21/04/18, 06:44:02
  // ----------------------------------------------------
  // Méthode : LB_ResizeLine
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------

C_TEXT:C284($1;$Listbox_Name;$FenetreInformation)

$Listbox_Name:=$1
$FenetreInformation:=""

LISTBOX SET PROPERTY:C1440(*;$Listbox_Name;lk truncate:K53:37;lk without ellipsis:K53:64)
LISTBOX SET PROPERTY:C1440(*;$Listbox_Name;lk allow wordwrap:K53:39;lk yes:K53:69)

LB_BlockEvents ($Listbox_Name)
displayInfo ($FenetreInformation)