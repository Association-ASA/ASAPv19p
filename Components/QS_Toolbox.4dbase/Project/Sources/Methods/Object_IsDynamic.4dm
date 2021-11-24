//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 13/03/18, 07:46:16
  // ----------------------------------------------------
  // Méthode : OBJECT_IsDynamic
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------

C_POINTER:C301($1;$PtrObject)
C_TEXT:C284($0;$Txt_name)
C_LONGINT:C283($Lon_field;$Lon_table)

$PtrObject:=$1

If (Is nil pointer:C315($PtrObject))
	
	$Txt_name:=""
	
Else 
	
	RESOLVE POINTER:C394($PtrObject;$Txt_name;$Lon_table;$Lon_field)
	
	If ($Lon_field>0)
		
		$Txt_name:="<"+Table name:C256($Lon_table)+">"+Field name:C257($Lon_table;$Lon_field)
		
	Else 
		
		If (Length:C16($Txt_name)>0)
			
			If ($Txt_name[[1]]="$")  // dynamic variable
				$Txt_name:="(dynamic)"
			End if 
			
		End if 
	End if 
End if 

$0:=$Txt_name