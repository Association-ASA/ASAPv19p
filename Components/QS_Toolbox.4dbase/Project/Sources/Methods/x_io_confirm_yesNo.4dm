//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}

C_POINTER:C301($QS_PTR_NIL)  // Used when you need a nil pointer !
C_TEXT:C284($txt)
$txt:=$1
C_BOOLEAN:C305($isAction)
C_POINTER:C301($ptr_action_ext;$2)
C_LONGINT:C283($action)
$isAction:=(Count parameters:C259>=2)
If ($isAction)
	$ptr_action_ext:=$2
	$isBoolean:=(Type:C295($ptr_action_ext->)=Is boolean:K8:9)
	If ($isBoolean)
		$action:=1-Num:C11($ptr_action_ext->)
	Else 
		$action:=1-$ptr_action_ext->
	End if 
Else 
	$action:=-1
End if 
$ptr_action:=->$action

C_BOOLEAN:C305($isOk)
ARRAY TEXT:C222($T_labels;0)
$T_labels{0}:=$txt
APPEND TO ARRAY:C911($T_labels;"YES")
If ($isAction)
	APPEND TO ARRAY:C911($T_labels;"NO")
End if 
C_TEXT:C284($rscPath)
$rscPath:="images/icons/icn_yesno"
$isOk:=x_btnPopup_val (On Clicked:K2:4;$ptr_action;$QS_PTR_NIL;$rscPath;->$T_labels)
If ($isOk)
	If ($isAction)
		If ($isBoolean)
			$ptr_action_ext->:=($action=0)
		Else 
			$ptr_action_ext->:=1-$action  // 0 nok ; 1 ok
		End if 
	Else 
		$isOk:=($action=0)
	End if 
End if 
$0:=$isOk
