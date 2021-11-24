//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
$chemin:=""
$evt:=Form event code:C388

Case of 
		
	: ($evt=On Clicked:K2:4)
		
		  // %W-533.3
		If ((BASE_NewSelf #"") & (BASE_NewSelf #"-"))
			  // %W+533.3
			$name:=OBJECT Get name:C1087(Object current:K67:2)
			$dossier:=Num:C11(OBJECT Get pointer:C1124(Object current:K67:2)->)-2
			
			Case of 
					
				: ($name="4DFolders")
					
					Case of 
							
						: ($dossier=10)  // "Macro V2")
							$chemin:=Get 4D folder:C485(Active 4D Folder:K5:10;*)+Replace string:C233("Macros v2/";"/";Folder separator:K24:12)
							
						Else 
							
							$chemin:=Get 4D folder:C485($dossier;*)
							
					End case 
					
				: ($name="SystemFolders")
					$chemin:=System folder:C487($dossier)
					
				: ($name="TemporaryFolder")
					$chemin:=Temporary folder:C486
					
				: ($name="4DFile")
					ON ERR CALL:C155("BASE_noERROR")
					$dossier:=$dossier+1
					$chemin:=Get 4D file:C1418($dossier;*)
					ON ERR CALL:C155("")
					
			End case 
			
			If ($chemin#"")
				displayInfo ("")
				SHOW ON DISK:C922($chemin;*)
			Else 
				$txt:="Nothing has been found for the option selected."
				displayInfo ($txt;"red")
			End if 
			
		End if 
End case 
