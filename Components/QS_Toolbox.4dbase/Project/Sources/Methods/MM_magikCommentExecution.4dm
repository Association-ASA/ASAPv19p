//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// Initialisation

C_COLLECTION:C1488($methods; $1; $pos; $listCommand; $pos2; $listMethod)
C_LONGINT:C283($currentWindow; $2; $window)
C_TEXT:C284($command)
C_LONGINT:C283($max)
C_OBJECT:C1216($ent)
C_COLLECTION:C1488($commands4d; $data)

$methods:=$1
$currentWindow:=$2
$n:=$methods.length

$data:=Storage:C1525.allMethods
// Initialisation
C_OBJECT:C1216($param; $3)
$param:=New object:C1471("title"; "Comment update"; "icon"; "icn_settings.png"; "type"; 0)
QST_progress_start($param)
$window:=$param.window

$commands4d:=Storage:C1525.commands4d.copy()
$is_parms_inline:=Bool:C1537(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_inLine)  // list variables' name found with the $x
$is_parms_lines:=Bool:C1537(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_CHECH_lines)  // list variable assignments
$nbParamsPerLine:=Storage:C1525.QS_TBX_SHARED_DATA.QS_SETUP_MAX_COMMENT_LINES  // number of parameters before linefeed

ARRAY TEXT:C222($T_comments; $n)
ARRAY TEXT:C222($T_methodNames; $n)
C_REAL:C285($value)

$oldErrorMethod:=Method called on error:C704
ON ERR CALL:C155("BASE_noERROR")

$max:=$methods.length
$a:=0
$alert:=False:C215

For each ($ent; $Methods)
	$a:=$a+1
	$value:=$a/$max
	
	C_TEXT:C284($path; $method; $comments)
	$path:=$ent.name
	$method:=$ent.code
	Use (Storage:C1525.allMethods)
		$ent.hasDescription:=True:C214
	End use 
	
	If (x_og_magikComment($method; $path; ->$comments; True:C214; $is_parms_inline; $is_parms_lines; $nbParamsPerLine))
		$T_methodNames{$a}:=$path
		
		$text:="## Restrictions"+(Char:C90(Carriage return:K15:38)*2)+"**Current 4D version: "+Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_4DVersion+"**"+(2*Char:C90(Carriage return:K15:38))
		$text:=$text+"Cannot be preemptif due to following information, ***except if*** there is/are called by a CALL FORM command:"+(2*Char:C90(Carriage return:K15:38))
		$text:=$text+"|Type|Variable / Method name|"+Char:C90(Carriage return:K15:38)+"|------|------|"+Char:C90(Carriage return:K15:38)
		$touch:=False:C215
		
		$pos:=$data.indices("name =:1"; $path)
		
		$listCommand:=$data[$pos[0]].commandToken
		If ($listCommand.length>0)
			For each ($command; $listCommand)
				$pos2:=$commands4d.indices("token =:1"; $command)
				$threadSafe:=Bool:C1537($commands4d[$pos2[0]].threadsafe)
				If ($threadSafe=False:C215)
					$touch:=True:C214
					$text:=$text+"|*4D Command*|`"+Storage:C1525.commands4d[$pos2[0]].EN+"`|"+Char:C90(Carriage return:K15:38)
				End if 
			End for each 
		End if 
		
		$listMethod:=$data[$pos[0]].callees
		
		If ($listMethod.length>0)
			
			For each ($methodName; $listMethod)
				$pos:=$data.indices("name =:1"; $methodName)
				If ($data[$pos[0]].attributes.preemptive#"capable")
					$touch:=True:C214
					$text:=$text+"|*Method*|`"+$methodName+"`|"+Char:C90(Carriage return:K15:38)
				End if 
			End for each 
		End if 
		
		If ($touch)
			$comments:=$comments+(2*Char:C90(Carriage return:K15:38))+$text
		End if 
		
		$T_comments{$a}:=$comments
		Use ($data)
			$data[$pos[0]].comment:=$comments
		End use 
	Else 
		If (gerror#15)
			$alert:=True:C214
		End if 
		gerror:=0
	End if 
	
	$param.value:=$value
	$param.content:=$path
	$param.canvas:="progress"
	CALL FORM:C1391($window; "progressBar_update"; $param)
	
End for each 

QST_progress_compileData($param)

METHOD SET COMMENTS:C1193($T_methodNames; $T_comments; *)
savingData

If ($alert)
	$txt:="One or more methods have been renamed or deleted. Perform a new analysis before launch again this tool."
	CALL FORM:C1391($currentWindow; "displayInfo"; $txt; "red")
Else 
	$txt:=String:C10($n)+" method"+TOOL_plurial($n)+" comment "+Choose:C955($n>1; "have"; "has")+" been updated."
	CALL FORM:C1391($currentWindow; "displayInfo"; $txt)
End if 

$3.trigger()

ON ERR CALL:C155($oldErrorMethod)
KILL WORKER:C1390("QST_Progress")