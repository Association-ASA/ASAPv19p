//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // User name (OS): Vanessa Talbot
  // Date and time: 17/01/17, 11:39:00
  // ----------------------------------------------------
  // Method: getDatabaseStructure
  // Description
  //   * Call getTablesAndFields method
  //   * Call getIndex method
  //   * Call getRelations method
  //
  // Parameters
  //   return an C_Object that contains all database information (table, field, index, relation)
  // ----------------------------------------------------
  // https://blog.4d.com/detailed-analysis-database-structure/

C_OBJECT:C1216($oStructure)
ARRAY OBJECT:C1221($arrTmp;0)

  // getTablesAndFields
OB GET ARRAY:C1229(STRCT_GetTablesAndFields ;"table";$arrTmp)
OB SET ARRAY:C1227($oStructure;"table";$arrTmp)

  //getIndex 
OB GET ARRAY:C1229(STRCT_GetIndex ;"index";$arrTmp)
OB SET ARRAY:C1227($oStructure;"index";$arrTmp)

  //getRelations 
OB GET ARRAY:C1229(STRCT_GetRelations ;"relation";$arrTmp)
OB SET ARRAY:C1227($oStructure;"relation";$arrTmp)

$0:=$oStructure