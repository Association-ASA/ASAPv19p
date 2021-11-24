//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 11/09/21, 11:52:53
// ----------------------------------------------------
// Méthode : QuizzPUMP1Actualise
// Description
// Méthode qui actualise la [DiaData]
//  correspondant à une image sup
// Paramètre : $1=message AJAX  
// type quizzPUM+type de donnée+ID de la [DiaData]+valeur du PUM
// ----------------------------------------------------
$Message:=Substring:C12($1; 9)  // élimination que quizzPUM
$Type:=Substring:C12($Message; 1; 6)  // Espèce ou Lésion toutes deux à 6 caractères
$Message:=Substring:C12($Message; 7)  // élimination que quizzPUM
$UUID:=Substring:C12($Message; 1; 32)
$Valeur:=Substring:C12($Message; 33)

READ WRITE:C146([DiaData:45])
QUERY:C277([DiaData:45]; [DiaData:45]ID:12=$UUID)
If ($Type[[1]]="e")
	[DiaData:45]XTexte:7:=$Valeur
Else 
	[DiaData:45]XTexteSup:8:=$Valeur
End if 
SAVE RECORD:C53([DiaData:45])
$Institution:=[DiaData:45]XAlpha:14
ZAmnistiePartielle(->[DiaData:45])
// Contenu de la liste
QUERY:C277([DiaData:45]; [DiaData:45]XAlpha:14=$Institution; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XBool:9=False:C215; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XType:5="QuizzPhoto")
DISTINCT VALUES:C339([DiaData:45]XTexte:7; TbPUMListeEspece)
DISTINCT VALUES:C339([DiaData:45]XTexteSup:8; TbPUMListeLesion)
SELECTION TO ARRAY:C260([DiaData:45]XNom:1; $TbNomFichierPhoto\
; [DiaData:45]ID:12; TbUUIDPhoto\
; [DiaData:45]XEntier:2; $TbNumPhoto\
; [DiaData:45]XTexte:7; TbEspecePhoto\
; [DiaData:45]XTexteSup:8; TbLesionPhoto\
; [DiaData:45]XValeur:4; TbOrientationPhoto\
; [DiaData:45]XDate:3; $TbDatePhoto)
LONGINT ARRAY FROM SELECTION:C647([DiaData:45]; $TbNumEnrPaniers)
$THTML:=QuizzEcritHTMAvantTableau
WEB SEND TEXT:C677($THTML)

