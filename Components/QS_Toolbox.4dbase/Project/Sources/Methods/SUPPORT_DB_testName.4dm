//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 15/04/19, 09:54:23
  // Paramètres
  // ----------------------------------------------------
  // $1 : pointer to collection
  // $2 : text to test
  // $3 : pattern
  // $4 : language
  // ----------------------------------------------------
  // Méthode : SUPPORT_DB_testName


C_COLLECTION:C1488($collection;$1)
C_TEXT:C284($2;$3)
C_TEXT:C284($0)

$collection:=$1
$0:=""

Case of 
		
	: (Match regex:C1019($3;$2;1))
		$0:="Char"
		
	: (Storage:C1525.commands4d.query($4+" = :1";$2).length>0)
		$0:="4D command"
		
	: ($collection.query("system = :1";$2).length>0)
		$0:="System"
		
	: ($collection.query("var4D = :1";$2).length>0)
		$0:="var 4D"
		
	: ($collection.query("cmdSQL = :1";$2).length>0)
		$0:="SQL command"
		
	: ($collection.query("varSQL = :1";$2).length>0)
		$0:="var SQL"
		
End case 