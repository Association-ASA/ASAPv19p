//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 22/01/19, 16:17:31
  // ----------------------------------------------------
  // Paramètres
  // ----------------------------------------------------
  // Méthode : ASAPFactureRAEMAPoudre
  // Description
  // Méthode générale permettant de facturer le RAEMA

C_LONGINT:C283($Salé;$FT;$Quantité)
C_TEXT:C284($TVA)

READ WRITE:C146([Factures:15])
READ WRITE:C146([Ventes:16])
READ WRITE:C146([Personnes:12])

  // Recueil des raema concernés
$AnN:=Year of:C25(Current date:C33)
$numCampagneMars:=RaemaTrouveNumCampagneParAn ($AnN)
$numCampagneOctobre:=RaemaTrouveNumCampagneParAn ($AnN;3)

TauxAdilva:=10  // Taux à revoir en fonction de la convention

  // les ADILVA et Belges et autres exotiques ont une facturation plus bas
  //CHERCHER PAR ATTRIBUT([Personnes]; & ;[Personnes]Arguments;"Association";#;"Adilva";*)  // Pas l'ADILVA
  //CHERCHER PAR ATTRIBUT([Personnes]; & ;[Personnes]Arguments;"Association";#;"belges";*)  // Pas l'belges

QUERY BY ATTRIBUTE:C1331([Personnes:12];[Personnes:12]Arguments:7;"Association";#;"@maroc@";*)  // Pas les marocains
QUERY:C277([Personnes:12]; & [Personnes:12]TypePersonne:5="laboratoire";*)  // un labo
QUERY BY ATTRIBUTE:C1331([Personnes:12]; & ;[Personnes:12]Arguments:7;"FacturationSpeciale";#;"Vrai";*)  // Pas de facturation spéciale
QUERY:C277([Personnes:12]; & [Personnes:12]Caduc:8=False:C215)  // Pas caduc = mauvais critère car on facture selon le programme de participation
$FT:=Records in selection:C76([Personnes:12])
For ($Salé;1;$FT)
	
	  // Initalisation des tableaux les lignes de facture ([Ventes])
	ARRAY TEXT:C222(TbLFNumFacture;0)
	ARRAY TEXT:C222(TbLFIntitule;0)
	ARRAY TEXT:C222(TbLFCodePrestation;0)
	ARRAY REAL:C219(TbLFPrixHT;0)
	ARRAY REAL:C219(TbLFTauxTVA;0)
	ARRAY REAL:C219(TbLFQuantité;0)
	ARRAY REAL:C219(TbLFPrixTotalHT;0)
	ARRAY DATE:C224(TbLFDateVente;0)
	
	
	$NumRaema:=ASAPTrouveNumeroLaboParUUID ([Personnes:12]UUID:1)
	$IDParticipeMars:=$NumRaema+"_"+$numCampagneMars+"_"
	$IDParticipeOctobre:=$NumRaema+"_"+$numCampagneOctobre+"_"
	$L:=Find in array:C230(<>TbLotoUUIDLabo;[Personnes:12]UUID:1)
	If ($L<0)
		Association:="ASA"
	Else 
		Association:=<>TbLotoAssociation{$L}
	End if 
	If (Association="")
		Association:="ASA"
	End if 
	$LMars:=Find in array:C230(<>TbLotoIdentifiantParticipation;$IDParticipeMars)
	$Mars:=($LMars>0)
	$LOctobre:=Find in array:C230(<>TbLotoIdentifiantParticipation;$IDParticipeOctobre)
	$Octobre:=($LOctobre>0)
	$UneSeule:=((Num:C11($Mars)+Num:C11($Octobre))=1)
	$Quantité:=1
	
	If ($Octobre) | ($Mars)  // sinon aucune facturation nécessaire
		
		  // Facturation de la cotisation
		$Cotis:=OB Get:C1224([Personnes:12]Arguments:7;"NonSoumisCotisation";Est un texte:K8:3)
		If ($Cotis#"Vrai") | (Association#"Adilva")
			ASAPCreerTbLigneFactureRaemaP ("COT";$Quantité)
		End if 
		
		  // Facturation RAEMA poudre
		
		  // Recherche dans les tableaux généraux de campagne de la participation éventuelle du laboratoire
		$NumRaema:=ASAPTrouveNumeroLaboParUUID ([Personnes:12]UUID:1)
		
		
		Case of 
			: ($Mars & $Octobre)
				  //FACTURATION des deux campagnes
				ASAPCreerTbLigneFactureRaemaP ("P2C";1)
				
				  // FACTURATION DES POUDRES AVEC RAPPORT COFRAC
				If (<>TbLotoNbColisPoudreAR{$LMars}>0) & (<>TbLotoNbColisPoudreAR{$LOctobre}>0)  // en  MARS et en OCTOBRE
					ASAPCreerTbLigneFactureRaemaP ("P2AR";(<>TbLotoNbColisPoudreAR{$LMars}+<>TbLotoNbColisPoudreAR{$LOctobre}))
				End if 
				
				  // FACTURATION DES POUDRES SANS RAPPORT COFRAC
				If (<>TbLotoNbColisPoudreSR{$LMars}>0) & (<>TbLotoNbColisPoudreSR{$LOctobre}>0)  // en  MARS et en OCTOBRE
					ASAPCreerTbLigneFactureRaemaP ("P2SR";(<>TbLotoNbColisPoudreSR{$LMars}+<>TbLotoNbColisPoudreSR{$LOctobre}))
				End if 
				
				  // FACTURATION DES BOITES ISOTHERMES
				$BoiteM:=<>TbLotoBoiteIsotherme{$LMars}
				$BoiteO:=<>TbLotoBoiteIsotherme{$LOctobre}
				If ($BoiteM=2) | ($BoiteO=2)
					$Code:="BOI"
					ASAPCreerTbLigneFactureRaemaP ($Code;(($BoiteM+$BoiteO)/2))
				End if 
				
				  // FACTURATION CORRESPONDANCE ENTRE POTS
				Case of 
					: (<>TbLotoCorrespondancePots{$LMars}) & (<>TbLotoCorrespondancePots{$LOctobre})  // en  MARS et en OCTOBRE
						ASAPCreerTbLigneFactureRaemaP ("COR";2)
						
					: (<>TbLotoCorrespondancePots{$LMars}) | (<>TbLotoCorrespondancePots{$LOctobre})  // en  MARS et en OCTOBRE
						ASAPCreerTbLigneFactureRaemaP ("COR";1)
						
				End case 
				
				  // Num Bon de commande
				If (<>TbLotoNumBonCommandePoudre{$LMars}#"")
					$NumBonDeCommande:=<>TbLotoNumBonCommandePoudre{$LMars}
				Else 
					$NumBonDeCommande:=""
				End if 
				
				
			: ($Mars)  // mars seulement
				
				  //FACTURATION de la campagne de MARS
				ASAPCreerTbLigneFactureRaemaP ("P1M";$Quantité)
				
				  // FACTURATION DES POUDRES AVEC RAPPORT COFRAC
				If (<>TbLotoNbColisPoudreAR{$LMars}>0)  // en  MARS 
					ASAPCreerTbLigneFactureRaemaP ("PMAR";(<>TbLotoNbColisPoudreAR{$LMars}))
				End if 
				
				  // FACTURATION DES POUDRES SANS RAPPORT COFRAC
				If (<>TbLotoNbColisPoudreSR{$LMars}>0)  // en  MARS
					ASAPCreerTbLigneFactureRaemaP ("PMSR";<>TbLotoNbColisPoudreSR{$LMars})
				End if 
				
				  // FACTURATION CORRESPONDANCE ENTRE POTS
				If (<>TbLotoCorrespondancePots{$LMars})  // en  MARS 
					ASAPCreerTbLigneFactureRaemaP ("COR";1)
				End if 
				
				
				  // FACTURATION DES BOITES ISOTHERMES
				$BoiteM:=<>TbLotoBoiteIsotherme{$LMars}
				If ($BoiteM=2)
					$Code:="BOI"
					ASAPCreerTbLigneFactureRaemaP ($Code;1)
				End if 
				
				  // Num Bon de commande
				If (<>TbLotoNumBonCommandePoudre{$LMars}#"")
					$NumBonDeCommande:=<>TbLotoNumBonCommandePoudre{$LMars}
				Else 
					$NumBonDeCommande:=""
				End if 
				
			: ($Octobre)
				
				  //FACTURATION de la campagne d'OCTOBRE
				ASAPCreerTbLigneFactureRaemaP ("P1O";$Quantité)
				
				  // FACTURATION DES POUDRES AVEC RAPPORT COFRAC
				If (<>TbLotoNbColisPoudreAR{$LOctobre}>0)  // en  Octobre 
					ASAPCreerTbLigneFactureRaemaP ("PMAR";(<>TbLotoNbColisPoudreAR{$LOctobre}))
				End if 
				
				  // FACTURATION DES POUDRES SANS RAPPORT COFRAC
				If (<>TbLotoNbColisPoudreSR{$LOctobre}>0)  // en  Octobre
					ASAPCreerTbLigneFactureRaemaP ("PMSR";<>TbLotoNbColisPoudreSR{$LOctobre})
				End if 
				
				  // FACTURATION CORRESPONDANCE ENTRE POTS
				If (<>TbLotoCorrespondancePots{$LOctobre})  // en OCTOBRE
					ASAPCreerTbLigneFactureRaemaP ("COR";1)
				End if 
				
				
				  // FACTURATION DES BOITES ISOTHERMES
				$BoiteO:=<>TbLotoBoiteIsotherme{$LOctobre}
				If ($BoiteO=2)
					$Code:="BOI"
					ASAPCreerTbLigneFactureRaemaP ($Code;1)
				End if 
				
				  // Num Bon de commande
				If (<>TbLotoNumBonCommandePoudre{$LOctobre}#"")
					$NumBonDeCommande:=<>TbLotoNumBonCommandePoudre{$LOctobre}
				Else 
					$NumBonDeCommande:=""
				End if 
				
		End case 
		
		$Frais:=OB Get:C1224([Personnes:12]Arguments:7;"PrixTransporteur";Est un numérique:K8:4)
		If ($Frais>0)
			
			APPEND TO ARRAY:C911(TbLFIntitule;"Frais de port")
			APPEND TO ARRAY:C911(TbLFPrixHT;$Frais)
			$TVA:=OB Get:C1224([Personnes:12]Arguments:7;"NonSoumisTVA";Est un texte:K8:3)
			If ($TVA="Faux") & (TbLFCodePrestation{Size of array:C274(TbLFCodePrestation)}#"COT")
				APPEND TO ARRAY:C911(TbLFTauxTVA;<>PermTVA)
			Else 
				APPEND TO ARRAY:C911(TbLFTauxTVA;0)
			End if 
			APPEND TO ARRAY:C911(TbLFQuantité;1)
			APPEND TO ARRAY:C911(TbLFPrixTotalHT;$Frais)
			APPEND TO ARRAY:C911(TbLFCodePrestation;"")
		End if 
		
		  // Gestion des factures antérieures
		READ WRITE:C146([Factures:15])
		  // Obtention du prochain n° de facture
		QUERY:C277([Factures:15];[Factures:15]NumFacture:3=(<>ZPermMille+"/RT@"))  // recherche des [Factures] de Raema P de l'nnée
		SELECTION TO ARRAY:C260([Factures:15]NumFacture:3;$TbNumFacture)
		SORT ARRAY:C229($TbNumFacture;<)
		If (Size of array:C274($TbNumFacture)=0)
			$ProchNumIndexFacture:=1
		Else 
			$ProchNumIndexFacture:=Num:C11(Substring:C12($TbNumFacture{1};5))+1
		End if 
		
		  // Recherche des factures du laboratoire
		QUERY SELECTION:C341([Factures:15];[Factures:15]UUIDPersonne:2=[Personnes:12]UUID:1;*)
		QUERY SELECTION:C341([Factures:15]; & [Factures:15]NumFacture:3#"@D")
		If (Records in selection:C76([Factures:15])=0)  // Pas de facture déjà éditée
			CREATE RECORD:C68([Factures:15])
			[Factures:15]UUIDPersonne:2:=[Personnes:12]UUID:1
			[Factures:15]NumFacture:3:=<>ZPermMille+"/RT"+String:C10($ProchNumIndexFacture;"0000")
		Else 
			READ WRITE:C146([Ventes:16])
			  // rappel des anciennes LF
			QUERY:C277([Ventes:16];[Ventes:16]NumFacture:2=[Factures:15]NumFacture:3)
			  // Suooression des anciennes LF
			DELETE SELECTION:C66([Ventes:16])
		End if 
		
		[Factures:15]DateFacture:4:=Current date:C33
		QUERY:C277([PersonnesAdresses:11];[PersonnesAdresses:11]UUIDPersonne:2=[Personnes:12]UUID:1;*)
		QUERY:C277([PersonnesAdresses:11]; & [PersonnesAdresses:11]TypeAdresse:9="Facturation")
		[Factures:15]AdresseFacturation:5:=ASAPEcritAdresseFacturation 
		[Factures:15]CP:6:=[PersonnesAdresses:11]CodePostal:6
		If ([PersonnesAdresses:11]Pays:8="")
			[Factures:15]PaysFacturation:7:="FRANCE"
		Else 
			[Factures:15]PaysFacturation:7:=[PersonnesAdresses:11]Pays:8
		End if 
		[Factures:15]NumBonCommande:14:=$NumBonDeCommande
		[Factures:15]TotalHT:8:=Sum:C1(TbLFPrixTotalHT)
		$TT:=Size of array:C274(TbLFPrixTotalHT)
		$MontantTVA:=0
		For ($Fumé;1;$TT)
			$MontantTVA:=$MontantTVA+Round:C94((TbLFPrixTotalHT{$Fumé}*(TbLFTauxTVA{$Fumé}/100));2)
			APPEND TO ARRAY:C911(TbLFDateVente;Current date:C33)
			APPEND TO ARRAY:C911(TbLFNumFacture;[Factures:15]NumFacture:3)
		End for 
		[Factures:15]TotalTVA:9:=$MontantTVA
		[Factures:15]TotalTTC:10:=[Factures:15]TotalHT:8+$MontantTVA
		SAVE RECORD:C53([Factures:15])
		ZViderSelectionCourante (->[Ventes:16])
		ARRAY TO SELECTION:C261(TbLFNumFacture;[Ventes:16]NumFacture:2\
			;TbLFDateVente;[Ventes:16]DateVente:4\
			;TbLFIntitule;[Ventes:16]Intitule:3\
			;TbLFCodePrestation;[Ventes:16]CodePrestation:9\
			;TbLFPrixTotalHT;[Ventes:16]PrixTotalHT:7\
			;TbLFPrixHT;[Ventes:16]PrixUHT:5\
			;TbLFQuantité;[Ventes:16]Quantité:6\
			;TbLFTauxTVA;[Ventes:16]TauxTVA:8)
	End if 
	NEXT RECORD:C51([Personnes:12])
End for 
ZAmnistiePartielle (->[Ventes:16])
ZAmnistiePartielle (->[Factures:15])
ALERT:C41("Les factures ont été générées")
  // L'ADILVA = facturation des poudres sup
If (False:C215)
	$FT:=Size of array:C274(<>TbLotoAssociation)
	For ($Salé;1;$FT)
		$Possible:=(<>TbLotoNumCampagne{$Salé}=$numCampagneMars) | (<>TbLotoNumCampagne{$Salé}=$numCampagneOctobre) & (<>TbLotoAssociation{$Salé}="ADILVA")
		If ($Possible & (<>TbLotoNbColisPoudreSR{$Salé}>0))
			CREATE RECORD:C68([Ventes:16])  // la cotis'
			[Ventes:16]NumFacture:2:=[Factures:15]NumFacture:3
			[Ventes:16]Intitule:3:="Frais de port"
			[Ventes:16]PrixUHT:5:=$PrixDuColisSupSansRapport
			$TVA:=OB Get:C1224([Personnes:12]Arguments:7;"NonSoumisTVA";Est un texte:K8:3)
			If ($TVA="Faux")
				[Ventes:16]TauxTVA:8:=<>PermTVA
			End if 
			[Ventes:16]Quantité:6:=1
			[Ventes:16]PrixTotalHT:7:=[Ventes:16]PrixUHT:5*[Ventes:16]Quantité:6
			[Ventes:16]DateVente:4:=Current date:C33
			SAVE RECORD:C53([Ventes:16])
		End if 
	End for 
	
	$Test:=<>ZPermMille+"/RT@"
	QUERY:C277([Factures:15];[Factures:15]NumFacture:3=$Test)
	VarSommeHT:=Sum:C1([Factures:15]TotalHT:8)
	VarSommeTTC:=Sum:C1([Factures:15]TotalTTC:10)
	
End if 
