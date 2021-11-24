//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Méthode : key_createKeyForCustomer
// Description
//
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 02/09/19, 07:06:59
// Paramètres

C_OBJECT:C1216($licence)
C_TEXT:C284($key; $request; $serveur)

$request:=Request:C163("Enter the end of licence validity: "; "26/09/1973")
$serveur:=Request:C163("T - Serveur / L - Monoposte: "; "M")
$licence:=New object:C1471("end"; Date:C102($request); "server"; Bool:C1537($serveur="T"))
$key:=key_createKey($licence)
SET TEXT TO PASTEBOARD:C523($key)
ALERT:C41("Licence is: "+$key+"\nand set in pasteboard, ready to be pasted in a document.")