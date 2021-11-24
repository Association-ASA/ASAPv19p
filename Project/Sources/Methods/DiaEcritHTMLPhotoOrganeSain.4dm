//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : MBPASA2015
// Date et heure : 30/09/21, 14:28:11
// ----------------------------------------------------
// Méthode : DiaEcritHTMLPhotoOrganeSain
// Description
// Méthode qui écrit le HTML de la partie photo
//  dans l'écran des organes sains
//  à partir d'une sélection de [DiaData] OrganeSainGibier
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT)
ARRAY OBJECT:C1221($TbObjet; 0)
SELECTION TO ARRAY:C260([DiaData:45]XNom:1; $TbNomFichier\
; [DiaData:45]XObjet:15; $TbObjet\
; [DiaData:45]XTexte:7; $TbOrgane\
; [DiaData:45]XTexteSup:8; $TbCom)
$THTML:=""
$THTML:=$THTML+"        <input type="+<>ZGuil+"hidden"+<>ZGuil+" id="+<>ZGuil+"languecourante"+<>ZGuil+" value="+<>ZGuil+"F"+<>ZGuil+" />"+<>ZCR
If (Size of array:C274($TbNomFichier)=0)
	$THTML:=$THTML+"        <p class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"         Aucune photo n'est disponible pour cet organe dans cette espèce"+<>ZCR
	$THTML:=$THTML+"       </p>"+<>ZCR
Else 
	If (Size of array:C274($TbNomFichier)>1)
		$THTML:=$THTML+"        <p class="+<>ZGuil+"textecentre"+<>ZGuil+">"+<>ZCR
		$THTML:=$THTML+"         Cliquez sur la photographie pour l’afficher et voir les éléments de la diagnose"+<>ZCR
		$THTML:=$THTML+"       </p>"+<>ZCR
		$FT:=Size of array:C274($TbNomFichier)
		$THTML:=$THTML+"       <div id="+<>ZGuil+"npcpetitesphotos"+<>ZGuil+" class="+<>ZGuil+"textecentre interligne1"+<>ZGuil+">"+<>ZCR
		For ($Salé; 2; $FT)
			$NomFichierSansExtension:=Substring:C12($TbNomFichier{$Salé}; 1; Length:C16($TbNomFichier{$Salé})-4)
			
			$Précision:=OB Get:C1224($TbObjet{$Salé}; "PrécisionOrgane"; Est un texte:K8:3)
			$THTML:=$THTML+"         <div id="+<>ZGuil+"npcphotos"+String:C10($Salé)+<>ZGuil+" class="+<>ZGuil+"npcpetitephoto"+<>ZGuil+">"+<>ZCR  // 
			$THTML:=$THTML+"           <img src="+<>ZGuil+"PhotosAsaDia/"+$NomFichierSansExtension+"is.jpg"+<>ZGuil+" alt="+<>ZGuil+$Précision+<>ZGuil
			$THTML:=$THTML+" width="+<>ZGuil+"160px"+<>ZGuil+" id="+<>ZGuil+"anatphoto"+String:C10($Salé)+<>ZGuil
			$THTML:=$THTML+" com="+<>ZGuil+$TbCom{$Salé}+<>ZGuil+" /><br />"+<>ZCR
			$THTML:=$THTML+"           <i id="+<>ZGuil+"comanatphoto"+String:C10($Salé)+<>ZGuil+">"+$Précision+"</i>"+<>ZCR
			$THTML:=$THTML+"         </div>"+<>ZCR
		End for 
		$THTML:=$THTML+"       </div>"+<>ZCR
	End if 
	$THTML:=$THTML+"       <div class="+<>ZGuil+"grandephotonormale"+<>ZGuil+">"+<>ZCR
	$Précision:=OB Get:C1224($TbObjet{1}; "PrécisionOrgane"; Est un texte:K8:3)
	$NomFichierSansExtension:=Substring:C12($TbNomFichier{1}; 1; Length:C16($TbNomFichier{1})-4)
	$THTML:=$THTML+"         <img src="+<>ZGuil+"PhotosAsaDia/"+$NomFichierSansExtension+"i.jpg"+<>ZGuil+" alt="+<>ZGuil+$Précision+<>ZGuil
	$THTML:=$THTML+" class="+<>ZGuil+"photoasadia imageenliste"+<>ZGuil+" id="+<>ZGuil+"grandephotoanat"+<>ZGuil
	$THTML:=$THTML+" width="+<>ZGuil+"630px"+<>ZGuil+" com="+<>ZGuil+$TbCom{1}+<>ZGuil+"/><br />"+<>ZCR
	$THTML:=$THTML+"         <i id="+<>ZGuil+"comphoto"+<>ZGuil+">"+$TbCom{1}+"</i>"+<>ZCR
	$THTML:=$THTML+"       </div>"+<>ZCR
End if 
$0:=$THTML