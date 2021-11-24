//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 12/05/16, 09:02:37
// ----------------------------------------------------
// méthode : TOOLS_ResetDebugButtons
// description
// http://forums.4d.fr/Post/FR/16299793/1/16312899#16312899
// keisuke MIYAKO
//
// paramètres
// ----------------------------------------------------

C_BOOLEAN:C305($Is_v13)

$Is_v13:=False:C215

Case of 
		
	: ($Is_v13)
		
		$path:=Get 4D folder:C485+"4D Preferences v13.4DPreferences"
		
		If (Test path name:C476($path)=Is a document:K24:1)
			
			$dom:=DOM Parse XML source:C719($path)
			ARRAY TEXT:C222($windows; 0x0000)
			$window:=DOM Find XML element:C864($dom; "preferences/internal_prefs_4d/windows/window"; $windows)
			C_LONGINT:C283($i)
			
			For ($i; 1; Size of array:C274($windows))
				
				$window:=$windows{$i}
				$name:=""
				DOM GET XML ATTRIBUTE BY NAME:C728($window; "name"; $name)
				
				If ($name="4ddebugger")
					DOM REMOVE XML ELEMENT:C869($window)
				End if 
				
			End for 
			
			XML SET OPTIONS:C1090($dom; XML indentation:K45:34; XML no indentation:K45:36)
			ON ERR CALL:C155("BASE_noERROR")
			DOM EXPORT TO FILE:C862($dom; $path)
			ON ERR CALL:C155("")
			DOM CLOSE XML:C722($dom)
			
		End if 
		
	Else   // >= v14
		C_LONGINT:C283($Majeur)
		$Majeur:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_4DMajeur
		
		$path:=Get 4D folder:C485(Active 4D Folder:K5:10)+Replace string:C233("4D Window Bounds v"+String:C10($Majeur)+"/coreDialog/[projectForm]/4ddebugger.json"; "/"; Folder separator:K24:12)
		
		If (Test path name:C476($path)=Is a document:K24:1)
			
			ON ERR CALL:C155("BASE_noERROR")
			DELETE DOCUMENT:C159($path)
			ON ERR CALL:C155("")
			
		End if 
End case 

$FenetreInformation:="Debugger buttons have been restored."
displayInfo($FenetreInformation)