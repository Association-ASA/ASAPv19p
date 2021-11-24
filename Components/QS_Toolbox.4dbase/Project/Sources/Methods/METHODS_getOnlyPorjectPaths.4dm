//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 21/05/18, 21:19:27
  // ----------------------------------------------------
  // Paramètres
  // $1 = Pointer to the array
  // ----------------------------------------------------
  // Méthode : METHODS_Get_Paths_Project
  // Description
  // Get project method list and remove COMPILER@ methods
  // Result array is sorted


C_POINTER:C301($1;$List)

ASSERT:C1129(Type:C295($1)=Is pointer:K8:14;"$1 must be a pointer")

$List:=$1
METHOD GET PATHS:C1163(Path project method:K72:1;$List->;*)
METHODS_Remove_Compilers ($List)
SORT ARRAY:C229($List->;>)
