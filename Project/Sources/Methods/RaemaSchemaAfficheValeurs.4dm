//%attributes = {}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 26/07/18, 19:28:02
// ----------------------------------------------------
// Paramètre aucun
// ----------------------------------------------------
// Méthode : RaemaSchemaAfficheValeurs
// Description
// // Méthode qui recrute et affiche les [RAEMAValeurs]
// en fonction de la ligne concernée

C_LONGINT:C283($Salé; $FT)
ARRAY LONGINT:C221(TbNumEnrValeurs; 0x0000)

// Rappel des [RAEMALignes] et affichage dans les tableaux
RELATE MANY:C262([RAEMALignes:22]UUID:1)
ORDER BY:C49([RAEMAValeurs:23]; [RAEMAValeurs:23]Identifiant:3; >)
SELECTION TO ARRAY:C260([RAEMAValeurs:23]NomEn:5; TbNomValeurEn\
; [RAEMAValeurs:23]NomFr:4; TbNomValeurFr\
; [RAEMAValeurs:23]Identifiant:3; TbIdentifiantValeur\
; [RAEMAValeurs:23]Arguments:6; TbArgumentsValeur)
LONGINT ARRAY FROM SELECTION:C647([RAEMAValeurs:23]; TbNumEnrValeurs)
$FT:=Size of array:C274(TbNomValeurFr)
ARRAY BOOLEAN:C223(TbEscamotage; $FT)
ARRAY BOOLEAN:C223(TbPrecision; $FT)
$GaffeCode:=False:C215
For ($Salé; 1; $FT)
	TbEscamotage{$Salé}:=OB Get:C1224(TbArgumentsValeur{$Salé}; "Escamotage"; Is boolean:K8:9)
	TbPrecision{$Salé}:=OB Get:C1224(TbArgumentsValeur{$Salé}; "Précision"; Is boolean:K8:9)
	$SupGel:=Num:C11(TbIdentifiantValeur{$Salé}[[3]]="A")
	If ($GaffeCode=False:C215)
		$GaffeCode:=Position:C15("a"; Substring:C12(TbIdentifiantValeur{$Salé}; 4))>0
	End if 
	TbIdentifiantValeur{$Salé}:=[RAEMALignes:22]Identifiant:3+String:C10($Salé; "00")
End for 
If ($GaffeCode) | (SuppValeur=True:C214)
	ARRAY TO SELECTION:C261(TbIdentifiantValeur; [RAEMAValeurs:23]Identifiant:3)
	SuppValeur:=False:C215
End if 
LISTBOX SELECT ROW:C912(*; "ValeursListBox"; 0; lk remove from selection:K53:3)
OBJECT SET VISIBLE:C603(*; "@lien"; False:C215)
OBJECT SET VISIBLE:C603(*; "@prec"; False:C215)
