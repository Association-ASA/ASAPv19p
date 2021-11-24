//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : ASA
  // Date et heure : 26/05/13, 07:01:47
  // ----------------------------------------------------
  // Méthode : WebIdentificationG
  // Description
  // Méthode declenchée lors de la tentative de login
  // pour l'accès à AsaDia 3 Web
  // Paramètre : {$1} si Langue différente du français
  // ----------------------------------------------------

VarLogin:="cegeheme@wanadoo.fr"
DiaWebEcritPageDiagnose ("FG";True:C214)  // affichage de la page HTML complète, entièrement écrite par 4D
CREATE RECORD:C68([DiaData:45])  // XDonnees de connexion
[DiaData:45]XNom:1:=VarLogin
[DiaData:45]XType:5:="Wad3"
[DiaData:45]XDate:3:=Current date:C33
[DiaData:45]XHeure:13:=Current time:C178
[DiaData:45]XTexte:7:=NavigateurLabo
SAVE RECORD:C53([DiaData:45])
ZAmnistieInternationale 