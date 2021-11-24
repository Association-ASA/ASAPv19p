//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 12/07/20, 15:19:08
  // ----------------------------------------------------
  // Méthode : DiaSurConnexionWeb
  // Description
  // Méthose de base appelée Sur ConnexionWeb d'AsaDia
  //
  // Paramètre: $1 = message AJAX
  // ----------------------------------------------------

$Mess:=$1

Case of 
	: ($Mess="PageGibier@")  // appel de la page gibier
		VarLogin:=Substring:C12($Mess;11)
		DiaWebEcritPageDiagnose ("FG";True:C214)
		
	: ($Mess="PageVache@")  // appel de la page gibier
		VarLogin:=Substring:C12($Mess;10)
		DiaWebEcritPageDiagnose ("F";True:C214)
		
		
		
		  // AJAX
		
		  // CHANGEMENT DE PAGE
	: ($Mess="ajaxpage@")  // Gestion des pages du sites
		  //TRACE
		DiaWebAffichePageAsaDia ($Mess)
		
		
	: ($Mess="ajaxtexte@")  // Gestion des textes d'anapath spéciale
		DiaWebAffichePageTexte ($Mess)
		
		
		  // FAQ
	: ($Mess="faqreception@")  // Gestion des retours d'info
		DiaWebEnvoiFaq ($Mess)
		
		
		  // DIAGNOSTIC
		
	: ($Mess="nomenclature@")  // Gestion des deux types de nomenclature
		DiaWebAfficheListeLesions ($Mess)
		
		
	: ($Mess="affichephotosparnum@")  // Affichage des photos suite au choix du numéro
		DiaWebAffichePhotosParNum ($Mess)
		
	: ($Mess="diaflipflo@")  // Affichage des photos suite au choix de critères 
		DiaWebAfficheListePhotos ($Mess)
		
	: ($Mess="filelesphotos@")  // Affichage des photos désignées
		DiaWebAfficheListePhotos ($Mess)
		
	: ($Mess="testimage@")  // Affichage de l'image dans les textes
		DiaWebAfficheImage ($Mess)
		
	: ($Mess="@lp@")  // affichage des éléments de description dans liste de photos
		DiaWebAfficheListeImage ($Mess)
		
		
	: ($Mess="@afficheengrand@")  // Réaction au clic d'agrandissement : IMAGES EN GRAND
		DiaWebAfficheImageEnGrand ($Mess)
		
		
	: ($Mess="metlesfleches@")  // Place les flèches
		DiaWebAfficheFleche ($Mess)
		
	: ($Mess="@metlesinfos@")  // Place les commentaires dans une image en grand
		DiaWebAfficheInfos ($Mess)
		
		
		  // LISTE DES LESIONS ET DES MOTIFS DE SAISIE
		
	: ($Mess="aboulelistelesion")  // appel de la liste des lésions en français
		DiaWebAbouleListeLesion ("F";True:C214)
		
	: ($Mess="detaillesion@")  // appel du HTML du détail d'une lésion en face de sa ligne
		DiaWebAbouleDetailLesion ($Mess)
		
	: ($Mess="motifdetail@")  // appel du HTML du détail d'un motif de saisie en face de sa ligne
		DiaWebAbouleDetailMotif ($Mess)
		
	: ($Mess="motifcherche@")  // appel du HTML du détail d'un motif de saisie
		DiaWebChercheMotif ($Mess)
		
	: ($Mess="cherche@")  // appel du HTML la liste des lésions réduites // anciennement en français
		DiaWebChercheLesion ($Mess)
		
		  //: ($Mess="search@")  // appel du HTML la liste des lésions réduites en anglais  // traitée dans la ligne précédente
		  //WebChercheLesionA ($Mess)
		
	: ($Mess="champliste@")  // liste après champ de recherche
		DiaWebAfficheListeLesioncourte ($Mess)
		
	: ($Mess="predictif@")  // liste après champ de recherche
		DiaWebAfficheProposeLesions ($Mess)
		
		
		
		  // LISTE DES PHOTOGRAPHIES
		
	: ($Mess="diadetail@")  // appel du HTML du détail d'une diapo
		DiaWebAbouleDetailDiapo ($Mess)
		
	: ($Mess="trouvephoto@")  // appel du HTML la liste des diapos réduites toutes langues // anciennement en français
		DiaWebChercheDiapo ($Mess)
		
	: ($Mess="find@")  // appel du HTML la liste des diapos réduites en anglais
		DiaWebChercheDiapoA ($Mess)
		
		
		  // GESTION DES ORGANES SAINS
		
	: ($Mess="anatomie@")  // appel du HTML de l'organe sain
		DiaWebAbouleModifOrganeSain ($Mess)
		
	: ($Mess="imageengrandanat@")  // appel du HTML de l'organe sain
		DiaWebAfficheEnGrandOrganeSain ($Mess)
		
		
		  // GESTION DES PANIERS
		
		  // GESTION DES PANIERS : Descriptif
	: ($Mess="paniervoir@")  // appel du HTML du descriptif d'un panier
		DiaWebAbouleModifPanier ($Mess)
		
	: ($Mess="paniermodif@")  // Modification du descriptif du panier
		DiaWebPanierModifieLeDescriptif ($Mess)
		
	: ($Mess="paniertuer@")  // Suppression du panier
		DiaWebPanierModifieLeDescriptif ($Mess;True:C214)
		
		  // GESTION DES PANIERS : Contenu (images) d'un panier
	: ($Mess="panierdetail@")  // appel du HTML du contenu (images) d'un panier
		DiaWebAbouleDetailPanier ($Mess)
		
	: ($Mess="photopanier@")  // appel du HTML de l'ordre d'un panier
		DiaWebPanierModifieTri ($Mess)
		
		
		  // GESTION DES PANIERS :  Partage
		
	: ($Mess="alertesuppanier@")  // Affichage du HTML d'envoi d'un panier
		DiaWebPanierEnvoiAlerte ($Mess)
		
	: ($Mess="panierenvoyer@")  // Affichage du HTML d'envoi d'un panier
		DiaWebPanierEnvoiAffiche ($Mess)
		
	: ($Mess="panierpartage@")  // récupère et traite le message AJAX d'envoi d'un panier
		DiaWebPanierEnvoiPartage ($Mess)
		
		
		  // GESTION DES PANIERS : Ajout d'une photo à un panier
	: ($Mess="panier@")  // suite à l'envoi de la demande d'ajout d'une diapo dans un panier  
		DiaWebPanierAjouteDia ($Mess)
		
	: ($Mess="pumpanier@")  // suite à l'envoi de la demande d'un nom de panier dans le PUM 
		DiaWebPanierPUMListePaniers ($Mess)
		
	: ($Mess="@auteurspumpanier@")  // suite à l'envoi du choix d'un auteur de panier  
		DiaWebPanierPUMAuteurs ($Mess)
		
		  // GESTION DES PANIERS : Diaporama
	: ($Mess="@lancepanier@")  // suite à la demande d'envoi du panier dans le diaporama 
		DiaWebPanierDiaporama ($Mess)
		
	: ($Mess="diaporamapanier@")  // suite à la demande de la diapo suivante ou précedente dans un panier  // IMAGES EN GRAND
		DiaWebPanierDiaporama ($Mess;True:C214)
		
	: ($Mess="@boutonsdiaporama@")  // appel du HTML des boutons d'explication en pleine page // IMAGES EN GRAND
		DiaWebPanierAfficheBoutons ($Mess)
		
		
		  // NPC AsaDia
	: ($Mess="donneNPC@")  // Permet d'afficher la page Web de comparaison des NPC
		DiaWebNPCAffiche ($Mess)
		
	: ($Mess="refnpc@")  // Appel AJAX bouton pour voir la page NPC  dans AsaDia général
		DiaWebEcritPageNPC ($Mess)
		
	: ($Mess="tnpcdeuxles@")  // Appel Ajax pour afficher le texte de comparaison de deux lésions dans AsaDia experts (NPC)
		DiaWebNPCAfficheDeuxLesions ($Mess)
		
	: ($Mess="npcclic@")  // Appel Ajax pour modifier la photo NPC dans AsaDia général (NPC)
		DiaWebModifiePageNPC ($Mess)
		
		  // NPC Experts
		
		  //: ($Mess="ccorganesp@")  // gestion sur clic de filtrage des organes espèces  dans AsaDia experts (NPC)
		  //WebNPCModifieSelection ($Mess)
		
		
		  //: ($Mess="donnetitle@")  // Appel Ajax pour afficher le title dans le champ de comparaison dans AsaDia experts (NPC)
		  //WebNPCDonneLeTitle ($Mess)
		
		
		  // QUIZ
		  // Quiz Experts
	: ($Mess="creationquiz@")  // Appel Ajax pour afficher la page de départ de la création des questionnaires d'une institution
		QuizzEcritPageDepart ($Mess)
		
	: ($Mess="quizzpum@")  // Appel Ajax pour attribuer une espèce ou une lésion à l'image sup
		QuizzPUMP1Actualise ($Mess)
		
	: ($Mess="lipum@")  // Appel Ajax pour filtrer la liste des images sup
		QuizzLPUMP1Cache ($Mess)
		
	: ($Mess="supphotosup@")  // Appel Ajax pour rendre caduque l'image sup
		QuizzSupPhotoSup ($Mess)
		
	: ($Mess="changeobjectif@")  // Appel Ajax pour changer les valeurs des thèmes d'évaluation
		QuizzModifieListeObjectif ($Mess)
		
	: ($Mess="ImpQuest@")  // Appel Ajax pour imprimer le questionnaire courant
		QuizzImprimeQuestionnaire ($Mess)
		
	: ($Mess="Sauvegarde@")  // Appel Ajax pour sauvegarder le questionnaire courant
		QuizzSauveQuestionnaire ($Mess)
		
	: ($Mess="histoire@")  // Appel Ajax pour afficher les sauvegardes disponibles pour le questionnaire
		QuizzSauvegardesAffiche ($Mess)
		
	: ($Mess="bouhistoire@")  // Appel Ajax pour restituer les sauvegardes disponibles pour le questionnaire
		QuizzUtiliseSauvegarde ($Mess)
		
	: ($Mess="cbtheme@")  // Appel Ajax pour changer la valeur d'une case à cocher des thèmes d'évaluation d'une réponse
		QuizzModifieCaseObjectif ($Mess)
		
	: ($Mess="changechampquizz@")  // Appel Ajax pour changer les valeurs des champs d'un quizz
		QuizzStockeChangement ($Mess)
		
	: ($Mess="modifiechemindefer@")  // Appel Ajax pour modifier le chemin de fer suite à un clic sur un bouton
		QuizzModifieCdF ($Mess)
		
	: ($Mess="modaliteevaluation@")  // Réaction au clic sur le PUM de la modalité réponse unique ou multiple avec ou sans retour possible
		QuizzChoixModalite ($Mess)
		
	: ($Mess="montrequestionnaire@")  // Appel Ajax pour voir le questionnaire à partir de l'espace de création
		QuizzMontrerQuestionnaire ($Mess)
		
	: ($Mess="photossup@")  // Appel Ajax pour gérer les questions d'explications des réponses
		QuizzGerePhotosSup ($Mess)
		
	: ($Mess="comsup@")  // Appel Ajax pour gérer les questions d'explications des réponses
		QuizzChangeComPhotosSup ($Mess)
		
		
		
		
		
		  // Quiz visiteur ou expert
	: ($Mess="quizzaffichepleinecran@")  // Réaction au clic d'agrandissement : IMAGES EN GRAND dans le quizz
		QuizzAfficheImageEnGrand ($Mess)
		
		
		  // Quiz visiteur
		
	: ($Mess="quizzlancer@")  // Appel Ajax pour lancer le quizz depuis AdaDia
		QuizzLancer ($Mess)
		
	: ($Mess="repquizz@")  // Réaction au clic sur une réponse dans le quizz
		QuizzSuiteChoixReponse ($Mess)
		
	: ($Mess="retourquizz@")  // Réaction au clic sur un bouton précédent dans le quizz
		QuizzSuiteChoixRetour ($Mess)
		
		
	: ($Mess="suitequizz@")  // Réaction au clic sur un bouton suivant dans le quizz
		QuizzSuiteChoixSuite ($Mess)
		
		
	: ($Mess="multiplelancequizz@")
		QuizzSuiteChoixMultipleSuite ($Mess)
		
		
	: ($Mess="voirquestion@")
		QuizzRevoirQuestion ($Mess)
		
		  //Sinon 
		  //DiaWebEcritPageDepartFr 
End case 