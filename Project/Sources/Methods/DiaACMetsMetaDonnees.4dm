//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 18/04/20, 06:26:46
// ----------------------------------------------------
// Méthode : AntichambreMetsMetaDonnees
// Description
// Méthode qui place dans l'image VarImage
//  les métadonnées descriptives de la photo
// ----------------------------------------------------

ARRAY TEXT:C222($TbMC; 7)
$TbMC{1}:=[Diapositives:40]Auteur:10
$TbMC{2}:=[Diapositives:40]Origine:11
$TbMC{3}:=[Diapositives:40]Espece:3
$TbMC{4}:=[Diapositives:40]Organe:2
$TbMC{5}:=Lowercase:C14(Uppercase:C13([Diapositives:40]NomLesion:4))
$TbMC{6}:="AsaDia"
$TbMC{7}:="Photo "+String:C10([Diapositives:40]NumOrdreDiapos:1)
$Meta:="Photo n°"+String:C10([Diapositives:40]NumOrdreDiapos:1)
$Meta:=$Meta+"       "+[Diapositives:40]Auteur:10
$Meta:=$Meta+"       "+[Diapositives:40]Origine:11+<>ZCR
$esp:=[Diapositives:40]Espece:3
$esp:=Substring:C12($esp; 1; Length:C16($esp)-1)
$esp:=Lowercase:C14(Substring:C12($esp; 1; 1))+Substring:C12($esp; 2)
$NL:=Uppercase:C13(Substring:C12([Diapositives:40]NomLesion:4; 1; 1))+Substring:C12([Diapositives:40]NomLesion:4; 2)
$NL:=Lowercase:C14($NL)
$Meta:=$Meta+$NL+" sur "+[Diapositives:40]Organe:2+" chez un "+$esp+"."+Char:C90(13)
$Meta:=$Meta+"Commentaire : "+Lowercase:C14(Uppercase:C13([Diapositives:40]Commentaires:7))
SET PICTURE METADATA:C1121(VarImage; IPTC caption abstract:K68:100; $Meta)
SET PICTURE METADATA:C1121(VarImage; IPTC Keywords:K68:118; $TbMC)
SET PICTURE METADATA:C1121(VarImage; IPTC copyright notice:K68:106; "ASA : tous droits réservés")


