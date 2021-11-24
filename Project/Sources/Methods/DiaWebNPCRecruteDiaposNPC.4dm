//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 09/06/16, 07:21:52
// ----------------------------------------------------
// Méthode : WebNPCRecruteDiaposNPC
// WebNPCRecruteDiaposNPC <- WebNPCEcritPage <- WebIdentification
//  WebNPCRecruteDiaposNPC <- WebNPCAffiche  <- Sur connexion Web

// Description
// Permet de recruter et d'afficher les photos
// appartenant aux critères NPC
// de la photo principale courante
// Paramètres :
//     $1 = o si tous les organes e toutes les espèces
//     $2 = n° d'enregistrement de la [XDonnées] "NPC" avec liste des photos ([XDonnées]XTexteSup)
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT)
$THTML:=""
If (Count parameters:C259=1)
	$Restriction:=$1
Else   //  <- WebIdentification
	$Restriction:=""
End if 
//$PhotosNPC:=WebNPCGereDiapoCoche ($NumEnrXDonnéesNPC)
CREATE EMPTY SET:C140([Diapositives:40]; "NPCCourant")
$T:=[Diapositives:40]NPC:14
$Espece:=[Diapositives:40]Espece:3
$Organe:=[Diapositives:40]Organe:2
$Pos:=Position:C15(<>ZCR; $T)
$NumDiaRefN:=[Diapositives:40]NumOrdreDiapos:1
// les photos cochées
$Nom:=String:C10($NumDiaRefN)
$Longueur:=Length:C16(String:C10($NumDiaRefN))
QUERY:C277([DiaData:45]; [DiaData:45]XNom:1=$Nom; *)
// CHERCHER([XDonnées];|[XDonnées]XAlpha=$Nom;*)
QUERY:C277([DiaData:45];  & [DiaData:45]XType:5="NPCdd")
$FT:=Records in selection:C76([DiaData:45])
ARRAY TEXT:C222($TbAlphaXdonnees; $FT)
//SÉLECTION VERS TABLEAU([XDonnées]XNom;TbNomXdonnees;[XDonnées]XTexte;TbTexteXdonnees;[XDonnées]XAlpha;TbAlphaXdonnees)
SELECTION TO ARRAY:C260([DiaData:45]XAlpha:14; $TbAlphaXdonnees)
ARRAY LONGINT:C221($TbCochees; 0)
For ($Salé; 1; $FT)
	$NumDiaCouranteA:=$TbAlphaXdonnees{$Salé}
	$NumDiaCouranteN:=Num:C11($NumDiaCouranteA)
	APPEND TO ARRAY:C911($TbCochees; $NumDiaCouranteN)
	$L:=Find in array:C230(<>TbDiaposNumOrdreDiapos; $NumDiaCouranteN)
	$Triplette:=<>TbDiaposNomLesion{$L}+" sur "+<>TbDiaposOrgane{$L}+" de "+<>TbDiaposEspece{$L}
	$Coche:=True:C214
	$THTML:=$THTML+"      <div>"+<>ZCR+DiaWebNPCEcritImage($NumDiaCouranteA; $Coche; $Triplette; <>TbDiaposOrientationPhotoH{$L}; $NumDiaRefN)+"      </div>"+<>ZCR
End for 


// les photos possibles
ARRAY TEXT:C222($TbNPC; 0)
While ($Pos>0)
	$Candidat:=Substring:C12($T; 1; ($Pos-1))
	If ($Candidat#"") & (Find in array:C230($TbNPC; $Candidat)<0)
		APPEND TO ARRAY:C911($TbNPC; $Candidat)
		QUERY:C277([Diapositives:40]; [Diapositives:40]NomLesion:4=$Candidat; *)
		If ($Restriction#"@o@")
			QUERY:C277([Diapositives:40];  & [Diapositives:40]Espece:3=$Espece; *)
		End if 
		If ($Restriction#"@e@")
			QUERY:C277([Diapositives:40];  & [Diapositives:40]Organe:2=$Organe; *)
		End if 
		QUERY:C277([Diapositives:40])
		CREATE SET:C116([Diapositives:40]; "Ajout")
		UNION:C120("NPCCourant"; "Ajout"; "NPCCourant")
	End if 
	$T:=Substring:C12($T; ($Pos+1))
	$Pos:=Position:C15(<>ZCR; $T)
End while 
If ($T#"")
	$Candidat:=$T
	If ($Candidat#"") & (Find in array:C230($TbNPC; $Candidat)<0)
		APPEND TO ARRAY:C911($TbNPC; $Candidat)
		QUERY:C277([Diapositives:40]; [Diapositives:40]NomLesion:4=$Candidat; *)
		If ($Restriction#"@o@")
			QUERY:C277([Diapositives:40];  & [Diapositives:40]Espece:3=$Espece; *)
		End if 
		If ($Restriction#"@e@")
			QUERY:C277([Diapositives:40];  & [Diapositives:40]Organe:2=$Organe; *)
		End if 
		QUERY:C277([Diapositives:40])
		CREATE SET:C116([Diapositives:40]; "Ajout")
		UNION:C120("NPCCourant"; "Ajout"; "NPCCourant")
	End if 
End if 

USE SET:C118("NPCCourant")
//INTERSECTION("ImagesH";"NPCCourant";"Horiz")
//UTILISER ENSEMBLE("Horiz")
$FT:=Records in selection:C76([Diapositives:40])
SELECTION TO ARRAY:C260([Diapositives:40]NumOrdreDiapos:1; $TbId\
; [Diapositives:40]OrientationPhotoH:30; $TbH\
; [Diapositives:40]NomLesion:4; $TbL\
; [Diapositives:40]Organe:2; $TbO\
; [Diapositives:40]Espece:3; $TbE)

For ($Salé; 1; $FT)
	If (Find in array:C230($TbCochees; $TbId{$Salé})<0)
		$Triplette:=$TbL{$Salé}+" sur "+$TbO{$Salé}+" de "+$TbE{$Salé}
		$NumA:=String:C10($TbId{$Salé})
		$Coche:=False:C215
		$THTML:=$THTML+"      <div>"+<>ZCR+DiaWebNPCEcritImage($NumA; $Coche; $Triplette; $TbH{$Salé}; $NumDiaRefN)+"      </div>"+<>ZCR
	End if 
End for 

//INTERSECTION("ImagesV";"NPCCourant";"Vert")
//UTILISER ENSEMBLE("Vert")
//$FT:=Enregistrements trouvés([Diapositives])
//SÉLECTION VERS TABLEAU([Diapositives]NumOrdreDiapos;$TbId;[Diapositives]NomLesion;$TbL;[Diapositives]Organe;$TbO;[Diapositives]Espece;$TbE)\



//$Div:=($FT\4)*4+($FT%4)
//Boucle ($Salé;1;$Div)
//Si ($Salé>$FT)
//$THTML:=$THTML+"        <p class="+<>ZGuil+"imagette"+<>ZGuil+" width="+<>ZGuil+"173px"+<>ZGuil+">"+<>ZCR
//$THTML:=$THTML+"        </p>"+<>ZCR2
//Sinon
//$NumA:=Chaîne($TbId{$Salé})
//$Triplette:=$TbL{$Salé}+" sur "+$TbO{$Salé}+" de "+$TbE{$Salé}
//$THTML:=$THTML+WebNPCEcritImage ($NumA;$PhotosNPC;$Triplette;Faux;$NumDiaRefN)
//Fin de si
//Fin de boucle
$0:=$THTML