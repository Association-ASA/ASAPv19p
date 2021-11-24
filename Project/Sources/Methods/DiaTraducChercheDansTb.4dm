//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 02/04/19, 14:34:41
// ----------------------------------------------------
// Méthode : Ad3TraducChercheDansTb
// Description
//   Méthode générique de rechercchez d'un terme
//    dans les tableaux de traduction du formulaire "DlgTraduction" 
// ----------------------------------------------------

$PtColonne:=$1

$TE:=Get edited text:C655
If (Length:C16($TE)>1)
	$test:="@"+$TE+"@"
	$L:=Find in array:C230($PtColonne->; $test)
	If ($L>0)
		$LAnc:=$L
		LISTBOX SELECT ROW:C912(ListBoxTraduc; $L)
		$Compteur:=0
		While ($L>0)
			LISTBOX SELECT ROW:C912(ListBoxTraduc; $L; lk ajouter à sélection:K53:2)
			$L:=Find in array:C230($PtColonne->; $test; ($L+1))
			$Compteur:=$Compteur+1
		End while 
		OBJECT SET SCROLL POSITION:C906(ListBoxTraduc; $LAnc)
		VarNbSouligne:=$Compteur
	Else 
		ALERT:C41("Je n'ai pas trouvé "+<>ZGuil+$TE+<>ZGuil+" dans le tableau...")
		LISTBOX SELECT ROW:C912(ListBoxTraduc; 0; lk supprimer de sélection:K53:3)
		VarNbSouligne:=0
	End if 
End if 
