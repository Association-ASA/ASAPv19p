$MCE:=<>Boss & Macintosh command down:C546
If ($MCE)
	READ WRITE:C146([DiaData:45])
End if 
QUERY:C277([DiaData:45];[DiaData:45]XType:5="TdC")
If (BLOB size:C605([DiaData:45]XBlob:11)=0) | $mce
	If (Records in selection:C76([DiaData:45])=0)
		CREATE RECORD:C68([DiaData:45])
		[DiaData:45]XNom:1:="fghfgTdC"
		[DiaData:45]XType:5:="TdC"
		SAVE RECORD:C53([DiaData:45])
	End if 
	$Doc:=Open document:C264("")
	If (OK=1)
		CLOSE DOCUMENT:C267($Doc)
		CheminDoc:=document
		ZVerrouAttendre (->[DiaData:45])
		DOCUMENT TO BLOB:C525(CheminDoc;[DiaData:45]XBlob:11)
		SAVE RECORD:C53([DiaData:45])
		UNLOAD RECORD:C212([DiaData:45])
		READ ONLY:C145([DiaData:45])
	End if 
Else 
	CheminDoc:=Get 4D folder:C485+"Correspondance.doc"
	If (Test path name:C476(CheminDoc)<0)
		$Doc:=Create document:C266(CheminDoc)
		CLOSE DOCUMENT:C267($Doc)
	End if 
	BLOB TO DOCUMENT:C526(CheminDoc;[DiaData:45]XBlob:11)
	OPEN URL:C673(CheminDoc)
End if 


