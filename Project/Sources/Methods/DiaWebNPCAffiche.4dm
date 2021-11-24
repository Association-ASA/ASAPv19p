//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 09/06/16, 07:44:01
// ----------------------------------------------------
// Méthode : WebNPCAffiche <- Sur connexion Web
// Description
// Permet de modifier la page Web en fonction du menu local des photographies
//
// Paramètre : $1 = n° de la diapo de référence en alpha
// ----------------------------------------------------

$NumDiaN:=Num:C11($1)
QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1=$NumDiaN)
//CHERCHER([XDonnées];[XDonnées]XType="NPC";*)
//CHERCHER([XDonnées];[XDonnées]XNom=Chaîne([Diapositives]NumOrdreDiapos))
//$NumEnrXDonnéesNPC:=Numéro enregistrement([XDonnées])
$Envoi:=Replace string:C233(DiaWebNPCAfficheDiapoRef; ";"; ",")+";"+DiaWebNPCRecruteDiaposNPC+"£"+DiaWebNPCGereDiapoCoche($NumDiaN)
WEB SEND TEXT:C677($Envoi)
ZAmnistieInternationale
// FIXER TEXTE DANS CONTENEUR($Envoi)