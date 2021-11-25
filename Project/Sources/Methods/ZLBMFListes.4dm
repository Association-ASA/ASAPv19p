//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Patrick
// Date et heure : 24/08/11
// ----------------------------------------------------
// Méthode : ZLBMFListes
// Description
// Méthode du formulaire projet LBSelection 
//  qui permet de gérer de façon standard 
//  la sélection d'une table (ZLBGèreListe)
// ----------------------------------------------------

C_BOOLEAN:C305(vl_b_print; tri)
C_LONGINT:C283($C; $L)

Case of 
	: (Form event code:C388=On Load:K2:1)
		var $file : 4D:C1709.file
		$file:=File:C1566("/LOGS/requestTableaux.json")
		SET DATABASE PARAMETER:C642(Client log recording:K37:44; 2)
		ds:C1482.startRequestLog($file)
		
		$Sep:=Folder separator:K24:12
		tri:=True:C214
		CREATE EMPTY SET:C140(ZPtTable->; "$ZFichesSurlignees")
		ZFenetreActualiseTitre
		ZViderSelectionCourante(->[CampagneParticipations:17])
		ZLBAfficheListe
		$PtLogo:=OBJECT Get pointer:C1124(Object named:K67:5; "VarLogoTable")
		READ PICTURE FILE:C678(VarCDLogo; $PtLogo->)
		OBJECT SET VISIBLE:C603(*; "imp@"; ZImprime)
		OBJECT SET VISIBLE:C603(*; "sup@"; ZSupprime)
		OBJECT SET VISIBLE:C603(*; "ens@"; ZGereEnsemble)
		OBJECT SET VISIBLE:C603(*; "lapin@"; (Size of array:C274(TbMethodeLapin)>0))
		
	: (Form event code:C388=On Unload:K2:2)
		SET DATABASE PARAMETER:C642(Client log recording:K37:44; 0)
		ds:C1482.stopRequestLog()
		SHOW ON DISK:C922(Get 4D folder:C485(Logs folder:K5:19))
		
		
End case 