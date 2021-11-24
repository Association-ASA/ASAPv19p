//%attributes = {"invisible":true,"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_OBJECT:C1216($QS_data)
C_BOOLEAN:C305($is_crossReference;$is_calleesCallers)
$action:=$1
$alert:=False:C215
$error:=""
$QS_data:=OB Copy:C1225(Storage:C1525.QS_TBX_SHARED_DATA)
$is_crossReference:=$QS_data.QS_TBX_crossReference

$startWorker:="4Dcommand;methodManager;formExplorer;dbOverview;methodAnalyser;methodsPallet;structureAnalysis;searchAndControl;methodsCallChain)"
$is_4DPop:=False:C215

Case of 
	: ($action="web")  // Open website or send an email  // -- Page 0 --
		
		If (Shift down:C543)
			OPEN URL:C673("mailto:info@association-qualisoft.eu")
		Else 
			OPEN URL:C673("http://www.association-qualisoft.eu")
		End if 
		
		  // BUTTONS
		
	: ($action="systeminfo")
		SC_get_Configuration 
		
	: ($action="camera")
		If (Shift down:C543)
			SHOW ON DISK:C922(Get 4D folder:C485(Logs folder:K5:19;*))
		Else 
			$path:=HELP_ScreenShotToFile 
		End if 
		
	: ($action="bugs")
		$vers_t:=Application version:C493
		$version_t:=Substring:C12($vers_t;1;2)
		$release_t:=Substring:C12($vers_t;3;1)
		$url:="https://bugs.4d.fr/fixes?version="+$version_t+Choose:C955(Num:C11($release_t)>0;"_R"+$release_t;"")
		OPEN URL:C673($url)
		
	: ($action="help")
		C_OBJECT:C1216($licence)
		$licence:=New object:C1471
		$licence:=OB Copy:C1225(Storage:C1525.licence.licence)
		$ref:=Open form window:C675("_Copyrights";Modal form dialog box:K39:7;Horizontally centered:K39:1;Vertically centered:K39:4)
		DIALOG:C40("_Copyrights";$licence)
		
		  // ====================================
		
	: (Position:C15($action;$startWorker)>0)  // Action has been found
		DATA_updateMethodsInfo ($is_4DPop)  // To force the update of the list -> can take a while depending of the DB
		CALL WORKER:C1389("QST_"+$action;"__"+$action)
		
	: ($action="dataExplorer")
		mQST_DataExplorer 
		
	: ($action="reports")
		DATA_updateMethodsInfo ($is_4DPop)
		mQST_reports 
		
		  // Separator
		
	: ($action="vcs")
		mQST_VCS 
		
	: ($action="converter")
		mQST_converter 
		
		  // Separator
		
	: ($action="dbAnalyze")
		
		If ($is_crossReference)
			CONFIRM:C162("Do you want to force a new DB analyze '"+$QS_data.QS_TBX_DBName+\
				"'?\nIt will close all unnecessary windows.")
			If (OK=1)
				If (Shift down:C543)
					MM_getMMdifferences 
				Else 
					mQST_dbAnalysis 
				End if 
			End if 
		Else 
			$alert:=True:C214
		End if 
		
	: ($action="Callees")
		CONFIRM:C162("Do you want to execute Callees/Callers analysis. That could take a while depending of the DB structure.\nIt will close all unnecessary windows.")
		If (OK=1)
			mQST_dbcallees 
		End if 
		
	: ($action="setup")
		mQST_setup 
		
	: ($action="goToStructure")
		INVOKE ACTION:C1439(ak return to design mode:K76:62)
		
	: ($action="restart")
		If (Shift down:C543) & (Macintosh option down:C545) & (Macintosh command down:C546)
			C_TEXT:C284($question)
			$question:=Request:C163("What is the great key phrase requested?")
			If ($question="hakuna matata")
				key_startFromScratch 
				mQST_restart4D 
			Else 
				ALERT:C41("OK. That's weird and you really need help.\nContact QualiSoft by mail. They might be able to help you...")
			End if 
		Else 
			mQST_restart4D 
		End if 
		
		
	: ($action="_MNU_Start")
		$newProcess:=New process:C317("_MNU_Start";0;"QST_Menu";"__Menu_og";*)
		
	Else 
		
		$nmc_t:=Current method name:C684
		$par_l:=Form event code:C388
		$error:=$nmc_t+" unexpected error\rname="+$action+"\revent="+String:C10($par_l)
		
End case 

If ($alert)
	ALERT:C41("Cross reference analysis at startup is not finished yet.\nRetry again in a few moment.")
End if 

$0:=$error