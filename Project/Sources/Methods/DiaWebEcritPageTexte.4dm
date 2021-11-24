//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 02/12/17, 08:15:07
  // ----------------------------------------------------
  // Méthode : WebEcritPageTexte
  // Description
  //  Ecrit la page de la liste des textes
  // ----------------------------------------------------

$THTML:=""
$THTML:=$THTML+"    <br /> <br />"+<>ZCR
$THTML:=$THTML+"      <p class="+<>ZGuil+"adtitrepage"+<>ZGuil+" id="+<>ZGuil+"titredelapage"+<>ZGuil+">Liste des documents</p>"+<>ZCR2

$THTML:=$THTML+"   <form method="+<>ZGuil+"post"+<>ZGuil+" action="+<>ZGuil+"mw2DiaWebAppelTexte"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      <input name="+<>ZGuil+"loginasadia"+<>ZGuil+" type="+<>ZGuil+"hidden"+<>ZGuil+" value="+<>ZGuil+VarLogin+<>ZGuil+" />"+<>ZCR

$THTML:=$THTML+"      <p class="+<>ZGuil+"adtitre0e"+<>ZGuil+" >Cours d'anatomie générale</p>"+<>ZCR
$THTML:=$THTML+"        <ul class="+<>ZGuil+"adtitre2e"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte1"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Anatomie pathologique générale</span> : Cours INFOMA revu par Claude GRANDMONTAGNE</li>"+<>ZCR
$THTML:=$THTML+"        </ul>"+<>ZCR
$THTML:=$THTML+"      </p>"+<>ZCR

$THTML:=$THTML+"      <p class="+<>ZGuil+"adtitre0e"+<>ZGuil+">Cours d'anatomie spéciale</p>"+<>ZCR

$THTML:=$THTML+"        <p class="+<>ZGuil+"adtitre1e"+<>ZGuil+">Lésions des bovins</p>"+<>ZCR
$THTML:=$THTML+"        <ul class="+<>ZGuil+"adtitre2e"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"         <li> <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte2"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions du foie</span> : Rec. Méd. Vét., 1991, 167 (1), 77-81. revu par le Professeur Pierre DEMONT</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte3"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions du rein</span> : Rec.Méd, Vét., 1993, 169(7), 577-584. revu par le Professeur Vincent CARLIER</li>"+<>ZCR
$THTML:=$THTML+"         <li> <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte4"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions du poumon</span> : Rec, Méd. Vét., 1992, 168 (l), 57-65. revu par le Professeur Jean-Michel CAPPELIER</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte5"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions du muscle</span> : Rec, Méd. Vét., 1997, 173 (4/5/6), 133-154. revu par le Professeur Geneviève BENARD</li>"+<>ZCR
$THTML:=$THTML+"         <li>   <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte26"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions de la tête</span> : Rec. Méd. Vét., 1994, 170 (12), 861-869. revu par le Professeur Pierre DEMONT</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte14"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions de la langue</span> : Rec. Méd. Vét., 1995, 171 (01), 9-15. revu par le Professeur Pierre DEMONT</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte13"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions du tube digestif</span> : Rec. Méd. Vet., 1995, 171 (6/7), 403-414. revu par le Professeur  Pierre DEMONT</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte18"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions des séreuses</span> : Rec. Méd. Vét., 1997, 173 (1/2/3), 65-79. revu par le Professeur Pierre DEMONT</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte25"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions de la peau et des pieds</span> : Rec. Méd. Vét., 1996, 172 (7/8), 409-420. revu par le Professeur Pierre DEMONT</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte28"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions des glandes endocrines</span> : Rec. Méd. Vét., 1996, 172 (3/4), 201-210. revu par le Professeur Pierre DEMONT</li>"+<>ZCR
$THTML:=$THTML+"        </ul>"+<>ZCR
$THTML:=$THTML+"        <br />"+<>ZCR

$THTML:=$THTML+"        <p class="+<>ZGuil+"adtitre1e"+<>ZGuil+">Lésions des ovins et de caprins</p>"+<>ZCR
$THTML:=$THTML+"        <ul class="+<>ZGuil+"adtitre2e"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte11"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions du foie</span> : Rec. Méd. Vét., 1991, 167 (1), 77-81. revu par le Professeur Pierre DEMONT</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"textexx"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions du rein</span> : Rec. Méd. Vét., 1994, 170 (l), 57-65 revu par le Professeur Vincent CARLIER</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte30"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions du poumon</span> : Rec. Méd. Vét., 1992, 168 (6/7), 443-550. revu par le Professeur Jean-Michel CAPPELIER</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte16"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions de la tête</span> : Rec. Méd. Vét., 1994, 170 (12), 861-869. revu par le Professeur Pierre DEMONT</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte15"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions de la langue</span> : Rec. Méd. Vét., 1997, 173 (1/2/3), 65-79. revu par le Professeur Pierre DEMONT</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte23"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions du tube digestif</span> : Rec. Méd, Vét., 1995, 171 (6/7), 403-414 revu par le Professeur Pierre DEMONT</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte24"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions des séreuses</span> : Rec. Méd. Vét., 1997, 173 (1/2/3), 65-79. revu par le Professeur Pierre DEMONT</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte27"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions de la peau et des pieds</span> : Rec. Méd. Vét., 1996, 172 (7/8), 409-420. revu par le Professeur Pierre DEMONT</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte29"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions des glandes endocrines et autres</span> : Rec. Méd. Vét., 1996, 172 (3/4), 201-210. revu par le Professeur Pierre DEMONT</li>"+<>ZCR
$THTML:=$THTML+"        </ul>"+<>ZCR
$THTML:=$THTML+"        <br />"+<>ZCR

$THTML:=$THTML+"        <p class="+<>ZGuil+"adtitre1e"+<>ZGuil+">Lésions des porcins</p>"+<>ZCR
$THTML:=$THTML+"        <ul class="+<>ZGuil+"adtitre2e"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte6"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions du foie</span> : Rec. Méd. Vét., 1991, 167 (9), 893-898 revu par le Professeur Nicolas KORSAK</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte8"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions du rein</span> : Rec. Méd. Vét. 1994, 170 (1), 57-65. revu par le Professeur Nicolas KORSAK</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte9"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions du poumon</span> : Rec, Méd. Vét., 1992, 168 (10), 823-828  revu par le Professeur Nicolas KORSAK</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte10"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions de la carcasse</span> : Rec.Méd, Vét., 1996, 172(11/12), 657-675 revu par le Professeur Nicolas KORSAK</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte19"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions de la tête</span> : Rec. Méd. Vér., 1994, 170 (12), 861-869. revu par le Professeur Nicolas KORSAK</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte17"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions de la langue</span> : Rec. Méd. Vét., 1995, 171 (01), 9-15. revu par le Professeur Nicolas KORSAK</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte21"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions du coeur</span> : Rec. Méd. Vét., 1993, 169 (4), 275-28 revu par le Professeur Nicolas KORSAK</li>"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte22"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions du tube digestif</span> : Rec. Méd, Vét., 1995, 171 (6/7), 403-419 revu par le Professeur Nicolas KORSAK</li>"+<>ZCR
$THTML:=$THTML+"         <Li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte20"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+" <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions de la rate</span> : Rec, Méd. Vét., 1994, 170 (8/9), 559-56 revu par le Professeur Nicolas KORSAK</li>"+<>ZCR
$THTML:=$THTML+"        </ul>"+<>ZCR
$THTML:=$THTML+"        <br />"+<>ZCR

$THTML:=$THTML+"        <p class="+<>ZGuil+"adtitre1e"+<>ZGuil+">Lésions des equins</p>"+<>ZCR
$THTML:=$THTML+"        <ul class="+<>ZGuil+"adtitre2e"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"         <li>  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"textexxx"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+"  <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Lésions du rein</span> : ReC. Méd. Vét. 1994, 170 (1), 57-65 revu par le Professeur Vincent CARLIER </li>"+<>ZCR
$THTML:=$THTML+"        </ul>"+<>ZCR
$THTML:=$THTML+"         <br /><br />"+<>ZCR

$THTML:=$THTML+"        <p class="+<>ZGuil+"adtitre0e"+<>ZGuil+" >Le point sur ...</p>"+<>ZCR
$THTML:=$THTML+"        <ul class="+<>ZGuil+"adtitre2e"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"         <li >  <input type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"texte7"+<>ZGuil+" value="+<>ZGuil+"Voir le texte"+<>ZGuil+"/>"
$THTML:=$THTML+"  <span class="+<>ZGuil+"fauxlien"+<>ZGuil+">Les péritonites chez les bovins</span> : Jean-Michel CAPPELIER revu par le comité d'experts de l'ASA</li>"+<>ZCR
$THTML:=$THTML+"        </ul>"+<>ZCR


$THTML:=$THTML+"         <br /><br />"+<>ZCR
$THTML:=$THTML+"   </form>"+<>ZCR

  // $THTML:=$THTML+"     <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/asadia2.js"+<>ZGuil+"></script> <!-- jQuery AsaDia    -->"+<>ZCR

WEB SEND TEXT:C677($THTML)