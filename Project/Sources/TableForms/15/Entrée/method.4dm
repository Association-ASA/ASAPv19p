$evt:=Form event code:C388

Case of 
	: ($evt=Sur chargement:K2:1)
		OBJECT SET VISIBLE:C603(*;"regle@";True:C214)
		CaseAdilva:=0
		ARRAY TEXT:C222(TbPrestation;0)
		ARRAY REAL:C219(TbQuantite;0)
		ARRAY REAL:C219(TbPrixUHT;0)
		ARRAY REAL:C219(TbPrixHT;0)
		ARRAY REAL:C219(TbTauxTVA;0)
		ARRAY REAL:C219(TbPrixTTC;0)
		ARRAY TEXT:C222(TbCodePresta;0)
		
		ARRAY TEXT:C222(PUMTypeFacture;4)
		PUMTypeFacture{1}:="Cotisation individuelle"
		PUMTypeFacture{2}:="RAEMA poudre"
		PUMTypeFacture{3}:="RAEMA gel"
		PUMTypeFacture{4}:="Autres"
		NouvelleFacture:=([Factures:15]NumFacture:3="")
		If ([Factures:15]NumFacture:3#"")  // On est en consultation
			RELATE MANY:C262([Factures:15]NumFacture:3)
			
			QUERY:C277([Personnes:12];[Personnes:12]UUID:1=[Factures:15]UUIDPersonne:2)
			$Millesime:=Substring:C12([Factures:15]NumFacture:3;1;2)
			VarAnnée:=Num:C11("20"+$Millesime)
			  // Choix du bon bouton radio
			Case of 
				: ([Personnes:12]TypePersonne:5="Individu")
					RadLabo:=0
					RadAdh:=1
					RadPro:=0
					RadPar:=0
					
					VarCode:=""
					$Prénom:=OB Get:C1224([Personnes:12]Arguments:7;"Prénom")
					VarNom:=$Prénom+" "+[Personnes:12]NomLong:2
					
				: ([Personnes:12]TypePersonne:5="Laboratoire")
					RadLabo:=1
					RadAdh:=0
					RadPro:=0
					RadPar:=0
					
					
					VarCode:=ASAPTrouveNumeroLaboParUUID ([Personnes:12]UUID:1)
					VarNom:=[Personnes:12]NomLong:2
				Else   // Ce n'est pas pour une personne enregistrée
					  // Gérer à terme les prospects et les partenaires
					VarNom:=""
					VarCode:=""
			End case 
			
			Case of 
				: ([Factures:15]NumFacture:3="@/C@")
					PUMTypeFacture:=1
				: ([Factures:15]NumFacture:3="@/RT@")
					PUMTypeFacture:=2
				: ([Factures:15]NumFacture:3="@/RC@")
					PUMTypeFacture:=3
				: ([Factures:15]NumFacture:3="@/X@")
					PUMTypeFacture:=4
			End case 
			
			If ([Factures:15]NumFacture:3="@D")
				CaseDevis:=1
			End if 
			QUERY:C277([Ventes:16];[Ventes:16]NumFacture:2=[Factures:15]NumFacture:3)
			SELECTION TO ARRAY:C260([Ventes:16]Intitule:3;TbPrestation\
				;[Ventes:16]PrixUHT:5;TbPrixUHT\
				;[Ventes:16]Quantité:6;TbQuantite\
				;[Ventes:16]PrixTotalHT:7;TbPrixHT\
				;[Ventes:16]TauxTVA:8;TbTauxTVA\
				;[Ventes:16]DateReglement:12;$TbDateReglement\
				;[Ventes:16]NumCheque:11;$TbNumCheque\
				;[Ventes:16]CodePrestation:9;TbCodePresta\
				;[Ventes:16]Banque:10;$TbBanque)
			SORT ARRAY:C229(TbPrestation;TbPrixUHT;TbPrixHT;TbQuantite;TbTauxTVA;$TbDateReglement;$TbNumCheque;$TbBanque;TbCodePresta;>)
			
			$TT:=Size of array:C274(TbPrestation)
			For ($Salé;1;$TT)
				$PrixTTC:=TbPrixHT{$Salé}*(1+(TbTauxTVA{$Salé}/100))
				APPEND TO ARRAY:C911(TbPrixTTC;$PrixTTC)
			End for 
			FactureMiseAJourTotaux 
			
			If ([Factures:15]SommeReglee:13=0)
				VarSommeRéglée:=[Factures:15]TotalTTC:10
			Else 
				VarSommeRéglée:=[Factures:15]SommeReglee:13
			End if 
			
			If ([Factures:15]RemiseAdilva:15=True:C214)
				CaseAdilva:=1
			Else 
				CaseAdilva:=0
			End if 
			
			VarNumCheque:=""
			VarBanque:=""
			VarDateReglement:=!00-00-00!
			$TT:=Size of array:C274($TbDateReglement)
			$Reglé:=False:C215
			For ($Salé;1;$TT)
				If ($TbDateReglement{$Salé}#!00-00-00!)
					  // Je remplis les variables
					VarNumCheque:=$TbNumCheque{$Salé}
					VarBanque:=$TbBanque{$Salé}
					VarDateReglement:=$TbDateReglement{$Salé}
					  // je régle l'interface
					$Reglé:=True:C214
					  // je sors de la boucle
					$Salé:=$TT
				End if 
			End for 
			OBJECT SET VISIBLE:C603(*;"regle@";$Reglé)
			  //$Titre:=(Num($Reglé)*"Enregistrer les données")+(Num(Non($Reglé))*"Entrer un réglement")
			  //OBJET FIXER TITRE(*;"BouEntreReglement@";$Titre)
			
		Else   // C'est une nouvelle facture
			  // Remise à 0 de tous les élements. On est en création.
			VarAnnée:=Year of:C25(Current date:C33)
			RadLabo:=1
			RadAdh:=0
			RadPro:=0
			RadPar:=0
			
			[Factures:15]DateFacture:4:=Current date:C33
			VarCode:=""
			VarNom:=""
			PUMTypeFacture:=0
		End if 
		
	: ($evt=Sur validation:K2:3)
		$ChampRechercheAv:=[Factures:15]ChampRecherche:11
		[Factures:15]ChampRecherche:11:=ASAPFactureChampsRecherche 
		READ WRITE:C146([Ventes:16])
		READ WRITE:C146([Factures:15])
		
		
		$TT:=Size of array:C274(TbPrestation)
		ARRAY TEXT:C222($TbNumFacture;$TT)
		ARRAY DATE:C224($TbDate;$TT)
		For ($salé;1;$TT)
			$TbNumFacture{$salé}:=[Factures:15]NumFacture:3
			$TbDate{$salé}:=[Factures:15]DateFacture:4
		End for 
		If (NouvelleFacture)
			NouvelleFacture:=False:C215
			ZViderSelectionCourante (->[Ventes:16])
			ARRAY TO SELECTION:C261(TbPrestation;[Ventes:16]Intitule:3;$TbNumFacture;[Ventes:16]NumFacture:2;$TbDate;[Ventes:16]DateVente:4;TbPrixUHT;[Ventes:16]PrixUHT:5;TbQuantite;[Ventes:16]Quantité:6;TbPrixHT;[Ventes:16]PrixTotalHT:7;TbTauxTVA;[Ventes:16]TauxTVA:8;TbCodePresta;[Ventes:16]CodePrestation:9)
			If (CaseAdilva=1)
				[Factures:15]RemiseAdilva:15:=True:C214
			Else 
				[Factures:15]RemiseAdilva:15:=False:C215
			End if 
			[Factures:15]LocalitePays:16:=OB Get:C1224([Personnes:12]Arguments:7;"FacturationPays";Est un texte:K8:3)
			$L:=Find in array:C230(<>TBPERUUID;[Personnes:12]UUID:1)
			If ($L>0)
				[Factures:15]PaysFacturation:7:=<>TbPerAdrFacPays{$L}
				If (<>TbPerAdrFacPays{$L}="")
					[Factures:15]PaysFacturation:7:=<>TbPerAdrLivPays{$L}
				End if 
			Else 
				[Factures:15]PaysFacturation:7:=""
			End if 
			SAVE RECORD:C53([Factures:15])
			QUERY:C277([Personnes:12];[Personnes:12]UUID:1=[Factures:15]UUIDPersonne:2)
			ASAPFactureNomDocPdfWeb 
		Else 
			DELETE SELECTION:C66([Ventes:16])
			$TT:=Size of array:C274(TbPrestation)
			ARRAY TEXT:C222($TbBanqueF;$TT)
			ARRAY DATE:C224($TbDateRegleF;$TT)
			ARRAY TEXT:C222($TbNumChequeF;$TT)
			For ($Salé;1;$TT)
				$TbBanqueF{$Salé}:=VarBanque
				$TbDateRegleF{$Salé}:=VarDateReglement
				$TbNumChequeF{$Salé}:=VarNumCheque
			End for 
			
			ARRAY TO SELECTION:C261(TbPrestation;[Ventes:16]Intitule:3;$TbNumFacture;[Ventes:16]NumFacture:2;$TbDate;[Ventes:16]DateVente:4;TbPrixUHT;[Ventes:16]PrixUHT:5;TbQuantite;[Ventes:16]Quantité:6;TbPrixHT;[Ventes:16]PrixTotalHT:7;TbTauxTVA;[Ventes:16]TauxTVA:8;TbCodePresta;[Ventes:16]CodePrestation:9;$TbBanqueF;[Ventes:16]Banque:10;$TbDateRegleF;[Ventes:16]DateReglement:12;$TbNumChequeF;[Ventes:16]NumCheque:11)
			FactureMiseAJourTotaux 
			If (CaseAdilva=1)
				[Factures:15]RemiseAdilva:15:=True:C214
			Else 
				[Factures:15]RemiseAdilva:15:=False:C215
			End if 
			[Factures:15]LocalitePays:16:=OB Get:C1224([Personnes:12]Arguments:7;"FacturationPays";Est un texte:K8:3)
			$L:=Find in array:C230(<>TBPERUUID;[Personnes:12]UUID:1)
			If ($L>0)
				[Factures:15]PaysFacturation:7:=<>TbPerAdrFacPays{$L}
				If (<>TbPerAdrFacPays{$L}="")
					[Factures:15]PaysFacturation:7:=<>TbPerAdrLivPays{$L}
				End if 
			Else 
				[Factures:15]PaysFacturation:7:=""
			End if 
			SAVE RECORD:C53([Factures:15])
			If ($ChampRechercheAv#[Factures:15]ChampRecherche:11)
				ASAPFactureNomDocPdfWeb 
			End if 
		End if 
		
		QUERY:C277([Factures:15];[Factures:15]NumFacture:3=(<>ZPermMille+"@"))
		If (Records in selection:C76([Factures:15])=0)
			$AnnéePrécédente:=String:C10(Num:C11(<>ZPermMille)-1)
			QUERY:C277([Factures:15];[Factures:15]NumFacture:3=($AnnéePrécédente+"@"))
		End if 
		ORDER BY:C49([Factures:15];[Factures:15]NumFacture:3;>)
		ASAPFabriqueTbFactures 
		
End case 
