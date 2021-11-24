//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable","publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false}
// ----------------------------------------------------
// $1 : object (licence)
// ----------------------------------------------------
// Méthode : key_create1stTime
// Description
// 
// ----------------------------------------------------
// Nom utilisateur (OS) : Patrick EMANUEL
// Date et heure : 03/07/2020, 12:16:17
// Paramètres

C_OBJECT:C1216($licence; $1)
C_DATE:C307($licenceEnd)
C_TEXT:C284($QS_VCS_COMP_DB_PATH; $lic_name)
C_BLOB:C604($blob)

$licence:=$1
$licenceEnd:=Date:C102($licence.end)
$licenceText:=JSON Stringify:C1217($licence)
$lic_name:="licence"
$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB

TEXT TO BLOB:C554($licenceText; $blob)

$file:=Folder:C1567(fk licenses folder:K87:16).file("qs_toolbox.licence")
If ($file.exists)
	$file.delete()
End if 
$file.create()
$file.setText($licenceText)

//Begin SQL
//USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;

//INSERT INTO LICENCE
//(LIC_PARAM, LIC_DATE, LIC_NAME)
//VALUES
//(:[$blob],:[$licenceEnd],:[$lic_name]);

//USE DATABASE SQL_INTERNAL;
//End SQL
