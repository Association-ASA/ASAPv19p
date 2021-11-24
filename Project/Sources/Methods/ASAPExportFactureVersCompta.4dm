//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : ASA
// Date et heure : 06/04/21, 14:22:05
// ----------------------------------------------------
// Méthode : ASAPExportFactureVersCompta
// Description
// Exporte les factures d'ASAP vers EBP
// ----------------------------------------------------
CREATE SELECTION FROM ARRAY:C640([Factures:15]; TbNumEnr)

SELECTION TO ARRAY:C260([Factures:15]NumFacture:3; $TbNumFacture; [Factures:15]TotalTTC:10; $TbTotalFacture; [Factures:15]UUIDPersonne:2; $TbUUIDPersFacture; [Factures:15]TotalTVA:9; $TbTTVAFacture; [Factures:15]AdresseFacturation:5; $TbAdresseFac)
RELATE MANY SELECTION:C340([Ventes:16]NumFacture:2)
SELECTION TO ARRAY:C260([Ventes:16]NumFacture:2; $TbNumFacVentes; [Ventes:16]TauxTVA:8; $TbTauxTVA; [Ventes:16]PrixTotalHT:7; $TbPrixHT; [Ventes:16]DateVente:4; $TbDateVente; [Ventes:16]CodePrestation:9; $TbCodePresta)
SORT ARRAY:C229($TbNumFacVentes; $TbTauxTVA; $TbPrixHT; $TbDateVente; $TbCodePresta; >)
$NbrFacture:=Records in selection:C76([Factures:15])
//CONFIRMER("Vous souhaitez réaliser l'export des "+Chaîne($NbrFacture)+" sélectionnées ?")

$TT:=Size of array:C274($TbNumFacVentes)
$Compteur:=1
$Export:=""

For ($Salé; 1; $TT)
	$TauxTVA:=0
	$CompteurTVA:=0
	Repeat 
		$L1:=Find in array:C230($TbNumFacture; $TbNumFacVentes{$Salé})
		$L2:=Find in array:C230(<>TBPERUUID; $TbUUIDPersFacture{$L1})
		If ($Salé=$TT)
			//$Fini:=($TbNumFacVentes{$Salé})#($TbNumFacVentes{$Salé+1})
			$Fini:=True:C214
		Else 
			$Fini:=($TbNumFacVentes{$Salé})#($TbNumFacVentes{$Salé+1})
		End if 
		
		//$Salé:=$Salé+Num(Non($Fini))
		// Traitement de la vente
		Case of 
			: $TbNumFacVentes{$salé}="@/C@"  // C'est un cotisation individuelle
				$Date:=$TbDateVente{$Salé}
				$DateRèglement:=ASAPFacTrouveDateRèglement($Date)
				If (<>TBPERNOMCOURT{$L2}#"")
					$NumFacNom:=$TbNumFacVentes{$Salé}+" "+<>TBPERNOMCOURT{$L2}
				Else 
					$NumFacNom:=$TbNumFacVentes{$Salé}+" "+<>TBPERNOMLONG{$L2}
				End if 
				$Prix:=Replace string:C233(String:C10($TbPrixHT{$Salé}; "########0.00"); ","; ".")
				$Export:=$Export+String:C10($Compteur)+<>ZTAB+String:C10($TbDateVente{$Salé})+<>ZTAB+"VE"+<>ZTAB+"7061000"+<>ZTAB+"LA"+<>ZTAB+$NumFacNom+<>ZTAB
				$Export:=$Export+$TbNumFacVentes{$Salé}+<>ZTAB+$Prix+<>ZTAB+"C"+<>ZTAB+String:C10($DateRèglement)+<>ZCR
				$Compteur:=$Compteur+1
				
				
			: $TbNumFacVentes{$salé}="@/RT@"  // C'est une facture RAEMA Poudre
				$Date:=$TbDateVente{$Salé}
				$DateRèglement:=ASAPFacTrouveDateRèglement($Date)
				If (<>TBPERNOMCOURT{$L2}#"")
					$NumFacNom:=$TbNumFacVentes{$Salé}+" "+<>TBPERNOMCOURT{$L2}
				Else 
					$NumFacNom:=$TbNumFacVentes{$Salé}+" "+<>TBPERNOMLONG{$L2}
				End if 
				$CodePresta:=""
				If ($TbCodePresta{$Salé}="COT")
					$CodePresta:="7061090"
				Else 
					$PaysFacturation:=<>TbPAFacturationPays{$L2}
					$Association:=<>TbPAAssociation{$L2}
					Case of 
						: ($PaysFacturation="France") & ($Association#"ADILVA@")
							$CodePresta:="7060190"
							
						: ($Association="ADILVA@")
							$CodePresta:="7060400"
							
						: ($PaysFacturation="Outre Mer") & ($Association#"ADILVA@")
							$CodePresta:="7060210"
							
						: ($PaysFacturation="Etrangers") & ($TbUUIDPersFacture{$L1}="8170383B1EB94C9EB70597A5424DA08C")
							$CodePresta:="7060420"
							
						: ($PaysFacturation="Etrangers")
							$CodePresta:="7060290"
							
						: ($PaysFacturation="")
							$CodePresta:=""
					End case 
					
				End if 
				If ($TbTauxTVA{$salé}#0)
					$CompteurTVA:=$CompteurTVA+1
				End if 
				$TauxTVA:=$TauxTVA+$TbTauxTVA{$salé}
				
				$Prix:=Replace string:C233(String:C10($TbPrixHT{$Salé}; "########0.00"); ","; ".")
				$Export:=$Export+String:C10($Compteur)+<>ZTAB+String:C10($TbDateVente{$Salé})+<>ZTAB+"VE"+<>ZTAB+$CodePresta+<>ZTAB+"LA"+<>ZTAB+$NumFacNom+<>ZTAB
				$Export:=$Export+$TbNumFacVentes{$Salé}+<>ZTAB+$Prix+<>ZTAB+"C"+<>ZTAB+String:C10($DateRèglement)+<>ZCR
				$Compteur:=$Compteur+1
				
			: $TbNumFacVentes{$salé}="@/RC@"  // C'est une facture RAEMA Gel
				$Date:=$TbDateVente{$Salé}
				$DateRèglement:=ASAPFacTrouveDateRèglement($Date)
				If (<>TBPERNOMCOURT{$L2}#"")
					$NumFacNom:=$TbNumFacVentes{$Salé}+" "+<>TBPERNOMCOURT{$L2}
				Else 
					$NumFacNom:=$TbNumFacVentes{$Salé}+" "+<>TBPERNOMLONG{$L2}
				End if 
				$CodePresta:=""
				If ($TbCodePresta{$Salé}="COT")
					$CodePresta:="7061090"
				Else 
					$PaysFacturation:=<>TbPAFacturationPays{$L2}
					$Association:=<>TbPAAssociation{$L2}
					Case of 
						: ($PaysFacturation="France") & ($Association#"ADILVA@")
							$CodePresta:="7060390"
							
						: ($Association="ADILVA@")
							$CodePresta:="7060349"
							
						: ($PaysFacturation="Outre Mer") & ($Association#"ADILVA@")
							$CodePresta:="7060590"
							
						: ($PaysFacturation="Etrangers")
							$CodePresta:="7060490"
							
						: ($PaysFacturation="")
							$CodePresta:=""
					End case 
					
				End if 
				
				If ($TbTauxTVA{$salé}#0)
					$CompteurTVA:=$CompteurTVA+1
				End if 
				$TauxTVA:=$TauxTVA+$TbTauxTVA{$salé}
				
				$Prix:=Replace string:C233(String:C10($TbPrixHT{$Salé}; "########0.00"); ","; ".")
				$Export:=$Export+String:C10($Compteur)+<>ZTAB+String:C10($TbDateVente{$Salé})+<>ZTAB+"VE"+<>ZTAB+$CodePresta+<>ZTAB+"LA"+<>ZTAB+$NumFacNom+<>ZTAB
				$Export:=$Export+$TbNumFacVentes{$Salé}+<>ZTAB+$Prix+<>ZTAB+"C"+<>ZTAB+String:C10($DateRèglement)+<>ZCR
				$Compteur:=$Compteur+1
				
			: $TbNumFacVentes{$salé}="@/X@"  // C'est une facture diverse
				$Date:=$TbDateVente{$Salé}
				$DateRèglement:=ASAPFacTrouveDateRèglement($Date)
				If (<>TBPERNOMCOURT{$L2}#"")
					$NumFacNom:=$TbNumFacVentes{$Salé}+" "+<>TBPERNOMCOURT{$L2}
				Else 
					$NumFacNom:=$TbNumFacVentes{$Salé}+" "+<>TBPERNOMLONG{$L2}
				End if 
				If ($NumFacNom="@RIOUALL@")
					$pos:=Position:C15(<>ZCR; $TbAdresseFac{$L1})
					$NumFacNom:=$TbNumFacVentes{$Salé}+" "+Substring:C12($TbAdresseFac{$L1}; 1; $pos-1)
				End if 
				$CodePresta:=""
				If ($TbTauxTVA{$salé}#0)
					$CompteurTVA:=$CompteurTVA+1
				End if 
				$TauxTVA:=$TauxTVA+$TbTauxTVA{$salé}
				
				$Prix:=Replace string:C233(String:C10($TbPrixHT{$Salé}; "########0.00"); ","; ".")
				$Export:=$Export+String:C10($Compteur)+<>ZTAB+String:C10($TbDateVente{$Salé})+<>ZTAB+"VE"+<>ZTAB+"7064000"+<>ZTAB+"LA"+<>ZTAB+$NumFacNom+<>ZTAB
				$Export:=$Export+$TbNumFacVentes{$Salé}+<>ZTAB+$Prix+<>ZTAB+"C"+<>ZTAB+String:C10($DateRèglement)+<>ZCR
				$Compteur:=$Compteur+1
				
			Else 
				If ($TbNumFacVentes{$salé})=""
					ALERT:C41("Vous tentez d'exporter une facture qui n'a pas de numéro.")
				Else 
					ALERT:C41("La facture "+$TbNumFacVentes{$salé}+"ne correpond pas à une RT, une RC, une C ou une X, merci de revoir le numéro de facture")
				End if 
		End case 
		$Salé:=$Salé+Num:C11(Not:C34($Fini))
		//Sinon 
		//$Fini:=Vrai
		//Fin de si 
		
	Until ($Fini)
	// traitement des lignes HT et TTC
	Case of 
		: $TbNumFacVentes{$salé}="@/C@"  // C'est un cotisation individuelle
			$Prix:=Replace string:C233(String:C10($TbTotalFacture{$L1}; "########0.00"); ","; ".")
			$Export:=$Export+String:C10($Compteur)+<>ZTAB+String:C10($TbDateVente{$Salé})+<>ZTAB+"VE"+<>ZTAB+"411019"+<>ZTAB+"LA"+<>ZTAB+$NumFacNom+<>ZTAB
			$Export:=$Export+$TbNumFacVentes{$Salé}+<>ZTAB+$Prix+<>ZTAB+"D"+<>ZTAB+String:C10($DateRèglement)+<>ZCR
			$Compteur:=$Compteur+1
			
		: $TbNumFacVentes{$salé}="@/RT@"  // C'est une facture RAEMA Poudre
			// Calculons le total TVA
			$TVAFacture:=$TbTTVAFacture{$L1}
			If ($TauxTVA#0)
				$TauxTVA:=$TauxTVA/$CompteurTVA
				$CodeTVA:=(Num:C11($TauxTVA=20)*"4457300")+(Num:C11($TauxTVA=8.5)*"4457600")+(Num:C11($TauxTVA=8.505)*"4457600")
				$Prix:=Replace string:C233(String:C10($TbTTVAFacture{$L1}; "########0.00"); ","; ".")
				$Export:=$Export+String:C10($Compteur)+<>ZTAB+String:C10($TbDateVente{$Salé})+<>ZTAB+"VE"+<>ZTAB+$CodeTVA+<>ZTAB+"LA"+<>ZTAB+$NumFacNom+<>ZTAB
				$Export:=$Export+$TbNumFacVentes{$Salé}+<>ZTAB+$Prix+<>ZTAB+"C"+<>ZTAB+String:C10($DateRèglement)+<>ZCR
				$Compteur:=$Compteur+1
			End if 
			// Calculons le total TTC
			$PaysFacturation:=<>TbPAFacturationPays{$L2}
			$CodeTTC:=(Num:C11($PaysFacturation="France")*"412000")+(Num:C11($PaysFacturation="Outre Mer")*"413000")+(Num:C11($PaysFacturation="Etrangers")*"414000")
			$Prix:=Replace string:C233(String:C10($TbTotalFacture{$L1}; "########0.00"); ","; ".")
			$Export:=$Export+String:C10($Compteur)+<>ZTAB+String:C10($TbDateVente{$Salé})+<>ZTAB+"VE"+<>ZTAB+$CodeTTC+<>ZTAB+"LA"+<>ZTAB+$NumFacNom+<>ZTAB
			$Export:=$Export+$TbNumFacVentes{$Salé}+<>ZTAB+$Prix+<>ZTAB+"D"+<>ZTAB+String:C10($DateRèglement)+<>ZCR
			$Compteur:=$Compteur+1
			
		: $TbNumFacVentes{$salé}="@/RC@"  // C'est une facture RAEMA Gel
			// Calculons le total TVA
			$TVAFacture:=$TbTTVAFacture{$L1}
			If ($TauxTVA#0)
				$TauxTVA:=$TauxTVA/$CompteurTVA
				$CodeTVA:=(Num:C11($TauxTVA=20)*"4457300")+(Num:C11($TauxTVA=8.5)*"4457600")+(Num:C11($TauxTVA=8.505)*"4457600")
				$Prix:=Replace string:C233(String:C10($TbTTVAFacture{$L1}; "########0.00"); ","; ".")
				$Export:=$Export+String:C10($Compteur)+<>ZTAB+String:C10($TbDateVente{$Salé})+<>ZTAB+"VE"+<>ZTAB+$CodeTVA+<>ZTAB+"LA"+<>ZTAB+$NumFacNom+<>ZTAB
				$Export:=$Export+$TbNumFacVentes{$Salé}+<>ZTAB+$Prix+<>ZTAB+"C"+<>ZTAB+String:C10($DateRèglement)+<>ZCR
				$Compteur:=$Compteur+1
			End if 
			// Calculons le total TTC
			$PaysFacturation:=<>TbPAFacturationPays{$L2}
			$CodeTTC:=(Num:C11($PaysFacturation="France")*"416000")+(Num:C11($PaysFacturation="Outre Mer")*"418100")+(Num:C11($PaysFacturation="Etrangers")*"418000")
			$Prix:=Replace string:C233(String:C10($TbTotalFacture{$L1}; "########0.00"); ","; ".")
			$Export:=$Export+String:C10($Compteur)+<>ZTAB+String:C10($TbDateVente{$Salé})+<>ZTAB+"VE"+<>ZTAB+$CodeTTC+<>ZTAB+"LA"+<>ZTAB+$NumFacNom+<>ZTAB
			$Export:=$Export+$TbNumFacVentes{$Salé}+<>ZTAB+$Prix+<>ZTAB+"D"+<>ZTAB+String:C10($DateRèglement)+<>ZCR
			$Compteur:=$Compteur+1
			
		: $TbNumFacVentes{$salé}="@/X@"  // C'est une facture diverse
			$TVAFacture:=$TbTTVAFacture{$L1}
			If ($TauxTVA#0)
				$TauxTVA:=$TauxTVA/$CompteurTVA
				$CodeTVA:=(Num:C11($TauxTVA=20)*"4457300")+(Num:C11($TauxTVA=8.5)*"4457600")+(Num:C11($TauxTVA=8.505)*"4457600")
				$Prix:=Replace string:C233(String:C10($TbTTVAFacture{$L1}; "########0.00"); ","; ".")
				$Export:=$Export+String:C10($Compteur)+<>ZTAB+String:C10($TbDateVente{$Salé})+<>ZTAB+"VE"+<>ZTAB+$CodeTVA+<>ZTAB+"LA"+<>ZTAB+$NumFacNom+<>ZTAB
				$Export:=$Export+$TbNumFacVentes{$Salé}+<>ZTAB+$Prix+<>ZTAB+"C"+<>ZTAB+String:C10($DateRèglement)+<>ZCR
				$Compteur:=$Compteur+1
			End if 
			// Calculons le total TTC
			$PaysFacturation:=<>TbPAFacturationPays{$L2}
			$CodeTTC:="417000"
			$Prix:=Replace string:C233(String:C10($TbTotalFacture{$L1}; "########0.00"); ","; ".")
			$Export:=$Export+String:C10($Compteur)+<>ZTAB+String:C10($TbDateVente{$Salé})+<>ZTAB+"VE"+<>ZTAB+$CodeTTC+<>ZTAB+"LA"+<>ZTAB+$NumFacNom+<>ZTAB
			$Export:=$Export+$TbNumFacVentes{$Salé}+<>ZTAB+$Prix+<>ZTAB+"D"+<>ZTAB+String:C10($DateRèglement)+<>ZCR
			$Compteur:=$Compteur+1
			
	End case 
End for 
SET TEXT TO PASTEBOARD:C523($Export)

$Export:=""

//Si (OK=1)
//$TT:=Taille tableau($TbNumFacVentes)
//$Compteur:=1
//Boucle ($Salé;1;$TT)
//$L1:=Chercher dans tableau($TbNumFacture;$TbNumFacVentes{$Salé})
//$L2:=Chercher dans tableau(<>TBPERUUID;$TbUUIDPersFacture{$L1})
//Au cas ou 
//: $TbNumFacVentes{$Salé}="@/C@"  // C'est un cotisation individuelle
//$Date:=Chaîne($TbDateVente{$Salé})
//$MoisRèglement:=Num(Sous chaîne($Date;4;2))
//Au cas ou 
//: ($MoisRèglement)<9
//$MoisPlus1:="0"+Chaîne(Num($MoisRèglement)+1)
//Si ($MoisPlus1="01") | ($MoisPlus1="03") | ($MoisPlus1="05") | ($MoisPlus1="07") | ($MoisPlus1="08") | ($MoisPlus1="10")
//$Jour:="31"
//Fin de si 
//Si ($MoisPlus1="04") | ($MoisPlus1="06") | ($MoisPlus1="09") | ($MoisPlus1="11")
//$Jour:="30"
//Fin de si 
//Si ($MoisPlus1="02")
//$Jour:="28"
//Fin de si 
//$DateRèglement:=$Jour+"/"+$MoisPlus1+"/"+Chaîne(Année de(Date du jour))

//: ($MoisRèglement)=12
//$DateRèglement:="31/01/"+Chaîne(Num(Année de(Date du jour)+1)

//Sinon 
//$MoisPlus1:=Chaîne(Num($MoisRèglement)+1)
//$DateRèglement:=$Jour+"/"+$MoisPlus1+"/"+Chaîne(Année de(Date du jour))
//Fin de cas 
//Si (<>TBPERNOMCOURT{$L2}#"")
//$NumFacNom:=$TbNumFacVentes{$Salé}+" "+<>TBPERNOMCOURT{$L2}
//Sinon 
//$NumFacNom:=$TbNumFacVentes{$Salé}+" "+<>TBPERNOMLONG{$L2}
//Fin de si 
//$Prix:=Remplacer chaîne(Chaîne($TbPrixHT{$Salé};"########0.00");",";".")
//$Export:=$Export+Chaîne($Compteur)+<>ZTAB+Chaîne($TbDateVente{$Salé})+<>ZTAB+"VE"+<>ZTAB+"7061000"+<>ZTAB+"LA"+<>ZTAB+$NumFacNom+<>ZTAB
//$Export:=$Export+$TbNumFacVentes{$Salé}+<>ZTAB+$Prix+<>ZTAB+"C"+<>ZTAB+$DateRèglement+<>ZCR
//$Compteur:=$Compteur+1
//$Export:=$Export+Chaîne($Compteur)+<>ZTAB+Chaîne($TbDateVente{$Salé})+<>ZTAB+"VE"+<>ZTAB+"411019"+<>ZTAB+"LA"+<>ZTAB+$NumFacNom+<>ZTAB
//$Export:=$Export+$TbNumFacVentes{$Salé}+<>ZTAB+$Prix+<>ZTAB+"D"+<>ZTAB+$DateRèglement+<>ZCR
//$Compteur:=$Compteur+1
//Fin de cas 
//Fin de boucle 

//Fin de si 
//FIXER TEXTE DANS CONTENEUR($Export)