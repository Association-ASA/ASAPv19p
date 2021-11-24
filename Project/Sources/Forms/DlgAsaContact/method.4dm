$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		ARRAY TEXT:C222(NomASAContact; 0)
		ARRAY DATE:C224(TbDateASAContact; 0)
		ARRAY TEXT:C222(TbUUID; 0)
		ARRAY REAL:C219(TbComptage; 0)
		ARRAY TEXT:C222(TbNuméroAC; 0)
		ARRAY TEXT:C222(TbAdresse; 0)
		
		QUERY:C277([XData:1]; [XData:1]XType:3="FichiersAC")
		SELECTION TO ARRAY:C260([XData:1]XNom:2; NomASAContact; [XData:1]XDate:4; TbDateASAContact; [XData:1]UUID:1; TbUUID; [XData:1]XValeur:7; TbComptage)
		SORT ARRAY:C229(NomASAContact; TbDateASAContact; TbUUID; TbComptage; <)
		
		$TT:=Size of array:C274(NomASAContact)
		For ($salé; 1; $TT)
			$Numéro:=String:C10(Num:C11(NomASAContact{$salé}))
			APPEND TO ARRAY:C911(TbNuméroAC; $Numéro)
			$URL:="https://association.asa-spv.fr/Aco"+TbUUID{$salé}+".pdf"
			APPEND TO ARRAY:C911(TbAdresse; $URL)
		End for 
End case 
