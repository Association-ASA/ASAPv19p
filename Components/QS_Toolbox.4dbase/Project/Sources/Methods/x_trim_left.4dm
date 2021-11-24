//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  //Cette méthode élimine les espaces superflus situés à DROITE d'une chaîne passée en param $1.

C_TEXT:C284($txt)
$txt:=$1

C_LONGINT:C283($j;$i;$len)
$j:=0
$len:=Length:C16($txt)
For ($i;1;$len)
	If ($txt[[$i]]#" ")  //Si ce n'est pas un espace...
		$j:=$i-1
		$i:=Length:C16($txt)+$i  //Forcer la boucle à stopper
	End if 
End for 
$0:=Delete string:C232($txt;1;$j)  //Suppression des espaces

