C_LONGINT:C283($C;$L)
LISTBOX GET CELL POSITION:C971(ListBoxTextes;$C;$L)
$ID:=Colonne4N{$L}  // récupération du num d'enregistrement
$Ordre:=Colonne3N{$L}
$Niveau:=Colonne2N{$L}
$Titre:=Colonne1{$L}
CREATE RECORD:C68([DiaTextesWebParagraphes:37])
[DiaTextesWebParagraphes:37]NiveauTitre:13:=$Niveau+1
GET HIGHLIGHT:C209(VarTexte;$deb;$fin)
[DiaTextesWebParagraphes:37]TitreParagraphe:6:=Substring:C12(VarTexte;$deb;($fin-$deb))
[DiaTextesWebParagraphes:37]CorpsParagraphe:8:=Substring:C12(VarTexte;($fin+1))
$NbreZerosId:=10^(6-$Niveau)
$NbreZerosBorne:=10^(6-$Niveau+1)
$OrdreA:=String:C10($Ordre)
$Suivant:=(Num:C11(Substring:C12($OrdreA;1;$Niveau-1))+1)*$NbreZerosBorne
$L:=Find in array:C230(Colonne3N;$Suivant)
If ($L>0)  // La borne supérieure existe
	$PrecedentA:=String:C10(Colonne3N{$L-1})
	$RadicalN:=Num:C11(Substring:C12($PrecedentA;1;$Niveau))+1
	[DiaTextesWebParagraphes:37]OrdreAffichage:12:=$RadicalN*$NbreZerosId
Else   // pas de borne supérieure
	$RadicalN:=(Num:C11(Substring:C12($OrdreA;1;($Niveau+1)))+1)
	[DiaTextesWebParagraphes:37]OrdreAffichage:12:=$RadicalN*(10^(6-$Niveau-1))
End if 

If ([DiaTextesWebParagraphes:37]TitreParagraphe:6#"")
	[DiaTextesWebParagraphes:37]IDTexte:7:=VarIDTexte
	SAVE RECORD:C53([DiaTextesWebParagraphes:37])
	$ID:=Record number:C243([DiaTextesWebParagraphes:37])
	DiaWebTextesAfficheGestion 
End if 

GOTO RECORD:C242([DiaTextesWebParagraphes:37];$ID)  // Remise sur la ligne d'origine ou a nouvelle
$L:=Find in array:C230(Colonne4N;$ID)
LISTBOX SELECT ROW:C912(ListBoxTextes;$L)
VarTexte:=[DiaTextesWebParagraphes:37]CorpsParagraphe:8