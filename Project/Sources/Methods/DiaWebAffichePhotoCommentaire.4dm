//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : cgm
  // Date et heure : 09/12/15, 05:42:09
  // ----------------------------------------------------
  // Méthode : WebAffichePhotoCommentaire
  // Description
  // Affiche le texte en regard de la photo
  //
  // Paramètres $1 = nature du commentaire   {$2} = rang concerné   {$3}= Langue
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT;$TT;$L;$L2)

$Langue:=$3
$SuffixeLangue:=(Num:C11($Langue="A")*"E")+(Num:C11($Langue#"A")*$Langue)

$NatCom:=DiaWebTraduitTexte ($1;$Langue)
$Rep:="           <span class="+<>ZGuil+"choixcritere"+<>ZGuil+">"+<>ZCR
$Rep:=$Rep+"            "+$NatCom+" </span> <br /><br />"
  //Si (Nombre de paramètres=1)  // sans effet de fondu = au départ
  //$Rep:=$Rep+"           "+Remplacer chaîne([Diapositives]Commentaires;<>ZCR;"<br />")+<>ZCR
  //Sinon   // sur demande = effet de visualisation
$VarIdFondu:="com"+String:C10([Diapositives:40]NumOrdreDiapos:1)+$2
$Rep:=$Rep+"           <span id="+<>ZGuil+$VarIdFondu+<>ZGuil+">"+<>ZCR
$L:=Find in array:C230(<>TbNLF;[Diapositives:40]NomLesion:4)
Case of 
	: ($1="Description macroscopique")
		$L2:=Find in array:C230(<>TbDiaposNumOrdreDiapos;[Diapositives:40]NumOrdreDiapos:1)
		$PtTb:=Get pointer:C304("<>TbDiaposCom"+$Langue)
		$Val:=$PtTb->{$L2}
		  //$Val:=(Num($3="A")*[Diapositives]CommentaireA)+(Num($3="F")*[Diapositives]Commentaires)
		
	: ($1="Description de la lésion")
		$PtTb:=Get pointer:C304("<>TbDM"+$Langue)
		$Val:=$PtTb->{$L}
		  //$Val:=(Num($3="A")*<>TbDME{$L})+(Num($3="F")*<>TbDMF{$L})
		
	: ($1="Fiche réflexe")
		If ($Langue="F") & ([Diapositives:40]DiapoFicheReflexe:31#"")
			$Val:=[Diapositives:40]DiapoFicheReflexe:31
		Else 
			$PtTb:=Get pointer:C304("<>TbFR"+$Langue)
			$Val:=$PtTb->{$L}
		End if 
		  // $Val:=(Num($3="A")*<>TbFRE{$L})+(Num($3="F")*<>TbFRF{$L})
		
	: ($1="Ne pas confondre")
		If ($Langue="F")  // L'affichage des photos pour les comparer deyux à deux est réservée aux francophones
			$Val:=Replace string:C233([Diapositives:40]NPC:14;<>ZCR;" <br />")
			$NumPhotoRefA:=String:C10([Diapositives:40]NumOrdreDiapos:1)
			QUERY:C277([DiaData:45];[DiaData:45]XType:5="NPC";*)
			QUERY:C277([DiaData:45];[DiaData:45]XNom:1=$NumPhotoRefA)
			$THTML:=""
			If ([DiaData:45]XTexteSup:8#"")
				ARRAY TEXT:C222($TbNumNpcPhotos;0)
				ZTexteVersTableau ([DiaData:45]XTexteSup:8;->$TbNumNpcPhotos)
				$FT:=Size of array:C274($TbNumNpcPhotos)
				$THTML:=$THTML+"            <div class="+<>ZGuil+"photosnpc"+<>ZGuil+">"+<>ZCR
				For ($Salé;1;$FT)
					$NumNpcPhotoCourant:=$TbNumNpcPhotos{$Salé}
					$L:=Find in array:C230(<>TbNumDia;Num:C11($NumNpcPhotoCourant))
					$Triplette:=DiaWebAfficheTriplette ($L;"F")
					$THTML:=$THTML+"              <img id="+<>ZGuil+"img2"+<>ZGuil+" class="+<>ZGuil+"imageenlistenpc"+<>ZGuil+" src="+<>ZGuil+"PhotosAsaDia/"+$NumNpcPhotoCourant+"i.jpg"+<>ZGuil
					$THTML:=$THTML+" alt="+<>ZGuil+$Triplette+<>ZGuil+" width="+<>ZGuil+"128px"+<>ZGuil+" height="+<>ZGuil+"85px"+<>ZGuil+<>ZCR
					$THTML:=$THTML+"               title="+<>ZGuil+$Triplette+" ("+$NumNpcPhotoCourant+")"+<>ZGuil+"  />"+<>ZCR
				End for 
				$THTML:=$THTML+"              <br  /> <button id="+<>ZGuil+"boutonnpc"+$NumPhotoRefA+<>ZGuil+">Aller à la page Ne Pas Confondre</button>"+<>ZCR
				$THTML:=$THTML+"                "+<>ZCR
				$THTML:=$THTML+"            </div>"+<>ZCR
				$Rep:=$Rep+$THTML
			Else 
				
				  //  $Rep:=$Rep+$Val+$THTML
				$Rep:=$Rep+"          Aucune lésion ne ressemble à celle-ci.<br />"+<>ZCR+[DiaData:45]XTexte:7
				
			End if 
		Else 
			ARRAY TEXT:C222($TbNLNPC;0)
			ZTexteVersTableau ([Diapositives:40]NPC:14;->$TbNLNPC)
			$TT:=Size of array:C274($TbNLNPC)
			If ($TT=0)
				$Rep:=$Rep+"          "+DiaWebTraduitTexte ("Aucune lésion ne ressemble à celle-ci.";$Langue)+<>ZCR
			Else 
				For ($Salé;1;$TT)
					$Rep:=$Rep+"          "+DiaWebTraduitLesion ($TbNLNPC{$Salé};$Langue)+"<br / >"+<>ZCR
				End for 
			End if 
		End if 
		
	: ($1="Références réglementaires")
		QUERY:C277([DiaLesions:44];[DiaLesions:44]NomLesion:1=[Diapositives:40]NomLesion:4)
		$Val:=DiaWebTraduitTexte ([DiaLesions:44]ReferenceReglementaireUE:17;$Langue)
		
End case 

If (Length:C16($3)>0)
	If ($1#"Ne pas confondre")
		$Rep:=$Rep+"           "+Replace string:C233($Val;<>ZCR;"<br />")+<>ZCR
	End if 
Else 
	Case of 
			
		: ($1="@fiche@")
			$Rep:=$Rep+"          "+DiaWebTraduitTexte ("Aucune conduite n'est prévue pour ce cas.";$Langue)+<>ZCR
			
	End case 
	$Rep:=$Rep+"          </span> "+<>ZCR
End if 
  //Fin de si
$0:=$Rep