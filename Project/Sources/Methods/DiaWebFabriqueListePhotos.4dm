//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 09/01/16, 07:10:33
  // ----------------------------------------------------
  // Méthode : WebFabriqueListePhotos
  // Description
  // Fabrique la liste des <20 diapositives
  //
  // Paramètre $1 = type de liste Anglaise DGAL ou ENV
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT;$La;$Ha;$L)
$Langue:=$1
If (VarPlusieursNomsMotifs)
	$Rep:=" NB : Vous avez demandé la liste des lésions dans le cadre de la nomenclature réglementaire "
	$Rep:=$Rep+"qui a parfois regroupé plusieurs lésions sur un motif."
	$Rep:=$Rep+"<br />C'est pourquoi il est affiché des images dont le nom de lésion n'est pas exactement la même que celui du motif.<br />"
Else 
	$Rep:=""
End if 

$FT:=Size of array:C274(TbNumDiaR)
For ($Salé;1;$FT)
	$rang:=String:C10($Salé)
	  // recherche de la ligne du tableau de référence initialisé par WebCreerTbDescriptionPhotos
	$NumDiapoCourant:=TbNumDiaR{$Salé}
	$L:=Find in array:C230(<>TbNumDia;$NumDiapoCourant)
	$NumImageA:=String:C10($NumDiapoCourant)
	$CDNomImage:=Get 4D folder:C485(Dossier racine HTML:K5:20)+"PhotosAsaDia"+Séparateur dossier:K24:12+String:C10($NumDiapoCourant)+"is.jpg"
	READ PICTURE FILE:C678($CDNomImage;$VarImage)
	PICTURE PROPERTIES:C457($VarImage;$La;$Ha)
	$Ho:=($La>$Ha)
	$Ve:=Not:C34($Ho)
	$HV:=(Num:C11($Ho)*"h")+(Num:C11($Ve)*"v")
	  // l'imagette = 1ere colonne
	$Rep:=$Rep+"        <div class="+<>ZGuil+"lignephoto1"+<>ZGuil+">"+<>ZCR
	
	$width:=(Num:C11($Ho)*"248px")+(Num:C11($Ve)*"164px")
	$heigth:=(Num:C11($Ho)*"164px")+(Num:C11($Ve)*"248px")
	
	$Rep:=$Rep+"              <img id="+<>ZGuil+"img"+$rang+<>ZGuil+" class="+<>ZGuil+"imageenliste"+<>ZGuil\
		+" src="+<>ZGuil+"PhotosAsaDia/"+$NumImageA+"i.jpg"+<>ZGuil+" width="+$width\
		+" height="+$heigth+" alt="+<>ZGuil+"image"+<>ZGuil+"/ > <br />"+<>ZCR
	
	$Rep:=$Rep+"          "+DiaWebAfficheTriplette ($L;$Langue)+" ("+$NumImageA+")"+<>ZCR
	$Rep:=$Rep+"        </div>"+<>ZCR
	
	  // les boutons d'affichage des détails = 2eme colonne
	$Rep:=$Rep+"          <p class="+<>ZGuil+"lignephoto2"+<>ZGuil+" >"+<>ZCR
	  // description de la diapositive
	$Title:=DiaWebTraduitTexte ("Description macroscopique";$Langue)
	$Rep:=$Rep+"            <img id="+<>ZGuil+"lpd"+$NumImageA+$rang+<>ZGuil+" width="+<>ZGuil+"25px"+<>ZGuil\
		+" src="+<>ZGuil+"images/BouComRepos.jpeg"+<>ZGuil+" alt="+<>ZGuil+$Title\
		+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+" />"+<>ZCR
	  // fiche reflexe
	$Title:=DiaWebTraduitTexte ("Fiche reflexe";$Langue)
	$Rep:=$Rep+"            <img id="+<>ZGuil+"lpf"+$NumImageA+$rang+<>ZGuil+" width="+<>ZGuil+"25px"+<>ZGuil\
		+" src="+<>ZGuil+"images/BouFRRepos.jpeg"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" title="\
		+<>ZGuil+$Title+<>ZGuil+" />"+<>ZCR
	  // descriptif de la lésion
	$Title:=DiaWebTraduitTexte ("description de la lésion";$Langue)
	$Rep:=$Rep+"            <img id="+<>ZGuil+"lpl"+$NumImageA+$rang+<>ZGuil+" width="+<>ZGuil+"25px"\
		+<>ZGuil+" src="+<>ZGuil+"images/BouLesRepos.jpeg"+<>ZGuil+" alt="+<>ZGuil+$Title\
		+<>ZGuil+"  title="+<>ZGuil+$Title+<>ZGuil+" />"+<>ZCR
	
	  // Ne pas confondre
	$Title:=DiaWebTraduitTexte ("Ne pas confondre avec";$Langue)
	$Rep:=$Rep+"            <img id="+<>ZGuil+"lpn"+$NumImageA+$rang+<>ZGuil+" width="+<>ZGuil+"25px"\
		+<>ZGuil+" src="+<>ZGuil+"images/BouNPCRepos.jpeg"+<>ZGuil+" alt="+<>ZGuil+$Title\
		+<>ZGuil+"  title="+<>ZGuil+$Title+<>ZGuil+" />"+<>ZCR
	
	  // Références réglementaires
	If ($Langue#"R")
		$Title:=DiaWebTraduitTexte ("Références réglementaires";$Langue)
		$Rep:=$Rep+"            <img id="+<>ZGuil+"lpr"+$NumImageA+$rang+<>ZGuil+" width="+<>ZGuil+"25px"\
			+<>ZGuil+" src="+<>ZGuil+"images/BouRegRepos.jpeg"+<>ZGuil+" alt="+<>ZGuil+$Title\
			+<>ZGuil+"  title="+<>ZGuil+$Title+<>ZGuil+" />"+<>ZCR
	End if 
	
	  // Ajout au panier
	If ($Langue#"A")
		$Title:=DiaWebTraduitTexte ("Ajouter au panier";$Langue)
		$Rep:=$Rep+"            <img id="+<>ZGuil+"lpp"+$NumImageA+$rang+<>ZGuil+" width="+<>ZGuil+"25px"\
			+<>ZGuil+" src="+<>ZGuil+"images/IconePanReposr.png"+<>ZGuil+" alt="+<>ZGuil+$Title\
			+<>ZGuil+"  title="+<>ZGuil+$Title+<>ZGuil+" />"+<>ZCR
		$Rep:=$Rep+"          </p>"+<>ZCR
	End if 
	
	
	  // le commentaire par défaut = 3eme colonne vide
	$Rep:=$Rep+"          <p class="+<>ZGuil+"lignephoto3"+<>ZGuil+" id="+<>ZGuil+"texte"+$NumImageA+$rang+<>ZGuil+">"+<>ZCR
	$Rep:=$Rep+"          </p>"+<>ZCR
	$Rep:=$Rep+"        <br /><br /><br />"+<>ZCR2
	
End for 
$0:=$Rep
  //FIXER TEXTE DANS CONTENEUR($Rep)