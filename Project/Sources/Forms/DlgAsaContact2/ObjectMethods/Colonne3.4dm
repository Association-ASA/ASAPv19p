
$evt:=Form event code:C388
Case of 
	: ($evt=Sur double clic:K2:5)
		C_LONGINT:C283($C;$L)
		LISTBOX GET CELL POSITION:C971(*;"ListBoxAsaContact";$C;$L)
		GOTO SELECTED RECORD:C245([XData:1];$L)
		$Code:="Aco"+[XData:1]UUID:1
		SET TEXT TO PASTEBOARD:C523($Code)
		ALERT:C41("Le code Web "+<>ZGuil+$Code+<>ZGuil+" a été placé dans le presse-papier")
End case 
