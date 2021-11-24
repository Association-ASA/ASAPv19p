//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Eloïse
  // Date et heure : 26/05/21, 14:07:03
  // ----------------------------------------------------
  // Méthode : ASAPCalculDerNumLabo
  // Description
  // Méthode qui permet de calculer le dernier numéro de 
  // labo utilisé, numéro supplémentaire compris et ajout 1
  // 
  // Paramètres
  // $O:= Prochain numéro de labo (en numérique)
  // ----------------------------------------------------

ALL RECORDS:C47([Personnes:12])
QUERY:C277([Personnes:12];[Personnes:12]TypePersonne:5="Laboratoire")

$FT:=Records in selection:C76([Personnes:12])
ARRAY LONGINT:C221(<>TbNumLaboUtilisés;0)
SELECTION TO ARRAY:C260([Personnes:12]UUID:1;$TbUUIDPersonne;[Personnes:12]Identificateur:4;$TbMdpLabo)
For ($Salé;1;$FT)
	$NumLabo:=RAEMADemoduleMdPWeb ($TbMdpLabo{$Salé})
	$L:=Find in array:C230(<>TbNumLaboUtilisés;$NumLabo)
	If ($L<0)
		APPEND TO ARRAY:C911(<>TbNumLaboUtilisés;$NumLabo)
	End if 
End for 

QUERY BY ATTRIBUTE:C1331([CampagneParticipations:17];[CampagneParticipations:17]Arguments:5;"CodeRaemaLié";#;Null:C1517)

$FT2:=Records in selection:C76([CampagneParticipations:17])
  //SÉLECTION VERS TABLEAU([CampagneParticipations]UUIDPersonne;$TbUUIDLabo)
For ($Salé;1;$FT2)
	$Codelié:=OB Get:C1224([CampagneParticipations:17]Arguments:5;"CodeRaemaLié")
	$NumLabo:=RAEMADemoduleMdPWeb ($Codelié)
	$L:=Find in array:C230(<>TbNumLaboUtilisés;$NumLabo)
	If ($L<0)
		APPEND TO ARRAY:C911(<>TbNumLaboUtilisés;$NumLabo)
	End if 
	NEXT RECORD:C51([CampagneParticipations:17])
End for 
SORT ARRAY:C229(<>TbNumLaboUtilisés;<)
$NumDerLabo:=<>TbNumLaboUtilisés{1}+1
$0:=$NumDerLabo


