//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 27/12/15, 07:43:38
// ----------------------------------------------------
// Méthode : WebTextesDetailLesion
// Description
// 
//
// Paramètres
// ----------------------------------------------------

QUERY:C277([DiaLesions:44]; [DiaLesions:44]NomLesion:1=VarNomLes)
$D:=Colonne2{Colonne2}+<>ZCR2
$D:=$D+"description :"+<>ZCR+[DiaLesions:44]DescriptionTypeMacro:4+<>ZCR2
$D:=$D+"Fiche réflexe :"+<>ZCR+[DiaLesions:44]FicheReflexe:12+<>ZCR2
$D:=$D+"Motif DGAL :"+<>ZCR+[DiaLesions:44]MotifSaisieDGAL:15+<>ZCR2
$D:=$D+"Motivation conduite :"+<>ZCR+[DiaLesions:44]JustificationConduite:8+<>ZCR2
$D:=$D+"NPC :"+<>ZCR+[DiaLesions:44]NPC:9+<>ZCR2
VarDetail:=$D