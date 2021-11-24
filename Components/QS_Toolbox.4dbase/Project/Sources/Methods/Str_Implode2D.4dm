//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 09/06/18, 10:37:22
// ----------------------------------------------------
// Paramètres
// $1 = 
// $2 = 
// ----------------------------------------------------
// Méthode : Str_Implode2D
// Description
//  
// http://forums.4d.com/Post/FR/24604397/1/24619895#24619895
// Arnaud DE MONTARD
//Str_implode2D(arr2Dtext_p;columnEnd_t;lineEnd_t)-> txt

// SAMPLE
//LISTBOX GET ARRAYS(*;$LBname_t;$colName_at;$header_at;$colVar_ap;$headerVar_ap;$colVisible_ab;$style_ap)
//$nbCol_l:=Size of array($colVar_ap)
//ARRAY TEXT($temp_a2t;$nbCol_l;0)
//For ($i_l;1;$nbCol_l)
//$source_p:=$colVar_ap{$i_l}
//$cible_p:=->$temp_a2t{$i_l}
//$error_t:=Arr_Copy ($source_p;$cible_p)
//End for 
//$out_t:=Str_Implode2D (->$temp_a2t;"\t";"\r")
// 


C_POINTER:C301($1)
C_TEXT:C284($2)
C_TEXT:C284($3)

C_LONGINT:C283($column_l)
C_LONGINT:C283($columns_l)
C_LONGINT:C283($line_l)
C_LONGINT:C283($lines_l)
C_LONGINT:C283($offset_l)
C_LONGINT:C283($params_l)
C_POINTER:C301($arr_p)
C_TEXT:C284($columnEnd_t)
C_TEXT:C284($lineEnd_t)
C_TEXT:C284($nmc_t)
C_TEXT:C284($out_t)

If (False:C215)
	C_POINTER:C301(Str_Implode2D; $1)
	C_TEXT:C284(Str_Implode2D; $2)
	C_TEXT:C284(Str_Implode2D; $3)
End if 
//_
$params_l:=Count parameters:C259
$nmc_t:=Current method name:C684
Case of 
	: (Not:C34(Asserted:C1132($params_l>0; $nmc_t+" $1 expected")))
	: (Not:C34(Asserted:C1132(Is nil pointer:C315($1); $nmc_t+" $1 nil")))
	: (Not:C34(Asserted:C1132(Type:C295($1->)=Array 2D:K8:24; $nmc_t+" $1 2D array text expected")))
	: (Not:C34(Asserted:C1132(Type:C295($1->{0})=Text array:K8:16; $nmc_t+" $1 2D array text expected")))
	Else 
		
		$arr_p:=$1
		$columnEnd_t:=""
		$lineEnd_t:=""
		If ($params_l>1)
			$columnEnd_t:=$2
			If ($params_l>2)
				$lineEnd_t:=$3
			End if 
		End if 
		
		$columns_l:=Size of array:C274($arr_p->)
		$lines_l:=Size of array:C274($arr_p->{1})
		
		SET BLOB SIZE:C606($concat_x; 0)
		$offset_l:=0
		For ($line_l; 1; $lines_l)
			For ($column_l; 1; $columns_l-1)
				TEXT TO BLOB:C554($arr_p->{$column_l}{$line_l}+$columnEnd_t; $concat_x; UTF8 text without length:K22:17; $offset_l)
			End for 
			TEXT TO BLOB:C554($arr_p->{$column_l}{$line_l}+$lineEnd_t; $concat_x; UTF8 text without length:K22:17; $offset_l)
		End for 
		$out_t:=Convert to text:C1012($concat_x; "utf-8")
		CLEAR VARIABLE:C89($concat_x)
		$0:=$out_t
End case 
//_