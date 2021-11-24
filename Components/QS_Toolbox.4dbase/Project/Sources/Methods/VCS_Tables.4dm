//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false}
// ----------------------------------------------------
// Nom utilisateur (OS) : Patrick EMANUEL
// ----------------------------------------------------
// Méthode : VCS_Tables
// Description
// 
//
// Paramètres
// ----------------------------------------------------

CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; Current method name:C684)

C_TEXT:C284($QS_VCS_COMP_DB_PATH)
$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB

Begin SQL
	-- USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH];
	
	/* Table contenant le code, la date de modif, l'heure et le "timestamp" */
	CREATE TABLE IF NOT EXISTS VCS (
	VCS_APPLICATION VARCHAR,
	VCS_PATH VARCHAR,
	VCS_CODE VARCHAR,
	VCS_DATE TIMESTAMP, -- not sure that is helpful
	VCS_TIME INT32,  -- not sure that is helpful
	VCS_TIMESTAMP VARCHAR);
	
	CREATE TABLE IF NOT EXISTS EXPORTS (
	EXP_APPLICATION VARCHAR,
	EXP_CODE VARCHAR,
	EXP_DATE TIMESTAMP);
	
	CREATE TABLE IF NOT EXISTS LICENCE (
	LIC_NAME VARCHAR, -- To pick the record
	LIC_DATE TIMESTAMP, -- limit date
	LIC_PARAM BLOB); -- BLOB crypted
	
	CREATE TABLE IF NOT EXISTS SETUP (
	MOD_NAME VARCHAR, -- Module name
	MOD_PARAM VARCHAR, -- Param name
	MOD_VALUE VARCHAR, -- Initial value (String format) -> must be managed after in case of Int
	MOD_REF INT32); -- Reference
	
	CREATE INDEX SETUP_moduleName ON SETUP (MOD_NAME);
	CREATE INDEX EXPORT_application ON EXPORTS (EXP_APPLICATION);
	CREATE INDEX VCS_application ON VCS (VCS_APPLICATION);
	CREATE INDEX VCS_timeStamp ON VCS (VCS_TIMESTAMP);
	CREATE INDEX LICENCE_name ON LICENCE (LIC_NAME);
	-- USE DATABASE SQL_INTERNAL;
End SQL

If (Count parameters:C259=1)
	C_OBJECT:C1216($1)
	signal_addResult($1; Current method name:C684)
End if 