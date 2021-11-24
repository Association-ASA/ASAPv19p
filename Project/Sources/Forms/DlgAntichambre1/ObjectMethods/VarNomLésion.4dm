C_LONGINT:C283($Salé;$FT)

$evt:=Form event code:C388
Case of 
	: ($evt=Sur après frappe clavier:K2:26)
		$T:=Get edited text:C655
		If (Length:C16($T)>2)
			$Test:="@"+$T+"@"
			QUERY:C277([DiaLesions:44];[DiaLesions:44]NomLesion:1=$Test)
			$FT:=Records in selection:C76([DiaLesions:44])
			Case of 
				: ($FT=0)
					ALERT:C41("Désolé, aucune lésion ne comporte la chaine "+$T)
					VarNomLésion:=""
					
				: ($FT=1)
					VarNomLésion:=[DiaLesions:44]NomLesion:1
					
					
				: ($FT>1)
					ARRAY TEXT:C222($TbNomLesion;$FT)
					ARRAY TEXT:C222($TbNomLesionAffichée;$FT)
					ORDER BY:C49([DiaLesions:44];[DiaLesions:44]NomLesion:1;>)
					SELECTION TO ARRAY:C260([DiaLesions:44]NomLesion:1;$TbNomLesion)
					$FT:=Size of array:C274($TbNomLesion)
					For ($Salé;1;$FT)
						$NLCourant:=$TbNomLesion{$Salé}
						$TbNomLesionAffichée{$Salé}:=Replace string:C233($NLCourant;"(";" ")
						$TbNomLesionAffichée{$Salé}:=Replace string:C233($TbNomLesionAffichée{$Salé};")";" ")
					End for 
					
					$Menu:=ZTableauVersTexte (->$TbNomLesionAffichée;";")
					$Li:=Pop up menu:C542($Menu)
					VarNomLésion:=$TbNomLesion{$Li}
			End case 
		End if 
		
	: ($evt=Sur données modifiées:K2:15)
		If (VarNomLésion#"")
			QUERY:C277([Diapositives:40];[Diapositives:40]Espece:3=<>PUMEspèce{<>PUMEspèce};*)
			QUERY:C277([Diapositives:40]; & [Diapositives:40]Organe:2=<>PUMOrgane{<>PUMOrgane};*)
			QUERY:C277([Diapositives:40]; & [Diapositives:40]NomLesion:4=VarNomLésion)
			$FT:=Records in selection:C76([Diapositives:40])
			ARRAY PICTURE:C279(TbImagesAsaDia;$FT)
			For ($Salé;1;$FT)
				$CDNomImage:=Get 4D folder:C485(Dossier base:K5:14)+"dossier Photos"+Séparateur dossier:K24:12+String:C10([Diapositives:40]NumOrdreDiapos:1)+".jpg"
				READ PICTURE FILE:C678($CDNomImage;$VarDia)
				TbImagesAsaDia{$Salé}:=$VarDia
				NEXT RECORD:C51([Diapositives:40])
			End for 
			VarNbDia:=Size of array:C274(TbImagesAsaDia)
		End if 
End case 
