
C_LONGINT:C283($Salé;$FT)

$FT:=LISTBOX Get number of rows:C915(ListBoxTraduc)

$Titre:=OBJECT Get title:C1068(CacMasque)
If ($Titre="Ne voir que les lignes selectionnées")  // Il veut masquer les lignes non sélectionnées
	For ($Salé;1;$FT)
		TbLignesMasque{$Salé}:=Not:C34(ListBoxTraduc{$Salé})
	End for 
	OBJECT SET TITLE:C194(CacMasque;"Voir toutes les lignes selectionnées")
Else 
	For ($Salé;1;$FT)
		TbLignesMasque{$Salé}:=False:C215
	End for 
	OBJECT SET TITLE:C194(CacMasque;"Ne voir que les lignes selectionnées")
End if 