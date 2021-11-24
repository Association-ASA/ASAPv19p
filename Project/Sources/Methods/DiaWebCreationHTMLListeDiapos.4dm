//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 24/07/16, 16:19:04
// ----------------------------------------------------
// Méthode : WebCreationHTMLListeDiapos
// Description
//   Méthode qui écrit le HTML de la liste des photos
//  de la sélection de [Diapositives]
// Paramètre : $1= initiale de la langue courante
// ----------------------------------------------------

C_LONGINT:C283($Salé; $FT)

$Langue:=$1
$Caract:=DiaWebTraduitTexte("Caractéristiques de la photo"; $Langue)
$Detail:=DiaWebTraduitTexte("Détail"; $Langue)

SELECTION TO ARRAY:C260([Diapositives:40]NumOrdreDiapos:1; $TbNumDiapo\
; [Diapositives:40]NomLesion:4; $TbNomLesion\
; [Diapositives:40]Organe:2; $TbNomOrgane\
; [Diapositives:40]Espece:3; $TbNomEspece)
$FT:=Size of array:C274($TbNumDiapo)
$THTML:=""
$THTML:=$THTML+"      <table id="+<>ZGuil+"TbLes"+<>ZGuil+" class="+<>ZGuil+"TbRes"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"        <thead class="+<>ZGuil+"TbETG"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"         <tr class="+<>ZGuil+"TbETL"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"           <th class="+<>ZGuil+"TbETC1"+<>ZGuil+"> N°</th>"+<>ZCR
$THTML:=$THTML+"           <th class="+<>ZGuil+"TbETC2"+<>ZGuil+">"+$Caract+"</th>"+<>ZCR
$THTML:=$THTML+"           <th class="+<>ZGuil+"TbETC1"+<>ZGuil+">"+$Detail+"</th>"+<>ZCR
$THTML:=$THTML+"         </tr>"+<>ZCR
$THTML:=$THTML+"        </thead>"+<>ZCR
$THTML:=$THTML+"        <tbody>"+<>ZCR
// Ad3TraducFabriqueTb
For ($Salé; 1; $FT)
	$NumDiapoA:=String:C10($TbNumDiapo{$Salé})
	$VarNomLes:=DiaWebTraduitLesion($TbNomLesion{$Salé}; $Langue)
	If ($Langue="F")
		$VarNomLes:=Replace string:C233($VarNomLes; " (lésions de)"; "")
	Else 
		$VarNomLes:=Replace string:C233($VarNomLes; " (lesions associated with)"; "")
	End if 
	$VarEspece:=DiaWebTraduitTexte($TbNomEspece{$Salé}; $Langue)
	$VarOrgane:=DiaWebTraduitTexte($TbNomOrgane{$Salé}; $Langue)
	$L:=Find in array:C230(<>TbNumDia; $TbNumDiapo{$Salé})
	$VarTriplette:=DiaWebAfficheTriplette($L; $Langue)
	$pair:=(Num:C11($Salé%2=1)*"even")+(Num:C11($Salé%2=0)*"odd")
	$THTML:=$THTML+"          <tr id="+<>ZGuil+"dialigne"+$NumDiapoA+$Langue+<>ZGuil+"class="+<>ZGuil+"TbCorpsL "+$pair+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"            <td class="+<>ZGuil+"TbCorpsC1 "+$pair+<>ZGuil+">"+$NumDiapoA+"</td>"+<>ZCR
	$THTML:=$THTML+"            <td class="+<>ZGuil+"TbCorpsC2 "+$pair+<>ZGuil+">"+$VarTriplette+"</td>"+<>ZCR
	$THTML:=$THTML+"            <td class="+<>ZGuil+"tbdetail "+$pair+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"              <img id="+<>ZGuil+"diadetail"+$NumDiapoA+$Langue+<>ZGuil+" title="+<>ZGuil+$Detail+<>ZGuil
	$THTML:=$THTML+" class="+<>ZGuil+"detailles"+<>ZGuil+" alt="+<>ZGuil+$Detail+<>ZGuil+" src="+<>ZGuil+"images/detail.PNG"+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"            </td>"+<>ZCR
	$THTML:=$THTML+"          </tr>"+<>ZCR
End for 
$THTML:=$THTML+"        </tbody>"+<>ZCR
$THTML:=$THTML+"      </table>"+<>ZCR
$THTML:=$THTML+"          <br /><br /><br />"+<>ZCR
$0:=$THTML