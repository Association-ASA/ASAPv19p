//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 05/03/19, 05:25:13
  // ----------------------------------------------------
  // Méthode : AdGibierHTMLPhotoTimbrePoste
  // Description
  // Méthode qui écrit le HTML d'une page AsaDia gibier
  //  avec 2 photos timbre poste
  // ----------------------------------------------------
C_LONGINT:C283($LDia;$LLes;$TailleMaxN;$LargeurPhotoN;$LargeurBlocN;$NumImageN)

$NumImageN:=$1
$NumImage:=String:C10($NumImageN)
$Largeur:=$2
$PhotoUnique:=(Count parameters:C259=3)
$LDia:=Find in array:C230(<>TbDiaposNumOrdreDiapos;$NumImageN)
$LLes:=Find in array:C230(<>TbLesionsNomLesion;<>TbDiaposNomLesion{$LDia})
$NomLésion:=<>TbDiaposNomLesion{$LDia}
$NomMotif:=<>TbDiaposMotifSaisieDGAL{$LDia}
$DiapoLiée:=<>TbDiaposRefPhotoLiéesGibier{$LDia}
$NomOrgane:=<>TbDiaposOrgane{$LDia}
$NomEspece:=<>TbDiaposEspece{$LDia}
$Commentaire:=Replace string:C233(<>TbDiaposComF{$LDia};<>ZCR;"<br />")
$Commentaire:=Replace string:C233($Commentaire;" . ";"<br />")
$NPCDia:=Replace string:C233(<>TbDiaposNPC{$LDia};<>ZCR;"<br />")
$NPCLésion:=Replace string:C233(<>TbLesionsNPC{$LLes};<>ZCR;"<br />")
$NPCFinal:=(Num:C11($NPCDia="")*$NPCLésion)+(Num:C11($NPCDia#"")*$NPCDia)
$FR:=Replace string:C233(<>TbLesionsFicheReflexe{$LLes};<>ZCR;"<br />")
$FR:=Replace string:C233($FR;" . ";"<br />")
$Reglementation:=Replace string:C233(<>TbLesionsReglementUE{$LLes};<>ZCR;"<br />")
$THTML:="<!DOCTYPE html>"+<>ZCR
$THTML:=$THTML+"<html>"+<>ZCR
$THTML:=$THTML+"  <head>"+<>ZCR
$THTML:=$THTML+"    <title>Page 2 photos</title>"+<>ZCR
$THTML:=$THTML+"    <meta http-equiv="+<>ZGuil+"Content-Type"+<>ZGuil+" content="+<>ZGuil+"text/html; charset=UTF-8"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    <link href="+<>ZGuil+"styles/style-asa.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    <link href="+<>ZGuil+"styles/style-clarisse.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    <link href="+<>ZGuil+"styles/style-claude.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    <link href="+<>ZGuil+"styles/style-asadia.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    <link href="+<>ZGuil+"styles/asadiagibier.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/jquery-1.11.3.js"+<>ZGuil+"></script>"+<>ZCR
$THTML:=$THTML+"    <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/asadiagibier.js"+<>ZGuil+"></script>"+<>ZCR
$THTML:=$THTML+"  </head>"+<>ZCR

$THTML:=$THTML+"  <body>"+<>ZCR
$THTML:=$THTML+"    <div class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      <img id="+<>ZGuil+"quittephotoengrand"+<>ZGuil+" src="+<>ZGuil+"images/bandeau.jpg"+<>ZGuil+" alt="+<>ZGuil+"logo"+<>ZGuil+" width="+<>ZGuil+"100%"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"       <br />"+<>ZCR
$THTML:=$THTML+"       Pour quitter cet écran, merci de cliquer sur le bandeau ci-dessus."+<>ZCR
$THTML:=$THTML+"      <br /><br />"+<>ZCR
$THTML:=$THTML+"    </div>"+<>ZCR

$LargeurN:=Num:C11($Largeur)

$TailleMaxN:=OB Get:C1224(<>TbDiaposObjetDiapo{$LDia};"MaxDim";Est un entier long:K8:6)
$TailleMaxA:=String:C10($TailleMaxN)
If ($PhotoUnique)
	$LargeurBlocN:=$LargeurN-90
Else 
	$LargeurBlocN:=($LargeurN-90)/2
End if 
If ($LargeurBlocN>$TailleMaxN)
	$LargeurBlocN:=$TailleMaxN
	$LargeurBlocA:=String:C10($TailleMaxA)+"px"
	$LargeurPhotoN:=$LargeurBlocN-30
	$LargeurPhotoA:=String:C10($LargeurPhotoN)+"px"
Else 
	$LargeurBlocA:=String:C10($LargeurBlocN)+"px"
	$LargeurPhotoN:=$LargeurBlocN-30
	$LargeurPhotoA:=String:C10($LargeurPhotoN)+"px"
End if 
$LargeurCorpsadg:=String:C10((2*$LargeurBlocN)+60)+"px"

$THTML:=$THTML+"    <div id="+<>ZGuil+"corpsadg"+<>ZGuil+" width="+<>ZGuil+$LargeurCorpsadg+<>ZGuil+">"+<>ZCR
$Triplette:=Uppercase:C13($NomLésion[[1]])+Substring:C12($NomLésion;2)+" sur "+Lowercase:C14($NomOrgane)+" de "+Lowercase:C14($NomEspece)
$THTML:=$THTML+"        <p class="+<>ZGuil+"adtitrepage"+<>ZGuil+">"+$Triplette+"</p>"+<>ZCR

$CDImage:="PhotosAsaDia/"

  // Bloc 1 = image cliquée

$THTML:=$THTML+"        <div id="+<>ZGuil+"bloc1"+<>ZGuil+" class="+<>ZGuil+"blocphotogibier"+<>ZGuil+" width="+<>ZGuil+$LargeurBlocA+<>ZGuil+" taillemax="+<>ZGuil+$TailleMaxA+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"          <img src="+<>ZGuil+$CDImage+$NumImage+"r.jpg"+<>ZGuil+" alt="+<>ZGuil+"photo 1"+<>ZGuil+" id="+<>ZGuil+"photo1"+<>ZGuil+" width="+<>ZGuil+$LargeurBlocA+<>ZGuil+"/>"+<>ZCR
$THTML:=$THTML+"          <div id="+<>ZGuil+"commentaire1"+<>ZGuil+" width="+<>ZGuil+$LargeurBlocA+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"            <p class="+<>ZGuil+"textebanal"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"                Photo n°"+$NumImage+" :  "+$Commentaire+"<br />"+<>ZCR
$THTML:=$THTML+"            </p>"+<>ZCR
$THTML:=$THTML+"         </div>"+<>ZCR
$THTML:=$THTML+"        </div>"+<>ZCR2

If ($PhotoUnique=False:C215)
	  // Bloc2 = image associée
	$LDia:=Find in array:C230(<>TbDiaposRefPhotoPrincipaleGibie;$DiapoLiée)
	$NumImage:=String:C10(<>TbDiaposNumOrdreDiapos{$LDia})
	$LLes:=Find in array:C230(<>TbLesionsNomLesion;<>TbDiaposNomLesion{$LDia})
	$NomOrgane:=<>TbDiaposOrgane{$LDia}
	$Commentaire:=<>TbDiaposComF{$LDia}
	$LargeurN:=Num:C11($Largeur)
	$LargeurBlocN:=($LargeurN-60)/2
	$LargeurBlocA:=String:C10($LargeurBlocN)+"px"
	$TailleMaxN:=OB Get:C1224(<>TbDiaposObjetDiapo{$LDia};"MaxDim";Est un entier long:K8:6)
	$TailleMaxA:=String:C10($TailleMaxN)
	If ($LargeurBlocN>$TailleMaxN)
		$LargeurBlocN:=$TailleMaxN
		$LargeurBlocA:=String:C10($TailleMaxA)+"px"
		$LargeurPhotoN:=$LargeurBlocN-30
		$LargeurPhotoA:=String:C10($LargeurPhotoN)+"px"
	End if 
	$THTML:=$THTML+"        <div id="+<>ZGuil+"bloc2"+<>ZGuil+" class="+<>ZGuil+"blocphotogibier"+<>ZGuil+" width="+<>ZGuil+$LargeurBlocA+<>ZGuil
	$THTML:=$THTML+" taillemax="+<>ZGuil+$TailleMaxA+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"          <img src="+<>ZGuil+$CDImage+$NumImage+"r.jpg"+<>ZGuil+" alt="+<>ZGuil+"photo 2"+<>ZGuil+" id="+<>ZGuil+"photo2"+<>ZGuil
	$THTML:=$THTML+" width="+<>ZGuil+$LargeurBlocA+<>ZGuil+"/>"+<>ZCR
	$THTML:=$THTML+"          <div id="+<>ZGuil+"commentaire2"+<>ZGuil+" width="+<>ZGuil+$LargeurBlocA+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"            <p class="+<>ZGuil+"textebanal"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"                Photo n°"+$NumImage+" :  "+$Commentaire+"<br />"+<>ZCR
	$THTML:=$THTML+"            </p>"+<>ZCR
	$THTML:=$THTML+"         </div>"+<>ZCR
	$THTML:=$THTML+"        </div>"+<>ZCR
End if 

$FR:=(Num:C11(<>TbDiaposDiapoFicheReflexe{$LDia}#"")*<>TbDiaposDiapoFicheReflexe{$LDia})+(Num:C11(<>TbDiaposDiapoFicheReflexe{$LDia}="")*<>TbLesionsFicheReflexe{$LLes})
$DL:=<>TbDiaposDescriptionTypeLesion{$LDia}
$MS:=<>TbDiaposMotifSaisieDGAL{$LDia}
$RG:=<>TbDiaposReferenceReglementaireU{$LDia}
If (True:C214)
	$THTML:=$THTML+"      </div>"+<>ZCR  // fin de div corpsadg
	$THTML:=$THTML+"      <div class="+<>ZGuil+"blocinfo"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"        <p class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"          <span class="+<>ZGuil+"adtitre0e"+<>ZGuil+">Motif de la saisie :</span> "+$NomMotif+<>ZCR
	$THTML:=$THTML+"        </p>"+<>ZCR2
	
	$THTML:=$THTML+"        <p class="+<>ZGuil+"adtitre0e"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"          Fiche réflexe <img id="+<>ZGuil+"gibiercomfr"+<>ZGuil+" src="+<>ZGuil+"images/trianglebas.jpeg"+<>ZGuil+" alt="+<>ZGuil+"voir plus"+<>ZGuil
	$THTML:=$THTML+" width="+<>ZGuil+"10px"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"        </p>"+<>ZCR
	$THTML:=$THTML+"        <p class="+<>ZGuil+"textedecalegibier"+<>ZGuil+" id="+<>ZGuil+"tgibiercomfr"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"          "+$FR+<>ZCR
	$THTML:=$THTML+"        </p>"+<>ZCR2
	
	$THTML:=$THTML+"        <p class="+<>ZGuil+"adtitre0e"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"          Ne pas confondre <img id="+<>ZGuil+"gibiercomnpc"+<>ZGuil+" src="+<>ZGuil+"images/trianglebas.jpeg"+<>ZGuil+" alt="+<>ZGuil+"voir plus"+<>ZGuil
	$THTML:=$THTML+" width="+<>ZGuil+"10px"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"        </p>"+<>ZCR
	$THTML:=$THTML+"        <p class="+<>ZGuil+"textedecalegibier"+<>ZGuil+" id="+<>ZGuil+"tgibiercomnpc"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"         "+$NPCFinal+<>ZCR
	$THTML:=$THTML+"        </p>"+<>ZCR2
	
	$THTML:=$THTML+"        <p class="+<>ZGuil+"adtitre0e"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"          Description type de la lésion <img id="+<>ZGuil+"gibiercomdl"+<>ZGuil+" src="+<>ZGuil+"images/trianglebas.jpeg"+<>ZGuil+" alt="+<>ZGuil+"voir plus"+<>ZGuil
	$THTML:=$THTML+" width="+<>ZGuil+"10px"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"        </p>"+<>ZCR
	$THTML:=$THTML+"        <p class="+<>ZGuil+"textedecalegibier"+<>ZGuil+" id="+<>ZGuil+"tgibiercomdl"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"          "+$DL+<>ZCR
	$THTML:=$THTML+"        </p>"+<>ZCR2
	
	$THTML:=$THTML+"        <p class="+<>ZGuil+"adtitre0e"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"Réglementation <img id="+<>ZGuil+"gibiercomre"+<>ZGuil+" src="+<>ZGuil+"images/trianglebas.jpeg"+<>ZGuil+" alt="+<>ZGuil+"voir plus"+<>ZGuil
	$THTML:=$THTML+" width="+<>ZGuil+"10px"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"        </p>"+<>ZCR
	$THTML:=$THTML+"        <p class="+<>ZGuil+"textedecalegibier"+<>ZGuil+" id="+<>ZGuil+"tgibiercomre"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"           "+$Reglementation+<>ZCR
	$THTML:=$THTML+"        </p>"+<>ZCR2
	$THTML:=$THTML+"      </div>"+<>ZCR
	
Else 
	$THTML:=$THTML+"        <div class="+<>ZGuil+"blocinfo"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"           <div class="+<>ZGuil+"adgtitreinfo"+<>ZGuil+" id="+<>ZGuil+"npcfr1"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"                Fiche réflexe"+<>ZCR
	$THTML:=$THTML+"                <p class="+<>ZGuil+"adgtexteinfo"+<>ZGuil+" id="+<>ZGuil+"npcfr1t"+<>ZGuil+">"+$FR+"</p>"+<>ZCR
	$THTML:=$THTML+"           </div>"+<>ZCR
	$THTML:=$THTML+"           <div class="+<>ZGuil+"adgtitreinfo"+<>ZGuil+" id="+<>ZGuil+"npcdl2"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"                Description type de la lésion"+<>ZCR
	$THTML:=$THTML+"                <p class="+<>ZGuil+"adgtexteinfo"+<>ZGuil+" id="+<>ZGuil+"npcdl2t"+<>ZGuil+">"+$DL+"</p>"+<>ZCR
	$THTML:=$THTML+"           </div>"+<>ZCR
	$THTML:=$THTML+"           <div class="+<>ZGuil+"adgtitreinfo"+<>ZGuil+" id="+<>ZGuil+"npcms3"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"              Motif de saisie"+<>ZCR
	$THTML:=$THTML+"              <p class="+<>ZGuil+"adgtexteinfo"+<>ZGuil+" id="+<>ZGuil+"npcms3t"+<>ZGuil+">"+$MS+"</p>"+<>ZCR
	$THTML:=$THTML+"           </div>"+<>ZCR
	$THTML:=$THTML+"           <div class="+<>ZGuil+"adgtitreinfo"+<>ZGuil+" id="+<>ZGuil+"npcrg1"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"              Réglementation"+<>ZCR
	$THTML:=$THTML+"             <p class="+<>ZGuil+"adgtexteinfo"+<>ZGuil+" id="+<>ZGuil+"npcrg1t"+<>ZGuil+">"+$RG+"</p>"+<>ZCR
	$THTML:=$THTML+"           </div>"+<>ZCR
	$THTML:=$THTML+"        </div>"+<>ZCR
	$THTML:=$THTML+"    </div>"+<>ZCR  // fin de div corpsadg
End if 
$THTML:=$THTML+"      <div id="+<>ZGuil+"pied"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <!--4dinclude piedF"+".shtml-->"+<>ZCR
$THTML:=$THTML+"      </div>"+<>ZCR
$THTML:=$THTML+"  </body>"+<>ZCR
$THTML:=$THTML+"</html>"+<>ZCR
$0:=$THTML