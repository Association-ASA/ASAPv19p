$evt:=Form event code:C388
Case of 
	: ($evt=Sur clic:K2:4)
		If (CaseAdilva=1)
			$TT:=Size of array:C274(TbPrixTTC)
			For ($Salé; 1; $TT)
				TbPrixTTC{$Salé}:=TbPrixTTC{$Salé}*(90/100)
				TbPrixHT{$Salé}:=TbPrixHT{$Salé}*(90/100)
				TbPrixUHT{$Salé}:=TbPrixUHT{$Salé}*(90/100)
			End for 
		Else 
			$TT:=Size of array:C274(TbPrixTTC)
			For ($Salé; 1; $TT)
				TbPrixTTC{$Salé}:=TbPrixTTC{$Salé}*100/90
				TbPrixHT{$Salé}:=TbPrixHT{$Salé}*100/90
				TbPrixUHT{$Salé}:=TbPrixUHT{$Salé}*100/90
			End for 
		End if 
		FactureMiseAJourTotaux
End case 