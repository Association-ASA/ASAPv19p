//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 12/12/17, 07:07:00
// ----------------------------------------------------
// Méthode : WebCreationHTMLListePaniers
// Description
// Méthode de création du tableau des paniers
// Paramètre : $1= langue {$2} si réponse AJAX
// ----------------------------------------------------

C_LONGINT:C283($Salé; $FT)

$Langue:=$1
SELECTION TO ARRAY:C260([DiaData:45]XNom:1; $TbNomPanier; [DiaData:45]XType:5; $TbIntiales)
LONGINT ARRAY FROM SELECTION:C647([DiaData:45]; $tbNumEnrPaniers)
$FT:=Size of array:C274($TbNomPanier)
If (Count parameters:C259=1)
	$THTML:=""
Else 
	$THTML:=String:C10($FT)+"£ "
End if 
$THTML:=$THTML+"       <table id="+<>ZGuil+"TbLes"+<>ZGuil+" class="+<>ZGuil+"TbRes"+<>ZGuil+">"+<>ZCR
// L'ET du tableau
$THTML:=$THTML+"         <thead class="+<>ZGuil+"TbETG"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"          <tr class="+<>ZGuil+"TbETL"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"            <th class="+<>ZGuil+"TbETC1"+<>ZGuil+">"+DiaWebTraduitTexte("Initiales"; $Langue)+"</th>"+<>ZCR
$THTML:=$THTML+"            <th class="+<>ZGuil+"TbETC2"+<>ZGuil+">"+DiaWebTraduitTexte("Nom du panier"; $Langue)+"</th>"+<>ZCR
$THTML:=$THTML+"            <th class="+<>ZGuil+"TbETC1"+<>ZGuil+">"+DiaWebTraduitTexte("Détail"; $Langue)+"</th>"+<>ZCR
$THTML:=$THTML+"          </tr>"+<>ZCR
$THTML:=$THTML+"         </thead>"+<>ZCR2

// Les lignes du tableau
For ($Salé; 1; $FT)
	$pairimpair:=(Num:C11($Salé%2=1)*"odd")+(Num:C11($Salé%2=0)*"even")
	$THTML:=$THTML+"         <tr id="+<>ZGuil+"ligne"+String:C10($tbNumEnrPaniers{$Salé})+<>ZGuil+"class="+<>ZGuil+"TbCorpsL "+$pairimpair+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"           <td class="+<>ZGuil+"TbCorpsC1 "+$pairimpair+<>ZGuil+">"+$TbIntiales{$Salé}+"</td>"+<>ZCR
	$THTML:=$THTML+"           <td class="+<>ZGuil+"TbCorpsC2 "+$pairimpair+<>ZGuil+">"+$TbNomPanier{$Salé}+"</td>"+<>ZCR
	$THTML:=$THTML+"           <td class="+<>ZGuil+"tbdetail "+$pairimpair+<>ZGuil+">"+<>ZCR
	$Title:=DiaWebTraduitTexte("voir le contenu"; $Langue)
	$THTML:=$THTML+"             <img id="+<>ZGuil+"panierdetail"+String:C10($tbNumEnrPaniers{$Salé})+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil
	$THTML:=$THTML+" class="+<>ZGuil+"detailles"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" src="+<>ZGuil+"images/detail.PNG"+<>ZGuil+" />"+<>ZCR2
	$Title:=DiaWebTraduitTexte("descriptif du panier"; $Langue)
	$THTML:=$THTML+"             <img id="+<>ZGuil+"paniervoir"+String:C10($tbNumEnrPaniers{$Salé})+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil
	$THTML:=$THTML+" class="+<>ZGuil+"detailles"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" src="+<>ZGuil+"images/Modif panier.png"+<>ZGuil+" />"+<>ZCR2
	$Title:=DiaWebTraduitTexte("partager le panier"; $Langue)
	$THTML:=$THTML+"             <img id="+<>ZGuil+"panierenvoyer"+String:C10($tbNumEnrPaniers{$Salé})+<>ZGuil+" title="+<>ZGuil+$Title+<>ZGuil
	$THTML:=$THTML+" class="+<>ZGuil+"detailles"+<>ZGuil+" alt="+<>ZGuil+$Title+<>ZGuil+" src="+<>ZGuil+"images/Export panier.png"+<>ZGuil+" />"+<>ZCR
	
	$THTML:=$THTML+"           </td>"+<>ZCR
	$THTML:=$THTML+"         </tr>"+<>ZCR2
End for 
$THTML:=$THTML+"       </table>"+<>ZCR
$0:=$THTML