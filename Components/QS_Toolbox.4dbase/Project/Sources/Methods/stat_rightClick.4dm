//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // $1 : collection
  // ----------------------------------------------------
  // Méthode : stat_rightClick
  // Description
  // 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 17/05/20, 15:35:09
  // Paramètres

C_COLLECTION:C1488($1;$data)
C_TEXT:C284($2;$title)

$data:=$1
$title:=$2

Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		If (Right click:C712)
			
			$col:=New collection:C1472("Export to .HTML";"Export to .CSV";"Export to .TXT";"Export to .MD")
			$referenceLigne:=Pop up menu:C542($col.join(";"))
			
			Case of 
				: ($referenceLigne=1)
					Collection_toHTML ($data;$title+" of "+Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName)
					
				: ($referenceLigne=2)
					Collection_toCSV ($data;$title+" of "+Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName)
					
				: ($referenceLigne=3)
					Collection_toTXT ($data;$title+" of "+Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName)
					
				: ($referenceLigne=4)
					Collection_toMd ($data;$title+" of "+Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName)
					
			End case 
			
		End if 
		
End case 