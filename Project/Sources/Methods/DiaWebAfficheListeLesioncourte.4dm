//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : cgm
  // Date et heure : 16/12/15, 16:01:39
  // ----------------------------------------------------
  // Méthode : WebAfficheListeLesioncourte
  // Description
  // Réduit la liste des lésions selon une chaine 
  // à trouver dans [Lesions]DescriptionTypeMacro
  // [Lesions]NomLesion, [Lesions]MotifSaisieDGAL
  //
  // Paramètre : chaine transmise par le Web
  // type champliste+ 1 lettre (a=asa d=dgal)+chaine à traiter
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)
ARRAY TEXT:C222($TbTL;0)
ARRAY TEXT:C222($TbMS;0)

$Mess:=$1
$dgal:=($Mess[[11]]="d")  // type de liste à renvoyer
$T:="@"+Substring:C12($Mess;12)+"@"  // contenu du champ entre @

QUERY:C277([DiaLesions:44];[DiaLesions:44]NomLesion:1=$T;*)
QUERY:C277([DiaLesions:44]; | [DiaLesions:44]MotifSaisieDGAL:15=$T;*)
QUERY:C277([DiaLesions:44]; | [DiaLesions:44]DescriptionTypeMacro:4=$T)


$TypeNomenclature:=$1
If ($dgal)
	SELECTION TO ARRAY:C260([DiaLesions:44]MotifSaisieDGAL:15;$TbMS)
	$Ft:=Size of array:C274($TbMS)
	
	For ($Salé;1;$FT)
		$VC:=$TbMS{$Salé}
		$YEst:=(Length:C16($VC)>0)
		$Pos:=Position:C15(<>ZCR;$VC)
		Case of 
			: ($YEst) & ($Pos=0)  // valeur unique
				If (Find in array:C230($TbTL;$VC)<0)
					APPEND TO ARRAY:C911($TbTL;$VC)
				End if 
			: ($YEst) & ($Pos>0)  // valeur multiples
				Repeat 
					$Ajout:=Substring:C12($VC;1;($Pos-1))
					If (Find in array:C230($TbTL;$Ajout)<0) & (Length:C16($Ajout)>0)
						APPEND TO ARRAY:C911($TbTL;$Ajout)
					End if 
					$VC:=Substring:C12($VC;($Pos+1))
					$Pos:=Position:C15(<>ZCR;$VC)
				Until ($Pos=0)
				If (Find in array:C230($TbTL;$VC)<0) & (Length:C16($VC)>0)
					APPEND TO ARRAY:C911($TbTL;$VC)
				End if 
		End case 
		
	End for 
	$CheckedReg:=" checked"
	$CheckedAsa:=""
Else 
	SELECTION TO ARRAY:C260([DiaLesions:44]NomLesion:1;$TbTL)
	$CheckedReg:=""
	$CheckedAsa:=" checked"
End if 
SORT ARRAY:C229($TbTL;>)
$THTML:=""
$FT:=Size of array:C274($TbTL)
For ($Salé;1;$FT)
	$THTML:=$THTML+"<option>"+$TbTL{$Salé}+"</option>"+<>ZCR
End for 
  //FIXER TEXTE DANS CONTENEUR($THTML)
WEB SEND TEXT:C677($THTML)
ZAmnistieInternationale 