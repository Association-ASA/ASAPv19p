//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : ASA
// Date et heure : 04/11/20, 15:34:40
// ----------------------------------------------------
// Méthode : ASAPTrouveDerNumLabo
// Description
// Méthode qui permet de trouver le dernier numéro de labo attribué
// ----------------------------------------------------
C_LONGINT:C283($0)
COPY ARRAY:C226(<>TbPerNumLaboRAEMA; $TbNumLabo)
QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];  & ; [CampagneParticipations:17]Arguments:5; "CodeRaemaLié"; #; Null:C1517)
SELECTION TO ARRAY:C260([CampagneParticipations:17]Arguments:5; $TbArg)
$TT:=Size of array:C274($TbArg)
For ($Salé; 1; $TT)
	$NumLaboLié:=RAEMADemoduleMdPWeb($TbArg{$salé}.CodeRaemaLié)
	If (Find in array:C230($TbNumLabo; $NumLaboLié)<0)
		APPEND TO ARRAY:C911($TbNumLabo; $NumLaboLié)
	End if 
End for 
$0:=Max:C3($TbNumLabo)
