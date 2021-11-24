//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 30/03/16, 10:29:49
// ----------------------------------------------------
// Méthode : WebEcritPageDiagnose
// Description
// Envoie la page d'index en tenant compte de la langue
// sélectionnée
// Paramètres : $1 = langue
//                               pour boucherie : F, A, R... en attendant mieux
//                               pour gibier : FZ = page diagnose spécifique
//    $2 = Vrai si on écrit tout et faux si on envoie que le corps
// ----------------------------------------------------

$Param1:=$1
$Langue:=$1[[1]]
$EcritTout:=$2

Gibier:=(Length:C16($Param1)=2)
If (Gibier)
	QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1>80000)
Else 
	QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1<80000)
End if 
DISTINCT VALUES:C339([Diapositives:40]MotifSaisieDGAL:23; $TbNomMotifsGibier)
DISTINCT VALUES:C339([Diapositives:40]Organe:2; $TbNomOrgane)
SORT ARRAY:C229($TbNomMotifsGibier; >)

$Russe:=(Num:C11($Langue="R")*"R")+(Num:C11(Gibier)*"G")
// Ad3FabriqueTbTraduc
$THTML:=""
$Title:=DiaWebTraduitTexte("Reconnaître une lésion"; $Langue)
If ($EcritTout)  // Bandeau y compris menus
	$Titre:=(Num:C11(Gibier)*("AsaDia Gibier"))+(Num:C11(Not:C34(Gibier))*$Title)
	VarPageAsaDia:="P1"
	$THTML:=$THTML+DiaWebCreationHTMLDebutPage($Langue; VarLogin; $Titre)
Else 
	$THTML:=$THTML+$Title+"£P1£"
End if 

// partie variable = id corps
//Si ($Langue="F")

$THTML:=$THTML+"<p class="+<>ZGuil+"adtitrepage"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+(5*" ")+DiaWebTraduitTexte("Reconnaître une lésion"; $Langue)+<>ZCR
$THTML:=$THTML+"   </p>"+<>ZCR
If (Gibier)
	$THTML:=$THTML+DiaWebCreationHTMLAide($Langue; 1; "AsaDiaGibierMdE")
Else 
	$THTML:=$THTML+DiaWebCreationHTMLAide($Langue; 1; "Diagnose")
End if 
//$THTML:=$THTML+"   <form method="+<>ZGuil+"post"+<>ZGuil+" action="+<>ZGuil+"mw2WebDiagnose"+$Langue+<>ZGuil+">"+<>ZCR
//Sinon
//$THTML:=$THTML+"<p class="+<>ZGuil+"adtitrepage"+<>ZGuil+">"+<>ZCR
//$THTML:=$THTML+"        Find a lesion"+<>ZCR
//$THTML:=$THTML+"   </p>"+<>ZCR
//$THTML:=$THTML+WebCreationHTMLAide ("DiagnoseA";1)
If ($Langue="F")  // Si (VarLogin="@.gouv.fr") | (VarLogin="cegeheme@wanadoo.fr")
	If (Gibier)
		$Title:="Aller sur la page diagnose animaux de boucherie"
		$Bestiole:="Vache"
	Else 
		$Title:="Aller sur la page diagnose gibier"
		$Bestiole:="Gibier"
	End if 
	$THTML:=$THTML+"   <form method="+<>ZGuil+"post"+<>ZGuil+" action="+<>ZGuil+"Page"+$Bestiole+VarLogin+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"     <input id="+<>ZGuil+"flagA"+<>ZGuil+" width="+<>ZGuil+"30px"+<>ZGuil+" type="+<>ZGuil+"image"+<>ZGuil
	$THTML:=$THTML+" src="+<>ZGuil+"images/Icone "+$Bestiole+".jpg"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"   </form> "+<>ZCR
End if 
$THTML:=$THTML+"      <br />"+<>ZCR
$THTML:=$THTML+"  <div id="+<>ZGuil+"paveautrequelesions"+<>ZGuil+" class="+<>ZGuil+"pavautrequelesions"+$Russe+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"     <p class="+<>ZGuil+"choixcritere"+<>ZGuil+">"+DiaWebTraduitTexte("Choisissez les espèces"; $Langue)+"</p>"+<>ZCR
$THTML:=$THTML+"        <div class="+<>ZGuil+"cac2"+<>ZGuil+">"+<>ZCR
If (Gibier)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac1"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+" class="+<>ZGuil+"casesp"
	$THTML:=$THTML+<>ZGuil+" id="+<>ZGuil+"bacce"+<>ZGuil+" name="+<>ZGuil+"Cerf"+<>ZGuil+" />Cerf</p>"+<>ZCR
	
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac1"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+" class="+<>ZGuil+"casesp"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"baccm"+<>ZGuil+" name="+<>ZGuil+"Chamois"+<>ZGuil+" />Chamois</p>"+<>ZCR
	
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac1"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+" class="+<>ZGuil+"casesp"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"baccl"+<>ZGuil+" name="+<>ZGuil+"Chevreuil"+<>ZGuil+" />Chevreuil</p>"+<>ZCR
	
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac1"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+" class="+<>ZGuil+"casesp"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacda"+<>ZGuil+" name="+<>ZGuil+"Daim"+<>ZGuil+" />Daim</p>"+<>ZCR
	
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac1"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+" class="+<>ZGuil+"casesp"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacmo"+<>ZGuil+" name="+<>ZGuil+"Mouflon"+<>ZGuil+" />Mouflon</p>"+<>ZCR
	
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac1"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+" class="+<>ZGuil+"casesp"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacsa"+<>ZGuil+" name="+<>ZGuil+"Sanglier"+<>ZGuil+" />Sanglier</p>"+<>ZCR
Else 
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac1"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+" class="+<>ZGuil+"casesp"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacbv"+<>ZGuil+" name="+<>ZGuil+"bovins"+<>ZGuil+" />"+DiaWebTraduitTexte("Bovins"; $Langue)+"</p>"+<>ZCR
	
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac1"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+" class="+<>ZGuil+"casesp"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacov"+<>ZGuil+" name="+<>ZGuil+"ovins"+<>ZGuil+" />"+DiaWebTraduitTexte("Ovins"; $Langue)+"</p>"+<>ZCR
	
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac1"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+" class="+<>ZGuil+"casesp"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacca"+<>ZGuil+" name="+<>ZGuil+"caprins"+<>ZGuil+" />"+DiaWebTraduitTexte("Caprins"; $Langue)+"</p>"+<>ZCR
	
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac1"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+" class="+<>ZGuil+"casesp"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacpo"+<>ZGuil+" name="+<>ZGuil+"porcins"+<>ZGuil+" />"+DiaWebTraduitTexte("Porcins"; $Langue)+"</p>"+<>ZCR
	
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac1"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+" class="+<>ZGuil+"casesp"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"baceq"+<>ZGuil+" name="+<>ZGuil+"équins"+<>ZGuil+" />"+DiaWebTraduitTexte("Equins"; $Langue)+"</p>"+<>ZCR
End if 
$THTML:=$THTML+"        </div>"+<>ZCR2
$THTML:=$THTML+"     <p class="+<>ZGuil+"choixcritere"+<>ZGuil+">"+DiaWebTraduitTexte("Choisissez les organes"; $Langue)+"</p>"+<>ZCR
$THTML:=$THTML+"       <p class="+<>ZGuil+"souschoixcritere"+<>ZGuil+">"+DiaWebTraduitTexte("Appareil digestif"; $Langue)+" : </p>"+<>ZCR
$THTML:=$THTML+"        <div class="+<>ZGuil+"cacesp"+<>ZGuil+">"+<>ZCR
If (Find in array:C230($TbNomOrgane; "langue")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+" class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"baclan"+<>ZGuil+" name="+<>ZGuil+"langue"+<>ZGuil+">"+DiaWebTraduitTexte("Langue"; $Langue)+"</input></p> "+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "oesophage")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+" class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacoes"+<>ZGuil+" name="+<>ZGuil+"oesophage"+<>ZGuil+">"+DiaWebTraduitTexte("Œsophage"; $Langue)+"</input></p>  "+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "tube digestif")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+" class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bactd"+<>ZGuil+" name="+<>ZGuil+"tube digestif"+<>ZGuil+">"+DiaWebTraduitTexte("Tube digestif"; $Langue)+"</input> </p>    "+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "foie")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+" class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacfoie"+<>ZGuil+" name="+<>ZGuil+"foie"+<>ZGuil+">"+DiaWebTraduitTexte("Foie"; $Langue)+"</input></p> "+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "pancreas")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+" class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacpan"+<>ZGuil+" name="+<>ZGuil+"pancreas"+<>ZGuil+">"+DiaWebTraduitTexte("Pancréas"; $Langue)+"</input></p> "+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "péritoine")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+" class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacpert"+<>ZGuil+" name="+<>ZGuil+"péritoine"+<>ZGuil+">"+DiaWebTraduitTexte("Péritoine"; $Langue)+"</input> </p>  "+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "fressure")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+" class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacfres"+<>ZGuil+" name="+<>ZGuil+"fressure"+<>ZGuil+">"+DiaWebTraduitTexte("Fressure"; $Langue)+" </input> </p> "+<>ZCR
End if 
$THTML:=$THTML+"        </div>"+<>ZCR2

$THTML:=$THTML+"       <p class="+<>ZGuil+"souschoixcritere"+<>ZGuil+">"+DiaWebTraduitTexte("Appareil respiratoire"; $Langue)+" :</p>"+<>ZCR
$THTML:=$THTML+"        <div class="+<>ZGuil+"cacesp"+<>ZGuil+"> "+<>ZCR
If (Find in array:C230($TbNomOrgane; "trachee")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bactrac"+<>ZGuil+" name="+<>ZGuil+"trachee"+<>ZGuil+" />"+DiaWebTraduitTexte("Trachée"; $Langue)+"</p> "+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "poumon")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacpou"+<>ZGuil+" name="+<>ZGuil+"poumon"+<>ZGuil+" />"+DiaWebTraduitTexte("Poumon"; $Langue)+"</p> "+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "plèvre")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacple"+<>ZGuil+" name="+<>ZGuil+"plèvre"+<>ZGuil+" />"+DiaWebTraduitTexte("Plèvre"; $Langue)+"</p> "+<>ZCR
End if 
$THTML:=$THTML+"        </div>"+<>ZCR2

$THTML:=$THTML+"       <p class="+<>ZGuil+"souschoixcritere"+<>ZGuil+">"+DiaWebTraduitTexte("Appareil circulatoire"; $Langue)+" : </p>"+<>ZCR
$THTML:=$THTML+"        <div class="+<>ZGuil+"cacesp"+<>ZGuil+">"+<>ZCR

If (Find in array:C230($TbNomOrgane; "coeur")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"baccoe"+<>ZGuil+" name="+<>ZGuil+"coeur"+<>ZGuil+" />"+DiaWebTraduitTexte("Cœur"; $Langue)+"</p> "+<>ZCR
End if 

If (Find in array:C230($TbNomOrgane; "péricarde")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacperc"+<>ZGuil+" name="+<>ZGuil+"péricarde"+<>ZGuil+" />"+DiaWebTraduitTexte("Péricarde"; $Langue)+"</p> "+<>ZCR
End if 

If (Find in array:C230($TbNomOrgane; "vaisseaux sanguins")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacvs"+<>ZGuil+" name="+<>ZGuil+"vaisseaux sanguins"+<>ZGuil+" />"+DiaWebTraduitTexte("Vaisseaux sanguins"; $Langue)+"</p> "+<>ZCR
End if 
$THTML:=$THTML+"        </div>"+<>ZCR2

$THTML:=$THTML+"       <p class="+<>ZGuil+"souschoixcritere"+<>ZGuil+">"+DiaWebTraduitTexte("Appareil ostéo-musculaire"; $Langue)+" :</p>"+<>ZCR
$THTML:=$THTML+"        <div class="+<>ZGuil+"cacesp"+<>ZGuil+">"+<>ZCR
If (Find in array:C230($TbNomOrgane; "os et articulation")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacos"+<>ZGuil+" name="+<>ZGuil+"os et articulation"+<>ZGuil+" />"+DiaWebTraduitTexte("Os et articulation"; $Langue)+"</p> "+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "muscles")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacmus"+<>ZGuil+" name="+<>ZGuil+"muscles"+<>ZGuil+" />"+DiaWebTraduitTexte("Muscles"; $Langue)+" </p> "+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "carcasse")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"baccar"+<>ZGuil+" name="+<>ZGuil+"carcasse"+<>ZGuil+" />"+DiaWebTraduitTexte("Carcasse"; $Langue)+" </p> "+<>ZCR
End if 
$THTML:=$THTML+"        </div>"+<>ZCR2

$THTML:=$THTML+"       <p class="+<>ZGuil+"souschoixcritere"+<>ZGuil+">"+DiaWebTraduitTexte("Appareil génito-urinaire"; $Langue)+" : </p>"+<>ZCR
$THTML:=$THTML+"        <div class="+<>ZGuil+"cacesp"+<>ZGuil+">"+<>ZCR
If (Find in array:C230($TbNomOrgane; "rein")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacrein"+<>ZGuil+" name="+<>ZGuil+"rein"+<>ZGuil+" />"+DiaWebTraduitTexte("Rein"; $Langue)+"</p> "+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "vessie")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacves"+<>ZGuil+" name="+<>ZGuil+"vessie"+<>ZGuil+" />"+DiaWebTraduitTexte("Vessie"; $Langue)+"</p> "+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "appareil génital femelle")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacagf"+<>ZGuil+" name="+<>ZGuil+"appareil génital femelle"+<>ZGuil+" />"+DiaWebTraduitTexte("Appareil génital femelle"; $Langue)+"</p> "+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "appareil génital mâle")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacagm"+<>ZGuil+" name="+<>ZGuil+"appareil génital mâle"+<>ZGuil+" />"+DiaWebTraduitTexte("Appareil génital mâle"; $Langue)+"</p>"+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "mamelle")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacmam"+<>ZGuil+" name="+<>ZGuil+"mamelle"+<>ZGuil+" />"+DiaWebTraduitTexte("Mamelle"; $Langue)+"</p>"+<>ZCR
End if 
$THTML:=$THTML+"        </div>"+<>ZCR2

$THTML:=$THTML+"       <p class="+<>ZGuil+"souschoixcritere"+<>ZGuil+">"+DiaWebTraduitTexte("Autres"; $Langue)+" :  </p>"+<>ZCR
$THTML:=$THTML+"        <div class="+<>ZGuil+"cacesp"+<>ZGuil+">"+<>ZCR
If (Find in array:C230($TbNomOrgane; "tissu conjonctivo-adipeux")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bactca"+<>ZGuil+" name="+<>ZGuil+"tissu conjonctivo-adipeux"+<>ZGuil+" />"+DiaWebTraduitTexte("Tissu conjonctivo-adipeux"; $Langue)+"</p>"+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "noeud lymphatique")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacnl"+<>ZGuil+" name="+<>ZGuil+"noeud lymphatique"+<>ZGuil+" />"+DiaWebTraduitTexte("Nœud lymphatique"; $Langue)+"</p>"+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "rate")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacrate"+<>ZGuil+" name="+<>ZGuil+"rate"+<>ZGuil+" />"+DiaWebTraduitTexte("Rate"; $Langue)+"</p>"+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "thymus")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacthym"+<>ZGuil+" name="+<>ZGuil+"thymus"+<>ZGuil+" />"+DiaWebTraduitTexte("Thymus"; $Langue)+"</p>"+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "oesophage")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bactet"+<>ZGuil+" name="+<>ZGuil+"tête"+<>ZGuil+" />"+DiaWebTraduitTexte("Tête"; $Langue)+"</p>"+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "tête")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacpeau"+<>ZGuil+" name="+<>ZGuil+"peau"+<>ZGuil+" />"+DiaWebTraduitTexte("Peau"; $Langue)+"</p>"+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "surrenales")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacsur"+<>ZGuil+" name="+<>ZGuil+"surrenales"+<>ZGuil+" />"+DiaWebTraduitTexte("Surrénales"; $Langue)+"</p>"+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "thyroide")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacthyr"+<>ZGuil+" name="+<>ZGuil+"thyroide"+<>ZGuil+" />"+DiaWebTraduitTexte("Thyroide"; $Langue)+"</p>"+<>ZCR
End if 
If (Find in array:C230($TbNomOrgane; "système nerveux")>0) | (Gibier=False:C215)
	$THTML:=$THTML+"          <p class="+<>ZGuil+"cac"+<>ZGuil+"><input type="+<>ZGuil+"checkbox"+<>ZGuil+"  class="+<>ZGuil+"casorg"+<>ZGuil
	$THTML:=$THTML+" id="+<>ZGuil+"bacsn"+<>ZGuil+" name="+<>ZGuil+"système nerveux"+<>ZGuil+" />"+DiaWebTraduitTexte("Système nerveux"; $Langue)+"</p>"+<>ZCR
End if 
$THTML:=$THTML+"        </div>"+<>ZCR2

$THTML:=$THTML+"      </div>"+<>ZCR2

$THTML:=$THTML+"      <div id="+<>ZGuil+"pavelesions"+<>ZGuil+" class="+<>ZGuil+"paveles"+$Russe+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <span class="+<>ZGuil+"choixcritere"+<>ZGuil+">"+DiaWebTraduitTexte("Choisissez les lésions"; $Langue)+"</span><br/>"+<>ZCR
If ($Langue="F")
	//  $Visible:=Num(Gibier)*(" style="+<>ZGuil+"display: none;"+<>ZGuil)
	$Visible:=""
	$THTML:=$THTML+"        <span class="+<>ZGuil+"textebanal"+<>ZGuil+$Visible+">"+<>ZCR
	$THTML:=$THTML+"          Nomenclature : <input type="+<>ZGuil+"radio"+<>ZGuil+" id="+<>ZGuil+"dgal"+<>ZGuil+" name="+<>ZGuil+"nom"+<>ZGuil+" value="+<>ZGuil+"operationnel"+<>ZGuil+" checked />réglementaire    "+<>ZCR
	$THTML:=$THTML+"          <input type="+<>ZGuil+"radio"+<>ZGuil+" id="+<>ZGuil+"asa"+<>ZGuil+" name="+<>ZGuil+"nom"+<>ZGuil+" value="+<>ZGuil+"scientifique"+<>ZGuil+" />anatomo-pathologique <br />"+<>ZCR
	$THTML:=$THTML+"        </span>"+<>ZCR
End if 
$THTML:=$THTML+"        <div  id="+<>ZGuil+"criteres"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        "+<>ZCR
$THTML:=$THTML+"          <select class="+<>ZGuil+"textebanal"+<>ZGuil+" id="+<>ZGuil+"lesion"+<>ZGuil+" name="+<>ZGuil+"organe"+<>ZGuil+" size="+<>ZGuil+"50"+<>ZGuil+" width="+<>ZGuil+"380px"+<>ZGuil+" multiple>"+<>ZCR
If (gibier)
	$THTML:=$THTML+DiaWebEcritListelesions($Langue; ->$TbNomMotifsGibier)
Else 
	$THTML:=$THTML+DiaWebEcritListelesions($Langue)
End if 
$THTML:=$THTML+"          </select>"+<>ZCR
$THTML:=$THTML+"        </div>"+<>ZCR
$THTML:=$THTML+"      </div>"+<>ZCR
// Gestion des variantes
If (Gibier)  // décalage vers le bas pour permettre de voir le HTML malgré le nombre d'organe restreint
	$THTML:=$THTML+"<br /><br /><br /> "
Else 
	$THTML:=$THTML+"     <p id="+<>ZGuil+"typephoto"+<>ZGuil+"  class="+<>ZGuil+"textecentre"+<>ZGuil+"><br />"+<>ZCR
	$THTML:=$THTML+"        <span class="+<>ZGuil+"choixcritere"+<>ZGuil+">"+DiaWebTraduitTexte("Choisissez le type de photographie"; $Langue)+"</span>"+<>ZCR
	$THTML:=$THTML+"        <input type="+<>ZGuil+"radio"+<>ZGuil+" id="+<>ZGuil+"toutesdia"+<>ZGuil+" name="+<>ZGuil+"typephoto"+<>ZGuil+" value="+<>ZGuil+"toutes"+<>ZGuil+<>ZCR
	$THTML:=$THTML+"               title="+<>ZGuil+DiaWebTraduitTexte("Sélectionne, selon les critères, parmi toutes les photographies d'AsaDia"; $Langue)+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"        "+DiaWebTraduitTexte("Toutes les photographies"; $Langue)+"      "+<>ZCR
	$THTML:=$THTML+"        <input type="+<>ZGuil+"radio"+<>ZGuil+" id="+<>ZGuil+"sansvariantedia"+<>ZGuil+" name="+<>ZGuil+"typephoto"+<>ZGuil+" value="+<>ZGuil+"sansvariante"+<>ZGuil+" checked"+<>ZCR
	$THTML:=$THTML+"               title="+<>ZGuil+DiaWebTraduitTexte("Sélectionne, selon les critères, seulement parmi les photographies d'aspect très caractéristique de la lésion"; $Langue)+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"        "+DiaWebTraduitTexte("Sans les variantes"; $Langue)+"      "+<>ZCR
	$THTML:=$THTML+"        <input type="+<>ZGuil+"radio"+<>ZGuil+" id="+<>ZGuil+"seulementvariantesdia"+<>ZGuil+" name="+<>ZGuil+"typephoto"+<>ZGuil+" value="+<>ZGuil+"variante"+<>ZGuil+<>ZCR
	$THTML:=$THTML+"               title="+<>ZGuil+DiaWebTraduitTexte("Sélectionne, selon les critères, seulement parmi les photographies d'aspect peu caractéristique de la lésion"; $Langue)+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"        "+DiaWebTraduitTexte("Que les variantes"; $Langue)+<>ZCR
	$THTML:=$THTML+"        <br />"+<>ZCR
	$THTML:=$THTML+"      </p>"+<>ZCR
End if 

// Appel des images par n°
If ($Langue="F") & (Gibier=False:C215)
	$THTML:=$THTML+"     <p class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"        <span class="+<>ZGuil+"choixcritere"+<>ZGuil+">"+"Appeler des photographies par leurs n°"+"</span>"+<>ZCR
	$THTML:=$THTML+"        <input type="+<>ZGuil+"text"+<>ZGuil+" id="+<>ZGuil+"trouveparnum"+<>ZGuil+" name="+<>ZGuil+"trouveparnum"+<>ZGuil+" value="+<>ZGuil+""+<>ZGuil+<>ZCR
	$THTML:=$THTML+"               title="+<>ZGuil+"Ajoute les photographies désignées par leurs numéros séparés par un espace"+<>ZGuil+" size="+<>ZGuil+"75"+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"      </p>"+<>ZCR
End if 

$THTML:=$THTML+"      <!-- Le cadre où se trouve la formule et le résultat de la recherche    -->"+<>ZCR
$THTML:=$THTML+"      <p id="+<>ZGuil+"formule"+<>ZGuil+" class="+<>ZGuil+"resrech"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      </p>"+<>ZCR
$THTML:=$THTML+"      "+<>ZCR
$THTML:=$THTML+"      <!-- Le paragraphe où se trouve le bouton de visualisation des photographies    -->"+<>ZCR
$THTML:=$THTML+"      <p id="+<>ZGuil+"boutonvoir"+<>ZGuil+" class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"          <button id="+<>ZGuil+"bouvisenombreuse"+<>ZGuil+" class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"+DiaWebTraduitTexte("Voir les photographies"; $Langue)+"</button>"+<>ZCR
$THTML:=$THTML+"      </p>"+<>ZCR
$THTML:=$THTML+"      "+<>ZCR
$THTML:=$THTML+"      <!-- La division où se trouve le tableau des résultats de recherche    -->"+<>ZCR
$THTML:=$THTML+"      <div id="+<>ZGuil+"tbphotos"+<>ZGuil+" class="+<>ZGuil+"tbphotos"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      </div>"+<>ZCR
$THTML:=$THTML+"      <!-- La division où se trouve la liste des images si < 20    -->"+<>ZCR
$THTML:=$THTML+"      <div id="+<>ZGuil+"trieusephotos"+<>ZGuil+" class="+<>ZGuil+"trieuse"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"      </div>"+<>ZCR
If ($Langue="F")
	$THTML:=$THTML+"     <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/dataTableF.js"+<>ZGuil+"></script><!-- jQuery dataTable    -->"+<>ZCR
Else 
	$THTML:=$THTML+"     <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/dataTableE.js"+<>ZGuil+"></script><!-- jQuery dataTable    -->"+<>ZCR
End if 
$THTML:=$THTML+"     <script type="+<>ZGuil+"text/javascript"+<>ZGuil+" src="+<>ZGuil+"js/asadiaP1.js"+<>ZGuil+"></script> <!-- jQuery AsaDia    -->"+<>ZCR
$THTML:=$THTML+"     <script src="+<>ZGuil+"js/multiple-select.js"+<>ZGuil+"></script>"+<>ZCR
$THTML:=$THTML+"     <script>"+<>ZCR
$THTML:=$THTML+"       $('select').multipleSelect({"+<>ZCR
$THTML:=$THTML+"         isOpen: true,"+<>ZCR
$THTML:=$THTML+"         keepOpen: true,"+<>ZCR
$THTML:=$THTML+"         width: 550"+<>ZCR
$THTML:=$THTML+"        });"+<>ZCR
$THTML:=$THTML+"     </script>"+<>ZCR



If ($EcritTout)  //  Partie fixe du pied
	$Pied:=DiaWebCreationHTMLPiedPage($Langue)
	$THTML:=$THTML+<>ZCR+$Pied
End if 
WEB SEND TEXT:C677($THTML)
// FIXER TEXTE DANS CONTENEUR($THTML)




