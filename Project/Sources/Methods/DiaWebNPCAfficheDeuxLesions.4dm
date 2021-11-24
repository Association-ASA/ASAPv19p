//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 31/05/17, 13:21:30
// ----------------------------------------------------
// Méthode : WebAfficheNPCDeuxLesions
// Description
// Répond à un appel AJAX type "tnpcdeuxles"+n° diapo1+"_"+n° diapo2
//
// Paramètres
// ----------------------------------------------------
$Mess:=Substring:C12($1; 12)  // suppression des 11 premiers caractères "tnpcdeuxles"
$Pos:=Position:C15("_"; $Mess)
$NumDiapoRefA:=Substring:C12($Mess; 1; ($Pos-1))
$NumDiapoNpcA:=Substring:C12($Mess; ($Pos+1))
$NumDiapoRefN:=Num:C11($NumDiapoRefA)
$NumDiapoNpcN:=Num:C11($NumDiapoNpcA)
QUERY:C277([DiaData:45]; [DiaData:45]XNom:1=$NumDiapoRefA; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XType:5="npcdd"; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XAlpha:14=$NumDiapoNpcA)
If ([DiaData:45]XTexte:7="")
	QUERY:C277([DiaData:45]; [DiaData:45]XNom:1=$NumDiapoNpcA; *)
	QUERY:C277([DiaData:45];  & [DiaData:45]XType:5="npcdd"; *)
	QUERY:C277([DiaData:45];  & [DiaData:45]XAlpha:14=$NumDiapoRefA)
End if 
If ([DiaData:45]XTexte:7="")
	$Lesion1:=DiaWebExtraitValeurTbParNum($NumDiapoRefN; -><>TbDiaposNumOrdreDiapos; -><>TbDiaposNomLesion)
	$Lesion2:=DiaWebExtraitValeurTbParNum($NumDiapoNpcN; -><>TbDiaposNumOrdreDiapos; -><>TbDiaposNomLesion)
	$test1:=$Lesion1+"/"+$Lesion2
	$test2:=$Lesion2+"/"+$Lesion1
	QUERY:C277([DiaData:45]; [DiaData:45]XNom:1=$test1; *)
	QUERY:C277([DiaData:45];  | [DiaData:45]XNom:1=$test2)
	If (Records in selection:C76([DiaData:45])=0)
		CREATE RECORD:C68([DiaData:45])
		[DiaData:45]XType:5:="NPCLL"
		[DiaData:45]XNom:1:=$test1
		[DiaData:45]XAlpha:14:=$test2
	End if 
	If ([DiaData:45]XTexte:7="")
		[DiaData:45]XTexte:7:="Comparaison de "+$Lesion1+<>ZCR+"avec "+$Lesion2+"."
	End if 
End if 
WEB SEND TEXT:C677([DiaData:45]XTexte:7)