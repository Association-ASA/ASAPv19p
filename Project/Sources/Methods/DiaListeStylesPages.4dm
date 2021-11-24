//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : cgm
// Date et heure : 29/12/15, 17:44:34
// ----------------------------------------------------
// Méthode : ListeStylesPages
// Description
// Permet de gérer les pages concernées par les styles CSS
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($Salé; $Pos; $FT; $L; $Fumé; $SFT)
$CD:=Get 4D folder:C485(Dossier racine HTML:K5:20)
DOCUMENT LIST:C474($CD; $TbNomsPages)
$Guil:=Char:C90(Guillemets:K15:41)

$FT:=Size of array:C274($TbNomsPages)
ARRAY TEXT:C222($TbStyleG; 0)
ARRAY TEXT:C222($TbNomsPagesStyles; 0)  // les avec styles

For ($Salé; 1; $FT)
	$Nom:=$TbNomsPages{$Salé}
	$CDPage:=$CD+$Nom
	$Doc:=Open document:C264($CDPage; Mode lecture:K24:5)
	RECEIVE PACKET:C104($Doc; $Page; 10000000)
	$Test:=" class="+$Guil
	$PtTb:=Get pointer:C304($Nom)
	ARRAY TEXT:C222($PtTb->; 0)
	$PtTN:=Get pointer:C304("N"+$Nom)
	ARRAY LONGINT:C221($PtTN->; 0)
	$Prem:=True:C214
	Repeat 
		$Pos:=Position:C15(" class="; $Page)
		If ($Pos>0)  // Il existe un style
			$Page:=Substring:C12($Page; ($Pos+8))
			$Pos:=Position:C15($Guil; $Page)
			$NomStyle:=Substring:C12($Page; 1; ($Pos-1))
			
			
			If (Length:C16($NomStyle)<50) & (Length:C16($NomStyle)>0)  // évite les pb des ' à la place des "
				If ($Prem)
					APPEND TO ARRAY:C911($TbNomsPagesStyles; $Nom)
					$Prem:=False:C215
				End if 
				// Remplissage des tableaux de la page
				$L:=Find in array:C230($PtTb->; $NomStyle)
				If ($L<0)
					APPEND TO ARRAY:C911($PtTb->; $NomStyle)
					APPEND TO ARRAY:C911($PtTN->; 1)
					
				Else 
					$PtTN->{$L}:=$PtTN->{$L}+1
				End if 
				
				// Remplissage du tableau général
				$L:=Find in array:C230($TbStyleG; $NomStyle)
				If ($L<0)
					APPEND TO ARRAY:C911($TbStyleG; $NomStyle)
				End if 
				
			End if 
			
		End if 
	Until ($Pos=0)
	CLOSE DOCUMENT:C267($Doc)
End for 

COPY ARRAY:C226($TbNomsPagesStyles; Colonne1)
LISTBOX SET COLUMN WIDTH:C833(Colonne1; 180)
SORT ARRAY:C229($TbStyleG; >)
$FT:=Size of array:C274($TbStyleG)
For ($Salé; 1; $FT)  // Pour chaque style
	$NomS:=$TbStyleG{$Salé}
	$Der:=LISTBOX Get number of columns:C831(ListBoxStyles)+1
	$NomCol:="Tb"+$Nom
	$PtTbCol:=Get pointer:C304("Col"+String:C10($Salé))
	ARRAY LONGINT:C221($PtTbCol->; 0)
	$NomET:="VarET"+String:C10($Salé)
	$PtVarET:=Get pointer:C304("VarET"+String:C10($Salé))
	LISTBOX INSERT COLUMN:C829(ListBoxStyles; $Der; $NomCol; $PtTbCol->; $NomET; $PtVarET->)
	OBJECT SET TITLE:C194($PtVarET->; $NomS)
	OBJECT SET HORIZONTAL ALIGNMENT:C706($PtTbCol->; Aligné au centre:K42:3)
	LISTBOX SET COLUMN WIDTH:C833($PtTbCol->; (8*Length:C16($NomS)))
	
	$SFT:=Size of array:C274(Colonne1)
	For ($Fumé; 1; $SFT)  // Pour chaque page
		$NomPage:=Colonne1{$Fumé}
		$PtTb:=Get pointer:C304($NomPage)
		$PtTN:=Get pointer:C304("N"+$NomPage)
		$L:=Find in array:C230($PtTb->; $NomS)
		APPEND TO ARRAY:C911($PtTbCol->; $PtTN->{$L})
	End for 
	
End for 
LISTBOX SET LOCKED COLUMNS:C1151(ListBoxStyles; 1)
