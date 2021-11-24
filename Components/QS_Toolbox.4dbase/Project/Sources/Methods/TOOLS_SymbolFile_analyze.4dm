//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// Nom utilisateur (OS) : Patrick EMANUEL
// Date et heure : 05/08/20, 14:12:04
// ----------------------------------------------------
// Méthode : TOOLS_SymbolFile_analyze
// Description
//
//
// Paramètres
// ----------------------------------------------------

C_OBJECT:C1216($2; $declaration)
C_COLLECTION:C1488($split; $splitLine)
C_TEXT:C284($1; $line; $varType; $varDimension; $varName)

C_BOOLEAN:C305($versionR)
C_LONGINT:C283($versionMineur; $versionMajeur)
$versionR:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_4DVersionR
$versionMineur:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_4DMineur
$versionMajeur:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_4DMajeur
$declaration:=$2

If (Is Windows:C1573)
	$split:=Split string:C1554($1; "\r\n")
Else 
	$split:=Split string:C1554($1; "\r")
End if 

For each ($line; $split)
	
	If (($line#"\n") & ($line#""))
		$splitLine:=Split string:C1554($line; "\t")
		$varName:=""
		
		Case of 
			: ($splitLine.length=1)  // Method description
				
			: ($splitLine.length=2)  // This is the date or a Project Method name
				Case of 
					: ($splitLine[0]#"")  // This is the date of the compilator execution
						
					: ($splitLine[0]="")  // This is a method name
						$varSourceName:=Substring:C12($splitLine[1]; Position:C15(")"; $splitLine[1])+1)
						$varSource:="M"
						
						Case of 
							: ($varSourceName="Sur ouverture")
								$varSourceName:="[DatabaseMethod]/onStartup"
								$varSource:="B"
								
							: ($varSourceName="Sur fermeture")
								$varSourceName:="[DatabaseMethod]/onExit"
								$varSource:="B"
								
							: ($varSourceName="Sur déposer")
								$varSourceName:="[DatabaseMethod]/onDrop"
								$varSource:="B"
								
							: ($varSourceName="Sur évènement système")
								$varSourceName:="[DatabaseMethod]/onSystemEvent"
								$varSource:="B"
								
							: ($varSourceName="Sur connexion web")
								$varSourceName:="[DatabaseMethod]/onWebConnection"
								$varSource:="B"
								
							: ($varSourceName="Sur authentification web")
								$varSourceName:="[DatabaseMethod]/onWebAuthentication"
								$varSource:="B"
								
							: ($varSourceName="Sur fermeture process web")
								$varSourceName:="[DatabaseMethod]/onWebSessionSuspend"
								$varSource:="B"
								
							: ($varSourceName="Sur démarrage sauvegarde")
								$varSourceName:="[DatabaseMethod]/onBackupStartup"
								$varSource:="B"
								
							: ($varSourceName="Sur arrêt sauvegarde")
								$varSourceName:="[DatabaseMethod]/onBackupShutdown"
								$varSource:="B"
								
							: ($varSourceName="Sur démarrage serveur")
								$varSourceName:="[DatabaseMethod]/onServerStartup"
								$varSource:="B"
								
							: ($varSourceName="Sur arrêt serveur")
								$varSourceName:="[DatabaseMethod]/onServerShutdown"
								$varSource:="B"
								
							: ($varSourceName="Sur ouverture connexion serveur")
								$varSourceName:="[DatabaseMethod]/onServerOpenConnection"
								$varSource:="B"
								
							: ($varSourceName="Sur fermeture connexion serveur")
								$varSourceName:="[DatabaseMethod]/onServerCloseConnection"
								$varSource:="B"
								
							: ($varSourceName="Sur authentification SQL")
								$varSourceName:="[DatabaseMethod]/onSqlAuthentication"
								$varSource:="B"
								
							: ($varSourceName="Sur authentitication 4D Mobile") | ($varSourceName="Sur authentitication REST")
								$varSourceName:="[DatabaseMethod]/On4DMobileAuthentication"
								$varSource:="B"
								
							: ($varSourceName="Sur authentitication app mobile")
								$varSourceName:="[DatabaseMethod]/OnMobileAppAuthentication"
								$varSource:="B"
								
							: ($varSourceName="Sur action app mobile")
								$varSourceName:="[DatabaseMethod]/OnMobileAppAction"
								$varSource:="B"
								
							: ($varSourceName="Sur évènement base hôte")
								$varSourceName:="[DatabaseMethod]/OnHostDatabaseEvent"
								$varSource:="B"
								
						End case 
						
						CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "ReadSymbolFile_"+$varSourceName)
						
				End case 
				
			: ($splitLine.length=4) & ($splitLine[3]="")  // This is a local variable
				$varName:=$splitLine[0]
				$varType:=$splitLine[1]
				$varDimension:=$splitLine[2]
				
			: ($splitLine.length=4) & (Substring:C12($splitLine[3]; 1; 1)="(") | (Substring:C12($splitLine[3]; 1; 1)="*")  // This is a variable (Interprocess / process)
				$varName:=$splitLine[0]
				$varType:=$splitLine[1]
				$varDimension:=$splitLine[2]
				If (Substring:C12($splitLine[3]; 1; 1)="(")  // M=Method / TM=table method / FM=form method / OM=object method / F=doesn't appear
					$varSource:=Substring:C12($splitLine[3]; 2; Position:C15(")"; $splitLine[3])-2)
				Else   // it is a Star (*) => Base
					$varSource:="B"
				End if 
				$varSourceName:=Substring:C12($splitLine[3]; Position:C15(")"; $splitLine[3])+3)
				
		End case 
		
		Case of 
			: ($varName="$_4D_auto_iter_@")
			: ($varName="$_4D_auto_mutex_@")
			: ($varName="")  // Name done by the compilator for undeclare variable used in For each .... end for each
			: ($varSourceName="Compiler_@")
				
			Else 
				CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; $varSourceName+": "+$varName)
				
				Use ($declaration.declaration)
					$declaration.declaration.push(New shared object:C1526("type"; "variable"; "name"; $varName; "varType"; $varType; "varDimension"; $varDimension; "source"; ZCapitalizeString($varSource; 3); "sourceName"; ZCapitalizeString($varSourceName; 3)))
				End use 
				
		End case 
	End if 
End for each 

Use ($declaration)
	$declaration.count:=$declaration.count+1
End use 
