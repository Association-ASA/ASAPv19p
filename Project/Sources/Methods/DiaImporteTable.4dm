//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 13/07/20, 14:56:48
// ----------------------------------------------------
// Méthode : ASAPImporteTable
// Description
// Méthode d'importation des données d'AsaDia dans ASAP 
// Paramètres : $1=Pt sur la table concernée
//             {$2} si non suppression des enregistrements existants
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT; $NumTable; $Type)
C_POINTER:C301($1; $PtTable)
$PtTable:=$1
$NumTable:=Table:C252($PtTable)
$Annonce:=Table name:C256($PtTable)
READ WRITE:C146($PtTable->)
If (Count parameters:C259=1)
	ALL RECORDS:C47($PtTable->)
	DELETE SELECTION:C66($PtTable->)
End if 
$CD:=System folder:C487(Bureau:K41:16)+$Annonce+".txt"
If (Test path name:C476($CD)#Est un document:K24:1)
	ALERT:C41("L'exportation de la table n'est pas sur le bureau")
Else 
	SET CHANNEL:C77(13; $CD)
	If (OK=1)
		RECEIVE VARIABLE:C81($Var)  // $Annonce
		If ($Var#$Annonce)
			ALERT:C41("le fichier ne semble pas être le bon...")
		Else 
			DEFAULT TABLE:C46($PtTable->)
			RECEIVE VARIABLE:C81($Var)
			While ($Var="une autre")
				RECEIVE RECORD:C79
				SAVE RECORD:C53
				$Var:=""
				RECEIVE VARIABLE:C81($Var)
			End while 
		End if 
	End if 
	SET CHANNEL:C77(11)
End if 