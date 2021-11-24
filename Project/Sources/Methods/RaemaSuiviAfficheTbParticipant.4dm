//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 15/08/18, 06:31:18
// ----------------------------------------------------
// Paramètres
// ----------------------------------------------------
// Méthode : RaemaSuiviAfficheTbParticipant <= MF "DlgSuiviReponse" sur Chargement 
//                                          <= MO de VarNumRAEMA de "DlgSuiviReponse"
// Description
// Remplit le tableau TbParticipantN
// avec la selection des [CampagneParticipation]
// de la campagne VarNumRAEMA
// ----------------------------------------------------

C_LONGINT:C283($Salé; $FT)

QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=VarNumRaema; *)
QUERY:C277([CampagneParticipations:17];  & [CampagneParticipations:17]UUIDPersonne:2#"EDD19B5976314840955572123A9B1B69"; *)
QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "Sauvage"; =; Null:C1517)
SELECTION TO ARRAY:C260([CampagneParticipations:17]Arguments:5; $TbArgument\
; [CampagneParticipations:17]TexteParticipation:4; $TbTexteParticipation\
; [CampagneParticipations:17]UUID:1; $TbUUIDParticipation\
; [CampagneParticipations:17]UUIDPersonne:2; $TbUUIDPersonne)
LONGINT ARRAY FROM SELECTION:C647([CampagneParticipations:17]; $TbNumEnr)
ARRAY TEXT:C222(TbCasParticuliersA; 0)
ARRAY LONGINT:C221(TbCasParticuliersN; 0)
ARRAY LONGINT:C221(TbNumEnrParticuliers; 0)
ARRAY BOOLEAN:C223(TbLignesCachées; 0)

ARRAY TEXT:C222(TbEnvoyé; 0)
ARRAY TEXT:C222(TbEnCours; 0)
ARRAY TEXT:C222(TbAbsent; 0)
$FT:=Size of array:C274($TbUUIDParticipation)
ARRAY BOOLEAN:C223(TbLignesCachées; $FT)
For ($Salé; 1; $FT)
	$NumLaboA:=ASAPTrouveNumeroLaboParUUID($TbUUIDPersonne{$Salé})
	$NumLaboN:=Num:C11($NumLaboA)
	// Cas particuliers
	If (OB Is defined:C1231($TbArgument{$Salé}; "IndiceCasParticulier"))
		APPEND TO ARRAY:C911(TbCasParticuliersA; $NumLaboA)
		APPEND TO ARRAY:C911(TbCasParticuliersN; $NumLaboN)
		APPEND TO ARRAY:C911(TbNumEnrParticuliers; $TbNumEnr{$Salé})
	End if 
	
	Case of 
		: ($TbArgument{$Salé}.RéponseEnvoyée)
			APPEND TO ARRAY:C911(TbEnvoyé; $TbUUIDParticipation{$Salé})
			
		: ($TbTexteParticipation{$Salé}="")
			APPEND TO ARRAY:C911(TbAbsent; $TbUUIDParticipation{$Salé})
			
		Else 
			APPEND TO ARRAY:C911(TbEnCours; $TbUUIDParticipation{$Salé})
			
	End case 
End for 

//Si (Faux)
//  // Cas particuliers
//CHERCHER PAR ATTRIBUT DANS SÉLECTION([CampagneParticipations]; & ;[CampagneParticipations]Arguments;"IndiceCasParticulier";>;0)
//SÉLECTION VERS TABLEAU([CampagneParticipations]UUIDPersonne;$TbUUIDPersonne;[CampagneParticipations]Arguments;$TbArgument)
//$FT:=Taille tableau($TbUUIDPersonne)
//TABLEAU TEXTE(TbCasParticuliersA;$FT)
//TABLEAU ENTIER LONG(TbCasParticuliersN;$FT)
//TABLEAU ENTIER LONG SUR SÉLECTION([CampagneParticipations];TbNumEnrParticuliers)
//Boucle ($Salé;1;$FT)
//TbCasParticuliersA{$Salé}:=ASAPTrouveNumeroLaboParUUID ($TbUUIDPersonne{$Salé})
//TbCasParticuliersN{$Salé}:=Num(TbCasParticuliersA{$Salé})
//$RL:=OB Lire($TbArgument{$Salé};"CodeRaemaLié";Est un texte)
//Si ($RL#"")
//$RL:=Sous chaîne($RL;1;10)
//TbCasParticuliersA{$Salé}:=TbCasParticuliersA{$Salé}+" - "+Chaîne(RAEMADemoduleMdPWeb ($RL))
//Fin de si 
//Fin de boucle 
//TABLEAU MULTI TRI(TbCasParticuliersN;>;TbCasParticuliersA;>;TbNumEnrParticuliers)

//  // les laboratoires ayant répondus
//  //UTILISER ENSEMBLE("concernées")
//  //CHERCHER DANS SÉLECTION([CampagneParticipations];[CampagneParticipations]TexteParticipation="@saisie des analyses@")
//  // CHERCHER DANS SÉLECTION([CampagneParticipation];[CampagneParticipation]ReponseLaboEnvoiOK=Vrai)
//NOMMER ENSEMBLE([CampagneParticipations];"envoyé")

//  // les laboratoires n'ayant pas accédé au 2e écrans
//UTILISER ENSEMBLE("concernées")
//CHERCHER DANS SÉLECTION([CampagneParticipations];[CampagneParticipations]TexteParticipation#"@deuxième ecran@")
//NOMMER ENSEMBLE([CampagneParticipations];"absence")

//  // Les labos ayant passé le 2e écran
//RÉUNION("envoyé";"absence";"extrème")
//DIFFÉRENCE("concernées";"extrème";"encours")
//UTILISER ENSEMBLE("concernées")
//Fin de si 
ARRAY LONGINT:C221(TbParticipantN; 0)  // Le tableau de visualisation des laboratoires
RaemaSuiviAfficheTbChoix
RaemaSuiviAfficheCadrans
RaemaSuiviGraphe

OBJECT SET VISIBLE:C603(ListBoxBilan; False:C215)
OBJECT SET VISIBLE:C603(ListBoxBilan1; False:C215)
OBJECT SET VISIBLE:C603(ListBoxZ; False:C215)
OBJECT SET VISIBLE:C603(BouExport; False:C215)
OBJECT SET VISIBLE:C603(ListBoxP2; False:C215)
OBJECT SET VISIBLE:C603(BouMail; (VarNumRaema=<>NumCampagneEnCoursSaisie))
OBJECT SET VISIBLE:C603(VarDateJour; (VarNumRaema=<>NumCampagneEnCoursSaisie))

//$test:="raema n°"+VarNumRaema
//CHERCHER([XData];[XData]XType="rae";*)
//CHERCHER([XData]; & [XData]XNom=$test)
// CHERCHER([RAEMACampagnes];[RAEMACampagnes]NumCampagne=VarNumRaema)

$L:=Find in array:C230(<>TbCampagnesNumCampagne; VarNumRaema)
$DélaiN:=<>TbCampagnesDateLimiteReponse{$L}-Current date:C33
DelaiReponseA:=String:C10($DélaiN)
VarDateJour:="Nous sommes le "+String:C10(Current date:C33; Système date long:K1:3)
Case of 
	: ($DélaiN=0)
		VarDateJour:="C'est AUJOURD'HUI la date limite"
		
	: ($DélaiN>0)  // Il reste encore du temps 
		$s:=Num:C11(Abs:C99($DélaiN)>1)*"s"
		VarDateJour:=VarDateJour+", il reste "+DelaiReponseA+" jour"+$s
		VarDateJour:=VarDateJour+" avant la date limite de réponse"
		
	Else   // La date limite est dépassée
		$s:=Num:C11($DélaiN<-1)*"s"
		VarDateJour:=VarDateJour+", la date limite de réponse est dépassée de "+String:C10(-$DélaiN)+" jour"+$s
		
End case 


// Remise à zéro des valeurs
VarHistorique:=""
LISTBOX SELECT ROW:C912(ListBoxParticipant; 0; lk supprimer de sélection:K53:3)
VarComSaisie:=""
LISTBOX SELECT ROW:C912(ListBoxCS; 0; lk supprimer de sélection:K53:3)

// Remplir la ListBoxCS des labos ayant ajouté un commentaire lors de la saisie des résultats
// type =  "ComCampR"+NumLaboActuelA+"_"+NumRaemaCourant
//$test:="ComCampR@_"+VarNumRaema
//$Labo13:="ComCampR13_"+VarNumRaema
//CHERCHER([XData];[XData]XType=$test;*)
//CHERCHER([XData]; & [XData]XType#$Labo13)
ARRAY LONGINT:C221(TbComSaisie; 0)
ARRAY LONGINT:C221(TbNumEnrComSaisie; 0)
ARRAY TEXT:C222(TbComCorps; 0)
QUERY:C277([WebConnexions:13]; [WebConnexions:13]Campagne:5=VarNumRaema; *)
QUERY:C277([WebConnexions:13];  & [WebConnexions:13]Commentaire:14#"")
If (Records in selection:C76([WebConnexions:13])>0)
	SELECTION TO ARRAY:C260([WebConnexions:13]CodeConnexion:4; $TbCodePersonne; [WebConnexions:13]Commentaire:14; $TbCom; [WebConnexions:13]NumEnvoi:9; $TbNumEnvoi)
	LONGINT ARRAY FROM SELECTION:C647([WebConnexions:13]; TbNumEnrConnexionCom)
	$FT:=Size of array:C274($TbCodePersonne)
	For ($Salé; 1; $FT)
		$CodeCourant:=$TbCodePersonne{$Salé}
		
		If ($TbCodePersonne{$Salé-1}#$CodeCourant)  // On a changé de laboratoire
			$L:=Find in array:C230(<>TBPERIDENTIFICATEUR; $CodeCourant)
			If ($L>0)
				$NumLaboN:=<>TbPerNumLaboRAEMA{$L}
				APPEND TO ARRAY:C911(TbComSaisie; $NumLaboN)
				APPEND TO ARRAY:C911(TbComCorps; $TbCom{$Salé})
				APPEND TO ARRAY:C911(TbNumEnrComSaisie; TbNumEnrConnexionCom{$Salé})
			End if 
		End if 
	End for 
	SORT ARRAY:C229(TbComSaisie; TbComCorps; TbNumEnrComSaisie; >)
End if 
// SÉLECTION VERS TABLEAU([XData]XEntier;TbComSaisie;[XData]XTexteSup;TbComCorps)


