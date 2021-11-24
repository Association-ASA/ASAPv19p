//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 01/08/14, 18:51:47
// ----------------------------------------------------
// méthode : SUPPORT_tablesAndFieldsList
// description
//
//
// paramètres
// ----------------------------------------------------
// http://forums.4d.fr/Post/FR/15024537/1/15024822#15024822

C_BOOLEAN:C305($1; $avecChamps_b)  // $1 faux=tables seules
C_LONGINT:C283($i; $j; $type_l; $long)
C_LONGINT:C283($tableFin_l; $nbChamps_l; $table_l; $champ_l; $tableDepart_l)
C_BOOLEAN:C305($bIndex)
C_BOOLEAN:C305($triAlpha_b)
C_TEXT:C284($tab_t; $cr_t; $indent_t)
C_TEXT:C284($out_t)


// _
$tab_t:="\t"
$cr_t:="\r"
$indent_t:=$tab_t+$tab_t
$avecChamps_b:=True:C214

If (Count parameters:C259>0)
	$avecChamps_b:=$1
End if 

$triAlpha_b:=False:C215

displayInfo("Copy Tables & Fields")
$tableDepart_l:=1
$tableFin_l:=Get last table number:C254

// en-têtes
$out_t:="Table Num"+$tab_t+"Table Name"

If ($avecChamps_b)
	$out_t:=$out_t+$tab_t+"Field Num"+$tab_t+"Field Name"+$tab_t+"Field Type"+$tab_t+"indexed"
	$out_t:=$out_t+$tab_t+"Index #"+$tab_t+"Index Type"
End if 

$out_t:=$out_t+$cr_t

ARRAY TEXT:C222($table_at; $tableFin_l)
ARRAY LONGINT:C221($table_al; $tableFin_l)

For ($i; $tableDepart_l; $tableFin_l)
	If (Is table number valid:C999($i))
		$table_al{$i}:=$i
		$table_at{$i}:=Table name:C256(Table:C252($i))
	End if 
End for 

If ($triAlpha_b)
	SORT ARRAY:C229($table_al; $table_at; >)  // tables en ordre alpha
End if 

For ($i; $tableDepart_l; $tableFin_l)
	
	$table_l:=$table_al{$i}
	
	If (Is table number valid:C999($table_l))
		
		$out_t:=$out_t+String:C10($table_l)+$tab_t+$table_at{$i}+$tab_t+$cr_t
		
		If ($avecChamps_b)
			
			$nbChamps_l:=Get last field number:C255($table_l)
			ARRAY TEXT:C222($champ_at; $nbChamps_l)
			ARRAY LONGINT:C221($champ_al; $nbChamps_l)
			
			For ($j; 1; $nbChamps_l)
				$champ_al{$j}:=$j
				$champ_at{$j}:=Field name:C257($table_l; $j)
			End for 
			
			If ($triAlpha_b)  // champs en ordre alpha
				SORT ARRAY:C229($champ_at; $champ_al; >)
			End if 
			
			For ($j; 1; $nbChamps_l)
				
				$champ_l:=$champ_al{$j}
				
				If (Is field number valid:C1000($table_l; $champ_l))
					
					GET FIELD PROPERTIES:C258($table_l; $champ_l; $type_l; $long; $bIndex)
					
					$type_t:=FIELD_GetType($type_l; $long)
					$out_t:=$out_t+$tab_t+$tab_t+String:C10($champ_l)+$tab_t+Field name:C257($table_l; $champ_l)+$tab_t
					$out_t:=$out_t+$type_t+$tab_t
					$out_t:=$out_t+(Num:C11($bIndex)*"Yes")+$tab_t
					
					$TypeIndex_t:=GetIndexType(Field:C253($table_l; $champ_l))
					
					If ($TypeIndex_t="")
						$out_t:=$out_t+""+$tab_t
					Else 
						$out_t:=$out_t+GetIndexNum(Field:C253($table_l; $champ_l))+$tab_t
					End if 
					
					$out_t:=$out_t+$TypeIndex_t+$tab_t
					
					$out_t:=$out_t+$cr_t
					
				End if 
			End for 
		End if 
	End if 
End for 

SET TEXT TO PASTEBOARD:C523($out_t)
displayInfo("Definition of Tables & Fields are ready to be paste.")