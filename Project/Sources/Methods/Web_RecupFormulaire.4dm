//%attributes = {"lang":"fr"}
// Peut-on identifier notre adhérent ??

ARRAY TEXT:C222($TbN; 0)
ARRAY TEXT:C222($TbV; 0)
WEB GET VARIABLES:C683($TbN; $TbV)
<>ZCR:=Char:C90(13)
// le tableau des $TbN  prend comme valeurs
// $TbN{1}=" NumAdh"
// $TbN{2}=" Nom"
// $TbN{3}=" Prénom"
// $TbN{4}=" Rue"
// $TbN{5}=" CP"
// $TbN{6}=" Ville"
// $TbN{7}=" adresse d'email"
// $TbN{8}=" MdP1"
// $TbN{9}=" MdP2"
//test de remplissage complet
$Retour:="Revenez au formulaire par la touche Page précédente"
If (($TbV{1}="") | ($TbV{2}="") | ($TbV{4}="") | ($TbV{3}="") | ($TbV{5}="") | ($TbV{6}="") | ($TbV{7}="") | ($TbV{8}="") | ($TbV{9}=""))
	WEB SEND FILE:C619("renseigneb.html")
Else   // il a bien rempli
	$Personne:=$TbV{3}+" "+$TbV{2}
	MotifErreur1:=""
	MotifErreur2:=""
	MotifErreur3:=""
	$TVB:=True:C214
	Case of 
			
		: ($TbV{8}#$TbV{9})
			MotifErreur1:="Le mot de passe n'est pas identique..."+<>ZCR
			RapAffichePb("Problème de mot de passe"; "IDENTIFICATION"; MotifErreur1; MotifErreur2; MotifErreur3)
			$TVB:=False:C215
			
		: (Position:C15("@"; $TbV{7})=0)
			MotifErreur1:="L'adresse mail n'est pas correcte..."+<>ZCR
			RapAffichePb("Problème d'adresse mail"; "IDENTIFICATION"; MotifErreur1; MotifErreur2; MotifErreur3)
			$TVB:=False:C215
			
	End case 
	If ($TVB)
		// cela semble correct a priori
		//CHERCHER([Adherents];[Adherents]NumAdherent=$TbV{1})
		//Si (Enregistrements trouves([Adhérents])=0)
		//ALERTE($Personne+", Je ne peux vous identifier... Envoyez un mail à l'association "+"pour obtenir votre n° d'adhérent"+Caractere(13)+$Retour)
		//Sinon 
		If ($TbV{1}#"")  // il a son n°d'adhérent     
			//$ReformateNumAdh:=Num($TbV{1})
			READ WRITE:C146([Personnes:12])
			$L:=Find in array:C230(<>TbPerNumPersonne; Num:C11($TbV{1}))
			QUERY:C277([Personnes:12]; [Personnes:12]UUID:1=<>TBPERUUID{$L})
			//$Dep:=Sous chaîne($TbV{5};1;2)  // le département est le bon
			$Destinaitaire:=OB Get:C1224([Personnes:12]Arguments:7; "EMail")
			If ($Destinaitaire=$TbV{7})
				//[Adherents]EMail:=$TbV{7}
				//[Adherents]MotDePasseInternet:=$TbV{8}
				OB SET:C1220([Personnes:12]Arguments:7; "MotDePasse"; $TbV{8})
				//[Adherents]Nouveaute:=Vrai
				SAVE RECORD:C53([Personnes:12])
				Adherent:=[Personnes:12]NomLong:2
				Aujourdhui:=Current date:C33
				//WEB ENVOYER FICHIER("verifok.html")
				WebAffichePageAdherent
				// testons d'emblée l'adresse mail
				$Mess:="Bonjour,"+<>ZCR2+"Nous vous confirmons la modification de votre mot de passe adhérent"+<>ZCR+"Votre login est "+$TbV{1}+"."
				$Mess:=$Mess+<>ZCR+"Votre mot de passe est "+$TbV{8}+"."+<>ZCR+"En vous souhaitant une bonne reception."+<>ZCR+<>ZCR
				$Mess:=$Mess+"L'équipe de l'ASA"
				//CHERCHER([ZZ_ExVariables];[ZZ_ExVariables]ExTitre="ET")
				//DestinataireCci:=[ZZ_ExVariables]ExTexte2
				//EnvoiMailSimple([Adherents]EMail;"Confirmation d'inscription au site de l'ASA";Mess)
				
				$email:=New object:C1471
				$transporter:=ASAPCreationtransporter
				$email.from:="asa-spv@wanadoo.fr"
				$email.subject:="Confirmation modification mot de passe de l'espace adhérent ASA"
				$email.to:=$Destinaitaire+",riouall.eloise@orange.fr,asa-spv@wanadoo.fr"
				// $email.to:="riouall.eloise@orange.fr
				$email.textBody:=$Mess
				$status:=$transporter.send($email)  // Envoi du message
				MailOK:=($status.success)
			Else 
				MotifErreur1:=$Personne+", je ne peux vous identifier..."
				MotifErreur2:="Envoyez un mail à l'association pour obtenir votre n° d'adhérent"
				RapAffichePb("Impossibilité d'identification"; "IDENTIFICATION"; MotifErreur1; MotifErreur2; MotifErreur3)
			End if 
			ZAmnistiePartielle(->[Personnes:12]; True:C214)
		End if 
	End if 
End if 
