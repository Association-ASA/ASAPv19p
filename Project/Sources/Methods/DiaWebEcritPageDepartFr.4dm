//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 18/12/19, 16:14:12
  // ----------------------------------------------------
  // Méthode : WebEcritPageDepartFr
  // Description
  // Méthode qui écrit la page d'identification d'AsaDia
  //
  // Paramètres
  // ----------------------------------------------------
$THTML:=""
$THTML:=$THTML+"<!DOCTYPE html>"+<>ZCR
$THTML:=$THTML+"<html>"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+"<head>"+<>ZCR
$THTML:=$THTML+"<title>Identification</title>"+<>ZCR
$THTML:=$THTML+"    <meta http-equiv="+<>ZGuil+"Content-Type"+<>ZGuil+" content="+<>ZGuil+"text/html; charset=UTF-8"+<>ZGuil+" />"+<>ZCR
  //$THTML:=$THTML+"    <meta http-equiv="+<>ZGuil+"Pragma"+<>ZGuil+" content="+<>ZGuil+"no-cache"+<>ZGuil+"/>"+<>ZCR
$THTML:=$THTML+"    <link href="+<>ZGuil+"styles/style-asa.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    <link href="+<>ZGuil+"styles/style-asadia.css"+<>ZGuil+" rel="+<>ZGuil+"stylesheet"+<>ZGuil+" type="+<>ZGuil+"text/css"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    <script src="+<>ZGuil+"js/jquery-1.11.3.js"+<>ZGuil+"></script>"+<>ZCR
$THTML:=$THTML+"    <script src="+<>ZGuil+"js/jquery-ui.min.js"+<>ZGuil+"></script>"+<>ZCR
$THTML:=$THTML+"  </head>"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+"<body>"+<>ZCR
  //$THTML:=$THTML+"<!-- BEGIN QUALITYSSL SITE SEAL CODE 2.0//-->"+<>ZCR
  //$THTML:=$THTML+"<a href="+<>ZGuil+"http://www.qualityssl.com/"+<>ZGuil+" target="+<>ZGuil+"_blank"+<>ZGuil+">"+<>ZCR
  //$THTML:=$THTML+"<img src="+<>ZGuil+"https://association.asa-spv.fr/images/qualityssl_siteseal.gif"+<>ZGuil+" width="+<>ZGuil+"120"+<>ZGuil+" height="+<>ZGuil+"60"+<>ZGuil+" border="+<>ZGuil+"0"+<>ZGuil+" alt="+<>ZGuil+"QualitySSL Site Seal"+<>ZGuil+" Title="+<>ZGuil+"High Assurance SSL provided by QualitySSL"+<>ZGuil+"></a>"+<>ZCR
  //$THTML:=$THTML+"<!-- END QUALITYSSL SITE SEAL CODE 2.0//-->"+<>ZCR
$THTML:=$THTML+"  <div id="+<>ZGuil+"header"+<>ZGuil+" align="+<>ZGuil+"center"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"    <a href="+<>ZGuil+"https://association.asa-spv.fr:500"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      <img src="+<>ZGuil+"images/bandeau.jpg"+<>ZGuil+" alt="+<>ZGuil+"logo"+<>ZGuil+" width="+<>ZGuil+"1008"+<>ZGuil+" > </img>"+<>ZCR
$THTML:=$THTML+"    </a>"+<>ZCR
$THTML:=$THTML+"    <p class="+<>ZGuil+"hautpage"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"     Cliquer sur l'image pour visiter le site de l'ASA"+<>ZCR
$THTML:=$THTML+"    </p>"+<>ZCR
$THTML:=$THTML+"  </div>"+<>ZCR2
$THTML:=$THTML+"  <div id="+<>ZGuil+"corpsdep"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"    <div id="+<>ZGuil+"faqcontenu"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      <a id="+<>ZGuil+"flagA"+<>ZGuil+" href="+<>ZGuil+"asadia3WebA.shtml"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <img  src="+<>ZGuil+"images/DrapeauA.gif"+<>ZGuil+" alt="+<>ZGuil+"drapeau anglais"+<>ZGuil+" width="+<>ZGuil+"30px"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"      </a>"+<>ZCR
$THTML:=$THTML+"      <a id="+<>ZGuil+"flagR"+<>ZGuil+" href="+<>ZGuil+"asadia3WebR.shtml"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"            <img"+<>ZCR
$THTML:=$THTML+"src="+<>ZGuil+"images/DrapeauR.gif"+<>ZGuil+" alt="+<>ZGuil+"drapeau russe"+<>ZGuil+" width="+<>ZGuil+"30px"+<>ZGuil
$THTML:=$THTML+"title= "+<>ZGuil+" La version russe de cet outil a pu être réalisée grâce à financement octroyé par l’Italie,"+<>ZCR
$THTML:=$THTML+"dans le cadre d’un projet de jumelage de l’OIE entre établissements d’enseignement vétérinaire"+<>ZGuil+"/>"+<>ZCR
$THTML:=$THTML+"      </a>"+<>ZCR
$THTML:=$THTML+"    </div>"+<>ZCR
$THTML:=$THTML+"    <div id="+<>ZGuil+"contenu1"+<>ZGuil+" class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"    <div id="+<>ZGuil+"aidepdfvideo"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      <a href="+<>ZGuil+"pdf/AsaDia3WebMdE.pdf"+<>ZGuil+" target="+<>ZGuil+"_blank"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <img type="+<>ZGuil+"image"+<>ZGuil+" src="+<>ZGuil+"images/AideF.png"+<>ZGuil+" alt="+<>ZGuil+"aide"+<>ZGuil+"  title="+<>ZGuil+"Aide en PDF"+<>ZGuil+" height="+<>ZGuil+"40"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"      </a>"+<>ZCR
$THTML:=$THTML+"      <a href="+<>ZGuil+"#"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <img type="+<>ZGuil+"image"+<>ZGuil+" id="+<>ZGuil+"faqpage"+<>ZGuil+" src="+<>ZGuil+"images/Faq.png"+<>ZGuil+" alt="+<>ZGuil+"Envoyer un message à l'ASA"+<>ZGuil+" title="+<>ZGuil+"Envoyer un message à l'ASA"+<>ZGuil+"  height="+<>ZGuil+"40"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"      </a>"+<>ZCR
$THTML:=$THTML+"    </div>"+<>ZCR
$THTML:=$THTML+"        <br/><br/><br/>"+<>ZCR
$THTML:=$THTML+"    <p class="+<>ZGuil+"titrepage"+<>ZGuil+" id="+<>ZGuil+"titredelapage"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"          ASADia 3 sur le Web : identification"+<>ZCR
$THTML:=$THTML+"    </p>"+<>ZCR
$THTML:=$THTML+"        <br/><br/>"+<>ZCR
$THTML:=$THTML+"    <p class="+<>ZGuil+"hautpage"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        Pour vous identifier, merci de bien vouloir entrer l'adresse mail<br/>"+<>ZCR
$THTML:=$THTML+"avec laquelle vous êtes enregistré(e) sur le site de l'ASA"+<>ZCR
$THTML:=$THTML+"    </p>"+<>ZCR
$THTML:=$THTML+"        <br/>"+<>ZCR
$THTML:=$THTML+"    <form name="+<>ZGuil+"form1"+<>ZGuil+" method="+<>ZGuil+"POST"+<>ZGuil+" action="+<>ZGuil+"/mw2DiaWebIdentification"+<>ZGuil+">  "+<>ZCR
$THTML:=$THTML+"      <p class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <label for="+<>ZGuil+"mailid"+<>ZGuil+">Adresse mail d'identification </label>"+<>ZCR
$THTML:=$THTML+"        <input type="+<>ZGuil+"text"+<>ZGuil+" name="+<>ZGuil+"mailid"+<>ZGuil+" id="+<>ZGuil+"mailvisiteur"+<>ZGuil+" size="+<>ZGuil+"50"+<>ZGuil+"/>"+<>ZCR
$THTML:=$THTML+"            <br/><br/>"+<>ZCR
$THTML:=$THTML+"        <input class="+<>ZGuil+"titrepage"+<>ZGuil+" type="+<>ZGuil+"submit"+<>ZGuil+" name="+<>ZGuil+"Submit"+<>ZGuil+" value="+<>ZGuil+"Envoyer"+<>ZGuil+" /> "+<>ZCR
$THTML:=$THTML+"            &nbsp; &nbsp; &nbsp;"+<>ZCR
$THTML:=$THTML+"        <input type="+<>ZGuil+"reset"+<>ZGuil+" name="+<>ZGuil+"Submit2"+<>ZGuil+" value="+<>ZGuil+"Effacer"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"      </p>"+<>ZCR
$THTML:=$THTML+"    </form>"+<>ZCR
$THTML:=$THTML+"  </div> "+<>ZCR
$THTML:=$THTML+" </div>"+<>ZCR
$THTML:=$THTML+" <div id="+<>ZGuil+"pied"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"  <!--4dinclude pied.shtml-->"+<>ZCR
$THTML:=$THTML+" </div>"+<>ZCR
$THTML:=$THTML+" <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/asadiaP1.js"+<>ZGuil+"></script> <!-- jQuery AsaDia    -->"+<>ZCR
$THTML:=$THTML+" </body>"+<>ZCR
$THTML:=$THTML+"</html>"+<>ZCR
$THTML:=$THTML+""+<>ZCR
$THTML:=$THTML+""+<>ZCR

WEB SEND TEXT:C677($THTML)