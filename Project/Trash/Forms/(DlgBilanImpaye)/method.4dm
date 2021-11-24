$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		Annee3:=Num:C11(Year of:C25(Current date:C33))
		Annee2:=Num:C11(Year of:C25(Current date:C33)-1)
		Annee1:=Num:C11(Year of:C25(Current date:C33)-2)
		
		  // Initialisation des variables du tableau
		TotalFRP1:=0
		TotalFRP2:=0
		TotalFRP3:=0
		TotalETP1:=0
		TotalETP2:=0
		TotalETP3:=0
		TotalOMP1:=0
		TotalOMP2:=0
		TotalOMP3:=0
		
		TotalFRG1:=0
		TotalFRG2:=0
		TotalFRG3:=0
		TotalETG1:=0
		TotalETG2:=0
		TotalETG3:=0
		TotalOMG1:=0
		TotalOMG2:=0
		TotalOMG3:=0
		
		NumImpayeFRP1:=0
		NumImpayeFRP2:=0
		NumImpayeFRP3:=0
		NumImpayeOMP1:=0
		NumImpayeOMP2:=0
		NumImpayeOMP3:=0
		NumImpayeETP1:=0
		NumImpayeETP2:=0
		NumImpayeETP3:=0
		
		NumImpayeFRG1:=0
		NumImpayeFRG2:=0
		NumImpayeFRG3:=0
		NumImpayeOMG1:=0
		NumImpayeOMG2:=0
		NumImpayeOMG3:=0
		NumImpayeETG1:=0
		NumImpayeETG2:=0
		NumImpayeETG3:=0
		
		NumFacEditeP1:=0
		NumFacEditeP2:=0
		NumFacEditeP3:=0
		
		NumFacEditeG1:=0
		NumFacEditeG2:=0
		NumFacEditeG3:=0
		
		$Millesime3:=Substring:C12(String:C10(Annee3);3;2)
		$Millesime2:=Substring:C12(String:C10(Annee2);3;2)
		$Millesime1:=Substring:C12(String:C10(Annee1);3;2)
		
		For ($Fumé;1;6)
			ARRAY TEXT:C222($TbNumFacNonPaye;0)
			ARRAY TEXT:C222($TbFacEditées;0)
			ARRAY TEXT:C222($TbFacImpayéesFR;0)
			ARRAY TEXT:C222($TbFacImpayéesET;0)
			ARRAY TEXT:C222($TbFacImpayéesOM;0)
			
			$TotalImpayéFRG:=0
			$TotalImpayéETG:=0
			$TotalImpayéOMG:=0
			$TotalImpayéFRP:=0
			$TotalImpayéETP:=0
			$TotalImpayéOMP:=0
			
			If ($Fumé>3)
				$Millesime:=Get pointer:C304("$Millesime"+String:C10(Num:C11($fumé-3)))
				$NumFacEdite:=Get pointer:C304("NumFacEditeG"+String:C10(Num:C11($fumé-3)))
				$NumImpayeFR:=Get pointer:C304("NumImpayeFRG"+String:C10(Num:C11($fumé-3)))
				$NumImpayeET:=Get pointer:C304("NumImpayeETG"+String:C10(Num:C11($fumé-3)))
				$NumImpayeOM:=Get pointer:C304("NumImpayeOMG"+String:C10(Num:C11($fumé-3)))
				$TotalFRG:=Get pointer:C304("TotalFRG"+String:C10(Num:C11($fumé-3)))
				$TotalETG:=Get pointer:C304("TotalETG"+String:C10(Num:C11($fumé-3)))
				$TotalOMG:=Get pointer:C304("TotalOMG"+String:C10(Num:C11($fumé-3)))
				$RCT:="RC"
			Else 
				$Millesime:=Get pointer:C304("$Millesime"+String:C10($fumé))
				$NumFacEdite:=Get pointer:C304("NumFacEditeP"+String:C10($fumé))
				$NumImpayeFR:=Get pointer:C304("NumImpayeFRP"+String:C10($fumé))
				$NumImpayeET:=Get pointer:C304("NumImpayeETP"+String:C10($fumé))
				$NumImpayeOM:=Get pointer:C304("NumImpayeOMP"+String:C10($fumé))
				$TotalFRP:=Get pointer:C304("TotalFRP"+String:C10($fumé))
				$TotalETP:=Get pointer:C304("TotalETP"+String:C10($fumé))
				$TotalOMP:=Get pointer:C304("TotalOMP"+String:C10($fumé))
				$RCT:="RT"
			End if 
			QUERY:C277([Factures:15];[Factures:15]NumFacture:3=($Millesime->+"/"+$RCT+"@"))
			SELECTION TO ARRAY:C260([Factures:15]NumFacture:3;$TbNumFacture;[Factures:15]Regle:12;$TbReglé;[Factures:15]TotalTTC:10;$TbTotalTTC;[Factures:15]UUIDPersonne:2;$TbUUIDPer;[Factures:15]LocalitePays:16;$TbLocalitePays)
			$TT:=Size of array:C274($TbNumFacture)
			For ($salé;1;$TT)
				$L:=Find in array:C230($TbNumFacture;$TbNumFacture{$Salé}+"A")
				Case of 
						  //: ($L<0) & ($TbNumFacture{$Salé}#"@D") & ($TbNumFacture{$Salé}#"@A") & ($TbReglé{$salé}=Faux)
						  //AJOUTER À TABLEAU($TbNumFacNonPaye;$TbNumFacture{$Salé})
					: ($L<0) & ($TbNumFacture{$Salé}#"@D") & ($TbNumFacture{$Salé}#"@A") & ($TbReglé{$salé}=False:C215) & ($TbLocalitePays{$salé}="France")
						APPEND TO ARRAY:C911($TbFacImpayéesFR;$TbNumFacture{$Salé})
						If ($fumé>3)
							$TotalImpayéFRG:=$TotalImpayéFRG+$TbTotalTTC{$salé}
						Else 
							$TotalImpayéFRP:=$TotalImpayéFRP+$TbTotalTTC{$salé}
						End if 
						
					: ($L<0) & ($TbNumFacture{$Salé}#"@D") & ($TbNumFacture{$Salé}#"@A") & ($TbReglé{$salé}=False:C215) & ($TbLocalitePays{$salé}="Etrangers")
						APPEND TO ARRAY:C911($TbFacImpayéesET;$TbNumFacture{$Salé})
						If ($fumé>3)
							$TotalImpayéETG:=$TotalImpayéETG+$TbTotalTTC{$salé}
						Else 
							$TotalImpayéETP:=$TotalImpayéETP+$TbTotalTTC{$salé}
						End if 
						
					: ($L<0) & ($TbNumFacture{$Salé}#"@D") & ($TbNumFacture{$Salé}#"@A") & ($TbReglé{$salé}=False:C215) & ($TbLocalitePays{$salé}="Outre Mer")
						APPEND TO ARRAY:C911($TbFacImpayéesOM;$TbNumFacture{$Salé})
						If ($fumé>3)
							$TotalImpayéOMG:=$TotalImpayéOMG+$TbTotalTTC{$salé}
						Else 
							$TotalImpayéOMP:=$TotalImpayéOMP+$TbTotalTTC{$salé}
						End if 
						
				End case 
				If ($L<0) & ($TbNumFacture{$Salé}#"@D") & ($TbNumFacture{$Salé}#"@A")
					APPEND TO ARRAY:C911($TbFacEditées;$TbNumFacture{$Salé})
				End if 
			End for 
			$NumFacEdite->:=Size of array:C274($TbFacEditées)
			$NumImpayeFR->:=Size of array:C274($TbFacImpayéesFR)
			$NumImpayeET->:=Size of array:C274($TbFacImpayéesET)
			$NumImpayeOM->:=Size of array:C274($TbFacImpayéesOM)
			If ($fumé>3)
				$TotalFRG->:=$TotalImpayéFRG
				$TotalETG->:=$TotalImpayéETG
				$TotalOMG->:=$TotalImpayéOMG
			Else 
				$TotalFRP->:=$TotalImpayéFRP
				$TotalETP->:=$TotalImpayéETP
				$TotalOMP->:=$TotalImpayéOMP
			End if 
		End for 
		
End case 
