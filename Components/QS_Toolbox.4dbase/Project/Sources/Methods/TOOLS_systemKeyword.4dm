//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS)) : Association QualiSoft
// Date et heure : 09/07/19, 10:59:14
// Paramètres
// ----------------------------------------------------
// Méthode : TOOLS_systemKeyword
// Description
//

// ‼️ MANUAL SETTINGS ‼️

var $coll : Collection
$coll:=New collection:C1472

$coll.push(New object:C1471("type"; "var4D"; "name"; "ok"))
$coll.push(New object:C1471("type"; "var4D"; "name"; "document"))
$coll.push(New object:C1471("type"; "var4D"; "name"; "fldDelimit"))
$coll.push(New object:C1471("type"; "var4D"; "name"; "recDelimit"))
$coll.push(New object:C1471("type"; "var4D"; "name"; "error"))
$coll.push(New object:C1471("type"; "var4D"; "name"; "Error method"))
$coll.push(New object:C1471("type"; "var4D"; "name"; "Error line"))
$coll.push(New object:C1471("type"; "var4D"; "name"; "Error formula"))
$coll.push(New object:C1471("type"; "var4D"; "name"; "MouseDown"))
$coll.push(New object:C1471("type"; "var4D"; "name"; "MouseX"))
$coll.push(New object:C1471("type"; "var4D"; "name"; "MouseY"))
$coll.push(New object:C1471("type"; "var4D"; "name"; "KeyCode"))
$coll.push(New object:C1471("type"; "var4D"; "name"; "Modifiers"))
$coll.push(New object:C1471("type"; "var4D"; "name"; "MouseProc"))
$coll.push(New object:C1471("type"; "var4D"; "name"; ".value"))
$coll.push(New object:C1471("type"; "var4D"; "name"; ".result"))
$coll.push(New object:C1471("type"; "var4D"; "name"; ".accumulator"))
$coll.push(New object:C1471("type"; "var4D"; "name"; ".stop"))
$coll.push(New object:C1471("type"; "var4D"; "name"; ".length"))
$coll.push(New object:C1471("type"; "var4D"; "name"; ".queryPlan"))
$coll.push(New object:C1471("type"; "var4D"; "name"; ".queryPath"))
$coll.push(New object:C1471("type"; "var4D"; "name"; ".__KEY"))
$coll.push(New object:C1471("type"; "var4D"; "name"; ".__STAMP"))
$coll.push(New object:C1471("type"; "var4D"; "name"; ".__NEW"))
$coll.push(New object:C1471("type"; "var4D"; "name"; "This."))
$coll.push(New object:C1471("type"; "var4D"; "name"; "signal"))
$coll.push(New object:C1471("type"; "var4D"; "name"; "Formula"))
$coll.push(New object:C1471("type"; "var4D"; "name"; "Form."))
$coll.push(New object:C1471("type"; "var4D"; "name"; "Storage"))


// SQL commands and functions

// SQL commands and functions
$path_t:=FILE_GetRessourceApplication+"4D"
$path_t:=$path_t+(Num:C11(Application type:C494=4D Server:K5:6)*" server")
If (Is macOS:C1572)  // Mac
	$path_t:=$path_t+".rsrc"
Else 
	$path_t:=$path_t+".rsr"
End if 

$ref_h:=Open resource file:C497($path_t)
If (OK=0)
	// error
Else 
	STRING LIST TO ARRAY:C511(1123; $varSQL_at; $ref_h)
End if 
CLOSE RESOURCE FILE:C498($ref_h)
ARRAY TO COLLECTION:C1563($coll; $varSQL_at; "varSQL")

// Update: Association QualiSoft (26/05/2018))
// http://infocenter.sybase.com/help/index.jsp?topic=/com.sybase.dc70202_1251/html/quickref/BEIJHIFE.htm
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "__ROW_ACTION"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "__ROW_ID"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "__ROW_STAMP"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ABS"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ABSOLUTE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ACOS"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ACTION"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ADD"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ALL"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ALLOCATE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ALPHA_NUMERIC"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ALTER DATABASE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ALTER SCHEMA"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ALTER TABLE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ALTER"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "AND"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ANY"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ARITH_OVERFLOW"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "AS"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ASC"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ASCII"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ASIN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ASYNC"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "AT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ATAN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ATAN2"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "AUTHORIZATION"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "AUTO_CLOSE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "AUTO_GENERATE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "AUTO_INCREMENT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "AVG"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "BEGIN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "BETWEEN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "BIT_LENGTH"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "BIT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "BLOB"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "BOOLEAN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "BOTH"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "BREAK"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "BROWSE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "BULK"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "BY"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "BYTE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CASCADE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CASE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CAST"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CEILING"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CHAR_CONVERT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CHAR_LENGTH"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CHAR"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CHECK"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CHECKPOINT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CLOB"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CLOSE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CLUSTERED"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "COALESCE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "COMMIT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "COMPUTE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CONCAT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CONCATENATE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CONFIRM"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CONNECT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CONSTRAINT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CONSTRAINTS"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CONTINUE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CONTROLROW"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CONVERT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "COS"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "COT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "COUNT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CREATE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CREATE DATABASE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CREATE INDEX"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CREATE SCHEMA"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CREATE TABLE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CREATE VIEW"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CREATE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CROSS"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CURDATE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CURRENT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CURRENT_DATE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CURRENT_TIME"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CURRENT_TIMESTAMP"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CURSOR"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "CURTIME"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DATABASE_PATH"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DATABASE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DATAFILE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DATE_TO_CHAR"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DATE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DAY"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DAYNAME"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DAYOFMONTH"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DAYOFWEEK"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DAYOFYEAR"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DBCC"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DEALLOCATE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DEBUG"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DECLARE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DEFAULT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DEGREES"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DELETE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DESC"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DETERMINISTIC"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DIRECT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DISABLE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DISK DISTINCT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DISTINCT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DOUBLE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DROP INDEX"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DROP SCHEMA"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DROP TABLE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DROP VIEW"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DROP"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DUMMY"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DUMP"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "DURATION"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ELSE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ENABLE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "END"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ENDTRAN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ERRLVL"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ERRORDATA"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ERROREXIT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ERRLVL"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ESCAPE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "EXCEPT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "EXCLUSIVE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "EXECUTE IMMEDIATE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "EXEC"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "EXECUTE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "EXISTS"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "EXP"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "EXP_ROW_SIZE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "EXTERNAL"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "EXTRACT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "FALSE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "FETCH"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "FILLFACTOR"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "FLOAT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "FLOOR"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "FN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "FOR"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "FOREIGN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "FROM"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "FULL"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "FUNC"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "GENERAL"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "GRANT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "GROUP"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "HAVING"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "HOUR"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "IF"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "IMMEDIATE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "IN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "INDEX"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "INDEXES"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "INF"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "INFILE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "INNER"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "INSERT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "INT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "INT16"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "INT32"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "INT64"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "INTERVAL"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "INTERNAL"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "INTO"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "IS"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "JAR"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "JOIN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "KEY"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "KILL"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "LATEST"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "LEADING"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "LEFT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "LENGTH"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "LEVEL"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "LIKE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "LIMIT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "LINENO"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "LISTBOX"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "LOAD"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "LOCAL"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "LOCATE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "LOCK TABLE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "LOCK"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "LOG"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "LOG10"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "LOWER"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "LTRIM"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "MAX"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "MAX_ROWS_PER_PAGE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "MILLISECOND"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "MIN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "MIRROR"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "MIRROREXIT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "MINUTE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "MOD"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "MODE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "MODIFY"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "MONTH"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "MONTHNAME"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "NATIONAL"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "NATURAL"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "NEW"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "NOCLUSTERED"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "NOHOLDLOCK"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "NOT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "NULL"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "NULLIF"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "NUMERIC"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "NUMERIC_TRUNCATION"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "OCTET_LENGTH"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "OF"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "OFFSET"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "OFFSETS"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ON"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ONCE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ONLY"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "OPEN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "OPTION"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "OR"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ORDER"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "OUT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "OUTER"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "OUTPUT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "OVER"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "PASCAL"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "PARTITION"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "PERM"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "PERMANENT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "PLAN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "PI"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "PICTURE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "POSITION"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "POWER"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "PRECISION"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "PREPARE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "PRIMARY KEY"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "PRIMARY"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "PRINT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "PRIVILEGES"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "PROC"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "PROCEDURE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "PROCESSEXIT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "PROXY_TABLE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "PUBLIC"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "QUIESCE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "QUARTER"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "RADIANS"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "RAND"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "RAISERROR"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "READ_WRITE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "READ"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "READPAST"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "READTEXT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "REAL"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "RECONFIGURE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "REFERENCES"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "REFERENCES REMOVE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "REORG"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "REMOTE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "RENAME"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "REPEAT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "REPLACE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "REPLICATE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "REPLICATION"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "RESERVEPAGEAP"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "RESTRICT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "RETURN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "RETURNS"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "REVOKE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "RIGHT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ROLE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ROLLBACK"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ROWCOUNT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ROWS"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ROUND"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "RULE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "RTRIM"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SAVE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SCHEMA"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SECOND"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SECTION"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SELECT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SET"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SETUSER"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SHARE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SHARED"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SHUTDOWN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SIGN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SIN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SMALLINT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SOME"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SOURCE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SPACE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SQL_INTERNAL"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SQRT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "STAMP"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "START"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "STATISTICS"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "STRINGSIZE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "STRIPE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "STRUCTURE_FILE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SUBSTRING"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SUM"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SYB_IDENTIFY"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SYB_RESTREE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SYB_TERMINATE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SYNC"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "SYNCHRONIZE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "TABLE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "TAN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "TEMP"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "TEMPORARY"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "TEXT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "TEXTSIZE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "THEN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "THREADING"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "TIME"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "TIMESTAMP"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "TO"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "TRAILING"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "TRAN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "TRANSACTION"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "TRANSLATE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "TRIGGER"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "TRIM"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "TRUE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "TRUNC"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "TRUNCATE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "TS"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "TSEQUAL"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "UNION"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "UNIQUE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "UNLOCK TABLE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "UNLOCK"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "UNPARTITION"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "UPDATE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "UPPER"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "USE DATABASE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "USE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "USER"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "USER_OPTION"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "USING"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "UTF16"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "UTF8"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "UUID"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "VALUES"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "VARCHAR"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "VARYING"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "VIEW"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "WAITFOR"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "WEEK"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "WHEN"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "WHERE"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "WITH"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "WORK"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "WRITETEXT"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "YEAR"))
$coll.push(New object:C1471("type"; "cmdSQL"; "name"; "ZONE"))

// http://forums.4d.com/Post/FR/29377354/1/29377355#29377355
$coll.push(New object:C1471("type"; "system"; "name"; "IN"))
$coll.push(New object:C1471("type"; "system"; "name"; "OUT"))
$coll.push(New object:C1471("type"; "system"; "name"; "PRN"))
$coll.push(New object:C1471("type"; "system"; "name"; "CON"))
$coll.push(New object:C1471("type"; "system"; "name"; "AUX"))
$coll.push(New object:C1471("type"; "system"; "name"; "NUL"))
$coll.push(New object:C1471("type"; "system"; "name"; "COM1"))
$coll.push(New object:C1471("type"; "system"; "name"; "COM2"))
$coll.push(New object:C1471("type"; "system"; "name"; "COM3"))
$coll.push(New object:C1471("type"; "system"; "name"; "COM4"))
$coll.push(New object:C1471("type"; "system"; "name"; "COM5"))
$coll.push(New object:C1471("type"; "system"; "name"; "COM6"))
$coll.push(New object:C1471("type"; "system"; "name"; "COM7"))
$coll.push(New object:C1471("type"; "system"; "name"; "COM8"))
$coll.push(New object:C1471("type"; "system"; "name"; "COM9"))
$coll.push(New object:C1471("type"; "system"; "name"; "LPT1"))
$coll.push(New object:C1471("type"; "system"; "name"; "LPT2"))
$coll.push(New object:C1471("type"; "system"; "name"; "LPT3"))
$coll.push(New object:C1471("type"; "system"; "name"; "LPT4"))
$coll.push(New object:C1471("type"; "system"; "name"; "LPT5"))
$coll.push(New object:C1471("type"; "system"; "name"; "LPT6"))
$coll.push(New object:C1471("type"; "system"; "name"; "LPT7"))
$coll.push(New object:C1471("type"; "system"; "name"; "LPT8"))
$coll.push(New object:C1471("type"; "system"; "name"; "LPT9"))

// http://4d.1045681.n5.nabble.com/v15-what-code-runs-before-On-Startup-td5765713.html
$coll.push(New object:C1471("type"; "system"; "name"; "debut"))
$coll.push(New object:C1471("type"; "system"; "name"; "startup"))

Use (Storage:C1525)
	Storage:C1525.systemKeywords:=New shared collection:C1527
	Use (Storage:C1525.systemKeywords)
		OB_CopyToSharedCollection($coll; Storage:C1525.systemKeywords)
	End use 
End use 

If (Count parameters:C259=1)
	var $1 : Object
	signal_addResult($1; Current method name:C684)
End if 
