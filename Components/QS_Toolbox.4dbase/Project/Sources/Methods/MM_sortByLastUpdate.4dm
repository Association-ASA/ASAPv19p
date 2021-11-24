//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 28/02/19, 13:27:20
  // ----------------------------------------------------
  // Méthode : CM_sortByLastUpdate
  // Description
  // $1 : listbox name
  // Paramètres
  // ----------------------------------------------------

ARRAY TEXT:C222($colNames;0)
ARRAY TEXT:C222($headerNames;0)
ARRAY POINTER:C280($colPtrs;0)
ARRAY POINTER:C280($headerPtrs;0)
ARRAY BOOLEAN:C223($colVisible;0)
ARRAY POINTER:C280($stylePtrs;0)
C_LONGINT:C283($headerNum;$HeaderNumber;$2)
C_TEXT:C284($1;$lbName;$col)

$lbName:=$1
$HeaderNumber:=$2
LISTBOX GET ARRAYS:C832(*;$lbName;$colNames;$headerNames;$colPtrs;$headerPtrs;$colVisible;$stylePtrs)
$headerNum:=Find in array:C230($headerPtrs;Self:C308)

$col:=$headerNames{$headerNum}

C_TEXT:C284($sortType)
$sortType:=Choose:C955(Form:C1466.toggleSort;"desc";"asc")
Use (Form:C1466.listboxDisplayed)
	Form:C1466.listboxDisplayed:=Form:C1466.listboxDisplayed.orderBy($col+" "+$sortType)
End use 
Form:C1466.toggleSort:=Not:C34(Form:C1466.toggleSort)