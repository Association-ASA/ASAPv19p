//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 06/09/15, 16:39:44
  // ----------------------------------------------------
  // Méthode : WebAffichePageAdherent
  // Description
  // Affiche la page des adhérents
  //  
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT)
ARRAY TEXT:C222($TbDoc;0)
ARRAY REAL:C219($TbTot;0)
QUERY:C277([XData:1];[XData:1]XType:3="FichiersAC")
SELECTION TO ARRAY:C260([XData:1]XNom:2;$TbDoc;[XData:1]XDate:4;$TbDate;[XData:1]UUID:1;$TbUUID;[XData:1]XEntier:6;$TbNumAC)
SORT ARRAY:C229($TbDoc;$TbDate;$TbUUID;$TbNumAC;<)
$DerAsaContact:=$TbNumAC{1}

$THTML:=""
$THTML:=$THTML+"<!DOCTYPE html>"+<>ZCR
$THTML:=$THTML+"<html>"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+"<head>"+<>ZCR
$THTML:=$THTML+"<title>Accès Adhérent</title>"+<>ZCR
$THTML:=$THTML+"<!--4dinclude HeaderASA.shtml-->"+<>ZCR
$THTML:=$THTML+"</head>"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+"<body>"+<>ZCR
$THTML:=$THTML+"<div id="+<>ZGuil+"header"+<>ZGuil+" align="+<>ZGuil+"center"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"<!--4dinclude bandeau.shtml-->"+<>ZCR
$THTML:=$THTML+"</div>"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+"<div id="+<>ZGuil+"corps"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+" "+<>ZCR
$THTML:=$THTML+"<div id="+<>ZGuil+"contenu1"+<>ZGuil+" class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+" "+<>ZCR
$THTML:=$THTML+"          <br /><br />"+<>ZCR
$THTML:=$THTML+"        <p class="+<>ZGuil+"titrepage"+<>ZGuil+">Cliquez sur le lien ci-dessous pour accéder au dernier numéro d'ASA Contact "+<>ZCR
$THTML:=$THTML+"          <br /><br />"+<>ZCR
$Title:="title="+<>ZGuil+String:C10($TbDate{1})+<>ZGuil+" "
$THTML:=$THTML+"         <a "+$Title+"href="+<>ZGuil+"Aco"+$TbUUID{1}+<>ZGuil+">"
$THTML:=$THTML+"           Dernier numéro d'ASA Contact ("+String:C10(Num:C11($DerAsaContact))+")"+<>ZCR
$THTML:=$THTML+"         </a>"+<>ZCR
$THTML:=$THTML+"           <br /><br />"+<>ZCR
$THTML:=$THTML+"        </p>"+<>ZCR
$THTML:=$THTML+"             "+<>ZCR
$THTML:=$THTML+"          <br /><br />"+<>ZCR
$THTML:=$THTML+"        <p class="+<>ZGuil+"titrepage"+<>ZGuil+">LISTE DES ANCIENS ASA CONTACTS</p>"+<>ZCR
$THTML:=$THTML+"        <p class="+<>ZGuil+"textecentre"+<>ZGuil+">Pour télécharger les numéros, cliquer sur le lien"+<>ZCR
$THTML:=$THTML+"        </p> "+<>ZCR
$THTML:=$THTML+"<br />"+<>ZCR
$THTML:=$THTML+"<table align="+<>ZGuil+"center"+<>ZGuil+" width="+<>ZGuil+"100%"+<>ZGuil+" border="+<>ZGuil+"1"+<>ZGuil+">"+<>ZCR

$FT:=Size of array:C274($TbDoc)
$Compteur5:=1
$THTML:=$THTML+"  <tr>"+<>ZCR
For ($Salé;2;$FT)
	$ACC:=$TbDoc{$Salé}
	If ($Compteur5=6)
		$Compteur5:=1
		$THTML:=$THTML+"  </tr>"+<>ZCR
		$THTML:=$THTML+"  <tr>"+<>ZCR
	End if 
	$NumACCourant:=String:C10($TbNumAC{$Salé})
	$THTML:=$THTML+"  <td class="+<>ZGuil+"cellulebord"+<>ZGuil+" width="+<>ZGuil+"9%"+<>ZGuil+" align="+<>ZGuil+"center"+<>ZGuil+">"
	$L:=Find in array:C230($TbDoc;("@"+$NumACCourant))
	$NomMoisAn:=<>ZTbNomDuMois{Month of:C24($TbDate{$Salé})}+" "+String:C10(Year of:C25($TbDate{$Salé}))
	$Title:="title="+<>ZGuil+$NomMoisAn+<>ZGuil
	$THTML:=$THTML+"   <a "+$Title+" href="+<>ZGuil+"Aco"+$TbUUID{$Salé}+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"     Asa Contact "+$NumACCourant+<>ZCR
	$THTML:=$THTML+"   </a>"+<>ZCR
	$THTML:=$THTML+"  </td>"+<>ZCR
	$Compteur5:=$Compteur5+1
End for 

$THTML:=$THTML+"  </tr>"+<>ZCR
$THTML:=$THTML+" </Table>"+<>ZCR
$THTML:=$THTML+"  <br /><br />"+<>ZCR2

$THTML:=$THTML+" <p class="+<>ZGuil+"textepetit textecentre"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"    Pour lire les fichiers au format PDF, t&eacute;l&eacute;chargez <b>Acrobat Reader </b>sur "+<>ZCR
$THTML:=$THTML+"    le <a href="+<>ZGuil+"http://www.adobe.fr/products/acrobat/main.html"+<>ZGuil+" target="+<>ZGuil+"_blank"+<>ZGuil+">site "+<>ZCR
$THTML:=$THTML+"    d'Adobe </a>"+<>ZCR
$THTML:=$THTML+"  <a href="+<>ZGuil+"http://www.adobe.fr/products/acrobat/main.html"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      <img src="+<>ZGuil+"images/acrobat.gif"+<>ZGuil+" width="+<>ZGuil+"59"+<>ZGuil+" height="+<>ZGuil+"21"+<>ZGuil+" align="+<>ZGuil+"absmiddle"+<>ZGuil+" border="+<>ZGuil+"0"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"          "+<>ZCR
$THTML:=$THTML+"      </img>"+<>ZCR
$THTML:=$THTML+"  </a>"+<>ZCR
$THTML:=$THTML+" </p>"+<>ZCR
$THTML:=$THTML+ResRaemaCréationPied 
WEB SEND TEXT:C677($THTML)