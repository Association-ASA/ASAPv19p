// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 25/12/12, 18:11:31
// ----------------------------------------------------
// Description
// 
//
// Paramètres
// ----------------------------------------------------

Case of 
	: (Form event code:C388=On Load:K2:1)
		var $c : Collection
		var $blob : Blob
		$c:=New collection:C1472
		$blob:=QS_PARAMS_LOAD
		BLOB TO VARIABLE:C533($blob; $c)
		Form:C1466.setup:=$c.copy()
		Form:C1466.stup:=Form:C1466.setup
		
		
	: (Form event code:C388=On Unload:K2:2)
		var $c : Collection
		var $blob : Blob
		$c:=Form:C1466.setup.copy()
		VARIABLE TO BLOB:C532($c; $blob)
		QS_PARAMS_SAVE($blob)
		
End case 
