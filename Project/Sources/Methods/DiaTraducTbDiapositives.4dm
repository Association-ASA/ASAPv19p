//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 03/12/18, 17:54:40
  // ----------------------------------------------------
  // Paramètre aucun
  // ----------------------------------------------------
  // Méthode : Ad3TraducTbDiapositives
  // Description
  // Méthode qui écrit en fichier texte  
  //  destiné à EXCEL pour permettre la traduction d'AsaDia
  // dans une autre langue que le Français et l'anglais

C_LONGINT:C283($Salé;$FT)

ALL RECORDS:C47([Diapositives:40])
SELECTION TO ARRAY:C260([Diapositives:40]NumOrdreDiapos:1;$TbNumDiaN\
;[Diapositives:40]Commentaires:7;$TbComF\
;[Diapositives:40]CommentaireA:28;$TbComA)
SORT ARRAY:C229($TbNumDiaN;$TbComF;$TbComA)

USE CHARACTER SET:C205("Macintosh";0)
$Doc:=Create document:C266("")
$FT:=Size of array:C274($TbNumDiaN)
For ($Salé;1;$FT)
	$TtexteFExpurgé:=Replace string:C233($TbComF{$Salé};<>ZCR;"£")
	$TtexteFExpurgé:=Replace string:C233($TtexteFExpurgé;<>ZTab;" ")
	$TtexteAExpurgé:=Replace string:C233($TbComA{$Salé};<>ZCR;"£")
	$TtexteAExpurgé:=Replace string:C233($TtexteAExpurgé;<>ZTab;" ")
	$envoi:=String:C10($TbNumDiaN{$Salé})+<>ZTab+$TtexteFExpurgé+<>ZTab+$TtexteAExpurgé+<>ZTab+<>ZCR
	SEND PACKET:C103($Doc;$envoi)
End for 
CLOSE DOCUMENT:C267($Doc)
USE CHARACTER SET:C205(*;0)