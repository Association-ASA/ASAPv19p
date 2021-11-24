//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// https://blog.4d.com/detailed-analysis-database-structure/
#DECLARE($oTable : Object)

var $tmp : Text
var $result : Collection

$result:=New collection:C1472
$result.push(New object:C1471("method"; "Id: "; "data"; $oTable.id; "empty"; ""))
$result.push(New object:C1471("method"; "Name: "; "data"; $oTable.name; "empty"; ""))
$result.push(New object:C1471("method"; "UUID: "; "data"; $oTable.uuid; "empty"; ""))

If (OB Is defined:C1231($oTable; "Table_comment"))
	$value:=$oTable.Table_comment
Else 
	$value:=""
End if 
$result.push(New object:C1471("method"; "Comment: "; "data"; $value; "empty"; ""))

If (OB Is defined:C1231($oTable; "Table_sql_schema_name"))
	$value:=$oTable.Table_sql_schema_name
Else 
	$value:=""
End if 
$result.push(New object:C1471("method"; "SQL schema name: "; "data"; $value; "empty"; ""))

If (OB Is defined:C1231($oTable; "Table_sql_schema_id"))
	$value:=$oTable.Table_sql_schema_id
Else 
	$value:=""
End if 
$result.push(New object:C1471("method"; "SQL schema id: "; "data"; $value; "empty"; ""))


If (OB Is defined:C1231($oTable; "leave_tag_on_delete"))
	$Tmp:=$oTable.leave_tag_on_delete
	$value:=Choose:C955((($Tmp="") | ($Tmp="False")); String:C10(False:C215); String:C10(True:C214))
Else 
	$value:=String:C10(False:C215)
End if 
$result.push(New object:C1471("method"; "Tage on delete: "; "data"; $value; "empty"; ""))

If (OB Is defined:C1231($oTable; "keep_record_sync_info"))
	$Tmp:=$oTable.keep_record_sync_info
	$value:=Choose:C955((($Tmp="") | ($Tmp="False")); String:C10(False:C215); String:C10(True:C214))
Else 
	$value:=String:C10(False:C215)
End if 
$result.push(New object:C1471("method"; "Keep record sync info: "; "data"; $value; "empty"; ""))

If (OB Is defined:C1231($oTable; "hide_in_REST"))
	$Tmp:=$oTable.hide_in_REST
	$value:=Choose:C955((($Tmp="") | ($Tmp="False")); String:C10(False:C215); String:C10(True:C214))
Else 
	$value:=String:C10(False:C215)
End if 
$result.push(New object:C1471("method"; "Hide in REST: "; "data"; $value; "empty"; ""))

If (OB Is defined:C1231($oTable; "prevent_journaling"))
	$Tmp:=$oTable.prevent_journaling
	$value:=Choose:C955((($Tmp="") | ($Tmp="False")); String:C10(False:C215); String:C10(True:C214))
Else 
	$value:=String:C10(False:C215)
End if 
$result.push(New object:C1471("method"; "Prevent journaling: "; "data"; $value; "empty"; ""))

If (OB Is defined:C1231($oTable; "visible"))
	$Tmp:=$oTable.visible
	$value:=Choose:C955((($Tmp="") | ($Tmp="False")); String:C10(False:C215); String:C10(True:C214))
Else 
	$value:=String:C10(False:C215)
End if 
$result.push(New object:C1471("method"; "Visible: "; "data"; $value; "empty"; ""))

If (OB Is defined:C1231($oTable; "trigger_insert"))
	$Tmp:=$oTable.trigger_insert
	$value:=Choose:C955((($Tmp="") | ($Tmp="False")); String:C10(False:C215); String:C10(True:C214))
Else 
	$value:=String:C10(False:C215)
End if 
$result.push(New object:C1471("method"; "Trigger insert: "; "data"; $value; "empty"; ""))

If (OB Is defined:C1231($oTable; "trigger_delete"))
	$Tmp:=$oTable.trigger_delete
	$value:=Choose:C955((($Tmp="") | ($Tmp="False")); String:C10(False:C215); String:C10(True:C214))
Else 
	$value:=String:C10(False:C215)
End if 
$result.push(New object:C1471("method"; "Trigger delete: "; "data"; $value; "empty"; ""))

If (OB Is defined:C1231($oTable; "trigger_update"))
	$Tmp:=$oTable.trigger_update
	$value:=Choose:C955((($Tmp="") | ($Tmp="False")); String:C10(False:C215); String:C10(True:C214))
Else 
	$value:=String:C10(False:C215)
End if 
$result.push(New object:C1471("method"; "Trigger update: "; "data"; $value; "empty"; ""))

If (OB Is defined:C1231($oTable; "trashed"))
	$Tmp:=$oTable.trashed
	$value:=Choose:C955((($Tmp="") | ($Tmp="False")); String:C10(False:C215); String:C10(True:C214))
Else 
	$value:=String:C10(False:C215)
End if 
$result.push(New object:C1471("method"; "Trashed: "; "data"; $value; "empty"; ""))

$Listbox_Name:="lb_result"
LB_Init_Start($Listbox_Name)

If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		
		Case of 
			: ($i=1)
				LISTBOX SET COLUMN WIDTH:C833(*; $tabPropertyNames{$i}; 200)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Table property")
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $tabPropertyNames{$i}; Align right:K42:4)
				OBJECT SET FONT STYLE:C166(*; $tabPropertyNames{$i}; Bold:K14:2)
				
			: ($i=2)
				LISTBOX SET COLUMN WIDTH:C833(*; $tabPropertyNames{$i}; 500)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Value")
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; $tabPropertyNames{$i}; Align left:K42:2)
				
			: ($i=3)
				OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "")
				
		End case 
		
	End for 
	
End if 

OBJECT SET VISIBLE:C603(*; $Listbox_Name; True:C214)
LB_BlockEvents($Listbox_Name)