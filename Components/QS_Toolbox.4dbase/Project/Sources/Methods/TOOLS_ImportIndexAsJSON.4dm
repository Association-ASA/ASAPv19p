//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 11/11/17, 14:12:18
  // ----------------------------------------------------
  // Méthode : TOOLS_ImportIndexAsJSON
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------
  // http://forums.4d.com/Post/FR/19006884/1/19006885#19006885
  // Arnaud de Montard

  // Index_ObjectToStructure(path_t)-> txt
  // créé les index définis par le fichier json$1

CONFIRM:C162("Do you really want to update all indexes of the current database?")
If (OK=1)
	
	C_TEXT:C284($1)
	C_TEXT:C284($error_t)
	C_LONGINT:C283($pos_l)
	
	C_OBJECT:C1216($indexes_o)
	C_OBJECT:C1216($index_o)
	ARRAY OBJECT:C1221($index_ao;0x0000)
	C_OBJECT:C1216($field_o;0x0000)
	ARRAY OBJECT:C1221($field_ao;0x0000)
	
	$nmc_t:=Current method name:C684
	$params_l:=Count parameters:C259
	$error_t:=""
	If (Count parameters:C259=1)
		$path_t:=$1
	Else 
		$path:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DestinationPath+"Export"+Folder separator:K24:12
		$path_t:=Select document:C905($path;"public.text";"Open a JSON document";Alias selection:K24:10)
		$path_t:=Document
	End if 
	
	If (Test path name:C476($path_t)#Is a document:K24:1)
		$error_t:=$nmc_t+" $1 invalid path"
	End if 
	
	If ($error_t="")
		$json_t:=Document to text:C1236($path_t)
		$indexes_o:=JSON Parse:C1218($json_t)
		
		OB GET ARRAY:C1229($indexes_o;"index";$index_ao)
		For ($i_l;1;Size of array:C274($index_ao))
			$index_o:=OB Copy:C1225($index_ao{$i_l})
			$indexName_t:=$index_o.name
			$index4DType_l:=$index_o.type
			$table_l:=$index_o.table
			ASSERT:C1129(Is table number valid:C999($table_l);"Invalid table number "+String:C10($table_l))
			If (Is table number valid:C999($table_l))
				$table_p:=Table:C252($table_l)
			End if 
			
			OB GET ARRAY:C1229($index_o;"column";$field_ao)
			ARRAY POINTER:C280($columnInIndex_ap;0x0000)
			ARRAY LONGINT:C221($order_al;0x0000)
			
			For ($j_l;1;Size of array:C274($field_ao))
				$field_o:=OB Copy:C1225($field_ao{$j_l})
				$field_l:=$field_o.field
				$pos_l:=$field_o.position
				If (Is field number valid:C1000($table_l;$field_l))
					APPEND TO ARRAY:C911($columnInIndex_ap;Field:C253($table_l;$field_l))
					APPEND TO ARRAY:C911($order_al;$pos_l)
				End if 
			End for 
			If (Size of array:C274($field_ao)>1)
				SORT ARRAY:C229($order_al;$columnInIndex_ap;>)
			End if 
			
			CREATE INDEX:C966($table_p->;$columnInIndex_ap;$index4DType_l;$indexName_t)
		End for 
		$txt:="Indexes have been updated."
		displayInfo ($txt;"")
		STRCT_UpdateDisplay 
	Else 
		$txt:="Indexes haven't been updated. An error occurs with the JSON file."
		displayInfo ($txt;"red")
	End if 
	
End if 
