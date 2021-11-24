//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : MBPASA2015
  // Date et heure : 01/04/16, 07:40:37
  // ----------------------------------------------------
  // Méthode : WebAfficheCommentaire
  // Description
  // Permet d'afficher le commentaire dans l'image en grand
  //  en tentnt compte de la langue
  // Paramètres $1 = nature du commentaire   {$2} = Langue
  // ----------------------------------------------------
C_LONGINT:C283($Salé;$FT)
$Langue:=$2
  // ZAmnistieInternationale
$NatCom:=DiaWebTraduitTexte ($1;$Langue)
$L:=Find in array:C230(<>TbNLF;[Diapositives:40]NomLesion:4)
Case of 
	: ($1="Description macroscopique")
		$Val:=(Num:C11($2="A")*[Diapositives:40]CommentaireA:28)+(Num:C11($2="F")*[Diapositives:40]Commentaires:7)
		
	: ($1="Description de la lésion")
		$Val:=(Num:C11($2="A")*<>TbDME{$L})+(Num:C11($2="F")*<>TbDMF{$L})
		
	: ($1="Fiche réflexe")
		$Val:=(Num:C11($2="A")*<>TbFRE{$L})+(Num:C11($2="F")*<>TbFRF{$L})
		
	: ($1="Ne pas confondre")
		$Val:=[Diapositives:40]NPC:14
		
	: ($1="Références réglementaires")
		RELATE MANY:C262([Diapositives:40]NomLesion:4)
		$Val:=DiaWebTraduitTexte ([DiaLesions:44]ReferenceReglementaireUE:17;$Langue)
		
End case 
$Rep:=""
If (Length:C16($Val)>0)
	$Rep:=$Rep+"           "+Replace string:C233($Val;<>ZCR;"<br />")+<>ZCR
Else 
	Case of 
		: ($1="@confo@")
			If ($Langue="A")
				$Rep:=$Rep+"          No lesion is like thereof."+<>ZCR
			Else 
				$Rep:=$Rep+"          Aucune lésion ne ressemble à celle-ci."+<>ZCR
			End if 
			
		: ($1="@fiche@")
			If ($Langue="A")
				$Rep:=$Rep+"          No advice is provided for this case."+<>ZCR
				
				$Rep:=$Rep+"          Aucune conduite n'est prévue pour ce cas."+<>ZCR
			End if 
			
	End case 
	$Rep:=$Rep+"          </span> "+<>ZCR
End if 
  //Fin de si
$0:=$Rep
  //ZAmnistieInternationale