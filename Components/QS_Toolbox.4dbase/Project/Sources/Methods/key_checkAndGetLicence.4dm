//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false}
// ----------------------------------------------------
// $1 : 
// $2 : 
// ----------------------------------------------------
// Méthode : key_checkAndGetLicence
// Description
// 
// ----------------------------------------------------
// Nom utilisateur (OS) : Patrick EMANUEL
// Date et heure : 10/10/19, 20:41:18
// Paramètres

C_OBJECT:C1216($licence; $licenceFileName)
C_TEXT:C284($QS_VCS_COMP_DB_PATH; $lic_name)
C_BLOB:C604($blob)

$lic_name:="licence"
$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB

Begin SQL
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	
	SELECT  LIC_PARAM
	FROM LICENCE
	WHERE LIC_NAME = :[$lic_name]
	INTO :[$blob];
	
	USE DATABASE SQL_INTERNAL;
End SQL

If (BLOB size:C605($blob)>0)
	
	$licenceText:=BLOB to text:C555($blob; UTF8 C string:K22:15)
	
	//$licenceFolder:=Get 4D folder(Licenses folder)
	//$fileName:=$licenceFolder+"qs_toolbox.licence"
	$licenceFileName:=Folder:C1567(fk licenses folder:K87:16).file("qs_toolbox.licence")
	
	// Not sure that is useful
	$licence:=JSON Parse:C1218($licenceText)
	$licenceText:=JSON Stringify:C1217($licence)
	//TEXT TO DOCUMENT($fileName; $licenceText)
	$licenceFileName.setText($licenceText)
	
Else 
	
	$licence:=QST_licence
	
End if 
