//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 30/08/18, 09:39:08
// ----------------------------------------------------
// Méthode : WebEnvoiFaq
// Description
//
//
// Paramètre : $1 = message AJAX de type
//   'faqreception'+'Liste des photographies§ 1693 lésions sur un total de 1693'
// + '£' + 'cegeheme@wanadoo.fr
// + '£' +Ca met 1000 ans à apparaître'
// ----------------------------------------------------

$Mess:=$1
$Mess:=Substring:C12($Mess; 13)  // elimination de 'faqreception'
$Pos:=Position:C15("£"; $Mess)
$Contexte:=Substring:C12($Mess; 1; ($Pos-1))
$Pos2:=Position:C15("§"; $Contexte)
If ($Pos2>0)
	$Page:=Substring:C12($Contexte; 1; ($Pos2-1))
	$Information:=Substring:C12($Contexte; ($Pos2+1))
	$Contexte:=Replace string:C233($Contexte; "§"; " :")
Else 
	$Page:=$Contexte
	$Information:=""
End if 
$Mess:=Substring:C12($Mess; ($Pos+1))

$Pos:=Position:C15("£"; $Mess)
$Mail:=Substring:C12($Mess; 1; ($Pos-1))
$Question:=Substring:C12($Mess; ($Pos+1))

// stockage du message
CREATE RECORD:C68([DiaData:45])
[DiaData:45]XType:5:="Retour"
[DiaData:45]XNom:1:=$Page
[DiaData:45]XAlpha:14:=$Mail
[DiaData:45]XTexte:7:=$Question
[DiaData:45]XTexteSup:8:=$Information
[DiaData:45]XDate:3:=Current date:C33
[DiaData:45]XHeure:13:=Current time:C178
SAVE RECORD:C53([DiaData:45])

// envoi du mail

$Sujet:="Retour AsaDia de "+$Mail
$Corps:=$Sujet+" dans le contexte "+$Contexte+<>ZCR+"Le message est :"+<>ZCR+$Question
$Corps:=$Corps+Char:C90(10)+Char:C90(10)+"--"+Char:C90(10)+"Le site Web de l'ASA"
$email:=New object:C1471
$email.to:="cegeheme@wanadoo.fr"
$email.from:="asadiaweb@orange.fr"
$email.subject:=$Sujet
$email.textBody:=$Corps
$status:=YEnvoiMailTransporter($email)  // Envoi du message
//TABLEAU TEXTE($TbDest;1)
//$TbDest{1}:="claude.grandmontagne@gmail.com"
//$OK:=ZMailEnvoiUnMail ("mail.ajar.ch";"cegeheme@wanadoo.fr";$Corps;"cegeheme@wanadoo.fr";->$TbDest;$Sujet)
WEB SEND TEXT:C677("OK")
