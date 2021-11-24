//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 16/01/13, 21:09:07
// ----------------------------------------------------
// méthode : TOOL_Get_CommandListe
// description
//
//
// paramètres
// ----------------------------------------------------

ARRAY TEXT:C222($ReservedWords_at; 0x0000)
C_TEXT:C284($words_t; $crlf)
C_TIME:C306($vhRef)
C_LONGINT:C283($wordsFound; $a)
C_COLLECTION:C1488($word)
$word:=New collection:C1472
$crlf:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)

// SQL commands and functions
$path_t:=FILE_GetRessourceApplication+"4D"
$path_t:=$path_t+(Num:C11(Application type:C494=4D Server:K5:6)*" server")
If (Is macOS:C1572)  // Mac
	$path_t:=$path_t+".rsrc"
Else 
	$path_t:=$path_t+".rsr"
End if 

// (Application type=4D Server)


$vhRef:=Open resource file:C497($path_t)

// 460 : liste des touches de commande
// 478 : liste des Triggers
// 479 : type d'alignement d'une image
// 480 : type de formatage Heure
// 481 : type de formatage Date
// 482 : Type de Variables
// 483 : Liste des Evenements objet
// 862 : Taille des écrans
// 1120 : Liste des pays
// 1121 : Liste des codes pays
// 1123 : SQL Commands
// 3103 : ??
// 3104 : ??
// 10132 : text divers
// 10133 : type fichier import
// 10135 : 4D folders et type application
// 14900 : %Report
// 14950 : OLE_Tools
// 14951 : OLE_Tools messages


If (OK=1)
	
	$i:=0
	
	While ($i<32767)
		$i:=$i+1  // = 32768
		STRING LIST TO ARRAY:C511($i; $ReservedWords_at; $vhRef)
		
		For ($a; 1; Size of array:C274($ReservedWords_at))
			$word.push(New object:C1471("ressource"; $i; "keyword"; $ReservedWords_at{$a}))
		End for 
		
	End while 
	
	CLOSE RESOURCE FILE:C498($vhRef)
	$wordsFound:=Size of array:C274($ReservedWords_at)
	$words_t:="Ressource "+String:C10($i)+$crlf*2
	
	For ($a; 1; $wordsFound)
		$words_t:=$words_t+$ReservedWords_at{$a}+$crlf
	End for 
	
	$words_t:=$word.extract("keyword").distinct().join("\n")
	SET TEXT TO PASTEBOARD:C523($words_t)
	
	ALERT:C41("Reserved Words were copied to your clipboard.")
End if 
