//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_BOOLEAN:C305($is_first;$is_previous;$is_next;$is_last)
$is_first:=False:C215
$is_previous:=False:C215
$is_next:=False:C215
$is_last:=False:C215

If (Form:C1466.found.length>0)
	If (Form:C1466.indice>0)
		SELECT LIST ITEMS BY REFERENCE:C630(Form:C1466.LH;Form:C1466.found[(Form:C1466.indice-1)])
		
		$is_first:=(Form:C1466.indice>1)
		$is_previous:=(Form:C1466.indice>1)
		$is_next:=(Form:C1466.indice<Form:C1466.found.length) & (Form:C1466.indice>0)
		$is_last:=(Form:C1466.indice<Form:C1466.found.length) & (Form:C1466.indice>0)
	End if 
	
End if 

OBJECT SET ENABLED:C1123(*;"btn_n_first";$is_first)
OBJECT SET ENABLED:C1123(*;"btn_n_previous";$is_previous)
OBJECT SET ENABLED:C1123(*;"btn_n_next";$is_next)
OBJECT SET ENABLED:C1123(*;"btn_n_last";$is_last)