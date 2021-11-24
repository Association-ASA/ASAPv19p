//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : cgm
// Date et heure : 25/12/15, 17:51:42
// ----------------------------------------------------
// Méthode : WebEcritLaPage
// Description
// Ecrit le HTML des cours d'anapath spéciale
//
// Paramètres  {$1} = si existe n'écrit que l'ID Corps
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT; $Fumé; $TT)

$EcritTout:=(Count parameters:C259=0)
ALL RECORDS:C47([DiaTexteIndex:39])
SELECTION TO ARRAY:C260([DiaTexteIndex:39]EntreeIndex:2; $TbIdex; [DiaTexteIndex:39]DefinitionIndex:3; $TbTexteIndex)
VarPageAsaDia:="P8"
$THTML:=DiaWebCreationHTMLDebutPage("F"; VarLogin; "Cours")
If (False:C215)
	// Gestion des styles !
	$THTML:=$THTML+"   <p class="+<>ZGuil+"radiostyle"+<>ZGuil+"> Style typographique :     "+<>ZCR
	$THTML:=$THTML+"     <input type="+<>ZGuil+"radio"+<>ZGuil+" id="+<>ZGuil+"classique"+<>ZGuil+" name=styl"+<>ZGuil+"  >Classique</input>     "+<>ZCR
	$THTML:=$THTML+"     <input type="+<>ZGuil+"radio"+<>ZGuil+"id="+<>ZGuil+"flashy"+<>ZGuil+" name=styl"+<>ZGuil+" >Flashy</input>     "+<>ZCR
	$THTML:=$THTML+"     <input type="+<>ZGuil+"radio"+<>ZGuil+"id="+<>ZGuil+"elegant"+<>ZGuil+" name=styl"+<>ZGuil+" >Elégant</input>"+<>ZCR
	$THTML:=$THTML+"   </p>"+<>ZCR
Else 
	$THTML:=$THTML+"   <br />  <br />"+<>ZCR
	
End if 
// Titre du texte avec son sous-titre
$THTML:=$THTML+"   <p class="+<>ZGuil+"adtitrepage"+<>ZGuil+" id="+<>ZGuil+"titredelapage"+<>ZGuil+">"+[DiaTextesWeb:38]TitreTexte:2+"</p>"+<>ZCR
$THTML:=$THTML+"   <p class="+<>ZGuil+"radiostyle"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      Texte d'origine : "+[DiaTextesWeb:38]RefRevueJaune:3+"  revu par "+[DiaTextesWeb:38]AuteurRevue:4+<>ZCR
$THTML:=$THTML+"   </p>    "+<>ZCR
// Réserve de l'espace pour la photo latérale type aside
$THTML:=$THTML+"   <div id="+<>ZGuil+"photolesion"+<>ZGuil+" class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR2
$THTML:=$THTML+"   </div>"+<>ZCR
// Espace type article pour le texte
$THTML:=$THTML+"   <div id="+<>ZGuil+"texte"+<>ZGuil+" class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"+<>ZCR

// Sélection et fabrication des tableaux triés par OrdreAffichage
RELATE MANY:C262([DiaTextesWeb:38]IDTexteWeb:1)
SELECTION TO ARRAY:C260([DiaTextesWebParagraphes:37]IDParagrapheTexteWeb:1; $TbID; \
[DiaTextesWebParagraphes:37]NiveauTitre:13; $TbNT; \
[DiaTextesWebParagraphes:37]OrdreAffichage:12; $TbOA; \
[DiaTextesWebParagraphes:37]CorpsParagraphe:8; $TbCP; \
[DiaTextesWebParagraphes:37]TitreParagraphe:6; $TbTP)
SORT ARRAY:C229($TbOA; $TbID; $TbNT; $TbCP; $TbTP; >)
$FT:=Size of array:C274($TbOA)

// gestion de l'index
// Initialisation des tableaux des index à mettre
ARRAY TEXT:C222($TbCodeIndexR; 0)
ARRAY TEXT:C222($TbTexteIndexR; 0)
$CompteurIndex:=0

For ($Salé; 1; $FT)  // Pour chaque paragraphe
	COPY ARRAY:C226($TbIdex; $TbIdexP)  // On travaille sur une copie du tableau des entrées
	// Pour pouvoir supprimer cette entrée après une première occurrence
	$id:="para"+String:C10($Salé)
	$idIm:=$id+"img"
	$class:="adtitre"+String:C10($TbNT{$Salé}-1)+"e"  // sa classe
	$Suite:=(Length:C16($TbCP{$Salé})>0)  // Test de l'existence d'un texte à afficher en bascule
	// html de l'image du triangle vers le bas signifiant qu'un texte peu être dévoilé
	$Im:=" <img id="+<>ZGuil+$idIm+<>ZGuil+" src="+<>ZGuil+"images/trianglebas.jpeg"+<>ZGuil
	$Im:=$Im+" alt="+<>ZGuil+"voir plus"+<>ZGuil+" width="+<>ZGuil+"10px"+<>ZGuil+" /> "
	$triangle:=Num:C11($suite)*$Im
	// L'annonce du paragraphe avec ou sans triangle
	$THTML:=$THTML+"        <p class="+<>ZGuil+$Class+<>ZGuil+" id="+<>ZGuil
	$THTML:=$THTML+$id+<>ZGuil+">"+$TbTP{$Salé}+$triangle+<>ZCR
	$THTML:=$THTML+"        </p>"+<>ZCR
	If ($Suite)  // il existe un texte affichable
		$Para:=$TbCP{$Salé}
		// Gestion des photos : dans le texte, le n° de la photo est précédée de "photo "
		$Pos:=Position:C15("photo "; $Para)
		If ($Pos>0)
			$P:=$TbCP{$Salé}
			$Para:=""
			While ($Pos>0)
				$Para:=$Para+Substring:C12($P; 1; ($Pos-1))  // Début de chaine
				$P:=Substring:C12($P; ($Pos+6))  // Raccourcissement
				$Name:=Substring:C12($P; 1; 5)  // Extraction du n° de photo
				$P:=Substring:C12($P; 6)  // Raccourcissement du n° de photo
				// Ajout de la balise a
				$Para:=$Para+"<a name="+<>ZGuil+$Name+<>ZGuil+" class="+<>ZGuil+"clic"+<>ZGuil+">photo "+$Name+"</a>"
				$Pos:=Position:C15("photo "; $P)  // test d'une nouvelle photo
			End while 
			$Para:=$Para+$P  // Ajout final
		End if 
		
		// gestion de l'index
		GET TEXT KEYWORDS:C1141($Para; $TbMC)  // Fabrication du tableau des mots indexables
		$TT:=Size of array:C274($TbMC)  // Nbre de mots
		For ($Fumé; 1; $TT)  // Pour chaque mots
			$MC:=$TbMC{$Fumé}  // Mot courant
			$L:=Find in array:C230($TbIdexP; $MC)
			If ($L>0)
				$Pos:=Position:C15($MC; $Para)
				$LIndex:=Length:C16($MC)
				$CarSuivant:=$Para[[($Pos+$LIndex)]]
				If ($CarSuivant=" ") | ($CarSuivant=",") | ($CarSuivant=".")
					$LTitle:=Length:C16($TbTexteIndex{$L})
					$fin:=Substring:C12($Para; ($Pos+$LIndex))  // fin de chaine
					$Para:=Substring:C12($Para; 1; ($Pos-1))  // Début de chaine
					$CompteurIndex:=$CompteurIndex+1
					$CodeIndex:="indexMC"+String:C10($CompteurIndex; "0000")
					APPEND TO ARRAY:C911($TbCodeIndexR; $CodeIndex)
					APPEND TO ARRAY:C911($TbTexteIndexR; $TbTexteIndex{$L})
					$Ajout:="<a alt="+<>ZGuil+$CodeIndex+<>ZGuil+" class="+<>ZGuil+"index"+<>ZGuil
					$Ajout:=$Ajout+" title="+<>ZGuil+$CodeIndex+<>ZGuil+">"+$MC+"</a>"
					$Para:=$Para+$Ajout+$fin
					$Pos:=Position:C15($MC; $Para; ($Pos+Length:C16($Ajout)+$LIndex))  // test d'une occurrence
				End if 
				// SUPPRIMER DANS TABLEAU($TbIdexP;$L)  // Histoire de ne faire l'index qu'une fois par paragraphe
			End if 
		End for 
		$Para:=Replace string:C233($Para; Char:C90(Arobase:K15:46); "")  // permet d'exclure un mot de l'indexation
		$Para:=Replace string:C233($Para; <>ZCR; "<br />")  // Restitution des retours chariot
		$THTML:=$THTML+"        <p class="+<>ZGuil+"description"+<>ZGuil+" id="+<>ZGuil+$id+"t"+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"          "+$Para+<>ZCR+"        </p>"+<>ZCR
	End if 
	
End for 
// remplaçons les $TbCodeIndex par les valeurs $TbTexteIndex
$FT:=Size of array:C274($TbCodeIndexR)
For ($Salé; 1; $FT)
	$THTML:=Replace string:C233($THTML; $TbCodeIndexR{$Salé}; $TbTexteIndexR{$Salé})
End for 


// Ecriture du bas de la page Web
$THTML:=$THTML+"   </div> "+<>ZCR  // Fermeture de la div id="texte"

$THTML:=$THTML+"  </div>"+<>ZCR  // Fermeture de la div id="corps"
$THTML:=$THTML+"    "+<>ZCR
$THTML:=$THTML+"  <div id="+<>ZGuil+"pied"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"   <!--4dinclude pied.shtml-->"+<>ZCR
$THTML:=$THTML+"  </div>"+<>ZCR
$THTML:=$THTML+"     <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/dataTableF.js"+<>ZGuil+"></script><!-- jQuery dataTable    -->"+<>ZCR
$THTML:=$THTML+"     <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/asadiaP1.js"+<>ZGuil+"></script> <!-- jQuery AsaDia    -->"+<>ZCR
$THTML:=$THTML+"     <script src="+<>ZGuil+"js/multiple-select.js"+<>ZGuil+"></script>"+<>ZCR
$THTML:=$THTML+"     <script>"+<>ZCR
$THTML:=$THTML+"       $('select').multipleSelect({"+<>ZCR
$THTML:=$THTML+"         isOpen: true,"+<>ZCR
$THTML:=$THTML+"         keepOpen: true,"+<>ZCR
$THTML:=$THTML+"         width: 550"+<>ZCR
$THTML:=$THTML+"        });"+<>ZCR
$THTML:=$THTML+"     </script>"+<>ZCR
$THTML:=$THTML+" </body>"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+"</html>"+<>ZCR2
$THTML:=$THTML+""+<>ZCR

WEB SEND TEXT:C677($THTML)
// FIXER TEXTE DANS CONTENEUR($THTML)


