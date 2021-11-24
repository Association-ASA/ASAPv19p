//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 04/01/16, 13:50:33
  // ----------------------------------------------------
  // Méthode : WebAfficheInfos
  // Description
  // Affiche les informations sur la photo en grand
  // Traitement AJAX de la chaine "Fmetlesinfos"+ x +"numphoto"
  // x = "c" pour commentaire, "f" pour fiche réflexe,
  // "l" pour description de la lésion, "n" pour ne pas confondre
  // "r" pour la réglementation, "s" pour anapath spéciale
  // Paramètre : $1 = chaine AJAX  type Fmetlesinfosp30704_mailvisiteur
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT)

$Mess:=$1
$Langue:=$Mess[[1]]
$TypeCom:=$Mess[[13]]
$NumImage:=Num:C11(Substring:C12($Mess;13))  // élimination de "metlesfleches"
NumImageA:=String:C10($NumImage)
QUERY:C277([Diapositives:40];[Diapositives:40]NumOrdreDiapos:1=$NumImage)
RELATE ONE:C42([Diapositives:40]NomLesion:4)  // Charge l'enregistrement de [Lesions]
$LLes:=Find in array:C230(<>TbNumLesN;[DiaLesions:44]NumLesion:18)
$LDia:=Find in array:C230(<>TbDiaposNumOrdreDiapos;[Diapositives:40]NumOrdreDiapos:1)
  // Ad3TraducFabriqueTb
$envoi:=""
Case of 
	: ($TypeCom="c")  // "c" pour commentaire
		$PtTb:=Get pointer:C304("<>TbDiaposCom"+$Langue)
		$Com:=$PtTb->{$LDia}
		$envoi:="<b>"+DiaWebTraduitTexte ("Description macroscopique";$Langue)+" ("+DiaWebTraduitTexte ("photo";$Langue)+" "+String:C10($NumImage)+")</b> :"+<>ZCR+$Com
		
	: ($TypeCom="f")  // "f" pour fiche réflexe
		$PtTb:=Get pointer:C304("<>TbFR"+$Langue)
		$Com:=$PtTb->{$LLes}
		$envoi:="<b>"+DiaWebTraduitTexte ("Fiche réflexe";$Langue)+"</b>:"+<>ZCR+$Com
		
	: ($TypeCom="l")  // "l" pour description de la lésion
		$PtTb:=Get pointer:C304("<>TbDM"+$Langue)
		$Com:=$PtTb->{$LLes}
		$envoi:="<b>"+DiaWebTraduitTexte ("Description de la lésion";$Langue)+"</b>:"+<>ZCR+$Com
		
	: ($TypeCom="n")  // "n" pour ne pas confondre
		$NPC:=[Diapositives:40]NPC:14
		ARRAY TEXT:C222($TbNPC;0)
		ZTexteVersTableau ($NPC;->$TbNPC)
		$Com:=""
		$FT:=Size of array:C274($TbNPC)
		$PtTb:=Get pointer:C304("<>TbNL"+$Langue)
		For ($Salé;1;$FT)
			$L:=Find in array:C230(<>TbNLF;$TbNPC{$Salé})
			If ($L>0)
				$Com:=$Com+$PtTb->{$L}+"<br />"+<>ZCR
			End if 
		End for 
		$bouton:=""
		If ($Langue="F")
			QUERY:C277([DiaData:45];[DiaData:45]XType:5="NPC";*)
			QUERY:C277([DiaData:45];[DiaData:45]XNom:1=String:C10($NumImage))
			If ([DiaData:45]XTexteSup:8#"")
				  //si(Enregistrements trouvés([XDonnees])>0)
				$bouton:="      <p class="+<>ZGuil+"boutonnpcgi"+<>ZGuil+">"
				$bouton:=$bouton+"         <button id="+<>ZGuil+"boutonnpc"+String:C10($NumImage)+<>ZGuil+" class="+<>ZGuil+"cac2"+<>ZGuil+">"
				$bouton:=$bouton+"Aller à la page Ne Pas Confondre</button>"
				$bouton:=$bouton+"      </p>"
			End if 
		End if 
		$envoi:="<b>"+DiaWebTraduitTexte ("Ne pas confondre avec";$Langue)+"</b>:"+<>ZCR+$Com+$bouton
		
		
		
	: ($TypeCom="r")  // "r" pour la réglementation
		$Com:=DiaWebTraduitTexte ([DiaLesions:44]ReferenceReglementaireUE:17;$Langue)
		$envoi:="<b>"+DiaWebTraduitTexte ("Références réglementaires";$Langue)+"</b>:"+<>ZCR+$Com
		
		
	: ($TypeCom="s")  // "s" pour anapath spéciale
		QUERY:C277([DiaTextesWebParagraphes:37];[DiaTextesWebParagraphes:37]NomEspece:2=[Diapositives:40]Espece:3;*)
		QUERY:C277([DiaTextesWebParagraphes:37]; & [DiaTextesWebParagraphes:37]NomOrgane:3=[Diapositives:40]Organe:2;*)
		QUERY:C277([DiaTextesWebParagraphes:37]; & [DiaTextesWebParagraphes:37]NomLesion:10=[DiaLesions:44]NomLesion:1)
		$envoi:="<b>Description d'anatomie pathologique spéciale </b>:"+<>ZCR+[DiaTextesWebParagraphes:37]CorpsParagraphe:8
		
	: ($TypeCom="p")  // "p" pour panier
		$Pos:=Position:C15("_";$Mess)
		$Login:=Substring:C12($Mess;($Pos+1))
		$envoi:=DiaWebPanierFormNouvelleDia ("0";$Login;$Langue)
		
	: ($TypeCom="q")  // "q" pour faq
		$envoi:=""
		$envoi:="<div class="+<>ZGuil+"faqengrand"+<>ZGuil+">"+<>ZCR
		$envoi:=$envoi+" <span class="+<>ZGuil+"panierconsigne"+<>ZGuil+">"+<>ZCR
		$envoi:=$envoi+"   Pour envoyer une remarque à l'ASA concernant la page actuelle, remplissez le champ ci dessous et cliquez sur le bouton "
		$envoi:=$envoi+<>ZGuil+"Envoyer"+<>ZGuil+"."+<>ZCR
		$envoi:=$envoi+" </span>"+<>ZCR
		$envoi:=$envoi+"  <textarea name="+<>ZGuil+""+<>ZGuil+" id="+<>ZGuil+"comfaq"+<>ZGuil+" cols="+<>ZGuil+"55"+<>ZGuil+" rows="+<>ZGuil+"5"+<>ZGuil+"></textarea><br /><br />"+<>ZCR
		$envoi:=$envoi+"  <button class="+<>ZGuil+"adtitre1e"+<>ZGuil+" id="+<>ZGuil+"faqsumit"+<>ZGuil+">Envoyer</button>"
		$envoi:=$envoi+"</div>"+<>ZCR
End case 
If ($TypeCom#"p")
	$envoi:=Replace string:C233($envoi;<>ZCR;" <br/> ")
End if 
WEB SEND TEXT:C677($envoi)
ZAmnistieInternationale 