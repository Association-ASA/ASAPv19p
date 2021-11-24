
// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 24/11/18, 04:02:26
// ----------------------------------------------------
// Paramètre aucun
// ----------------------------------------------------
// Méthode : DlgTraductions.BouExporter
// Description
// Méthode qui exporte les tableaux présents 



C_LONGINT:C283($Salé; $FT)
USE CHARACTER SET:C205("Macintosh"; 0)
$Doc:=Create document:C266("")
If (OK=1)
	$Ligne:="N°"+<>ZTab+"Français"+<>ZTab+"Anglais"+<>ZTab+"Russe"+<>ZTab+<>ZCR
	SEND PACKET:C103($Doc; $Ligne)
	$FT:=Size of array:C274(Colonne1)
	For ($Salé; 1; $FT)
		$Col1:=String:C10(Colonne3N{$Salé})
		$Col2:=Replace string:C233(Colonne1{$Salé}; <>ZCR; "£")
		$Col2:=Replace string:C233($Col2; Char:C90(10); "£")
		$Col2:=Replace string:C233($Col2; <>ZTab; " ")
		$Col3:=Replace string:C233(Colonne2{$Salé}; <>ZCR; "£")
		$Col3:=Replace string:C233($Col3; Char:C90(10); "£")
		$Col3:=Replace string:C233($Col3; <>ZTab; " ")
		$Col4:=Replace string:C233(Colonne3{$Salé}; <>ZCR; "£")
		$Col4:=Replace string:C233($Col4; Char:C90(10); "£")
		$Col4:=Replace string:C233($Col4; <>ZTab; " ")
		$Ligne:=$Col1+<>ZTab+$Col2+<>ZTab+$Col3+<>ZTab+$Col4+<>ZTab+<>ZCR
		SEND PACKET:C103($Doc; $Ligne)
	End for 
	CLOSE DOCUMENT:C267($Doc)
End if 
USE CHARACTER SET:C205(*; 0)

