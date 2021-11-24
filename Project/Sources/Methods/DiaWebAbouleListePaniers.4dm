//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 24/07/16, 10:03:18
  // ----------------------------------------------------
  // Méthode : WebAbouleListePaniers
  // Description
  // Ecrit le HTML du corps d'écran des paniers
  //  Paramètre : $1 = initiale de la langue concernée
  // ----------------------------------------------------

$Langue:=$1
  // Contenu de la liste
QUERY:C277([DiaData:45];[DiaData:45]XAlpha:14=VarLogin;*)
QUERY:C277([DiaData:45]; & [DiaData:45]XBool:9=False:C215;*)
QUERY:C277([DiaData:45]; & [DiaData:45]XEntier:2=1951)
$Nre:=Records in selection:C76([DiaData:45])
$BlancInsécable:=" "

  // Ecrivons le HTML
$Titre:=DiaWebTraduitTexte ("Liste des paniers";$Langue)
$THTML:=$Titre+"£P6£"
$NomPDF:="Paniers"+$Langue
$THTML:=$THTML+DiaWebCreationHTMLAide ($Langue;1;$NomPDF)+"<br /><br />"
$THTML:=$THTML+"      <p class="+<>ZGuil+"adtitrepage"+<>ZGuil+" id="+<>ZGuil+"titredelapage"+<>ZGuil+">"+$Titre+"</p>"+<>ZCR
$THTML:=$THTML+"      <br />"+<>ZCR
$THTML:=$THTML+"        <p class="+<>ZGuil+"textedecale"+<>ZGuil+">"+<>ZCR
If (Records in selection:C76([DiaData:45])=0)  // Informons le visiteur de la possibilité de faire des paniers
	
	$THTML:=$THTML+"        <p class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"          <br /><br />"+<>ZCR
	$THTML:=$THTML+"          "+DiaWebTraduitTexte ("Votre login";$Langue)+"("+VarLogin+") "+DiaWebTraduitTexte ("n'a pas encore prévu de paniers";$Langue)+"."+<>ZCR
	$THTML:=$THTML+"          <br /><br />"+<>ZCR
	$THTML:=$THTML+"          "+DiaWebTraduitTexte ("AsaDia 3 Web a une fonction Paniers";$Langue)+<>ZCR
	$THTML:=$THTML+"          "+DiaWebTraduitTexte ("dans une collection";$Langue)+<>ZCR
	$THTML:=$THTML+"          "+DiaWebTraduitTexte ("Le recrutement des photos";$Langue)+<>ZCR
	$THTML:=$THTML+"          "+DiaWebTraduitTexte ("Une fois constituée";$Langue)+<>ZCR
	$THTML:=$THTML+"          "+(12*$BlancInsécable)+"- "+DiaWebTraduitTexte ("ne sélectionner que certains auteurs";$Langue)+",<br />"+<>ZCR
	$THTML:=$THTML+"          "+(12*$BlancInsécable)+"- "+DiaWebTraduitTexte ("voir ou modifier";$Langue)+",<br />"+<>ZCR
	$THTML:=$THTML+"          "+(12*$BlancInsécable)+"- "+DiaWebTraduitTexte ("supprimer un panier";$Langue)+",<br />"+<>ZCR
	$THTML:=$THTML+"          "+(12*$BlancInsécable)+"- "+DiaWebTraduitTexte ("partager un panier avec d'autres utilisateurs d'AsaDia";$Langue)+",<br />"+<>ZCR
	$THTML:=$THTML+"          "+(12*$BlancInsécable)+"- "+DiaWebTraduitTexte ("visualiser le contenu d'un panier";$Langue)+",<br />"+<>ZCR
	$THTML:=$THTML+"          "+(12*$BlancInsécable)+"- "+DiaWebTraduitTexte ("changer l’ordre des diapositives d'un panier";$Langue)+",<br />"+<>ZCR
	$THTML:=$THTML+"          "+(12*$BlancInsécable)+"- "+DiaWebTraduitTexte ("supprimer une diapositive d'un panier";$Langue)+",<br />"+<>ZCR
	$THTML:=$THTML+"          "+(12*$BlancInsécable)+"- "+DiaWebTraduitTexte ("lancer le panier";$Langue)+".<br />"+<>ZCR
	$THTML:=$THTML+"          <br /><br />"+<>ZCR
	$THTML:=$THTML+"          <p class="+<>ZGuil+"adtitrepage"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"         "+DiaWebTraduitTexte ("Pour en savoir plus";$Langue)+"... <span class="+<>ZGuil+"textebanalgrand"+<>ZGuil+"><a href="+<>ZGuil+"pdf/Paniers"+$Langue+".pdf"+<>ZGuil
	$THTML:=$THTML+">"+DiaWebTraduitTexte ("Télécharger le mode d'emploi";$Langue)+"</a></span> <br />"+<>ZCR
	$THTML:=$THTML+"          </p>"+<>ZCR
	$THTML:=$THTML+"        </p>"+<>ZCR
	
Else   // Il existe au moins un panier
	ARRAY TEXT:C222($TbAuteurs;0)
	DISTINCT VALUES:C339([DiaData:45]XType:5;$TbAuteurs)
	SORT ARRAY:C229($TbAuteurs;>)
	If ($TbAuteurs{1}#"")
		INSERT IN ARRAY:C227($TbAuteurs;1)
	End if 
	$TbAuteurs{1}:=DiaWebTraduitTexte ("Tous";$Langue)
	$FT:=Size of array:C274($TbAuteurs)
	If ($FT>2)
		$THTML:=$THTML+"         "+DiaWebTraduitTexte ("Pour afficher la liste des paniers";$Langue)+","+<>ZCR
		$THTML:=$THTML+"         "+DiaWebTraduitTexte ("sélectionnez-le dans le menu local";$Langue)+","+<>ZCR
		$THTML:=$THTML+"         <select id="+<>ZGuil+"auteurspumpanier"+<>ZGuil+" class="+<>ZGuil+"pluspum"+<>ZGuil+">"+<>ZCR
		For ($Salé;1;$FT)
			$THTML:=$THTML+"           <option>"+$TbAuteurs{$salé}+"</option>"+<>ZCR
		End for 
		$THTML:=$THTML+"         </select>"+<>ZCR
		$THTML:=$THTML+"         <br /><br />"+<>ZCR
	End if 
	
	$THTML:=$THTML+"         "+DiaWebTraduitTexte ("Pour afficher le détail d'un panier";$Langue)+","+<>ZCR
	$THTML:=$THTML+"       <input id="+<>ZGuil+"nbtotal"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" name="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+String:C10($Nre)+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"       <input id="+<>ZGuil+"nbactuel"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" name="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+String:C10($Nre)+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"       </p>"+<>ZCR
	$THTML:=$THTML+"      <div id="+<>ZGuil+"listepanier"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+DiaWebCreationHTMLListePaniers ($Langue)
	$THTML:=$THTML+"      </div>"+<>ZCR
	$THTML:=$THTML+"      <div id="+<>ZGuil+"colonnepanier"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"       <div id="+<>ZGuil+"voirdescriptifpanier"+<>ZGuil+">"+<>ZCR  // div où afficher le descriptif du panier
	$THTML:=$THTML+"       </div>"+<>ZCR
	$THTML:=$THTML+"       <div id="+<>ZGuil+"boutonspanier"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"        <button id="+<>ZGuil+"lancepanier"+<>ZGuil+" class="+<>ZGuil+"souschoixcritere"+<>ZGuil+">"+DiaWebTraduitTexte ("Lancer le diaporama";$Langue)+"</button>"+<>ZCR
	$THTML:=$THTML+"       </div>"+<>ZCR
	$THTML:=$THTML+"       <div id="+<>ZGuil+"ledetailpanier"+<>ZGuil+">"+<>ZCR  // div où afficher les photos du panier
	$THTML:=$THTML+"       </div>"+<>ZCR
	$THTML:=$THTML+"<div id="+<>ZGuil+"dialog"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"</div>"+<>ZCR
	$THTML:=$THTML+"      </div>"+<>ZCR
	  // $THTML:=$THTML+"     <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/asadia4.js"+<>ZGuil+"></script>"+<>ZCR
End if 
WEB SEND TEXT:C677($THTML)

  // FIXER TEXTE DANS CONTENEUR($THTML)
ZAmnistieInternationale 
