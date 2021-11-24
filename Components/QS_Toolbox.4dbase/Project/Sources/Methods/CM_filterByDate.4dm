//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 21/02/19, 16:29:52
  // Paramètres
  // ----------------------------------------------------
  // $1 : Object (row)
  // $2 : limit date to accept the data
  // ----------------------------------------------------
  // Méthode : CM_filterByDate
  // Description
  // callback function to select row to display
  // See why .filter() is used
  // https://forums.4d.com/Post/FR/28656363/1/28661721#28661721

C_OBJECT:C1216($1)
C_DATE:C307($2)
C_TEXT:C284($3)

$1.result:=False:C215  // By default, not displayed

If (Date:C102($1.value.lastUpdate)>=$2)  //& ($1.value.path=$3)
	$1.result:=True:C214
End if 


