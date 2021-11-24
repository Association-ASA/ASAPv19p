//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 08/04/19, 06:59:03
  // ----------------------------------------------------
  // Méthode : WebPanierEnvoiAlerte
  // Description
  //  Méthode qui écrit l'alerte dans la bonne langue
  //
  // Paramètre $1 = massage AJAX du type "alertesuppanierF"
  // ----------------------------------------------------

$Mess:=$1
$Langue:=$Mess[[Length:C16($Mess)]]
$Oui:=DiaWebTraduitTexte ("Oui";$Langue)
$Non:=DiaWebTraduitTexte ("Non";$Langue)
$Title:=DiaWebTraduitTexte ("Supprimer le panier";$Langue)
$Envoi:=$Oui+"£"+$Non+"£"+$Title+"£"+DiaWebTraduitTexte ("Vous avez demandé à supprimer le panier";$Langue)
WEB SEND TEXT:C677($Envoi)