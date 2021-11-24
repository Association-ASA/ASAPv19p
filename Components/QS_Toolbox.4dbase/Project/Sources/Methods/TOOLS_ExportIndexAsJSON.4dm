//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 11/11/17, 14:03:08
// ----------------------------------------------------
// Méthode : TOOLS_ExportIndexAsJSON
// Description
//  
//
// Paramètres
// ----------------------------------------------------
// http://forums.4d.com/Post/FR/19006884/1/19006885#19006885
// Arnaud de Montard


// Description of the elements of _USER_INDEXES system table:
// INDEX_ID (VARCHAR): Index number
// INDEX_TYPE (INT32): Index type
// (1=BTree/Composite, 3=Cluster/ (-3) keywords, 7=Auto, 8=Auto for object field)
// KEYWORD (BOOLEAN): True only if keyword index, false otherwise
// UNIQUENESS (BOOLEAN): True only if uniqueness is required, false otherwise
// _USER_IND_COLUMNS:
// INDEX_ID VARCHAR Numéro dindex
// INDEX_NAME VARCHAR Nom dindex
// TABLE_NAME VARCHAR Nom de table avec index
// COLUMN_NAME VARCHAR Nom de colonne avec index
// COLUMN_POSITION INT32 Position de colonne dans lindex
// TABLE_ID INT64 Numéro de table avec index
// COLUMN_ID INT64 Numéro de colonne

C_OBJECT:C1216($indexes_o)
C_OBJECT:C1216($index_o)
C_OBJECT:C1216($field_o)
C_BOOLEAN:C305($indexEnd_b;$unique_b;$idx_b)
C_LONGINT:C283($len_l;$type_l)
C_TIME:C306($doc)

ARRAY OBJECT:C1221($field_ao;0x0000)
ARRAY OBJECT:C1221($index_ao;0x0000)

ARRAY TEXT:C222($indexID_at;0x0000)
ARRAY TEXT:C222($indexName_at;0x0000)
ARRAY LONGINT:C221($position_al;0x0000)
ARRAY LONGINT:C221($table_al;0x0000)
ARRAY LONGINT:C221($column_al;0x0000)
ARRAY BOOLEAN:C223($keyword_ab;0x0000)
ARRAY BOOLEAN:C223($unique_ab;0x0000)
ARRAY LONGINT:C221($type_al;0x0000)

Begin SQL
	SELECT A.INDEX_ID, A.INDEX_NAME, A.COLUMN_POSITION, A.TABLE_ID, A.COLUMN_ID, B.INDEX_TYPE, B.KEYWORD, B.UNIQUENESS
	FROM _USER_IND_COLUMNS A, _USER_INDEXES B
	WHERE B.INDEX_ID = A.INDEX_ID
	INTO :$indexID_at, :$indexName_at, :$position_al, :$table_al, :$column_al, :$type_al, :$keyword_ab, :$unique_ab;
End SQL
$zz:=Count in array:C907($keyword_ab;True:C214)

MULTI SORT ARRAY:C718($indexID_at;>;$position_al;>;$indexName_at;$table_al;$column_al;$type_al;$keyword_ab;$unique_ab)
ARRAY LONGINT:C221($columnInIndex_al;0x0000)
$indexEnd_b:=False:C215
$indexes_o:=New object:C1471
$index_o:=New object:C1471
$field_o:=New object:C1471

For ($i_l;1;Size of array:C274($indexID_at))
	$indexName_t:=$indexName_at{$i_l}  //ignored
	$indexSQLType_l:=$type_al{$i_l}
	$position_l:=$position_al{$i_l}
	$table_l:=$table_al{$i_l}
	APPEND TO ARRAY:C911($columnInIndex_al;$column_al{$i_l})
	
	//vérif champ unique => index unique
	If ($unique_ab{$i_l})
		$nomChamp_t:=Field name:C257($table_l;$column_al{$i_l})
		GET FIELD PROPERTIES:C258($table_l;$column_al{$i_l};$type_l;$len_l;$idx_b;$unique_b)
		ASSERT:C1129($unique_b=$unique_ab{$i_l})
	End if 
	
	//index SQL-> 4D translation
	//SQL 1=BTree/ Composite, 3=Cluster/ Mots-clés, 7=Auto, 8=Auto pour champ Objet
	//CREATE INDEX-1= Mots-clés, 0= par défaut, 1= B-Tree standard, 3= BTree cluster
	Case of 
		: ($indexSQLType_l=1)  //1=BTree/Composite
			$index4DType_l:=1  //1= B-Tree standard
			If (Size of array:C274($columnInIndex_al)>1)
				$codeName_t:="cp"
			Else 
				$codeName_t:="bt"
			End if 
			
		: ($indexSQLType_l=3)  //3=Cluster/Mots-clés
			If ($keyword_ab{$i_l})
				$index4DType_l:=-1  //-1= Mots-clés
				$codeName_t:="kw"
			Else 
				$index4DType_l:=3  //3= BTree cluster
				$codeName_t:="cl"
			End if 
			
		: ($indexSQLType_l=7)  //7=Auto
			$index4DType_l:=0  //0= par défaut
			$codeName_t:="au"
			
		: ($indexSQLType_l=8)  //8=Auto pour champ Objet
			//#TODO en attente v15, tester si type du champ= Est un objet
			
		Else 
			ASSERT:C1129(False:C215;"unknown index type")
	End case 
	
	Case of 
		: ($i_l=Size of array:C274($indexID_at))
			$indexEnd_b:=True:C214  //fin description
			
		: ($indexID_at{$i_l}=$indexID_at{$i_l+1})  //composite
			$indexEnd_b:=False:C215
			
		Else 
			$indexEnd_b:=True:C214  //fin description
	End case 
	
	If ($indexEnd_b)
		
		//$indexName_t="")
		//Passez dans nomIndex le nom de l'index à créer.
		// Nommer les index est nécessaire
		// si plusieurs index de types différents
		// peuvent être associés à un même champ
		// et si vous souhaitez pouvoir les supprimer individuellement
		// à l'aide de la commande SUPPRIMER INDEX.
		// Si l'index nomIndex existe déjà, la commande ne fait rien.
		
		$indexName_t:="T"+String:C10($table_l)+"."+$codeName_t
		For ($j_l;1;Size of array:C274($columnInIndex_al))
			$indexName_t:=$indexName_t+".C"+String:C10($columnInIndex_al{$j_l})
			$index_o.readable:="["+Table name:C256($table_l)+"]"+Field name:C257($table_l;$columnInIndex_al{$j_l})
		End for 
		
		$index_o.name:=$indexName_t
		$index_o.table:=$table_l
		$index_o.type:=$index4DType_l
		$index_o.unique:=$unique_ab{$i_l}
		
		For ($j_l;1;Size of array:C274($columnInIndex_al))
			$field_o.field:=$columnInIndex_al{$j_l}
			$field_o.position:=$j_l
			APPEND TO ARRAY:C911($field_ao;OB Copy:C1225($field_o))
		End for 
		
		OB SET ARRAY:C1227($index_o;"column";$field_ao)
		CLEAR VARIABLE:C89($field_ao)
		CLEAR VARIABLE:C89($columnInIndex_al)
		APPEND TO ARRAY:C911($index_ao;OB Copy:C1225($index_o))
	End if 
	
End for 
OB SET ARRAY:C1227($indexes_o;"index";$index_ao)

//// Delete previous doc file
//$Dest:=Storage.QS_TBX_SHARED_DATA.QS_TBX_DestinationPath
//$script:=$Dest+"Export"+Folder separator+"index.txt"

//If (Test path name($script)=Is a document)
//CONFIRM("A JSON file already exist. Do you want to overwrite it?")
//If (OK=1)
//DELETE DOCUMENT($script)
//Else 
//$script:=Request("Enter the document name with NO EXTENSION")
//$script:=$Dest+"Export"+Folder separator+$script+".txt"
//If (Test path name($script)=Is a document)
//DELETE DOCUMENT($script)
//End if 
//End if 
//End if 

//$doc:=Create document($script)
//FILE_SendPacket_UTF8($doc;JSON Stringify($indexes_o;*))
//CLOSE DOCUMENT($doc)

$file:=Folder:C1567(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DestinationPath;fk platform path:K87:2).file("Export/index.txt";fk platform path:K87:2)
$txt:=JSON Stringify:C1217($indexes_o;*)
If ($file.exists)  // In case we need to update
	CONFIRM:C162("A JSON file already exist. Do you want to overwrite it?")
	If (OK=1)
		$file.delete()
	End if 
	
	$created:=$file.create()
	$file.setText($txt)
End if 

SET TEXT TO PASTEBOARD:C523($txt)
$txt:="Indexes definition have been saved into the Export folder and ready to be paste."
displayInfo($txt)