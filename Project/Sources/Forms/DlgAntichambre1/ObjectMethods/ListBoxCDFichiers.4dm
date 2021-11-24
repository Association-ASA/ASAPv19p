
$evt:=Form event code:C388
C_LONGINT:C283($C; LigneClic)
LISTBOX GET CELL POSITION:C971(*; "ListBoxCDFichiers"; $C; LigneClic)

Case of 
	: ($evt=Sur nouvelle sélection:K2:29)
		If (Macintosh command down:C546)
			DiaACClicLBCandidats
		Else 
			DiaACClicLBCandidats(True:C214)
		End if 
		
	: ($evt=Sur double clic:K2:5)
		OPEN URL:C673(TbCheminFichier{LigneClic})
End case 
