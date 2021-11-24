//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur (OS) : cgm
// Date et heure : 16/08/15, 07:16:44
// ----------------------------------------------------
// Méthode : WebAfficheListeLesions
// Description
// Permet de changer de type de liste de lésion sur le Web
//
// Paramètres $1= type de nomenclature
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT)
ARRAY TEXT:C222($TbTL; 0)
$Message:=$1
C_OBJECT:C1216($Objet)
$Objet:=JSON Parse:C1218(Substring:C12($Message; 13))  // Elimination de motifdetail
$Nomenclature:=OB Get:C1224($Objet; "nomenclature"; Est un texte:K8:3)
$Visiteur:=OB Get:C1224($Objet; "typevisiteur"; Est un texte:K8:3)
If ($Nomenclature="@dgal@")  // motif de saisie
	If ($Visiteur="")  // Boucherie : affichage total
		QUERY:C277([DiaMotifSaisieDGAL:42]; [DiaMotifSaisieDGAL:42]TypeListe:8="A")
		SELECTION TO ARRAY:C260([DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1; $TbTL)
	Else   // Gibier : affichage des motifs exiatant pour les images du gibier
		QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1>80000; *)
		QUERY:C277([Diapositives:40];  & [Diapositives:40]MotifSaisieDGAL:23#"")
		DISTINCT VALUES:C339([Diapositives:40]MotifSaisieDGAL:23; $TbTL)
	End if 
	$CheckedReg:=" checked"
	$CheckedAsa:=""
	
Else   // Nomenclature ana-path
	If ($Visiteur="")  // Boucherie : affichage total
		ALL RECORDS:C47([DiaLesions:44])
		SELECTION TO ARRAY:C260([DiaLesions:44]NomLesion:1; $TbTL)
		$CheckedReg:=""
		$CheckedAsa:=" checked"
	Else 
		QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1>80000)
		RELATE ONE SELECTION:C349([Diapositives:40]; [DiaLesions:44])
		SELECTION TO ARRAY:C260([DiaLesions:44]NomLesion:1; $TbTL)
	End if 
End if 
SORT ARRAY:C229($TbTL; >)
$THTML:=""
$FT:=Size of array:C274($TbTL)
For ($Salé; 1; $FT)
	$THTML:=$THTML+"            <option class="+<>ZGuil+"changerequete"+<>ZGuil+">"+$TbTL{$Salé}+"</option>"+<>ZCR
End for 

WEB SEND TEXT:C677($THTML)
ZAmnistieInternationale