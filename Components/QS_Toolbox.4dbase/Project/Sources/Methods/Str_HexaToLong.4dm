//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // Str_HexaToLong("chaine hexa")-> entier long
  // par Keisuke MIYAKO
  // voir aussi MATHS_entierVersHexa

C_TEXT:C284($1;$chaineHexa)
C_LONGINT:C283($0;$i;$resultat;$pos;$offset)

$resultat:=0
$offset:=0

$chaineHexa:=$1

If (Length:C16($chaineHexa)<=8)  // 4*8=32 bits
	
	For ($i;Length:C16($chaineHexa);1;-1)
		
		$pos:=Position:C15($chaineHexa[[$i]];"0123456789abcdef")-1  // entre 0 et 15
		
		If ($pos=No current record:K29:2)
			$i:=1  // sortie de boucle si incohérence
			
		Else 
			$resultat:=$resultat+($pos << $offset)
			$offset:=$offset+4
		End if 
		
	End for 
End if 

$0:=$resultat