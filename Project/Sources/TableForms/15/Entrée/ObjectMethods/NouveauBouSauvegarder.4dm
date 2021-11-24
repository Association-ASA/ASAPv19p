READ WRITE:C146([Ventes:16])
RELATE MANY:C262([Factures:15]NumFacture:3)
$FT:=Records in selection:C76([Ventes:16])
ARRAY DATE:C224($TbDateReglement; $FT)
ARRAY TEXT:C222($TbNumCheque; $FT)
ARRAY TEXT:C222($TbBanque; $FT)
For ($Salé; 1; $FT)
	$TbDateReglement{$Salé}:=VarDateReglement
	$TbNumCheque{$Salé}:=VarNumCheque
	$TbBanque{$Salé}:=VarBanque
End for 
ARRAY TO SELECTION:C261($TbBanque; [Ventes:16]Banque:10\
; $TbNumCheque; [Ventes:16]NumCheque:11\
; $TbDateReglement; [Ventes:16]DateReglement:12)

[Factures:15]SommeReglee:13:=VarSommeRéglée
[Factures:15]Regle:12:=True:C214
SAVE RECORD:C53([Factures:15])
ALERT:C41("Le paiement a bien été enregistré")