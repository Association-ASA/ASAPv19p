//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 18/07/20, 11:35:59
  // ----------------------------------------------------
  // Méthode : YAjusteNumAutomatique
  // Description
  // Méthode qui remet la numérotation automatique d'une table
  //   en harmonie avec les données
  // Paramètre : $1 Pt sur champ de numérotation automatique
  // ----------------------------------------------------
C_LONGINT:C283($NumTable;$DerIndice;$DerNum)
C_POINTER:C301($PtChamp;$1)

$PtChamp:=$1
$NumTable:=Table:C252($PtChamp)
$PtTable:=Table:C252($NumTable)
ALL RECORDS:C47($PtTable->)
$DerIndice:=Max:C3($PtChamp->)
$DerNum:=Sequence number:C244($PtTable->)
SET DATABASE PARAMETER:C642($PtTable->;31;$DerIndice)
