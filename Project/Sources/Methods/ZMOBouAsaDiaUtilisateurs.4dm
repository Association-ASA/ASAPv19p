//%attributes = {"lang":"fr"}
ARRAY TEXT:C222(TbMethodeLapin; 0)
C_OBJECT:C1216($ObParam)
C_TEXT:C284($Chemin)
READ ONLY:C145([DiaUtilisateurs:14])
QUERY:C277([DiaUtilisateurs:14]; [DiaUtilisateurs:14]Caduc:13=False:C215)

$Chemin:="Images/Buttons/AsaDiaUtilisateurs.png"
$CDImage:=Get 4D folder:C485(Dossier Resources courant:K5:16)+Replace string:C233($Chemin; "/"; Séparateur dossier:K24:12)

OB SET:C1220($ObParam\
; "Champ significatif"; ->[DiaUtilisateurs:14]EmailASA:12\
; "Chemin logo"; $CDImage\
; "Saisie"; "Saisie"\
; "Sortie"; "Liste"\
; "Fiche"; "Saisie"\
; "Gestion ensemble"; True:C214)
ZLBGèreListe($ObParam)