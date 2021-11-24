//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 27/12/15, 08:57:27
// ----------------------------------------------------
// Méthode : GetIndexType (http://forums.4d.fr/Post/FR/11529957/1/17262337)
// description
// retourne le type d'index du champ passé
//
// -3 = Mots-clés
// 0 = pas d'index
// 1 = BTree/ Composite
// 3 = Cluster
// 7 = Auto
//
// paramètres
// ----------------------------------------------------

C_LONGINT:C283($long_l; $type_l; $TypeIndex)
C_POINTER:C301($field_p; $1)
C_BOOLEAN:C305($index_b; $motscles)
C_TEXT:C284($columnName_t; $indexID; $tableName_t; $result; $0)

$field_p:=$1
$motscles:=False:C215
$TypeIndex:=0  // not indexed

GET FIELD PROPERTIES:C258($field_p; $type_l; $long_l; $index_b)

If ($index_b)
	
	$columnName_t:=Field name:C257($field_p)
	$tableName_t:=Table name:C256($field_p)
	
	Begin SQL  // lire le numéro de l'index
		select INDEX_ID
		FROM _USER_IND_COLUMNS
		WHERE(TABLE_NAME = :$tableName_t) AND (COLUMN_NAME = :$columnName_t)
		INTO :$indexID;
	End SQL
	
	Begin SQL  // lire le type de l'index
		select INDEX_TYPE
		FROM _USER_INDEXES
		WHERE INDEX_ID = :$indexID
		INTO :$TypeIndex, :$motscles;
	End SQL
	
End if 

If ($motscles)
	$TypeIndex:=-$TypeIndex
End if 

Case of 
		// type d’index (1=BTree / Composite, 3=Cluster / Mots-clés, 7=Auto, 8=Auto for Object field)
		// type -3 : Keywords
	: ($TypeIndex=-3)
		$result:="Keywords"
		
	: ($TypeIndex=0)
		$result:=""
		
	: ($TypeIndex=1)
		$result:="BTree"
		
	: ($TypeIndex=3)
		$result:="Cluster"
		
	: ($TypeIndex=7)
		$result:="Auto"
		
	: ($TypeIndex=8)
		$result:="Auto (object field)"
		
	Else 
		$result:=""
		
End case 

$0:=$result