//%attributes = {"publishedWeb":true,"lang":"fr"}
// ZTestRecherche 6.0  du 30/08/98
//  MG de recherche des enregistrements sur la totalité de la table
//  qui avertit l'utilisateur si la recherche est infructueuse
//  appelée par le boutons standard ZBouRechTotale
//  utilise ZActualiseTitreFenetre

CREATE SET:C116(ZPtTable->; "Ceusses avant")
QUERY:C277(ZPtTable->)
If (Records in selection:C76(ZPtTable->)=0)
	CONFIRM:C162("Aucune fiche trouvée: je reprends la sélection précédente")
	If (OK=1)
		USE SET:C118("Ceusses avant")
	End if 
End if 
ZFenetreActualiseTitre