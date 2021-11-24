var $evt : Integer
$evt:=Form event code:C388

Case of 
	: ($evt=On Load:K2:1)
		SET WINDOW TITLE:C213(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName)
		OBJECT SET ENABLED:C1123(*; "btn_camera"; Storage:C1525.QS_TBX_SHARED_DATA.NirCmd)
		//If (Storage.QS_TBX_SHARED_DATA.QS_TBX_ServerMode)
		//OBJECT SET RGB COLORS(*; "rectangle"; 0xFFFF; 0x0000)
		//End if 
		
	: ($evt=On Unload:K2:2) | ($evt=On Close Box:K2:21)
		CANCEL:C270
		KILL WORKER:C1390
		
End case 

