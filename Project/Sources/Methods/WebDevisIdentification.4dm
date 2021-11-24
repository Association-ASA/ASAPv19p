//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : MBPASA2015
// Date et heure : 11/12/16, 16:56:41
// ----------------------------------------------------
// Méthode : WebDevisIdentification
// Description
// Envoi AJAX du devis RaemaGel
//  type "devisid"+$('#numlabo').val()+"_"+$('#mdplabo').val();
// Paramètre $1=message AJAX
// ----------------------------------------------------

$Mess:=$1
If ($Mess="EC@")
	$Mess:=Substring:C12($Mess; 3)
	$DeEC:=True:C214
End if 

$Pos:=Position:C15("_"; $Mess)
$NumLaboA:=Substring:C12($Mess; 8; ($Pos-8))
$Mdp:=Substring:C12($Mess; ($Pos+1))
$L:=Find in array:C230(<>TbPerNumLaboRAEMAA; $NumLaboA)

Association:=<>TbPAAssociation{$L}
If (Association="@ADILVA@")
	Association:="Adilva"
Else 
	Association:="ASA"
End if 
If (<>TbPerIdentificateur{$L}=$mdp)
	$Retour:="<br /><p id="+<>ZGuil+"Association"+<>ZGuil+" class="+<>ZGuil+"textecentre "+Association+<>ZGuil+"> Bonjour, vous êtes identifé comme <b>"+<>TbPerNomLong{$L}+"</b></p>"
	$Retour:=$Retour+"     <br />"+<>ZCR
	$Retour:=$Retour+"     <p class="+<>ZGuil+"rougeencadre"+<>ZGuil+">Par défaut, le devis est pré-rempli avec la dernière commande envoyée à l'ASA, vous avez la possibilité de la modifier selon vos besoins.</p>"+<>ZCR
	$Retour:=$Retour+"     <br />"+<>ZCR
Else 
	$Retour:="<br />Désolé, nous ne parvenons pas à vous identifier"
End if 

If ($DeEC)
	$THTML:=$Retour+WebDevisEcritRGLabo($NumLaboA)
	$0:=$THTML
	
Else 
	$Retour:=$Retour+"£"+WebDevisEcritRGLabo($NumLaboA)
	WEB SEND TEXT:C677($Retour)
End if 
//Sinon 
//$THTML:="<br /><p class="+<>ZGuil+"RougeMargeGras"+<>ZGuil+">L'inscription aux campagnes RAEMA Gel n'est pas encore ouverte. L'ASA vous informera dès que le devis sera disponible.</p>"
//$0:=$THTML
//Fin de si 