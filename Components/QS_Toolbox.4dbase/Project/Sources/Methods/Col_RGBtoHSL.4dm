//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // Col_RGBtoHSL ( couleurRVB ; ->teinte ; ->saturation ; ->luminosité )

C_LONGINT:C283($1)  // couleur codée 0xRRGGBB
C_POINTER:C301($2;$3;$4)
C_LONGINT:C283($rouge;$vert;$bleu;$teinte;$luminosite;$saturation)

$rouge:=(($1 & 0x00FF0000) >> 16)*100/255
$vert:=(($1 & 0xFF00) >> 8)*100/255
$bleu:=($1 & 0x00FF)*100/255

Case of 
		
	: ($rouge>$vert) & ($vert=$bleu)  // 0
		
		$luminosite:=$rouge
		$saturation:=100*($luminosite-$bleu)/$luminosite
		$teinte:=0
		
	: ($rouge>$vert) & ($vert>$bleu)  // 1 à 59
		
		$luminosite:=$rouge
		$saturation:=100*($luminosite-$bleu)/$luminosite
		$teinte:=0+(60*(($vert-$bleu)/($rouge-$bleu)))  // plus le vert croit, plus le HUE croit
		
	: ($vert=$rouge) & ($rouge>$bleu)  // 60
		
		$luminosite:=$rouge
		$saturation:=100*($luminosite-$bleu)/$luminosite
		$teinte:=60
		
	: ($vert>$rouge) & ($rouge>$bleu)  // 61 à 119
		
		$luminosite:=$vert
		$saturation:=100*($luminosite-$bleu)/$luminosite
		$teinte:=60+(60*(($vert-$rouge)/($vert-$bleu)))  // plus le Rouge décroit, plus le HUE croit
		
	: ($vert>$bleu) & ($bleu=$rouge)  // 120
		
		$luminosite:=$vert
		$saturation:=100*($luminosite-$rouge)/$luminosite
		$teinte:=120
		
	: ($vert>$bleu) & ($bleu>$rouge)  // 121 à 179
		
		$luminosite:=$vert
		$saturation:=100*($luminosite-$rouge)/$luminosite
		$teinte:=120+(60*(($bleu-$rouge)/($vert-$rouge)))  // plus le bleu croit, plus le HUE croit
		
	: ($bleu=$vert) & ($vert>$rouge)  // 180
		
		$luminosite:=$vert
		$saturation:=100*($luminosite-$rouge)/$luminosite
		$teinte:=180  // 180
		
	: ($bleu>$vert) & ($vert>$rouge)  // 181 à 239
		$luminosite:=$bleu
		$saturation:=100*($luminosite-$rouge)/$luminosite
		$teinte:=180+(60*(($bleu-$vert)/($bleu-$rouge)))  // plus le Vert décroit, plus le HUE croit
		
	: ($bleu>$rouge) & ($rouge=$vert)  // 240
		$luminosite:=$bleu
		$saturation:=100*($luminosite-$vert)/$luminosite
		$teinte:=240
		
	: ($bleu>$rouge) & ($rouge>$vert)  // 241 à 299
		
		$luminosite:=$bleu
		$saturation:=100*($luminosite-$vert)/$luminosite
		$teinte:=240+(60*(($rouge-$vert)/($bleu-$vert)))  // plus le rouge croit, plus le HUE croit
		
	: ($rouge=$bleu) & ($bleu>$vert)  // 300
		
		$luminosite:=$bleu
		$saturation:=100*($luminosite-$vert)/$luminosite
		$teinte:=300
		
	: ($rouge>=$bleu) & ($bleu>=$vert)
		
		$luminosite:=$rouge
		$saturation:=100*($luminosite-$vert)/$luminosite
		$teinte:=300+(60*(($rouge-$bleu)/($rouge-$vert)))  // plus le Bleu décroit, plus le HUE croit
		
	: ($rouge=$bleu) & ($bleu=$vert)
		$luminosite:=$bleu  // or red or green
		$saturation:=0
		$teinte:=0
		
End case 

If ($teinte>=0)
	
	$2->:=$teinte
	$3->:=$saturation
	$4->:=$luminosite
	
End if 