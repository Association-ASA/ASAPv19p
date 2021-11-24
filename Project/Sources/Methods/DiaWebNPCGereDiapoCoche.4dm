//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 28/07/16, 06:44:20
  // ----------------------------------------------------
  // Méthode : WebNPCGereDiapoCoche
  // Description
  // Fonction qui renvoie la chaine composée 
  // des numéro des diapositives cochées
  // comme à retenir pour NPC
  // ----------------------------------------------------

$NumDiaRefA:=String:C10($1)
QUERY:C277([DiaData:45];[DiaData:45]XNom:1=$NumDiaRefA;*)
QUERY:C277([DiaData:45]; & [DiaData:45]XType:5="npcdd")
SELECTION TO ARRAY:C260([DiaData:45]XAlpha:14;$TbNumDiaNPC)
$Compteur:=Size of array:C274($TbNumDiaNPC)
$PhotosNPC:=ZTableauVersTexte (->$TbNumDiaNPC;" ")
If ($Compteur=0)
	$PhotosNPC:="aucune photographie"
End if 
$0:=$PhotosNPC