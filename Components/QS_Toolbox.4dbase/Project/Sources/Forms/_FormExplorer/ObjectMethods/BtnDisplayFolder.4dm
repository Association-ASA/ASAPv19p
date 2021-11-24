Case of 
	: (Form event code:C388=On Clicked:K2:4)
		SHOW ON DISK:C922(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DestinationPath+"Export JSON"+Folder separator:K24:12)
		If (OK=0)
			$FenetreInformation:="No JSON export has been done for this database."
			displayInfo ($FenetreInformation)
		End if 
		
End case 