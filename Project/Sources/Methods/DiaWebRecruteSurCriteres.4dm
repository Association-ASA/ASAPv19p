//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 09/01/16, 07:16:05
// ----------------------------------------------------
// Méthode : WebRecruteSurCriteres
// Description
//  Recrute les diapos pertinentes en fonction des critères
//  TradKO
// Paramètres : $1= message AJAX
//                       $2=type de liste (voir WebAfficheListePhotos)
//                       $3= variantes ou non
// ----------------------------------------------------
C_LONGINT:C283($Salé; $Pos; $TT; $Rang)
ARRAY TEXT:C222($TbEsp; 0)
ARRAY TEXT:C222($TbTradEsp; 0)
ARRAY TEXT:C222($TbOrg; 0)
ARRAY TEXT:C222($TbTradOrg; 0)
ARRAY TEXT:C222($TbLes; 0)
ARRAY TEXT:C222($TbTradLes; 0)
CREATE EMPTY SET:C140([Diapositives:40]; "esp")
CREATE EMPTY SET:C140([Diapositives:40]; "org")
CREATE EMPTY SET:C140([Diapositives:40]; "les")
CREATE EMPTY SET:C140([Diapositives:40]; "res")
$Mess:=$1
$TypeListe:=$2
$Variantes:=$3
If ($TypeListe="y") | ($TypeListe="d") | ($TypeListe="z") | ($TypeListe="x")  // liste ana-path en français OU dgal OU gibier
	$Langue:="F"
Else 
	$Langue:=$TypeListe
End if 
$Rang:=24+Num:C11(AffichageListeNombreuse)
$Rec:=Substring:C12($Mess; $Rang)  // Bovins,Caprins<br />Organes : langue,mamelle<br />Lésions : abcès pyohémiques,albinisme musculaire

VarPlusieursNomsMotifs:=False:C215  // Booléen qui va permettre l'affichage d'une information de divergence entre nom de la lésion et motfif de saisie

// initialisation de l'information de la demande dans le rectangle vert sur le Web
// type "15 photos répondent aux critères proposés : " + "<br /> sur tous les organes chez les caprins"  bouton "Annuler la recherche"
// + le bouton "Annuler la recherche   =  "<button id="boutuerecherche" class="textebanalgrand">Annuler la recherche</button>


// Tableau des espèces
$Pos:=Position:C15("<br />"; $Rec)
$Item:=Substring:C12($Rec; 1; ($Pos-1))
$Rec:=Substring:C12($Rec; ($Pos+16))  // élimination de "Bovins,Caprins<br />Organes : "
$Pos:=Position:C15(","; $Item)
While ($Pos>0)
	$val:=Substring:C12($Item; 1; ($Pos-1))
	APPEND TO ARRAY:C911($TbEsp; $val)
	If ($TypeListe="z")
		$s:=Num:C11($val#"@s")*"s"  // Pour éviter les chamoiss  !!!
		APPEND TO ARRAY:C911($TbTradEsp; ($val+$s))
	Else 
		APPEND TO ARRAY:C911($TbTradEsp; DiaWebTraduitTexte($val; $Langue))
	End if 
	$Item:=Substring:C12($Item; ($Pos+2))  // Tient compte de l'espace
	$Pos:=Position:C15(","; $Item)
End while 
If ($Item#"")
	APPEND TO ARRAY:C911($TbEsp; $Item)
	If ($TypeListe="z")
		$s:=Num:C11($Item#"@s")*"s"  // Pour éviter les chamoiss  !!!
		APPEND TO ARRAY:C911($TbTradEsp; ($Item+$s))
	Else 
		APPEND TO ARRAY:C911($TbTradEsp; DiaWebTraduitTexte($Item; $Langue))
	End if 
	$InfoEspeces:=ZTableauVersTexte(->$TbTradEsp; ", ")
Else 
	$InfoEspeces:=" "+DiaWebTraduitTexte("toutes les espèces"; $Langue)
End if 
// Recherche des [Diapositives] pertinentes
$TT:=Size of array:C274($TbEsp)
If ($TT>0)
	QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1<=-2; *)
	For ($Salé; 1; $TT)
		If (Length:C16($TbEsp{$Salé})>0)
			QUERY:C277([Diapositives:40];  | [Diapositives:40]Espece:3=$TbEsp{$Salé}; *)
		End if 
	End for 
	QUERY:C277([Diapositives:40])
Else 
	If ($TypeListe="z") | ($TypeListe="y")
		QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1>80000)
	Else 
		QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1<80000)
	End if 
End if 
CREATE SET:C116([Diapositives:40]; "esp")


// Tableau des organes
$Pos:=Position:C15("<br />"; $Rec)
$Item:=Substring:C12($Rec; 1; ($Pos-1))
$Rec:=Substring:C12($Rec; ($Pos+16))  // élimination de "langue,mamelle<br />Lésions : "
$Pos:=Position:C15(","; $Item)
While ($Pos>0)
	$val:=Substring:C12($Item; 1; ($Pos-1))
	APPEND TO ARRAY:C911($TbOrg; $val)
	APPEND TO ARRAY:C911($TbTradOrg; DiaWebTraduitTexte($val; $Langue))
	$Item:=Substring:C12($Item; ($Pos+2))  // Tient compte de l'espace
	$Pos:=Position:C15(","; $Item)
End while 
If ($Item#"")
	APPEND TO ARRAY:C911($TbOrg; $Item)
	APPEND TO ARRAY:C911($TbTradOrg; DiaWebTraduitTexte($Item; $Langue))
	$InfoOrganes:=ZTableauVersTexte(->$TbTradOrg; ", ")
Else 
	$InfoOrganes:=DiaWebTraduitTexte("tous les organes"; $Langue)
End if 
// Recherche des [Diapositives] pertinentes
$TT:=Size of array:C274($TbOrg)
If ($TT>0)
	QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1<=-2; *)
	For ($Salé; 1; $TT)
		If (Length:C16($TbOrg{$Salé})>0)
			QUERY:C277([Diapositives:40];  | [Diapositives:40]Organe:2=$TbOrg{$Salé}; *)
		End if 
	End for 
	QUERY:C277([Diapositives:40])
Else 
	If ($TypeListe="z") | ($TypeListe="y")
		QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1>80000)
	Else 
		QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1<80000)
	End if 
End if 
CREATE SET:C116([Diapositives:40]; "org")
INTERSECTION:C121("org"; "esp"; "res")

// Tableau des lésions
$Item:=$Rec
$Pos:=Position:C15(","; $Item)
While ($Pos>0)
	$val:=Substring:C12($Item; 1; ($Pos-1))
	APPEND TO ARRAY:C911($TbLes; $val)
	// AJOUTER À TABLEAU($TbTradLes;WebTraduitLesion($val;$Langue))
	$Item:=Substring:C12($Item; ($Pos+1))  // Tient compte de l'espace
	$Pos:=Position:C15(","; $Item)
End while 
If ($Item#"")
	APPEND TO ARRAY:C911($TbLes; $Item)
	// AJOUTER À TABLEAU($TbTradLes;WebTraduitTexte ($Item;$Langue))
	$InfoLésions:=ZTableauVersTexte(->$TbLes; ", ")
Else 
	$InfoLésions:=DiaWebTraduitTexte("toutes les lésions"; $Langue)
End if 
// Recherche des [Diapositives] pertinentes
$TT:=Size of array:C274($TbLes)
If ($TT>0)
	QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1<=-2; *)
	For ($Salé; 1; $TT)
		If (Length:C16($TbLes{$Salé})>0)
			$PtTbLesionLangueCourante:=Get pointer:C304("<>TbNL"+$Langue)
			If ($TypeListe="d") | ($TypeListe="z")  // liste DGAL
				QUERY:C277([Diapositives:40];  | [Diapositives:40]MotifSaisieDGAL:23=$TbLes{$Salé}; *)
			Else 
				$L:=Find in array:C230($PtTbLesionLangueCourante->; $TbLes{$Salé})
				QUERY:C277([Diapositives:40];  | [Diapositives:40]NomLesion:4=<>TbNLF{$L}; *)
			End if 
		End if 
	End for 
	QUERY:C277([Diapositives:40])
Else 
	If ($TypeListe="z") | ($TypeListe="y")
		QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1>80000)
	Else 
		QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1<80000)
	End if 
End if 
CREATE SET:C116([Diapositives:40]; "les")
INTERSECTION:C121("les"; "res"; "res")

Case of 
	: ($Variantes="s")  // sans les variantes
		QUERY:C277([Diapositives:40]; [Diapositives:40]Statut:18="Reférence")
		CREATE SET:C116([Diapositives:40]; "var")
		INTERSECTION:C121("var"; "res"; "res")
		
	: ($Variantes="v")  // sans les variantes
		QUERY:C277([Diapositives:40]; [Diapositives:40]Statut:18="Variante")
		CREATE SET:C116([Diapositives:40]; "var")
		INTERSECTION:C121("var"; "res"; "res")
End case 

USE SET:C118("res")

If ($TypeListe="d")  // Si on est sur une liste DGAL, on doit replacer les photos dans l'ordre
	SELECTION TO ARRAY:C260([Diapositives:40]NumOrdreDiapos:1; TbNumDiaR\
		; [Diapositives:40]NomLesion:4; $TbNomLésion\
		; [Diapositives:40]MotifSaisieDGAL:23; $TbNomMotif)
	LONGINT ARRAY FROM SELECTION:C647([Diapositives:40]; $TbNumEnrDia)
	
	$TT:=Size of array:C274($TbNumEnrDia)
	ARRAY LONGINT:C221($TbOrdre; $TT)
	For ($Salé; 1; $TT)
		$TbOrdre{$Salé}:=Num:C11($TbNomLésion{$Salé}#$TbNomMotif{$Salé})
		If ($TbNomLésion{$Salé}#$TbNomMotif{$Salé})
			VarPlusieursNomsMotifs:=True:C214
		End if 
	End for 
	SORT ARRAY:C229($TbOrdre; $TbNumEnrDia; >)
	CREATE SELECTION FROM ARRAY:C640([Diapositives:40]; $TbNumEnrDia)
End if 
SELECTION TO ARRAY:C260([Diapositives:40]NumOrdreDiapos:1; TbNumDiaR)
// fabrication du tableau des n° de diapos
// Permet d'enrécupérer les éléments à afficher grâce à WebCreerTbDescriptionPhotos

// Construisons le commentaire du résultat de la recherche
$Critere:=DiaWebTraduitTexte("Résultat recherche"; $Langue)
// <3> photos répondent aux critères proposés : <Actinobacillose/Actinomycose> sur <langue> chez les <bovins>
$Critere:=Replace string:C233($Critere; "<3>"; String:C10(Size of array:C274(TbNumDiaR)))
ARRAY LONGINT:C221($TbBornesEntrante; 0)
ARRAY LONGINT:C221($TbBornesSortante; 0)
$FT:=Length:C16($Critere)
For ($Salé; 1; $FT)
	If ($Critere[[$Salé]]="<")
		APPEND TO ARRAY:C911($TbBornesEntrante; $Salé)
	End if 
	If ($Critere[[$Salé]]=">")
		APPEND TO ARRAY:C911($TbBornesSortante; $Salé)
	End if 
End for 
$Critere1:=Substring:C12($Critere; 1; ($TbBornesEntrante{1}-1))+$InfoLésions
$Critere2:=Substring:C12($Critere; ($TbBornesSortante{1}+1); ($TbBornesEntrante{2}-$TbBornesSortante{1}-1))+$InfoOrganes
If (Size of array:C274($TbEsp)>0)
	$Critere3:=Substring:C12($Critere; ($TbBornesSortante{2}+1); ($TbBornesEntrante{3}-$TbBornesSortante{2}-1))+$InfoEspeces+" "
Else 
	$Critere3:=$InfoEspeces+" "
End if 
$Critere:=$Critere1+$Critere2+$Critere3
// ajoutons le bouton d'annulation de la recherche
$Critere:=$Critere+"<br/><br/><button id="+<>ZGuil+"boutuerecherche"+<>ZGuil+" class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"
$Critere:=$Critere+DiaWebTraduitTexte("Annuler la recherche"; $Langue)+"</button>"
$0:=$critere