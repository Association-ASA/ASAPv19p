//%attributes = {"invisible":true,"preemptive":"capable","publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedWeb":false,"publishedSql":false,"published4DMobile":{"scope":"none"},"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 16/05/18, 07:03:30
  // ----------------------------------------------------
  // Paramètres
  // $1 = Pointer on 'Start' of indentation
  // $2 = Pointer on 'End' of indentation
  // $3 =Pointer on 'Neutral' of indentation
  // ----------------------------------------------------
  // Méthode : INDENT_StartUp
  // Description
  //  
C_POINTER:C301($1;$2;$3)

ARRAY TEXT:C222($1->;8)
ARRAY TEXT:C222($2->;8)
ARRAY TEXT:C222($3->;2)
$i:=0

$langage:=Config_getLanguage 

$i:=$i+1
$1->{$i}:=Choose:C955($langage="fr";"Si (";"If (")
$3->{$i}:=Choose:C955($langage="fr";"Sinon";"Else")
$2->{$i}:=Choose:C955($langage="fr";"Fin de si";"End if")

$i:=$i+1
$1->{$i}:=Choose:C955($langage="fr";"Au cas ou";"Case of")
$3->{$i}:=":"
$2->{$i}:=Choose:C955($langage="fr";"Fin de cas";"End case")

$i:=$i+1
$1->{$i}:=Choose:C955($langage="fr";"Tant que";"While")
$2->{$i}:=Choose:C955($langage="fr";"Fin tant que";"End while")

$i:=$i+1
$1->{$i}:=Choose:C955($langage="fr";"Pour chaque (";"For each (")
$2->{$i}:=Choose:C955($langage="fr";"Fin de chaque";"End for each")

$i:=$i+1
$1->{$i}:=Choose:C955($langage="fr";"Boucle (";"For (")
$2->{$i}:=Choose:C955($langage="fr";"Fin de boucle";"End for\r")

$i:=$i+1
$1->{$i}:=Choose:C955($langage="fr";"Repeter";"Repeat")
$2->{$i}:=Choose:C955($langage="fr";"Jusque";"Until")

$i:=$i+1
$1->{$i}:=Choose:C955($langage="fr";"Debut SQL";"Begin SQL")
$2->{$i}:=Choose:C955($langage="fr";"Fin SQL";"End SQL")

$i:=$i+1
$1->{$i}:=Choose:C955($langage="fr";"Utiliser (";"Use (")
$2->{$i}:=Choose:C955($langage="fr";"Fin utiliser";"End use\r")
