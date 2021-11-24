//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Patrick EMANUEL
// Date et heure : 16/06/20, 15:46:57
// ----------------------------------------------------
// Méthode : displayCollections
// Description
//
//
// Paramètres
// ----------------------------------------------------

C_TEXT:C284($object)
C_COLLECTION:C1488($result)
$result:=New collection:C1472
$object:=FORM Event:C1606.objectName
$option:=Num:C11($object)

If ($option>9)
	C_TEXT:C284($QS_VCS_COMP_DB_PATH)
	$QS_VCS_COMP_DB_PATH:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_ExternalDB
	
	ARRAY TEXT:C222($tbAppl; 0x0000)
	ARRAY TEXT:C222($tbPath; 0x0000)
	ARRAY TEXT:C222($tbCode; 0x0000)
	ARRAY TEXT:C222($tbDate; 0x0000)
	ARRAY TEXT:C222($tbTime; 0x0000)
	ARRAY TEXT:C222($tbTimeStamp; 0x0000)
	ARRAY LONGINT:C221($QS_SETUP_REF; 0x0000)
	ARRAY DATE:C224($QS_Licence; 0x0000)
	ARRAY BLOB:C1222($QS_Blob; 0x0000)
End if 

Case of 
	: ($option=1)
		$result:=Storage:C1525.commands4d.copy()
		
	: ($option=2)
		$result:=Storage:C1525.symbols_variable.copy()
		
	: ($option=3)
		$result:=Storage:C1525.allMethods.copy()
		
	: ($option=4)
		$result:=Storage:C1525.plugIn.copy()
		
	: ($option=5)
		$result:=Storage:C1525.componantsMethods.copy()
		
	: ($option=6)
		$result:=Storage:C1525.constants.copy()
		
	: ($option=7)
		$result:=Storage:C1525.objectType.copy()
		
	: ($option=8)
		$result:=Storage:C1525.structureTable.copy()
		
	: ($option=9)
		$result:=Storage:C1525.systemKeywords.copy()
		
	: ($option=10)
		Begin SQL
			USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
			
			/* Table contenant le code, la date de modif, l'heure et le "timestamp" */
			SELECT * FROM VCS INTO :[$tbAppl],:[$tbPath] ,:[$tbCode] ,:[$tbDate],:[$tbTime],:[$tbTimeStamp];
			USE DATABASE SQL_INTERNAL;
		End SQL
		ARRAY TO COLLECTION:C1563($result; $tbAppl; "Application"; $tbPath; "Path"; $tbCode; "Code"; $tbDate; "Date"; $tbTime; "Time"; $tbTimeStamp; "TimeStamp")
		
	: ($option=11)
		
		Begin SQL
			USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
			
			SELECT *
			FROM LICENCE
			INTO :[$tbAppl], :[$QS_Licence], :[$QS_Blob];
			
			USE DATABASE SQL_INTERNAL;
		End SQL
		ARRAY TEXT:C222($tbTimeStamp; Size of array:C274($QS_Blob))
		For ($a; 1; Size of array:C274($tbTimeStamp))
			$tbTimeStamp{$a}:=BASE_bytesToSTR(BLOB size:C605($QS_Blob{$a}))
		End for 
		ARRAY TO COLLECTION:C1563($result; $tbAppl; "Licence"; $QS_Licence; "Date"; $tbTimeStamp; "Blob Size")
		
	: ($option=12)
		Begin SQL
			USE REMOTE DATABASE DATAFILE :[$QS_VCS_COMP_DB_PATH] AUTO_CLOSE;
			
			SELECT *
			FROM SETUP
			ORDER BY MOD_REF
			INTO :[$tbAppl], :[$tbPath], :[$tbCode], :[$QS_SETUP_REF];
			
			USE DATABASE SQL_INTERNAL;
		End SQL
		ARRAY TO COLLECTION:C1563($result; $tbAppl; "Module"; $tbPath; "Parameter"; $tbCode; "Value"; $QS_SETUP_REF; "Order reference")
		
	: ($option=13)
		$result:=Storage:C1525.debug.copy()
		
	: ($option=14)
		If (Storage:C1525.getCallChain#Null:C1517)
			$result:=Storage:C1525.getCallChain.copy()
		Else 
			displayInfo("No error in the stack"; "blue")
		End if 
		
	: ($option=15)
		If (Storage:C1525.bdAnalysis#Null:C1517)
			$result:=Storage:C1525.bdAnalysis.copy()
		Else 
			displayInfo("Run a new Analysis first"; "blue")
		End if 
		
		
	: ($option=16)
		C_COLLECTION:C1488($paths)
		C_OBJECT:C1216($obj)
		ARRAY TEXT:C222($tbObjProp; 0x0000)
		ARRAY TEXT:C222($tbPropToHave; 6)
		
		$paths:=getConvertToProjectLogs
		If ($paths.length>0)
			$path:=Folder:C1567(Folder:C1567(fk logs folder:K87:17).platformPath; fk platform path:K87:2)
			$obj:=JSON Parse:C1218(Document to text:C1236($paths[0].platformPath))
			$paths:=$obj.messages
			
			$tbPropToHave{1}:="form"
			$tbPropToHave{2}:="message"
			$tbPropToHave{3}:="object"
			$tbPropToHave{4}:="severity"
			$tbPropToHave{5}:="table"
			$tbPropToHave{6}:="tableName"
			
			For each ($obj; $paths)
				OB GET PROPERTY NAMES:C1232($obj; $tbObjProp)
				
				For ($a; 1; Size of array:C274($tbPropToHave))
					
					$p:=Find in array:C230($tbObjProp; $tbPropToHave{$a})
					If ($p<0)
						If ($a#5)
							$obj[$tbPropToHave{$a}]:="-"
						Else 
							$obj[$tbPropToHave{$a}]:=0
						End if 
						
					End if 
				End for 
				
			End for each 
			
			$result:=$paths.copy()
		End if 
		
	: ($option=17)
		$result:=MM_inFolderList
		
End case 

$Listbox_Name:="LB_Information"
If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	If ($option>10)
		LB_BlockEvents($Listbox_Name)
	Else 
		ARRAY LONGINT:C221($MyEventsOnLB; 1)
		$MyEventsOnLB{1}:=On Clicked:K2:4
		OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
	End if 
	
End if 