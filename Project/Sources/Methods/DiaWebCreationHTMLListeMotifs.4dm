//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 11/08/16, 05:55:47
// ----------------------------------------------------
// Méthode : WebCreationHTMLListeMotifs
// Description
//  Ecrit la div qui contient la liste des motifs de saisie
//
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT)
SELECTION TO ARRAY:C260([DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1; $TbNomLesion; [DiaMotifSaisieDGAL:42]Ordre:10; $TbNumLesion)
$FT:=Records in selection:C76([DiaMotifSaisieDGAL:42])
$FTA:=String:C10($FT)
$THTML:=""
SORT ARRAY:C229($TbNomLesion; $TbNumLesion; >)
$THTML:=$THTML+"        <table id="+<>ZGuil+"TbLes"+<>ZGuil+" class="+<>ZGuil+"TbRes"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"          <thead class="+<>ZGuil+"TbETG"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"           <tr class="+<>ZGuil+"TbETL"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"             <th class="+<>ZGuil+"TbETC1"+<>ZGuil+"> N°</th>"+<>ZCR
$THTML:=$THTML+"             <th class="+<>ZGuil+"TbETC2"+<>ZGuil+">Motif de saisie</th>"+<>ZCR
$THTML:=$THTML+"             <th class="+<>ZGuil+"TbETC1"+<>ZGuil+">Détail</th>"+<>ZCR
$THTML:=$THTML+"           </tr>"+<>ZCR
$THTML:=$THTML+"          </thead>"+<>ZCR

// Corps du tableau
For ($Salé; 1; $FT)
	$pair:=(Num:C11($Salé%2=1)*"even")+(Num:C11($Salé%2=0)*"odd")
	$LigneA:=String:C10($TbNumLesion{$Salé})
	$THTML:=$THTML+"  <tr id="+<>ZGuil+"ligne"+$LigneA+<>ZGuil+"class="+<>ZGuil+"TbCorpsL "+$pair+<>ZGuil+">"+<>ZCR  // Ligne
	// 3 Colonnes : N°, nom de la lésion, détail
	$THTML:=$THTML+"    <td class="+<>ZGuil+"TbCorpsC1 "+$pair+<>ZGuil+">"
	$THTML:=$THTML+String:C10($TbNumLesion{$Salé})
	$THTML:=$THTML+"    </td>"+<>ZCR
	$THTML:=$THTML+"    <td class="+<>ZGuil+"TbCorpsC2 "+$pair+<>ZGuil+">"
	//$NomLesionAffiche:=Remplacer chaîne($TbNomLesion{$Salé};$SupLesion;"")
	$THTML:=$THTML+$TbNomLesion{$Salé}
	$THTML:=$THTML+"    </td>"+<>ZCR
	$THTML:=$THTML+"    <td class="+<>ZGuil+"tbdetail "+$pair+<>ZGuil+">"+<>ZCR
	$THTML:=$THTML+"      <img id="+<>ZGuil+"motifdetail"+$LigneA+<>ZGuil+" title="+<>ZGuil+"détail"+<>ZGuil+" class="+<>ZGuil+"detailles"+<>ZGuil
	$THTML:=$THTML+" alt="+<>ZGuil+"detail"+<>ZGuil+" src="+<>ZGuil+"images/detail.PNG"+<>ZGuil+" />"+<>ZCR
	$THTML:=$THTML+"    </td>"+<>ZCR
	$THTML:=$THTML+"  </tr>"+<>ZCR2  // fin de ligne
End for 

$THTML:=$THTML+"              "+<>ZCR
$THTML:=$THTML+"</table>"+<>ZCR
$0:=$THTML