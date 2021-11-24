//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Méthode : _runOnce_keyCreation
  // Description
  // Creation of key used for Licencing the componant
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 31/07/19, 06:51:33
  // Paramètres
  // NOT preemptive

C_BLOB:C604($publicKey;$privateKey)
C_TEXT:C284($contents;$methodName)
ARRAY TEXT:C222($t_noms;0x0000)

METHOD GET NAMES:C1166($t_Noms)
If (Find in array:C230($t_noms;"keyPrivate")<0)
	  // Insert data inside the comments of the code: in any case, componant will be "compiled"
	
	GENERATE ENCRYPTION KEYPAIR:C688($privateKey;$publicKey)
	$contents:=BLOB to text:C555($privateKey;UTF8 text without length:K22:17)
	$methodName:="keyPrivate"
	UPDT_WriteMethod ($methodName;"")
	METHOD SET COMMENTS:C1193($methodName;$contents)
	METHOD SET ATTRIBUTE:C1192($methodName;Attribute invisible:K72:6;True:C214)
	
	$contents:=BLOB to text:C555($publicKey;UTF8 text without length:K22:17)
	$methodName:="keyPublic"
	UPDT_WriteMethod ($methodName;"")
	METHOD SET COMMENTS:C1193($methodName;$contents)
	METHOD SET ATTRIBUTE:C1192($methodName;Attribute invisible:K72:6;True:C214)
	
Else 
	
	ALERT:C41("PublicKey and PrivateKey have been created. Don't delete them except if you want to change the QST key generator.")
	
End if 
