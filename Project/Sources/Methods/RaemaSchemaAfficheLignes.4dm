//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 26/07/18, 19:23:51
  // ----------------------------------------------------
  // Paramètre aucun
  // ----------------------------------------------------
  // Méthode : RaemaSchemaAfficheLignes
  // Description
  // Méthode qui affiche la sélection des lignes
  // en fonction du germe sélectionné

C_LONGINT:C283($Salé;$FT)

  // Rappel des [RAEMALignes] et affichage dans les tableaux
RELATE MANY:C262([RAEMAGermes:21]UUID:1)
ORDER BY:C49([RAEMALignes:22];[RAEMALignes:22]Identifiant:3;>)
SELECTION TO ARRAY:C260([RAEMALignes:22]NomEn:5;TbNomLigneEn\
;[RAEMALignes:22]NomFr:4;TbNomLigneFr\
;[RAEMALignes:22]Arguments:6;TbArgumentsLigne\
;[RAEMALignes:22]UUID:1;$TbUUIDLigne\
;[RAEMALignes:22]Identifiant:3;TbIdentifiantLigne)
LONGINT ARRAY FROM SELECTION:C647([RAEMALignes:22];TbNumEnrLigne)

$GaffeCode:=(Find in array:C230(TbIdentifiantLigne;"@a")>0)
$FT:=Size of array:C274(TbNomLigneFr)
ARRAY BOOLEAN:C223(TbEscamotable;$FT)
ARRAY BOOLEAN:C223(TbMultiple;$FT)
For ($Salé;1;$FT)
	TbEscamotable{$Salé}:=OB Get:C1224(TbArgumentsLigne{$Salé};"Escamotable";Est un booléen:K8:9)
	TbMultiple{$Salé}:=OB Get:C1224(TbArgumentsLigne{$Salé};"ChoixMultiple";Est un booléen:K8:9)
	$SupGel:=Num:C11(TbIdentifiantLigne{$Salé}[[3]]="A")
	If ($GaffeCode)
		TbIdentifiantLigne{$Salé}:=Substring:C12(TbIdentifiantLigne{$Salé};1;(4+$SupGel))+String:C10($Salé;"00")
	End if 
End for 
If ($GaffeCode)
	ARRAY TO SELECTION:C261(TbIdentifiantLigne;[RAEMALignes:22]Identifiant:3)
End if 

If ($GaffeCode) | (Supp=True:C214)
	SELECTION TO ARRAY:C260([RAEMALignes:22]Identifiant:3;$TbIDLigne;[RAEMALignes:22]UUID:1;$TbUUIDLigne)
	READ WRITE:C146([RAEMAValeurs:23])
	  //$ID:=Sous chaîne($TbIDLigne{1};1;4)
	  //CHERCHER([RAEMAValeurs];[RAEMAValeurs]Identifiant=($ID+"@"))
	  //SÉLECTION VERS TABLEAU([RAEMAValeurs]Identifiant;$IDValeurs;[RAEMAValeurs]UUIDLigne;$UUIDLigneValeur)
	$TT:=Size of array:C274($TbUUIDLigne)
	For ($Salé;1;$TT)
		QUERY:C277([RAEMAValeurs:23];[RAEMAValeurs:23]UUIDLigne:2=$TbUUIDLigne{$Salé})
		ORDER BY:C49([RAEMAValeurs:23];[RAEMAValeurs:23]Identifiant:3;>)
		$FT:=Records in selection:C76([RAEMAValeurs:23])
		For ($Fumé;1;$FT)
			[RAEMAValeurs:23]Identifiant:3:=$TbIDLigne{$Salé}+String:C10($Fumé;"00")
			SAVE RECORD:C53([RAEMAValeurs:23])
			NEXT RECORD:C51([RAEMAValeurs:23])
		End for 
	End for 
	If (Supp=True:C214)
		QUERY:C277([RAEMAValeurs:23];[RAEMAValeurs:23]UUIDLigne:2=UUIDLigneSupp)
		If (Records in selection:C76([RAEMAValeurs:23])>0)
			DELETE SELECTION:C66([RAEMAValeurs:23])
		End if 
	End if 
	Supp:=False:C215
End if 
OBJECT SET ENTERABLE:C238(TbNomLigneFr;False:C215)
OBJECT SET ENTERABLE:C238(TbNomLigneEn;False:C215)
LISTBOX SELECT ROW:C912(*;"LignesListBox";0;lk supprimer de sélection:K53:3)

OBJECT SET ENABLED:C1123(*;"LigneBouColler";(Size of array:C274(TbNECopierLigne)>0))
