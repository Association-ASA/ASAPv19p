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
	LISTBOX DELETE ROWS:C914(ListBoxTraduc; $L)
	If (PUMTraduc=5)  // Seulement pour les textes
		READ WRITE:C146([DiaData:45])
		QUERY:C277([DiaData:45]; [DiaData:45]XNom:1="TbTraducTexte"; *)
		QUERY:C277([DiaData:45];  & [DiaData:45]XType:5="TbTra")
		ZVariableVersBlob(->[DiaData:45]XBlob:11; ->Colonne1; ->Colonne2)
		SAVE RECORD:C53([DiaData:45])
		ZAmnistiePartielle(->[DiaData:45])
	End if 
	
End if 