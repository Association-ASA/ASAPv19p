//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 26/11/17, 09:09:38
  // ----------------------------------------------------
  // Méthode : TOOLS_RecordEvents
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------
C_BOOLEAN:C305($Debug)
C_LONGINT:C283($TypeLog)

$Debug:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Debug
$TypeLog:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_TypeLog

If ($Debug=False:C215)
	$FenetreInformation:="Record event Started."
Else 
	$FenetreInformation:="Record event Stopped."
	SHOW ON DISK:C922(Get 4D folder:C485(Logs folder:K5:19))
End if 

$Debug:=Not:C34($Debug)
$TypeLog:=Choose:C955($TypeLog=4;0;4)

Use (Storage:C1525)
	Use (Storage:C1525.QS_TBX_SHARED_DATA)
		Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Debug:=$Debug
		Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_TypeLog:=$TypeLog
	End use 
End use 
OBJECT SET VISIBLE:C603(*;"encours";$Debug)
SET DATABASE PARAMETER:C642(Debug log recording:K37:34;$TypeLog)

displayInfo ($FenetreInformation)