//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Patrick
  // date et heure : 18/12/11
  // ----------------------------------------------------
  // méthode : FILE_SendPacket_UTF8
  // description
  //
  //
  // paramètres
  // ----------------------------------------------------

C_TIME:C306($1;$doc)
C_TEXT:C284($2;$Texte)
C_BLOB:C604($Blob)

$doc:=$1
$script:=$2

CONVERT FROM TEXT:C1011($script;"UTF-8";$Blob)
$Texte:=Convert to text:C1012($Blob;"UTF-8")
SEND PACKET:C103($doc;$Texte)