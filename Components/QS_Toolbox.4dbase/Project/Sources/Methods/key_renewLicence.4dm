//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable","publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false}
C_TEXT:C284($licenceText;$QS_VCS_COMP_DB_PATH)
C_OBJECT:C1216($licence)
C_DATE:C307($licenceEnd)

$licenceText:=JSON Stringify:C1217($licence)
TEXT TO DOCUMENT:C1237($fileName;$licenceText)

$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB
$lic_name:="licence"
TEXT TO BLOB:C554($licenceText;$blob)

$licenceEnd:=Date:C102(Storage:C1525.licence.licence.end)

Begin SQL
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	
	UPDATE LICENCE
	SET LIC_PARAM = :[$blob], LIC_DATE = :[$licenceEnd]
	WHERE LIC_NAME = :[$lic_name];
	
	USE DATABASE SQL_INTERNAL;
End SQL
