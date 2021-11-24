//%attributes = {"invisible":true,"shared":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 05/04/14, 13:33:32
// ----------------------------------------------------
// méthode : LOG_CreateLine
// description
// récupéré et adapté de Pole Contact de Mimosa
// paramètres
// ----------------------------------------------------
// LOG_CreateLine  ("texte à écrire") -> "chemin d'accès au document"
// gère un journal texte sur le disque dur pour tracer ce qu'on désire
// emplacement du journal (un par jour) dans un dossier "Trace" créé si nécessaire
// elle ajoute le texte au log en cours avec marque de l'heure, elle génère elle même les saut de lignes entre les trace
// ex : LOG_CreateLine("toto va à la plage")
// --> ajoute "12:26:12 : toto va à la plage" au journal

// ***************
// READY TO USE
// ***************
// QS - Patrick EMANUEL, 12/09/21 - 07:36:54

C_TEXT:C284($1; $logToAdd)  // texte de trace à rajouter
C_OBJECT:C1216($folder)
C_TEXT:C284($fileName; $path)
C_TIME:C306($FileRef)

If (Count parameters:C259>=1)
	$logToAdd:=$1
Else 
	$logToAdd:="..."
End if 

$folder:=Folder:C1567(fk logs folder:K87:17; *).folder("QST_trace")
If ($folder.exists=False:C215)
	$folder.create()
End if 

$fileName:=DATE_ConvertAsText(Current date:C33(*); "-")+".txt"
$path:=$folder.platformPath+$fileName

If (Test path name:C476($path)=Is a document:K24:1)
	$FileRef:=Append document:C265($path)  // si le document existe déjà, on écrit à la suite
Else 
	$FileRef:=Create document:C266($path; Text document:K4:1)  // sinon, on le crée (un fichier par jour)
End if 

If (OK=1)  // File opened
	
	$logToAdd:=String:C10(Current time:C178; HH MM SS:K7:1)+": "+$logToAdd+"\n"
	SEND PACKET:C103($FileRef; $logToAdd)
	CLOSE DOCUMENT:C267($FileRef)
	USE CHARACTER SET:C205(*; 0)
	
End if 