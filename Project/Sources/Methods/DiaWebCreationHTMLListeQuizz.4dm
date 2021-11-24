//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 24/05/19, 07:53:33
  // ----------------------------------------------------
  // Méthode : WebCreationHTMLListeQuizz
  // Description
  //  Méthode qui écrit le HTML de la liste des Quizz
  //
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT)
SELECTION TO ARRAY:C260([QuizzQuestionnaires:35]Titre:3;$TbQuizzTitre;[QuizzQuestionnaires:35]Auteur:2;$TbQuizzAuteur)
LONGINT ARRAY FROM SELECTION:C647([QuizzQuestionnaires:35];$TbNumEnrQuestionnaire)
$FT:=Records in selection:C76([QuizzQuestionnaires:35])
$FTA:=String:C10($FT)
$THTML:=""
$THTML:=$THTML+"        <table id="+<>ZGuil+"TbLes"+<>ZGuil+" class="+<>ZGuil+"TbRes"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"          <thead class="+<>ZGuil+"TbETG"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"           <tr class="+<>ZGuil+"TbETL"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"             <th class="+<>ZGuil+"TbETC1"+<>ZGuil+">Auteur</th>"+<>ZCR
$THTML:=$THTML+"             <th class="+<>ZGuil+"TbETC2"+<>ZGuil+">Titre du questionnaire</th>"+<>ZCR
$THTML:=$THTML+"             <th class="+<>ZGuil+"TbETC1"+<>ZGuil+">Lancer</th>"+<>ZCR
$THTML:=$THTML+"           </tr>"+<>ZCR
$THTML:=$THTML+"          </thead>"+<>ZCR

  // Corps du tableau
For ($Salé;1;$FT)
	$pair:=(Num:C11($Salé%2=1)*"even")+(Num:C11($Salé%2=0)*"odd")
	$LigneA:=String:C10($TbNumEnrQuestionnaire{$Salé})
	$THTML:=$THTML+"  <tr id="+<>ZGuil+"ligne"+$LigneA+<>ZGuil+"class="+<>ZGuil+"TbCorpsL "+$pair+<>ZGuil+">"+<>ZCR  // Ligne
	  // 3 Colonnes : Auteur, Titre du questionnaire, Lancer
	$THTML:=$THTML+"    <td class="+<>ZGuil+"TbCorpsC1 "+$pair+<>ZGuil+">"
	$THTML:=$THTML+$TbQuizzAuteur{$Salé}
	$THTML:=$THTML+"    </td>"+<>ZCR
	$THTML:=$THTML+"    <td class="+<>ZGuil+"TbCorpsC2 "+$pair+<>ZGuil+">"
	$THTML:=$THTML+$TbQuizzTitre{$Salé}
	$THTML:=$THTML+"    </td>"+<>ZCR
	$THTML:=$THTML+"    <td class="+<>ZGuil+"tbdetail "+$pair+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"      <img id="+<>ZGuil+"quizzlancer"+$LigneA+<>ZGuil+" title="+<>ZGuil+"Lancer le questionnaire"+<>ZGuil+" class="+<>ZGuil+"detailles"+<>ZGuil
	$THTML:=$THTML+" alt="+<>ZGuil+"Lancer le questionnaire"+<>ZGuil+" src="+<>ZGuil+"images/detail.PNG"+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"    </td>"+<>ZCR
	$THTML:=$THTML+"  </tr>"+<>ZCR2  // fin de ligne
End for 

$THTML:=$THTML+"              "+<>ZCR
$THTML:=$THTML+"</table>"+<>ZCR
$0:=$THTML