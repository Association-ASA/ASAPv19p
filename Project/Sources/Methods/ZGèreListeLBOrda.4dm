//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 07/05/18, 12:13:41
// ----------------------------------------------------
// Pas de paramètres
// ----------------------------------------------------
// Méthode : ZGèreListeLBOrda
// Description
// Anciennement
// ZGèreListeLB (->[XUtilisateurs]Nom;$CDImage;"Entrée";"Fiche";"")

var $ObParam : Object
var $CDImage : 4D:C1709.File

$table:="Personnes"

$ObParam:=New object:C1471

$SurChargementSaisie:="ASAPSurChargementSaisieLabo"
$CDImage:=Folder:C1567(fk dossier ressources:K87:11).file("Images/Buttons/laboratoire.png")

$coll:=New collection:C1472
$coll.push(New object:C1471("titre"; "Laboratoire avec RAEMA liés"; "methode"; "GATrouveRaemaLies"))
$coll.push(New object:C1471("titre"; "Accéder au loto"; "methode"; "RaemaLotoAffiche"))
$coll.push(New object:C1471("titre"; "Gestion des demandes de RAEMA Gel"; "methode"; "WebDevisGestionDemandes"))
$coll.push(New object:C1471("titre"; "Envoyer un courriel"; "methode"; "ASAPEnvoiCourrielLabo"))

//VarModifPer:=False
//VarModifPar:=False

OB SET:C1220($ObParam\
; "Champ significatif"; "NomLong"\
; "Champ clefs"; "ChampRecherche"\
; "Chemin logo"; $CDImage.platformPath\
; "Saisie"; "SaisieLabo"\
; "Sortie"; "Liste"\
; "Fiche"; "Fiche"\
; "Avant"; "ASAPSurChargementSaisieLabo"\
; "Après"; "ASAPSurValidationSaisieLabo"\
; "Sur destruction"; "ZBoumPersonne"\
; "Dialogue"; ""\
; "Gestion tableaux"; True:C214)

$ObParam.modifPer:=False:C215
$ObParam.modifPar:=False:C215
$ObParam["Gestion ensemble"]:=True:C214
$ObParam["Méthode lapin"]:=$coll
$ObParam.premiereOuverture:=True:C214
$ObParam.gestionFixe:=(OB Get:C1224($ObParam; "Dialogue"; Est un texte:K8:3)#"")
$ObParam.table:=$table
$ObParam.ajoutEnr:=False:C215
$ObParam.tri:="asc"  // "desc"
$ObParam.champFiltre:="TypePersonne = 'Laboratoire'"

ZLBGereListeOrda($ObParam)