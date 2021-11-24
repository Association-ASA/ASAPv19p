QUERY:C277([Factures:15]; [Factures:15]DateFacture:4>=Date:C102("01/01/"+<>ZPermMille))
SELECTION TO ARRAY:C260([Factures:15]NumFacture:3; TbNumFactureEnCours)
SORT ARRAY:C229(TbNumFactureEnCours; <)

ZLBZNouveau("*")