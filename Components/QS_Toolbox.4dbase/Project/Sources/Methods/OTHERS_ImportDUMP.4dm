//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
CONFIRM:C162("Do you want to import data?")
If (OK=1)
	CONFIRM:C162("Are you sure because all currend data will be scrapped."; "Yes, I am sure"; "Oh No, stop it now !")
	If (ok=1)
		
		$chemin:=Select folder:C670("Select the DUMP folder: "; System folder:C487(Documents folder:K41:18))
		ARRAY TEXT:C222($TbListeDoc; 0x0000)
		
		// Get le document list '.sql' to import
		DOCUMENT LIST:C474($chemin; $TbListeDoc; Recursive parsing:K24:13+Absolute path:K24:14)
		$i:=1
		While ($i<Size of array:C274($TbListeDoc))
			If (Substring:C12($TbListeDoc{$i}; Length:C16($TbListeDoc{$i})-3)#".sql")
				DELETE FROM ARRAY:C228($TbListeDoc; $i)
			Else 
				$i:=$i+1
			End if 
		End while 
		
		// Integration data into the datafile
		
		//$BarInformation:=THERM_Init ("Data integration of ...";"";"images/methods/icns_method.png")
		$Progression:=0
		$m:=Size of array:C274($TbListeDoc)
		$Pas:=1/($m+1)
		
		// Initialisation
		C_LONGINT:C283($window)
		C_OBJECT:C1216($param)
		$param:=New object:C1471("title"; "Data integration of ..."; "icon"; "icns_method.png"; "type"; 0)
		QST_progress_start($param)
		$window:=$param.window
		
		
		If (Get last table number:C254>0)  //si la base contient bien des tables
			For ($vlTables; Get last table number:C254; 1; -1)
				If (Is table number valid:C999($vlTables))
					TRUNCATE TABLE:C1051(Table:C252($vlTables)->)
					If (OK#1)
						ALERT:C41("An error occured during the data suppression of table "+Table name:C256($vlTables))
					End if 
				End if 
			End for 
		End if 
		
		Begin SQL  // Stop index and constraints (and trigger too)
			ALTER DATABASE DISABLE INDEXES; 
			ALTER DATABASE DISABLE CONSTRAINTS;
		End SQL
		
		For ($a; 1; $m)
			$Progression:=$Progression+$pas
			$param.value:=$Progression
			$param.content:=$TbListeDoc{$a}
			CALL FORM:C1391($window; "progressBar_update"; $param)
			SQL EXECUTE SCRIPT:C1089($TbListeDoc{$a}; SQL On error continue:K49:17)  // Intégration des fichiers d'export
		End for 
		
		Begin SQL  // Restart index and constraints (and trigger too)
			ALTER DATABASE ENABLE INDEXES;
			ALTER DATABASE ENABLE CONSTRAINTS;
		End SQL
		
		KILL WORKER:C1390("QST_Progress")
		
		CONFIRM:C162("DUMP integration finished. It's recommanded to restart the application and check data before using the application."; "Restart"; "Continuer without restart")
		If (OK=1)
			RESTART 4D:C1292
		End if 
	End if 
End if 