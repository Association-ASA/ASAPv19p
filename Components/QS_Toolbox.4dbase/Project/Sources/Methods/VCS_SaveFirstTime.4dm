//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable","publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 21/05/18, 10:37:19
// ----------------------------------------------------
// Paramètres
// $0 = boolean
// ----------------------------------------------------
// Méthode : VCS_SaveFirstTime
// Description
//
// PE 15/12/20 - update to inclde the LIC_NAME search.

#DECLARE->$firstTime : Boolean

var $Count; $Count2 : Integer
var $dbName; $QS_VCS_COMP_DB_PATH : Text

$firstTime:=False:C215
$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB
$dbName:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName

Begin SQL
	USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
	
	/*
	SELECT count(*)
	FROM VCS
	INTO :[$Count];
	*/
	
	SELECT count(*)
	FROM LICENCE
	WHERE LIC_NAME = :[$dbName]
	INTO :[$Count2];
	
	USE DATABASE SQL_INTERNAL;
	
End SQL

$firstTime:=($count2=0)  // | ($Count=0) // | (Storage.allMethods.length=0))  
