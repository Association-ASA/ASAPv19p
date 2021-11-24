C_LONGINT:C283($Salé; $FT)

$evt:=Form event code:C388
Case of 
	: ($evt=Sur après frappe clavier:K2:26)
		$T:=Get edited text:C655
		If (Length:C16($T)>2)
			$Test:="@"+$T+"@"
			QUERY:C277([DiaLesions:44]; [DiaLesions:44]NomLesion:1=$Test)
			$FT:=Records in selection:C76([DiaLesions:44])
			Case of 
				: ($FT=0)
					ALERT:C41("Désolé, aucune lésion ne comporte la chaine "+$T)
					VarNomLésionP2:=""
					
				: ($FT=1)
					VarNomLésionP2:=[DiaLesions:44]NomLesion:1
					
					
				: ($FT>1)
					ARRAY TEXT:C222($TbNomLesion; $FT)
					ARRAY TEXT:C222($TbNomLesionAffichée; $FT)
					ORDER BY:C49([DiaLesions:44]; [DiaLesions:44]NomLesion:1; >)
					SELECTION TO ARRAY:C260([DiaLesions:44]NomLesion:1; $TbNomLesion)
					$FT:=Size of array:C274($TbNomLesion)
					For ($Salé; 1; $FT)
						$NLCourant:=$TbNomLesion{$Salé}
						$TbNomLesionAffichée{$Salé}:=Replace string:C233($NLCourant; "("; " ")
						$TbNomLesionAffichée{$Salé}:=Replace string:C233($TbNomLesionAffichée{$Salé}; ")"; " ")
					End for 
					
					$Menu:=ZTableauVersTexte(->$TbNomLesionAffichée; ";")
					$Li:=Pop up menu:C542($Menu)
					VarNomLésionP2:=$TbNomLesion{$Li}
			End case 
		End if 
		
	: ($evt=Sur données modifiées:K2:15)
		If (VarNomLésionP2#"")
			[DiaData:45]XObjet:15.Lésion:=VarNomLésionP2
			SAVE RECORD:C53([DiaData:45])
			REDRAW:C174(ListBoxVisuAC)
		End if 
End case 
