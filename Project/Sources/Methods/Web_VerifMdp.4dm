//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 02/09/20, 08:12:08
  // ----------------------------------------------------
  // Méthode : Web_VerifMdp
  // Description
  // Méthode qui vérifie le mot de passe 
  //   dans l'espace adhérent
  // ----------------------------------------------------
C_BOOLEAN:C305($OnContinue)
ARRAY TEXT:C222($tnoms;0)
ARRAY TEXT:C222($tvaleurs;0)
C_TEXT:C284(Adherent)
C_DATE:C307(Aujourdhui)
  // Récupération dans des tableaux des noms de variables et des valeurs
WEB GET VARIABLES:C683($tnoms;$tvaleurs)

  //Par défaut, on n'a pas le droit d'aller plus loin
$OnContinue:=False:C215
$OnExiste:=False:C215
  //Ce n’est pas un utilisateur défini dans 4D, 
  // chercher dans la table des [Personnes]
$L:=Find in array:C230(<>TbPerNumPersonneA;$tvaleurs{1})
$UUID:=<>TbPerUUID{$L}
QUERY:C277([Personnes:12];[Personnes:12]UUID:1=$UUID)
$MdP:=""
$MdP:=[Personnes:12]Arguments:7.MotDePasse
If ($MdP="")
	$MdP:=""
End if 
$OnExiste:=(Records in selection:C76([Personnes:12])=1)
$OnContinue:=($tvaleurs{2}=$MdP)
If ([Personnes:12]Caduc:8=True:C214)
	$OnContinue:=False:C215
End if 

Case of 
	: ($OnContinue)
		If ($MdP="")  //il ne s'est jamais connecté
			WEB SEND FILE:C619("renseigne.html")
		Else 
			Adherent:=[Personnes:12]NomLong:2
			Aujourdhui:=Current date:C33
			WebAffichePageAdherent 
		End if 
		
	: ($OnExiste) & ($tvaleurs{2}="") & ([Personnes:12]Caduc:8=False:C215)  //il veut changer son MdP
		WEB SEND FILE:C619("renseigne.html")
		
	Else   // Qui c'est ce mec qui ignore son n° d'adhérent
		WEB SEND FILE:C619("verifko.html")
End case 
