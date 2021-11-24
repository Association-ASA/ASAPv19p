//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 18/07/16, 08:28:05
  // ----------------------------------------------------
  // Méthode : WebCreationHTMLListeLesions
  // Description
  //  Ecrit la div qui contient la liste des lésions
  //
  // Paramètres : $1 = initiale de la langue concernée
  //                      {$2} = si existe, concerne une liste tronquée
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)
C_TEXT:C284($Langue)

SELECTION TO ARRAY:C260([DiaLesions:44]NumLesion:18;$TbNumLesionF)
ORDER BY:C49([DiaLesions:44];[DiaLesions:44]NomLesion:1;>)

ARRAY TEXT:C222($TbNLF;0)
ARRAY TEXT:C222($TbNLE;0)
ARRAY TEXT:C222($TbDMF;0)
ARRAY TEXT:C222($TbDME;0)
ARRAY TEXT:C222($TbFRF;0)
ARRAY TEXT:C222($TbFRE;0)
ARRAY TEXT:C222($TbNomLesActuel;0)
ARRAY LONGINT:C221($TbNumLes;0)
$Langue:=$1

  // $A:=Num(Non($french))*"A"
$Nb:=Num:C11(Count parameters:C259=2)*(String:C10($FT)+"£ ")
$SupLesion:=DiaWebTraduitTexte ("lésions de";$Langue)
$ETNomLésion:=DiaWebTraduitTexte ("Nom de la lésion";$Langue)
$Detail:=DiaWebTraduitTexte ("Détail";$Langue)
$PtTbNomLésion:=Get pointer:C304("<>TbNL"+$Langue)
$FT:=Size of array:C274(<>TbNumLesN)

COPY ARRAY:C226(<>TbNumLesN;$TbNumLesN)
COPY ARRAY:C226($PtTbNomLésion->;$TbNomLesActuel)
SORT ARRAY:C229($TbNomLesActuel;$TbNumLesN;>)
ARRAY LONGINT:C221($TbNumLesNActuel;$FT)
$Compteur:=1
For ($Salé;1;$FT)
	$ValeurCourante:=$TbNomLesActuel{$Salé}
	If ($ValeurCourante="")
		$TbNumLesNActuel{$Salé}:=0
	Else 
		$TbNumLesNActuel{$Salé}:=$Compteur
		$Compteur:=$Compteur+1
	End if 
End for 
SORT ARRAY:C229($TbNomLesActuel;$TbNumLesNActuel;$TbNumLesN;>)

$THTML:=$Nb+"<table id="+<>ZGuil+"TbLes"+<>ZGuil+" class="+<>ZGuil+"TbRes"+<>ZGuil+">"+<>ZCR
  // ET du tableau
$THTML:=$THTML+"  <thead class="+<>ZGuil+"TbETG"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"   <tr class="+<>ZGuil+"TbETL"+<>ZGuil+">"+<>ZCR
$THTML:=$THTML+"     <th class="+<>ZGuil+"TbETC1"+<>ZGuil+"> N°</th>"+<>ZCR
  //Varitem:=(Num($french)*">Nom de la lésion</th>")+(Num(Non($french))*">Name of lesion</th>")
$THTML:=$THTML+"     <th class="+<>ZGuil+"TbETC2"+<>ZGuil+">"+$ETNomLésion+"</th>"+<>ZCR
  // Varitem:=(Num($french)*">Détail</th>")+(Num(Non($french))*">Detail</th>")
$THTML:=$THTML+"     <th class="+<>ZGuil+"TbETC1"+<>ZGuil+">"+$Detail+"</th>"+<>ZCR
$THTML:=$THTML+"   </tr>"+<>ZCR
$THTML:=$THTML+"  </thead>"+<>ZCR2
  // Corps du tableau
If ($ListeTonquée)
	$FT:=Size of array:C274($TbNumLesionF)
	For ($Salé;1;$FT)
		$NumLésionFCourant:=$TbNumLesionF{$Salé}
		$L:=Find in array:C230($TbNumLesN;$NumLésionFCourant)
		If ($L>0)
			$NumActuelA:=String:C10($TbNumLesNActuel{$L})
			$NomActuel:=$TbNomLesActuel{$L}
			If ($NomActuel#"")
				$pair:=(Num:C11($Salé%2=1)*"even")+(Num:C11($Salé%2=0)*"odd")
				$IntituléBalise:=String:C10($NumLésionFCourant)+$Langue
				$THTML:=$THTML+"  <tr id="+<>ZGuil+"ligne"+$IntituléBalise+<>ZGuil+"class="+<>ZGuil+"TbCorpsL "+$pair+<>ZGuil+">"+<>ZCR  // Ligne
				  // 3 Colonnes : N°, nom de la lésion, détail
				$THTML:=$THTML+"    <td class="+<>ZGuil+"TbCorpsC1 "+$pair+<>ZGuil+">"
				$THTML:=$THTML+$NumActuelA
				$THTML:=$THTML+"    </td>"+<>ZCR
				$THTML:=$THTML+"    <td class="+<>ZGuil+"TbCorpsC2 "+$pair+<>ZGuil+">"
				$NomLesionAffiche:=$NomActuel
				  // $NomLesionAffiche:=Remplacer chaîne($NomActuel;$SupLesion;"")
				$THTML:=$THTML+$NomLesionAffiche
				$THTML:=$THTML+"    </td>"+<>ZCR
				$THTML:=$THTML+"    <td class="+<>ZGuil+"tbdetail "+$pair+<>ZGuil+">"+<>ZCR
				$THTML:=$THTML+"      <img id="+<>ZGuil+"detail"+$IntituléBalise+<>ZGuil+" title="+<>ZGuil+$Detail+<>ZGuil
				$THTML:=$THTML+" class="+<>ZGuil+"detailles"+<>ZGuil
				$THTML:=$THTML+" alt="+<>ZGuil+$Detail+<>ZGuil+" src="+<>ZGuil+"images/detail.PNG"+<>ZGuil+" />"+<>ZCR
				$THTML:=$THTML+"    </td>"+<>ZCR
				$THTML:=$THTML+"  </tr>"+<>ZCR2  // fin de ligne
			End if 
			
		End if 
	End for 
	
Else   // liste entière
	$Compteur:=0
	For ($Salé;1;$FT)
		If ($TbNomLesActuel{$Salé}#"")
			$pair:=(Num:C11($Salé%2=1)*"even")+(Num:C11($Salé%2=0)*"odd")
			$IntituléBalise:=String:C10($TbNumLesN{$Salé})+$Langue
			$THTML:=$THTML+"  <tr id="+<>ZGuil+"ligne"+$IntituléBalise+<>ZGuil+"class="+<>ZGuil+"TbCorpsL "+$pair+<>ZGuil+">"+<>ZCR  // Ligne
			  // 3 Colonnes : N°, nom de la lésion, détail
			$THTML:=$THTML+"    <td class="+<>ZGuil+"TbCorpsC1 "+$pair+<>ZGuil+">"
			$THTML:=$THTML+String:C10($TbNumLesNActuel{$Salé})
			$THTML:=$THTML+"    </td>"+<>ZCR
			$THTML:=$THTML+"    <td class="+<>ZGuil+"TbCorpsC2 "+$pair+<>ZGuil+">"
			$NomLesionAffiche:=Replace string:C233($TbNomLesActuel{$Salé};$SupLesion;"")
			$THTML:=$THTML+$NomLesionAffiche
			$THTML:=$THTML+"    </td>"+<>ZCR
			$THTML:=$THTML+"    <td class="+<>ZGuil+"tbdetail "+$pair+<>ZGuil+">"+<>ZCR
			$THTML:=$THTML+"      <img id="+<>ZGuil+"detail"+$IntituléBalise+<>ZGuil+" title="+<>ZGuil+$Detail+<>ZGuil
			$THTML:=$THTML+" class="+<>ZGuil+"detailles"+<>ZGuil
			$THTML:=$THTML+" alt="+<>ZGuil+$Detail+<>ZGuil+" src="+<>ZGuil+"images/detail.PNG"+<>ZGuil+" />"+<>ZCR
			$THTML:=$THTML+"    </td>"+<>ZCR
			$THTML:=$THTML+"  </tr>"+<>ZCR2  // fin de ligne
		End if 
	End for 
End if 
$THTML:=$THTML+"              "+<>ZCR
$THTML:=$THTML+"</table>"+<>ZCR
$0:=$THTML
