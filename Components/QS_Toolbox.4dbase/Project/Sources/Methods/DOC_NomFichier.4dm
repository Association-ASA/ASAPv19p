//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // méthode projet Nom long vers nom de fichier
  // nom long vers nom de fichier ( Chaîne ) -> Chaîne
  // nom long vers nom de fichier ( nom long ) -> nom de fichier

C_LONGINT:C283($i;$2)
C_TEXT:C284($1;$0;$CheminAcces)

$CheminAcces:=$1
$i:=Length:C16($CheminAcces)

If ($i#0)
	
	If ($CheminAcces[[$i]]=Folder separator:K24:12)  // on enlève les deux points finaux ou le slash
		$i:=$i-1
		$CheminAcces:=Substring:C12($CheminAcces;1;$i)
	End if 
	
	$a:=$i
	
	While ($i>0)
		
		If ($CheminAcces[[$i]]#Folder separator:K24:12)
			$i:=$i-1
		Else 
			$a:=$i
			$i:=0
		End if 
		
	End while 
	
	$i:=$a
	
	If ($2=1)
		$0:=Substring:C12($CheminAcces;$i+1)  // on retourne le nom du document
	Else 
		$0:=Substring:C12($CheminAcces;1;$i)  // on retourne le chemin d'accès
	End if 
	
Else   // chaîne vide
	
	$0:=""
	
End if 
