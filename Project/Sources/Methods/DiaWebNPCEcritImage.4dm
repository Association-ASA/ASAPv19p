//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 29/07/16, 09:21:17
// ----------------------------------------------------
// Méthode : WebNPCEcritImage  <-  WebNPCRecruteDiaposNPC
//           WebNPCEcritImage  <-  WebNPCModifieSelection
// Description
//  Ecrit le HTML de l'image des NPC
// Paramètres :
//   $1 = [Diapositives]NumOrdreDiapos
//   $2 = Booléen de cochage de la photo
//   $3 = Triplette : Lésion - Organe - Espèce
//   $4 = Booléen d'horizontalité
//   $5 = n° de la diapo de référence
// ----------------------------------------------------
C_LONGINT:C283($NumN; $Salé; $FT; $NumDiaRefN; $L)

$NumA:=$1
$NumN:=Num:C11($NumA)
$Coche:=$2
$Triplette:=$3
$H:=$4
$NumDiaRefN:=$5
$NumDiaRefA:=String:C10($NumDiaRefN)
If ($H)
	$Largeur:="260px"
	$V:=""
	$Rows:="11"
	$NbMaxIcones:=10
Else 
	$Largeur:="173px"
	$V:="V"
	$Rows:="15"
	$NbMaxIcones:=15
End if 
$Checked:=Num:C11($Coche)*" checked "
QUERY:C277([DiaData:45]; [DiaData:45]XNom:1=$NumDiaRefA; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XType:5="npcdd"; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XAlpha:14=$NumA)
$Textenpcdd:=[DiaData:45]XTexte:7
//Si (Enregistrements trouvés([XDonnées])=0)
//CHERCHER([XDonnées];[XDonnées]XNom=$NumA;*)
//CHERCHER([XDonnées]; & [XDonnées]XType="npcdd";*)
//CHERCHER([XDonnées]; & [XDonnées]XAlpha=$NumDiaRefA)
//$Checked:=Num([XDonnées]XTexte#"")*" checked "
//Fin de si

$THTML:=""
// La photo; sa case à cocher et sa triplette
$THTML:=$THTML+"         <p class="+<>ZGuil+"imagette"+$V+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"           <input class="+<>ZGuil+"bac"+<>ZGuil+" id="+<>ZGuil+"bac"+$NumA+<>ZGuil+" name="+<>ZGuil+"bac"+$NumA+<>ZGuil
$THTML:=$THTML+" type="+<>ZGuil+"checkbox"+<>ZGuil+$Checked+" /> Cocher si l'image est adéquate <br />"+<>ZCR
$THTML:=$THTML+"           <img src="+<>ZGuil+"PhotosAsaDia/"+$NumA+"i.JPG"+<>ZGuil+" alt="+<>ZGuil+$NumA+<>ZGuil+" title="+<>ZGuil+$NumA+<>ZGuil
$THTML:=$THTML+" class="+<>ZGuil+"photoasadia"+<>ZGuil+" width="+<>ZGuil+$Largeur+<>ZGuil+" /><br />"+<>ZCR
$THTML:=$THTML+"          Photo n°"+$NumA+" : <br />"+$Triplette+<>ZCR
$THTML:=$THTML+"         </p>"+<>ZCR
// Les presse papiers
$THTML:=$THTML+"         <p class="+<>ZGuil+"pptextenpc"+<>ZGuil+" id="+<>ZGuil+"ppp"+$NumA+<>ZGuil+">"+<>ZCR
$L:=Find in array:C230(<>TbDiaposNumOrdreDiapos; $NumN)
$NomLesion1:=<>TbDiaposNomLesion{$L}
$TestLesion1:="@"+$NomLesion1+"@"
$L:=Find in array:C230(<>TbDiaposNumOrdreDiapos; $NumDiaRefN)
$NomLesion2:=<>TbDiaposNomLesion{$L}
$TestLesion2:="@"+<>TbDiaposNomLesion{$L}+"@"
ARRAY TEXT:C222($TbComNpc; 0)
QUERY:C277([DiaData:45]; [DiaData:45]XNom:1=($NomLesion1+"/"+$NomLesion2); *)
QUERY:C277([DiaData:45];  | [DiaData:45]XNom:1=($NomLesion2+"/"+$NomLesion1); *)
QUERY:C277([DiaData:45];  & [DiaData:45]XType:5="npcll")
$RefComCourante:=Replace string:C233([DiaData:45]XTexte:7; <>ZCR; "\r")
$THTML:=$THTML+"           <img id="+<>ZGuil+"pptxt"+[DiaData:45]ID:12+"_"+$NumA+<>ZGuil+" src="+<>ZGuil+"images/PP.png"+<>ZGuil+" width="+<>ZGuil+"15px"+<>ZGuil
$THTML:=$THTML+" title="+<>ZGuil+$RefComCourante+<>ZGuil+" />"+<>ZCR  // premier = éléments de langage
APPEND TO ARRAY:C911($TbComNpc; $RefComCourante)

// Recherche des commentaires antérieurs
QUERY:C277([DiaData:45]; [DiaData:45]XTexteSup:8=$TestLesion1; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XType:5="npcdd"; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XTexteSup:8=$TestLesion2)
SELECTION TO ARRAY:C260([DiaData:45]XTexte:7; $TbRefComNpc; [DiaData:45]ID:12; $TbUUID)
$FT:=Size of array:C274($TbRefComNpc)
$CompteurImage:=1
For ($Salé; 1; $FT)
	$RefComCourante:=Replace string:C233($TbRefComNpc{$Salé}; <>ZCR; "\r")
	$L:=Find in array:C230($TbComNpc; $RefComCourante)
	If ($L<0) & ($TbRefComNpc{$Salé}#"") & ($CompteurImage<$NbMaxIcones)
		$THTML:=$THTML+"           <img id="+<>ZGuil+"pptxt"+$TbUUID{$Salé}+"_"+$NumA+<>ZGuil+" src="+<>ZGuil+"images/PP.png"+<>ZGuil+" width="+<>ZGuil+"15px"+<>ZGuil
		$THTML:=$THTML+" title="+<>ZGuil+$RefComCourante+<>ZGuil+" />"+<>ZCR
		APPEND TO ARRAY:C911($TbComNpc; $RefComCourante)
		$CompteurImage:=$CompteurImage+1
	End if 
End for 
$THTML:=$THTML+"         </p>"+<>ZCR
// Le commentaire de l'expert
$THTML:=$THTML+"         <p class="+<>ZGuil+"comdiagdif"+$V+<>ZGuil+" id="+<>ZGuil+"tnpc"+$NumA+<>ZGuil+"> Ecrire le commentaire de diagnostic différentiel entre les deux lésions <br>"+<>ZCR
$THTML:=$THTML+"           <textarea rows="+<>ZGuil+$Rows+<>ZGuil+" cols="+<>ZGuil+"42"+<>ZGuil+"  class="+<>ZGuil+"textebanal"+<>ZGuil
$THTML:=$THTML+" id="+<>ZGuil+"ta"+$NumA+<>ZGuil+" name="+<>ZGuil+"ta"+$NumA+<>ZGuil+">"+$Textenpcdd+"</textarea>"+<>ZCR
$THTML:=$THTML+"         </p>"+<>ZCR
// Le commentaire de la photo
$THTML:=$THTML+"          <p class="+<>ZGuil+"comphotonpc"+<>ZGuil+"> Commentaire de la photo <br />"+<>ZCR
$THTML:=$THTML+"            <span class="+<>ZGuil+"textecom"+<>ZGuil+" id="+<>ZGuil+"comphoto"+$NumA+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"              "+DiaWebExtraitValeurTbParNum($NumN; -><>TbDiaposNumOrdreDiapos; -><>TbDiaposComF)+<>ZCR
$THTML:=$THTML+"            </span>"+<>ZCR
$THTML:=$THTML+"          </p>"+<>ZCR
$THTML:=$THTML+""+<>ZCR

$0:=$THTML