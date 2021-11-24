//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 06/01/17, 07:50:14
// ----------------------------------------------------
// Méthode : WebEcritPageNPC
// Description
//
//
// Paramètre $1=Message AJAX type "refnpcxxxxxx_login"
// où xxxxxx est le n° de la photo ref  et login l'adresse d'identification
// ----------------------------------------------------

C_LONGINT:C283($Salé; $FT)
$Mess:=$1
$Pos:=Position:C15("_"; $Mess)
$Login:=Substring:C12($Mess; ($Pos+1))
$Mess:=Substring:C12($Mess; 1; ($Pos-1))
$NumRefPhoto:=Substring:C12($Mess; 7)
//CHERCHER([XDonnees];[XDonnees]XType="NPCdd";*)
QUERY:C277([DiaData:45]; [DiaData:45]XType:5="NPC"; *)
QUERY:C277([DiaData:45]; [DiaData:45]XNom:1=$NumRefPhoto)
ARRAY TEXT:C222($TbNumNpcPhotos; 0)
ZTexteVersTableau([DiaData:45]XTexteSup:8; ->$TbNumNpcPhotos)
// SÉLECTION VERS TABLEAU([XDonnees]XAlpha;$TbNumNpcPhotos)
$FT:=Size of array:C274($TbNumNpcPhotos)
// $NumRefPhoto:="13769" // pour le test ->50621 20742 13768 13781
$title:="NPC "+$NumRefPhoto
Gibier:=False:C215
VarPageAsaDia:="P1"
$THTML:=DiaWebCreationHTMLDebutPage("F"; $Login; $title)

$THTML:=$THTML+"      <br /><br />"+<>ZCR
$THTML:=$THTML+"      <p class="+<>ZGuil+"adtitrepage"+<>ZGuil+" id="+<>ZGuil+"titredelapage"+<>ZGuil+">"
$THTML:=$THTML+"        Aspect des lésions à ne pas confondre"+<>ZCR
$THTML:=$THTML+"      </p>"+<>ZCR
If ($FT>1)
	$THTML:=$THTML+"      <p class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"        Cliquez sur la photographie pour l’afficher et voir les éléments de la diagnose différentielle"+<>ZCR
	$THTML:=$THTML+"      </p>"+<>ZCR
End if 

// les petites photos en haut
$THTML:=$THTML+"      <div id="+<>ZGuil+"npcpetitesphotos"+<>ZGuil+" class="+<>ZGuil+"textecentre interligne1"+<>ZGuil+">"+<>ZCR


QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1=Num:C11($NumRefPhoto))
QUERY:C277([DiaLesions:44]; [DiaLesions:44]NomLesion:1=[Diapositives:40]NomLesion:4)
If ([Diapositives:40]DiapoFicheReflexe:31#"")
	$FicheReflexe:=Replace string:C233(ZfVireLesVides([Diapositives:40]DiapoFicheReflexe:31); <>ZCR; "<br />")
Else 
	$FicheReflexe:=Replace string:C233(ZfVireLesVides([DiaLesions:44]FicheReflexe:12); <>ZCR; "<br />")
End if 
$Lesion1:=[Diapositives:40]NomLesion:4


// Boucle sur le nombre des photos ressemblantes = $FT-1
For ($Salé; 2; $FT)
	//Boucle ($Salé;1;$FT)
	$NumNpcPhotoCourant:=$TbNumNpcPhotos{$Salé}
	$L:=Find in array:C230(<>TbDiaposNumOrdreDiapos; Num:C11($NumNpcPhotoCourant))
	If ([Diapositives:40]Organe:2=<>TbDiaposOrgane{$L}) & ([Diapositives:40]Espece:3=<>TbDiaposEspece{$L})
		$THTML:=$THTML+"        <div id="+<>ZGuil+"npcphotos"+String:C10($Salé)+<>ZGuil+" class="+<>ZGuil+"npcpetitephoto"+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"          <img src="+<>ZGuil+"PhotosAsaDia/"+$NumNpcPhotoCourant+"i.jpg"+<>ZGuil+" alt="+<>ZGuil+"photo"+$NumNpcPhotoCourant+<>ZGuil
		$L:=Find in array:C230(<>TbNumDia; Num:C11($NumNpcPhotoCourant))
		$THTML:=$THTML+" class="+<>ZGuil+"petitephoto"+<>ZGuil+" id="+<>ZGuil+"photonpc"+String:C10($Salé)+<>ZGuil+" /><br /> Photo n°"+$NumNpcPhotoCourant+" : <i>"+DiaWebAfficheTriplette($L; "F")+"</i>"+<>ZCR
		$THTML:=$THTML+"        </div>"+<>ZCR
	End if 
End for 
$THTML:=$THTML+"      </div>"+<>ZCR

// Le pavé de la photo de référence
$THTML:=$THTML+"      <div id="+<>ZGuil+"npcgrandesphotos"+<>ZGuil+" class="+<>ZGuil+"textecentre interligne1"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <div id="+<>ZGuil+"cadrephotoref"+<>ZGuil+" class="+<>ZGuil+"npcligne2"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"          <p class="+<>ZGuil+"adsoustitrepage"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"            Photographie de référence"+<>ZCR
$THTML:=$THTML+"          </p>"+<>ZCR
$THTML:=$THTML+"          <div id="+<>ZGuil+"imagephotoref"+<>ZGuil+" class="+<>ZGuil+"npcgrandephoto"+<>ZGuil+">"+<>ZCR
$ClassPhoto:="imageenliste "+(Num:C11([Diapositives:40]OrientationPhotoH:30)*"grandephotoH")+(Num:C11(Not:C34([Diapositives:40]OrientationPhotoH:30))*"grandephotoV")
$THTML:=$THTML+"            <img src="+<>ZGuil+"PhotosAsaDia/"+$NumRefPhoto+"i.jpg"+<>ZGuil+" alt="+<>ZGuil+"photo n°"+$NumRefPhoto+<>ZGuil+" title="+<>ZGuil+"photo n°"+$NumRefPhoto+<>ZGuil
$THTML:=$THTML+" class="+<>ZGuil+$ClassPhoto+<>ZGuil+" id="+<>ZGuil+"grandephotoref"+<>ZGuil+" />"
$THTML:=$THTML+"            <br />"+<>ZCR
$L:=Find in array:C230(<>TbNumDia; Num:C11($NumRefPhoto))
$THTML:=$THTML+"            Photo n°"+$NumRefPhoto+" : <i>"+DiaWebAfficheTriplette($L; "F")+"</i>"+<>ZCR
$THTML:=$THTML+"          </div>"+<>ZCR
$THTML:=$THTML+"          <div id="+<>ZGuil+"comphotoref"+<>ZGuil+" class="+<>ZGuil+"npccomphoto"+<>ZGuil+">"+<>ZCR
// $THTML:=$THTML+"            <b>Description de la photographie</b><br />"+<>ZCR
$THTML:=$THTML+"            "+Replace string:C233([Diapositives:40]Commentaires:7; <>ZCR; "<br />")+<>ZCR
$THTML:=$THTML+"            <br />"+<>ZCR
//Si ([XDonnées]XTexte#"")
//$THTML:=$THTML+"            <b>Commentaires</b><br />"+<>ZCR
//$THTML:=$THTML+"            "+[XDonnées]XTexte+<>ZCR
//$THTML:=$THTML+"            <br /><br />"+<>ZCR
//Fin de si
$THTML:=$THTML+"            <div class="+<>ZGuil+"adtitre2 adtitre2e"+<>ZGuil+" id="+<>ZGuil+"npcfr1"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"              Fiche réflexe <img id="+<>ZGuil+"imagenpcfr1"+<>ZGuil+" src="+<>ZGuil+"images/trianglebas.jpeg"+<>ZGuil+" alt="+<>ZGuil+"voir plus"+<>ZGuil+" width="+<>ZGuil+"10px"+<>ZGuil+"> "+<>ZCR
$THTML:=$THTML+"            </div>"+<>ZCR
$THTML:=$THTML+"            <div class="+<>ZGuil+"description descriptione"+<>ZGuil+" id="+<>ZGuil+"npcfr1t"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"              "+$FicheReflexe+<>ZCR
$THTML:=$THTML+"            </div>"+<>ZCR
$THTML:=$THTML+"             <div class="+<>ZGuil+"adtitre2 adtitre2e"+<>ZGuil+" id="+<>ZGuil+"npcdl1"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"              Description type de la lésion <img id="+<>ZGuil+"imagenpcdl1"+<>ZGuil+" src="+<>ZGuil+"images/trianglebas.jpeg"+<>ZGuil+" alt="+<>ZGuil+"voir plus"+<>ZGuil+" width="+<>ZGuil+"10px"+<>ZGuil+"> "+<>ZCR
$THTML:=$THTML+"            </div>"+<>ZCR
$THTML:=$THTML+"            <div class="+<>ZGuil+"description descriptione"+<>ZGuil+" id="+<>ZGuil+"npcdl1t"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"              "+Replace string:C233([Diapositives:40]DescriptionTypeLesion:8; <>ZCR; "<br />")+<>ZCR
$THTML:=$THTML+"            </div>"+<>ZCR
$THTML:=$THTML+"          </div>"+<>ZCR
$THTML:=$THTML+"        </div>"+<>ZCR

// Le pavé de la première photo NPC
$THTML:=$THTML+"        <div id="+<>ZGuil+"npcphoto"+<>ZGuil+" class="+<>ZGuil+"npcligne2"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"          <p class="+<>ZGuil+"adsoustitrepage"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"            Lésion à ne pas confondre"+<>ZCR
$THTML:=$THTML+"          </p>"+<>ZCR
$THTML:=$THTML+"          <div id="+<>ZGuil+"imagephotonpc"+<>ZGuil+" class="+<>ZGuil+"npcgrandephoto"+<>ZGuil+">"+<>ZCR
QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1=Num:C11($TbNumNpcPhotos{1}))
QUERY:C277([DiaLesions:44]; [DiaLesions:44]NomLesion:1=[Diapositives:40]NomLesion:4)
If ([Diapositives:40]DiapoFicheReflexe:31#"")
	$FicheReflexe:=Replace string:C233([Diapositives:40]DiapoFicheReflexe:31; <>ZCR; "<br />")
Else 
	$FicheReflexe:=Replace string:C233([DiaLesions:44]FicheReflexe:12; <>ZCR; "<br />")
End if 
$ClassPhoto:="imageenliste "+(Num:C11([Diapositives:40]OrientationPhotoH:30)*"grandephotoH")+(Num:C11(Not:C34([Diapositives:40]OrientationPhotoH:30))*"grandephotoV")
$THTML:=$THTML+"            <img src="+<>ZGuil+"PhotosAsaDia/"+$TbNumNpcPhotos{1}+"i.jpg"+<>ZGuil+" alt="+<>ZGuil+"Photo n°"+$TbNumNpcPhotos{1}+<>ZGuil+" title="+<>ZGuil+"Photo n°"+$TbNumNpcPhotos{1}+<>ZGuil
$THTML:=$THTML+" class="+<>ZGuil+$ClassPhoto+<>ZGuil+" id="+<>ZGuil+"grandephotonpc"+<>ZGuil+" />"
$L:=Find in array:C230(<>TbNumDia; Num:C11($TbNumNpcPhotos{1}))
$THTML:=$THTML+"            <br />Photo n°"+$TbNumNpcPhotos{1}+" : <i>"+DiaWebAfficheTriplette($L; "F")+"</i>"+<>ZCR
$THTML:=$THTML+"          </div>"+<>ZCR
$THTML:=$THTML+"          <div id="+<>ZGuil+"comphotonpc"+<>ZGuil+" class="+<>ZGuil+"npccomphoto"+<>ZGuil+">"+<>ZCR
//$THTML:=$THTML+"            <b>Description de la photographie</b><br />"+<>ZCR
$THTML:=$THTML+"            "+Replace string:C233([Diapositives:40]Commentaires:7; <>ZCR; "<br />")+<>ZCR
$THTML:=$THTML+"            <br /><br />"+<>ZCR
//$THTML:=$THTML+"            <b>Description type de la lésion</b><br />"+<>ZCR
//$THTML:=$THTML+"            "+Remplacer chaîne([Diapositives]DescriptionTypeLesion;<>ZCR;"<br />")+<>ZCR
//$THTML:=$THTML+"            </div>"+<>ZCR
$THTML:=$THTML+"            <div class="+<>ZGuil+"adtitre2 adtitre2e"+<>ZGuil+" id="+<>ZGuil+"npcfr2"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"              Fiche réflexe <img id="+<>ZGuil+"imagenpcfr2"+<>ZGuil+" src="+<>ZGuil+"images/trianglebas.jpeg"+<>ZGuil+" alt="+<>ZGuil+"voir plus"+<>ZGuil+" width="+<>ZGuil+"10px"+<>ZGuil+"> "+<>ZCR
$THTML:=$THTML+"            </div>"+<>ZCR
$THTML:=$THTML+"            <div class="+<>ZGuil+"description descriptione"+<>ZGuil+" id="+<>ZGuil+"npcfr2t"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"              "+$FicheReflexe+<>ZCR
$THTML:=$THTML+"            </div>"+<>ZCR
$THTML:=$THTML+"            <div class="+<>ZGuil+"adtitre2 adtitre2e"+<>ZGuil+" id="+<>ZGuil+"npcdl2"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"              Description type de la lésion <img id="+<>ZGuil+"imagenpcdl2"+<>ZGuil+" src="+<>ZGuil+"images/trianglebas.jpeg"+<>ZGuil+" alt="+<>ZGuil+"voir plus"+<>ZGuil+" width="+<>ZGuil+"10px"+<>ZGuil+"> "+<>ZCR
$THTML:=$THTML+"            </div>"+<>ZCR
$THTML:=$THTML+"            <div class="+<>ZGuil+"description descriptione"+<>ZGuil+" id="+<>ZGuil+"npcdl2t"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"              "+Replace string:C233([Diapositives:40]DescriptionTypeLesion:8; <>ZCR; "<br />")+<>ZCR
$THTML:=$THTML+"            </div>"+<>ZCR
$THTML:=$THTML+"          </div>"+<>ZCR


$THTML:=$THTML+"        </div>"+<>ZCR


$THTML:=$THTML+"      </div>"+<>ZCR
// Le cadre récapitulatif
QUERY:C277([DiaData:45]; [DiaData:45]XType:5="NPCdd"; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XNom:1=$NumRefPhoto; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XAlpha:14=String:C10([Diapositives:40]NumOrdreDiapos:1))
If (Records in selection:C76([DiaData:45])=1)
	$Diagno:=[DiaData:45]XTexte:7
Else 
	$test1:=$Lesion1+"/"+[Diapositives:40]NomLesion:4
	$test2:=[Diapositives:40]NomLesion:4+"/"+$Lesion1
	QUERY:C277([DiaData:45]; [DiaData:45]XNom:1=$test1; *)
	QUERY:C277([DiaData:45];  | [DiaData:45]XNom:1=$test2)
	$Diagno:=[DiaData:45]XTexte:7
End if 

$THTML:=$THTML+"        <p id="+<>ZGuil+"npcformule"+<>ZGuil+" class="+<>ZGuil+"resrech"+<>ZGuil+">Eléments de diagnostic différentiel : <br>"+<>ZCR
$THTML:=$THTML+"          "+Replace string:C233($Diagno; <>ZCR; "<br />")+<>ZCR
$THTML:=$THTML+"        </p>"+<>ZCR
$THTML:=$THTML+"      <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/dataTableF.js"+<>ZGuil+"></script><!-- jQuery dataTable    -->"+<>ZCR
$THTML:=$THTML+"      <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/asadiaP1.js"+<>ZGuil+"></script> <!-- jQuery AsaDia    -->"+<>ZCR
$THTML:=$THTML+"      <script src="+<>ZGuil+"js/multiple-select.js"+<>ZGuil+"></script>"+<>ZCR
$THTML:=$THTML+"      <script>"+<>ZCR
$THTML:=$THTML+"       $('select').multipleSelect({"+<>ZCR
$THTML:=$THTML+"         isOpen: true,"+<>ZCR
$THTML:=$THTML+"         keepOpen: true,"+<>ZCR
$THTML:=$THTML+"         width: 550"+<>ZCR
$THTML:=$THTML+"        });"+<>ZCR
$THTML:=$THTML+"      </script>"+<>ZCR
$THTML:=$THTML+DiaWebCreationHTMLPiedPage("F")
// FIXER TEXTE DANS CONTENEUR($THTML)
$NomCourt:="npc"+$NumRefPhoto+".shtml"
$CD:=Get 4D folder:C485(Dossier racine HTML:K5:20)+$NomCourt
If (Test path name:C476($CD)=Est un document:K24:1)
	DELETE DOCUMENT:C159($CD)
End if 
$Doc:=Create document:C266($CD)
SEND PACKET:C103($Doc; $THTML)
CLOSE DOCUMENT:C267($Doc)
WEB SEND TEXT:C677($NomCourt)