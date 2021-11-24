//%attributes = {"invisible":true,"preemptive":"capable"}
  // COLOR_HSLtoRGB  ( ->teinte ; ->saturation ; ->luminosité ) -> couleur
  // teinte de 0 à 360
  // saturation de 0 à 100
  // luminosité de 0 à 100
  // voir aussi :  Color_RGBtoHSL

C_LONGINT:C283($0;$1;$2;$3;$teinte;$saturation;$luminosite;$couleur;$rouge;$vert;$bleu;$mini;$maxi;$ecart)

$teinte:=$1%360  // 0 à 360°
$saturation:=$2  // 0 à 100%
$luminosite:=$3  // 0 à 100%

$maxi:=$luminosite*255/100  // RGB 0..255
$mini:=$maxi*((100-$saturation)/100)
$ecart:=$maxi-$mini

Case of 
		
	: ($teinte>=300)
		
		$teinte:=$teinte-300
		$rouge:=$maxi
		$vert:=$mini
		$bleu:=$maxi-($ecart*($teinte/60))  // bleu décroissant
		
	: ($teinte>=240)
		
		$teinte:=$teinte-240
		$bleu:=$maxi
		$vert:=$mini
		$rouge:=$mini+($ecart*($teinte/60))  // rouge croissant
		
	: ($teinte>=180)
		
		$teinte:=$teinte-180
		$bleu:=$maxi
		$rouge:=$mini
		$vert:=$maxi-($ecart*($teinte/60))  // vert décroissant
		
	: ($teinte>=120)
		
		$teinte:=$teinte-120
		$vert:=$maxi
		$rouge:=$mini
		$bleu:=$mini+($ecart*($teinte/60))  // bleu croissant
		
	: ($teinte>=60)
		
		$teinte:=$teinte-60
		$vert:=$maxi
		$bleu:=$mini
		$rouge:=$maxi-($ecart*($teinte/60))  // rouge décroissant
		
	: ($teinte>=0)
		
		$teinte:=$teinte-0  // pour la symétrie des autres cas :-)
		$rouge:=$maxi
		$bleu:=$mini
		$vert:=$mini+($ecart*($teinte/60))  // vert croissant
		
End case 

$couleur:=($rouge << 16)+($vert << 8)+$bleu
$0:=$couleur