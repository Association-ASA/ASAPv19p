// ----------------------------------------------------
// Nom utilisateur (OS) : MBPASA2015
// Date et heure : 29/03/16, 14:04:08
// ----------------------------------------------------
// Méthode : DlgTraductions.BouPlus
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($C; $L)
LISTBOX GET CELL POSITION:C971(ListBoxTraduc; $C; $L)
If ($L>0)
	LISTBOX INSERT ROWS:C913(ListBoxTraduc; $L+1)
	Colonne3N{$L}:=Max:C3(Colonne3N)+1
	EDIT ITEM:C870(Colonne1{$L+1})
End if 