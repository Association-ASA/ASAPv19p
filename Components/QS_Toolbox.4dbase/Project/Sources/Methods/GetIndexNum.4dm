//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // date et heure : 23/02/2017 21:33
  // ----------------------------------------------------
  // méthode : GetIndexNum
  // description
  // retourne le numéro d'index du champ passé
  //
  // paramètres
  // ----------------------------------------------------

C_TEXT:C284($0)
C_POINTER:C301($1)
C_LONGINT:C283($long_l)
C_POINTER:C301($field_p)
C_BOOLEAN:C305($index_b)
C_LONGINT:C283($type_l)

Case of 
		
	: (Not:C34(Asserted:C1132(Count parameters:C259=1;"$1 missing")))
		
	Else 
		
		$field_p:=$1
		GET FIELD PROPERTIES:C258($field_p;$type_l;$long_l;$index_b)
		
		If ($index_b)
			
			C_TEXT:C284($columnName_t;$tableName_t)
			$columnName_t:=Field name:C257($field_p)
			$tableName_t:=Table name:C256($field_p)
			
			C_TEXT:C284($indexID)
			
			Begin SQL  // lire le numéro de l'index
				select INDEX_ID
				FROM _USER_IND_COLUMNS
				WHERE(TABLE_NAME = :$tableName_t) AND (COLUMN_NAME = :$columnName_t)
				INTO :$indexID;
			End SQL
			
		End if 
End case 

$0:=$indexID
