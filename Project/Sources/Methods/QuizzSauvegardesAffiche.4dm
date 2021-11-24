//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 30/05/20, 19:14:29
// ----------------------------------------------------
// Méthode : QuizzSauvegardesAffiche
// Description
// Méthode qui renvoie la page des sauvegardes disponibles
// Paramètre : $1=message AJAX de type Histoire + n° du questionnaire
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT)
$Mess:=$1

$NumQuestionnaireN:=Num:C11($Mess)
QUERY:C277([DiaData:45]; [DiaData:45]XType:5="ExportDonnées"; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XEntier:2=$NumQuestionnaireN)
ORDER BY:C49([DiaData:45]; [DiaData:45]XDate:3; <; [DiaData:45]XHeure:13; <)
SELECTION TO ARRAY:C260([DiaData:45]XDate:3; $TbDate; [DiaData:45]XHeure:13; $TbHeure; [DiaData:45]XTexteSup:8; $TbAction)
LONGINT ARRAY FROM SELECTION:C647([DiaData:45]; $TbNumEnrXDonnees)
QUERY:C277([QuizzQuestionnaires:35]; [QuizzQuestionnaires:35]ID:1=$NumQuestionnaireN)
$THTML:=""
$THTML:=$THTML+"  <div id="+<>ZGuil+"alerte"+<>ZGuil+"></div>"+<>ZCR
$THTML:=$THTML+"  <div id="+<>ZGuil+"headerquizz"+<>ZGuil+" class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"     <img src="+<>ZGuil+"images/bandeau.jpg"+<>ZGuil+" alt="+<>ZGuil+"logo"+<>ZGuil+" width="+<>ZGuil+"1024"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"     <br /><br />"+<>ZCR
$THTML:=$THTML+"     <p class="+<>ZGuil+"titrepage"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"         Récupération des données sauvegardées du questionnaire<br />"+<>ZCR
$THTML:=$THTML+"         "+[QuizzQuestionnaires:35]Titre:3+<>ZCR
$THTML:=$THTML+"     </p>"+<>ZCR
$THTML:=$THTML+"  </div>"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+"    <div class="+<>ZGuil+"tablehistoire"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"     <br /><br /><br />"+<>ZCR
$THTML:=$THTML+"<i>Cliquez sur l'icône de la version que vous souhaitez récupérer <br/>ou revenez à la version actuelle en cliquant"+<>ZCR
$THTML:=$THTML+"     <a href="+<>ZGuil+"#"+<>ZGuil+" id="+<>ZGuil+"bouhistoire"+String:C10($NumQuestionnaireN)+"&"+<>ZGuil+"></i>ici</a>"+<>ZCR
$THTML:=$THTML+"     <table class="+<>ZGuil+"tablehistoire"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      <tr class="+<>ZGuil+"tbhistoireet"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireet"+<>ZGuil+" width="+<>ZGuil+"15%"+<>ZGuil+">Date</td>"+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireet"+<>ZGuil+" width="+<>ZGuil+"15%"+<>ZGuil+">Heure</td>"+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireet"+<>ZGuil+" width="+<>ZGuil+"50%"+<>ZGuil+">Dernière action avant sauvegarde</td>"+<>ZCR
$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireet"+<>ZGuil+" width="+<>ZGuil+"15s%"+<>ZGuil+">Récupérer</td>"+<>ZCR
$THTML:=$THTML+"      </tr>"+<>ZCR

$ft:=Size of array:C274($TbDate)
For ($Salé; 1; $FT)
	$THTML:=$THTML+"      <tr class="+<>ZGuil+"tbhistoireligne"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireligne"+<>ZGuil+">"+String:C10($TbDate{$Salé})+"</td>"+<>ZCR
	$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireligne"+<>ZGuil+">"+String:C10($TbHeure{$Salé})+<>ZCR
	$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireligne"+<>ZGuil+">"+String:C10($TbAction{$Salé})+<>ZCR
	$THTML:=$THTML+"       <td class="+<>ZGuil+"tbhistoireligne"+<>ZGuil+">"+<>ZCR
	$Title:="Récupérer l'ancienne version"
	$THTML:=$THTML+"          <img src="+<>ZGuil+"images/flecheenbas.png"+<>ZGuil+" alt="+$Title+" title="+$Title
	$THTML:=$THTML+"  id="+<>ZGuil+"bouhistoire"+String:C10($TbNumEnrXDonnees{$Salé})+<>ZGuil+" class="+<>ZGuil+"imagesurvol"+<>ZGuil
	$THTML:=$THTML+" width="+<>ZGuil+"24px"+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"       </td>"+<>ZCR
	$THTML:=$THTML+"      </tr>"+<>ZCR
End for 

$THTML:=$THTML+"      </table>"+<>ZCR
$THTML:=$THTML+"      <br /><br /><br />"+<>ZCR
$THTML:=$THTML+"   </div>"+<>ZCR
$THTML:=$THTML+"   <br /><br /><br />"+<>ZCR
$THTML:=$THTML+"   <br /><br /><br />"+<>ZCR
$THTML:=$THTML+"  <div id="+<>ZGuil+"pied"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"   Site officiel de l'association Animal - Société - Aliment (ASA) <br> Adresse : Bâtiment Jean GIRARD - Ecole Nationale Vétérinaire d'Alfort -"+<>ZCR
$THTML:=$THTML+"   7 avenue du Général de Gaulle - 94704 Maisons-Alfort Cedex &nbsp;&nbsp;&nbsp;FRANCE<br>"+<>ZCR
$THTML:=$THTML+"   Téléphone : <b>+ 33 (0)1 56 29 36 30</b> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Fax : <b>+ 33 (0)9 61 24 33 81</b>  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+<>ZCR
$THTML:=$THTML+"   e-mail : <a href="+<>ZGuil+"mailto:asa-spv@wanadoo.fr"+<>ZGuil+"><b>asa-spv@wanadoo.fr</b></a> <br>"+<>ZCR
$THTML:=$THTML+"   <em>Pour signaler un problème, cliquez sur le lien suivant "+<>ZCR
$THTML:=$THTML+"   <a href="+<>ZGuil+"mailto:cegeheme@wanadoo.fr"+<>ZGuil+"> écrire au webmaster</a></em>"+<>ZCR
$THTML:=$THTML+"   <br /><br />"+<>ZCR
$THTML:=$THTML+"  </div>"+<>ZCR
$THTML:=$THTML+"  <script src="+<>ZGuil+"js/historique.js"+<>ZGuil+"></script>"+<>ZCR
WEB SEND TEXT:C677($THTML)