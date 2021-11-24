//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : MBPASA2015
// Date et heure : 16/07/20, 11:26:50
// ----------------------------------------------------
// Méthode : ASAPSurConnexionWeb
// Description
// 
//
// Paramètres
// ----------------------------------------------------
WEB SET ROOT FOLDER:C634("pages_Web")
$Mess:=$1
NumCampagneEnCoursInfoOK:=<>NumCampagneEnCoursInfoOK

Case of 
		
	: ($Mess="raemadate")  // Demande de la date de début de campagne
		$L:=Find in array:C230(<>TbCampagnesNumCampagne; <>NumCampagneEnCoursSaisie)
		$Envoi:=String:C10(<>TbCampagnesDateEnvoiColis{$L})
		WEB SEND TEXT:C677($Envoi)
		
	: ($Mess="FileLeTbDeDilution@")  // contrôle de la dilution
		ResControleDil($Mess)
		
	: ($Mess="ControleEch@")  // contrôle de l'existence des numéros échantillons
		ResControleEch($Mess)
		
	: ($Mess="ControleSer@")  // contrôle de la compatibilité des séries des numéros échantillons
		ResControleSer($Mess)
		
	: ($Mess="flipflop@")  // traitement de l'apparition / disparition des champs
		// ainsi que (CdC R63) de l'affectation des milieux et fabricants f(méthode) 
		ResFlipFlop($Mess)
		
	: ($Mess="WebDevisRecevoir@")
		$UUID:=Substring:C12($Mess; 17)
		$Res:=0
		EXECUTE METHOD:C1007("WebDevisRecevoir"; $Res; $UUID)
		
	: ($Mess="EC_@")  //  Appel de l'espace client
		WebAppelEspaceClient($Mess)
		
	: ($Mess="RaemaInfP1@")
		$UUID:=Substring:C12($Mess; 12)
		$Langue:=Substring:C12($Mess; 11; 1)
		$Res:=0
		EXECUTE METHOD:C1007("RaemaInfP1"; $Res; $UUID; $Langue)
		
	: ($Mess="DevisGel@")
		$UUID:=Substring:C12($Mess; 9)
		WebDevisEcritPage($UUID)
		
	: ($Mess="espaceclient@")  //  Appel de l'espace client
		$Langue:=$Mess[[13]]
		$UUID:=Substring:C12($Mess; 14)
		WEB SEND TEXT:C677(WebEcritHTMLEspaceClient($UUID; $Langue))
		
	: ($Mess="DonneesPersonnelles@")  //  Appel des données personnels dans l'espace client
		$Langue:=$Mess[[20]]
		$LigneTbGnx:=Substring:C12($Mess; 53)
		$UUID:=Substring:C12($Mess; 21)
		WebDonneesPersonnellesClient($Mess; $Langue; $UUID; $LigneTbGnx)
		
	: ($Mess="téléchargement@")  //  Appel de l'EC depuis le tableau de droite
		WebTelechargeEspaceClientASAP($Mess)
		
		
	: ($Mess="PGtéléchargements@")  //  Appel de l'EC depuis la partie gauche
		WebProposeLesDocDispo($Mess)
		
	: ($Mess="RapP2MF@")
		TypeDemande:=Substring:C12($Mess; 8)
		EXECUTE METHOD:C1007("RapP2MF")
		
	: ($Mess="RechercheLesTheses")
		// WebTrouveLesThèses
		
	: ($Mess="ACo@")
		WebAsaContact($Mess)
		
	: ($Mess="EnregistreAsa")
		// AsaDia2WebEnregistre
		
		
	: ($Mess="@VerifAdherent@")
		Web_VerifMdp
		
	: ($Mess="@Formulaire@")
		Web_RecupFormulaire
		
	: ($Mess="@ConfirmerMdP@")
		Web_ConfirmeMdp
		
	: ($Mess="MettreIciLa chaineAJAX")
		ResAjaxDate
		
	: ($Mess="pdf/Rapports/@")  // Téléchargement sur page complète
		RapAjax($Mess)
		
	: ($Mess="breve@")
		//  WebVisuBreve($Mess)
		
	: ($Mess="rep@")  // Réponse du quizz
		//  WebReponseQuizz($Mess)
		
	: ($Mess="devisid@")  // Devis identification
		WebDevisIdentification($Mess)
		
	: ($Mess="calculedevis@")  //  calcul du devis
		WebDevisCalcul($Mess)
		
	: (NavigateurLabo="put / http@")
		WEB SEND TEXT:C677("présent")
End case 