//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 02/05/20, 11:10:33
  // ----------------------------------------------------
  // Méthode : WebScrutePJCourriels
  // Description
  // Méthode qui permet de créer un lien vers un document
  //   qui a été placé dans la DropBox partagée 
  //   SynchroBases > DossierPJCourriels dans le dossier PJCourriels
  //   de façon à pouvoir être lu avec l'URL
  //   https://association.asa-spv.fr//Nomdufichier.ext
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT)
ARRAY TEXT:C222($TbNomsDoc;0)
  // Incorporation des PJ
DOCUMENT LIST:C474(<>PermCheDosPJCourrielSource;$TbNomsDoc;Ignorer invisibles:K24:16)
$FT:=Size of array:C274($TbNomsDoc)
For ($Salé;1;$FT)
	$Source:=<>PermCheDosPJCourrielSource+$TbNomsDoc{$Salé}
	$Cible:=<>PermCheDosPJCourrielWeb+$TbNomsDoc{$Salé}
	If (Test path name:C476($Cible)=Est un document:K24:1)
		DELETE DOCUMENT:C159($Cible)
	End if 
	MOVE DOCUMENT:C540($Source;$Cible)
End for 