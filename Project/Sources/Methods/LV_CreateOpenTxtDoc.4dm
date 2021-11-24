//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// PM: "yCreateOpenTxtDoc" (new LV 20.05.20, 21:50:16)
// $0 - C_BOOLEAN - Result successfully executed
// $1 - C_TEXT - SrcTxt for document to create and open
// $2 - C_TEXT - FileName
// $2 - C_TEXT - DocType | ".html" | ".csv" | ".md" | ".txt" | ".tsv" | ".xml" | ".json" | 
// Create and open a text document
// Last change: LV 20.05.20, 21:50:16
// PE 28/11/20 - 

C_BOOLEAN:C305($result; $0)
C_TEXT:C284($srcTxt; $1)
C_TEXT:C284($fileName; $2)
C_TEXT:C284($docType; $3)

C_TEXT:C284($prevErrorMethod)
C_LONGINT:C283($prevOK)

$result:=False:C215  // init

If (Count parameters:C259>0)
	$srcTxt:=$1
	If (Count parameters:C259>1)
		$fileName:=$2
		If (Count parameters:C259>2)
			$docType:=$3
		End if 
	End if 
End if 

$docType:=collectionToGetDocType($docType)
$prevErrorMethod:=Method called on error:C704
ON ERR CALL:C155("base_noError")

$prevOK:=OK
OK:=0  // init

$file:=Folder:C1567("/LOGS/Export/").file($fileName+$docType)
If ($file.exists)  // In case we need to update
	$file.delete()
End if 

$created:=$file.create()
$file.setText($srcTxt)
OPEN URL:C673($file.platformPath)
If (OK=1)
	$result:=True:C214
End if 

ON ERR CALL:C155($prevErrorMethod)  // set back to previous value
OK:=$prevOK  // set back to previous value
$0:=$result