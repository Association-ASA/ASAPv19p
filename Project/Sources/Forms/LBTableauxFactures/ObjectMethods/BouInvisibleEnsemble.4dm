
If (GestionTableau)
	CREATE SELECTION FROM ARRAY:C640(ZPtTable->; TbNumEnr)
End if 
CREATE SET:C116(ZPtTable->; ZNomEnsembleAvant)  // Utile en cas de gestion de liste pour  Ajouter à sélection
$Menu:="Retirer les chorus;Retirer les Adilva;Retirer Adilva et Chorus;Adilva sans Chorus;-;Etranger;Outre-mer"
$VarChoixUtilisateur:=Pop up menu:C542($Menu)
$OC:=True:C214
Case of 
	: ($VarChoixUtilisateur=1)  // Retire les chorus
		CREATE SET:C116([Factures:15]; "ToutesFactures")
		QUERY SELECTION BY ATTRIBUTE:C1424([Factures:15]; [Personnes:12]Arguments:7; "FactureDansChorusGel"; =; "Vrai"; *)
		QUERY SELECTION BY ATTRIBUTE:C1424([Factures:15];  | ; [Personnes:12]Arguments:7; "FactureDansChorus"; =; "Vrai")
		CREATE SET:C116([Factures:15]; "FactureChorus")
		DIFFERENCE:C122("ToutesFactures"; "FactureChorus"; "FactureSansChorus")
		USE SET:C118("FactureSansChorus")
		ASAPFabriqueTbFactures
		
		
		
	: ($VarChoixUtilisateur=2)  // Retire les Adilva
		CREATE SET:C116([Factures:15]; "ToutesFactures")
		QUERY SELECTION BY ATTRIBUTE:C1424([Factures:15]; [Personnes:12]Arguments:7; "Association"; =; "Adilva@")
		CREATE SET:C116([Factures:15]; "FactureAdilva")
		DIFFERENCE:C122("ToutesFactures"; "FactureAdilva"; "FactureSansAdilva")
		USE SET:C118("FactureSansAdilva")
		ASAPFabriqueTbFactures
		
		
	: ($VarChoixUtilisateur=3)  // Retire les Adilva et les chorus
		CREATE SET:C116([Factures:15]; "ToutesFactures")
		QUERY SELECTION BY ATTRIBUTE:C1424([Factures:15]; [Personnes:12]Arguments:7; "FactureDansChorusGel"; =; "Vrai"; *)
		QUERY SELECTION BY ATTRIBUTE:C1424([Factures:15];  | ; [Personnes:12]Arguments:7; "FactureDansChorus"; =; "Vrai"; *)
		QUERY SELECTION BY ATTRIBUTE:C1424([Factures:15];  & ; [Personnes:12]Arguments:7; "Association"; =; "Adilva@")
		CREATE SET:C116([Factures:15]; "FactureChorusAdilva")
		DIFFERENCE:C122("ToutesFactures"; "FactureChorusAdilva"; "FactureSansChorusAdilva")
		USE SET:C118("FactureSansChorusAdilva")
		ASAPFabriqueTbFactures
		
	: ($VarChoixUtilisateur=4)  // Sélectionne les Adilva sans Chorus
		//NOMMER ENSEMBLE([Factures];"ToutesFactures")
		QUERY SELECTION BY ATTRIBUTE:C1424([Factures:15]; [Personnes:12]Arguments:7; "FactureDansChorusGel"; #; "Vrai"; *)
		QUERY SELECTION BY ATTRIBUTE:C1424([Factures:15];  & ; [Personnes:12]Arguments:7; "FactureDansChorus"; #; "Vrai"; *)
		QUERY SELECTION BY ATTRIBUTE:C1424([Factures:15];  & ; [Personnes:12]Arguments:7; "Association"; =; "Adilva@")
		//NOMMER ENSEMBLE([Factures];"FactureSansAdilva")
		//DIFFÉRENCE("ToutesFactures";"FactureSansAdilva";"FactureAdilva")
		//UTILISER ENSEMBLE("FactureAdilva")
		ASAPFabriqueTbFactures
		
	: ($VarChoixUtilisateur=6)  // Sélectionne les Etrangers
		QUERY SELECTION BY ATTRIBUTE:C1424([Factures:15]; [Personnes:12]Arguments:7; "FacturationPays"; =; "Etrangers")
		ASAPFabriqueTbFactures
		
	: ($VarChoixUtilisateur=7)  // Sélectionne les Adilva sans Chorus
		QUERY SELECTION BY ATTRIBUTE:C1424([Factures:15]; [Personnes:12]Arguments:7; "FacturationPays"; =; "Outre Mer")
		ASAPFabriqueTbFactures
		
		
	Else 
		$OC:=False:C215
End case 

If ($OC)
	
	
	If (GestionTableau)
		CREATE SELECTION FROM ARRAY:C640(ZPtTable->; TbNumEnr)
	End if 
	
	
	LISTBOX SELECT ROW:C912(*; "Lb_Tableaux"; 0; lk supprimer de sélection:K53:3)
	ZNbEnr:=Size of array:C274(TbNumFactureASA)
	ZFenetreActualiseTitre
End if 