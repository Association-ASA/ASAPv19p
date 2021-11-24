//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
var $item; $tmp : Object
var $1; $data; $methodsToUpdate; $update : Collection
var $n; $window : Integer
var $name : Text
ARRAY TEXT:C222($allMethods; 0x0000)

$before:=Method called on error:C704
ON ERR CALL:C155("BASE_noERROR")

C_OBJECT:C1216($param)
$param:=New object:C1471("title"; "Attributes update"; "icon"; "btn_attributes.png"; "type"; 0)
QST_progress_start($param)
$window:=$param.window

$methodsToUpdate:=$1

METHOD GET PATHS:C1163(Path project method:K72:1+Path database method:K72:2+Path table form:K72:5+Path trigger:K72:4; $allMethods; *)
SORT ARRAY:C229($allMethods; >)
$i:=0
$n:=$methodsToUpdate.length
$data:=Storage:C1525.allMethods

// Loop for each item in the collection
For each ($item; $methodsToUpdate)
	$i:=$i+1
	$param.value:=($i/$n)
	$param.content:=$item.name
	CALL FORM:C1391($window; "progressBar_update"; $param)
	
	If (Find in sorted array:C1333($allMethods; $item.name; >))
		// Save the attribute object
		$name:=$item.name
		$tmp:=$item.attributes
		METHOD SET ATTRIBUTES:C1335($name; $tmp; *)
		
		$update:=$data.indices("name  = :1"; $name)
		Use ($data)
			$data[$update.first()].attributes:=$tmp
		End use 
	End if 
End for each 

ON ERR CALL:C155($before)
$param.window:=$window
QST_progress_compileData($param)
savingData
KILL WORKER:C1390("QST_Progress")