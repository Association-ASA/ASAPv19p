
// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 28/01/19, 08:13:01
// ----------------------------------------------------
// Paramètres
// ----------------------------------------------------
// Méthode : LBTableauxParticipation
// Description
// 

C_BOOLEAN:C305(vl_b_print; tri)
C_LONGINT:C283($C; $L)

Case of 
	: (Form event code:C388=Sur chargement:K2:1)
		ZLBMFListes
		//$Sep:=Séparateur dossier
		//tri:=Vrai
		//ENSEMBLE VIDE(ZPtTable->;"$ZFichesSurlignees")
		//ZFenetreActualiseTitre 
		//ZLBAfficheListe 
		//$PtLogo:=OBJET Lire pointeur(Objet nommé;"VarLogoTable")
		//LIRE FICHIER IMAGE(VarCDLogo;$PtLogo->)
		//OBJET FIXER VISIBLE(*;"imp@";ZImprime)
		//OBJET FIXER VISIBLE(*;"sup@";ZSupprime)
		//OBJET FIXER VISIBLE(*;"ens@";ZGereEnsemble)
		//OBJET FIXER VISIBLE(*;"lapin@";(Taille tableau(TbMethodeLapin)>0))
		<>PUMAnRaemaPoudre:=0
		QUERY:C277([CampagneParticipations:17]; [CampagneParticipations:17]NumCampagne:3=PUMNumCampagneSuivi{PUMNumCampagneSuivi}; *)
		QUERY:C277([CampagneParticipations:17];  & [CampagneParticipations:17]UUIDPersonne:2#"EDD19B5976314840955572123A9B1B69"; *)
		QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "Sauvage"; =; Null:C1517)
		ASAPParFabriqueTbEnvoiColis
		OBJECT SET VISIBLE:C603(TbNumCampagne; False:C215)
End case 
