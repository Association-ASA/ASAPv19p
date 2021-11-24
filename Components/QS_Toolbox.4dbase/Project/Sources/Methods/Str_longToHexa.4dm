//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // Str_longToHexa(long_l{;sansPrefixe_b{;option00_l)-> txt
  // Description
  // convertit long en chaine hexadécimale"&xAABBCCDD"
  // $2 optionnel enlever le&x en préfixe* défaut  Enlever
  // $3 optionnel traitement des"00" non significatifs au début
  // * défaut ne rien faire
  // >0 forcer à longueur 8
  // <0 enlever si présents
  // Paramètres

C_TEXT:C284($0)
C_LONGINT:C283($1)
C_BOOLEAN:C305($2)
C_LONGINT:C283($3)

C_TEXT:C284($out_t)
C_LONGINT:C283($in_l)
C_BOOLEAN:C305($removeX_b)
C_LONGINT:C283($optionZero_l)

C_LONGINT:C283($params_l)
C_TEXT:C284($nmc_t)

  //_
$params_l:=Count parameters:C259
$nmc_t:=Current method name:C684
Case of 
	: (Not:C34(Asserted:C1132($params_l>0;$nmc_t+" $1 missing")))
	Else 
		$in_l:=$1
		$removeX_b:=True:C214
		$optionZero_l:=0
		If (Count parameters:C259>1)
			$removeX_b:=$2
			If (Count parameters:C259>2)
				$optionZero_l:=$3
			End if 
		End if 
		
		$out_t:=Substring:C12(String:C10($in_l;"&x");3)
		
		Case of 
			: ($optionZero_l<0)  //enlever les 00 non significatifs
				Case of 
					: ($in_l<(2^8))  //00FF
						$out_t:=Substring:C12($out_t;3)
						
					: ($in_l<(2^16))  //FFFF
						  //rien
						
					: ($in_l<(2^24))  //00FFFFFF
						$out_t:=Substring:C12($out_t;3)
						
				End case 
				
			: ($optionZero_l>0)  //forcer les 00 non significatifs
				Case of 
					: ($in_l<(2^16))
						$out_t:="0000"+$out_t
				End case 
		End case 
		
		If (Not:C34($removeX_b))  //préfixe"&x" demandé
			$out_t:="&x"+$out_t
		End if 
		
End case 

$0:=$out_t
  //_

