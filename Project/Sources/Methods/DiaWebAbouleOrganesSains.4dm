//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 24/09/21, 10:30:21
  // ----------------------------------------------------
  // Méthode : DiaWebAbouleOrganesSains
  // Description
  // Méthode qui écrit le HTML de la page
  //   des organes sains
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)

$Langue:="F"
$Titre:="Organes sains"
$THTML:=$Titre+"£P9£"
$NomPDF:="Organes sainsF"+$Langue
  //$THTML:=$THTML+DiaWebCreationHTMLAide ($Langue;1;$NomPDF)+"<br /><br />"
$THTML:=$THTML+"   <p class="+<>ZGuil+"adtitrepage"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"     <br />Anatomie des organes sains"+<>ZCR
$THTML:=$THTML+"   </p>"+<>ZCR
$THTML:=$THTML+"   <div id="+<>ZGuil+"aidepdfvideo"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"    <a href="+<>ZGuil+"pdf/OrganesSains.pdf"+<>ZGuil+" target="+<>ZGuil+"_blank"+<>ZGuil+" >"+<>ZCR
$THTML:=$THTML+"      <img type="+<>ZGuil+"image"+<>ZGuil+" src="+<>ZGuil+"images/AideF.png"+<>ZGuil+" alt="+<>ZGuil+"Aide PDF"+<>ZGuil+" title="+<>ZGuil+"Aide PDF"+<>ZGuil+"  height="+<>ZGuil+"40"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    </a>"+<>ZCR
$THTML:=$THTML+"    <a href="+<>ZGuil+"#"+<>ZGuil+" >"+<>ZCR
$THTML:=$THTML+"      <img src="+<>ZGuil+"images/FAQ.png"+<>ZGuil+" id="+<>ZGuil+"faqpage"+<>ZGuil+" alt="+<>ZGuil+"Envoyer un message à l'ASA"+<>ZGuil+" title="+<>ZGuil+"Envoyer un message à l'ASA"+<>ZGuil+" height="+<>ZGuil+"40"+<>ZGuil+" />"+<>ZCR
$THTML:=$THTML+"    </a>"+<>ZCR
$THTML:=$THTML+"  </div>"+<>ZCR
$THTML:=$THTML+"  <div id="+<>ZGuil+"faqcontenu"+<>ZGuil+"></div>"+<>ZCR
  // $THTML:=$THTML+"   <form method="+<>ZGuil+"post"+<>ZGuil+" action="+<>ZGuil+"PageGibiercegeheme@wanadoo.fr"+<>ZGuil+">"+<>ZCR
  //$THTML:=$THTML+"     <input id="+<>ZGuil+"flagA"+<>ZGuil+" width="+<>ZGuil+"30px"+<>ZGuil+" type="+<>ZGuil+"image"+<>ZGuil+" src="+<>ZGuil+"images/Icone Gibier.jpg"+<>ZGuil+" alt="+<>ZGuil+"Aller sur la page diagnose gibier"+<>ZGuil+" title="+<>ZGuil+"Aller sur la page diagnose gibier"+<>ZGuil+">"+<>ZCR
  //$THTML:=$THTML+"   </form> "+<>ZCR
$THTML:=$THTML+"      <br />"+<>ZCR
QUERY:C277([DiaData:45];[DiaData:45]XType:5="OrganeSainGibier";*)
QUERY:C277([DiaData:45]; & [DiaData:45]XAlpha:14="Sanglier")
$THTML:=$THTML+"    <div id="+<>ZGuil+"pavespeceorgane"+<>ZGuil+" class="+<>ZGuil+"pavespeceorgane"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"     <p class="+<>ZGuil+"choixcritere"+<>ZGuil+">Choisissez l'espèce</p>"+<>ZCR
$THTML:=$THTML+"        <div class="+<>ZGuil+"cac2"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"          <p class="+<>ZGuil+"cac1"+<>ZGuil+" id="+<>ZGuil+"espece"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"           <input type="+<>ZGuil+"radio"+<>ZGuil+"  id="+<>ZGuil+"anatecerf"+<>ZGuil+" name="+<>ZGuil+"espece"+<>ZGuil+" />Cerf<br />"+<>ZCR
$THTML:=$THTML+"           <input type="+<>ZGuil+"radio"+<>ZGuil+"  id="+<>ZGuil+"anatechamois"+<>ZGuil+" name="+<>ZGuil+"espece"+<>ZGuil+" />Chamois<br />"+<>ZCR
$THTML:=$THTML+"           <input type="+<>ZGuil+"radio"+<>ZGuil+"  id="+<>ZGuil+"anatechevreuil"+<>ZGuil+" name="+<>ZGuil+"espece"+<>ZGuil+" />Chevreuil<br />"+<>ZCR
$THTML:=$THTML+"           <input type="+<>ZGuil+"radio"+<>ZGuil+"  id="+<>ZGuil+"anatemouflon"+<>ZGuil+" name="+<>ZGuil+"espece"+<>ZGuil+" />Mouflon<br />"+<>ZCR
$THTML:=$THTML+"           <input checked="+<>ZGuil+""+<>ZGuil+" type="+<>ZGuil+"radio"+<>ZGuil+"  id="+<>ZGuil+"anatesanglier"+<>ZGuil+" name="+<>ZGuil+"espece"+<>ZGuil+" />Sanglier<br />"+<>ZCR
$THTML:=$THTML+"          </p>"+<>ZCR
$THTML:=$THTML+"        </div>"+<>ZCR2

$THTML:=$THTML+"       <p class="+<>ZGuil+"choixcritere"+<>ZGuil+">Choisissez l'organe</p>"+<>ZCR
$THTML:=$THTML+"        <div class="+<>ZGuil+"cac2"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+" id="+<>ZGuil+"organe"+<>ZGuil+">"+<>ZCR
DISTINCT VALUES:C339([DiaData:45]XTexte:7;$TbOrgane)
SORT ARRAY:C229($TbOrgane;>)
$FT:=Size of array:C274($TbOrgane)
For ($Salé;1;$FT)
	$Checked:=Num:C11($TbOrgane{$Salé}="Foie")*(" checked="+<>ZGuil+""+<>ZGuil)
	$THTML:=$THTML+"           <input type="+<>ZGuil+"radio"+<>ZGuil+" class="+<>ZGuil+"casorg"+<>ZGuil+" id="+<>ZGuil+"anato"+$TbOrgane{$Salé}+<>ZGuil
	$THTML:=$THTML+" name="+<>ZGuil+"organe"+<>ZGuil+$Checked+" />"+$TbOrgane{$Salé}+"<br />"+<>ZCR
End for 
$THTML:=$THTML+"          </p> "+<>ZCR
$THTML:=$THTML+"        </div>"+<>ZCR2
$THTML:=$THTML+"    </div>"+<>ZCR2  // fin de div id="pavespeceorgane"

$THTML:=$THTML+"    <div id="+<>ZGuil+"pavephotos"+<>ZGuil+" class="+<>ZGuil+"pavephotos"+<>ZGuil+">"+<>ZCR
QUERY SELECTION:C341([DiaData:45];[DiaData:45]XTexte:7="Foie")

$THTML:=$THTML+DiaEcritHTMLPhotoOrganeSain 
$THTML:=$THTML+"    </div>"+<>ZCR
WEB SEND TEXT:C677($THTML)
