//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 05/06/18, 07:15:10
  // ----------------------------------------------------
  // Paramètres
  // $1 = 0 (ReadOnly) or 1 (ReadWrite)
  // ----------------------------------------------------
  // Méthode : OBJ_ReadAndWriteIcon
  // Description
  //  Manage to paddle to ReadAndWrite visualisation

C_BOOLEAN:C305($1)

C_BOOLEAN:C305($is_rw)
$is_rw:=$1
$ptr:=OBJECT Get pointer:C1124(Object named:K67:5;"btn_rw")

x_btn_toggleSet ($ptr;Num:C11($is_rw))

