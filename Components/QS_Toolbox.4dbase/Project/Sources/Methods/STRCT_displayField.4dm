//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// https://blog.4d.com/detailed-analysis-database-structure/

C_OBJECT:C1216($oTable; $1)
C_TEXT:C284($tmp; $TableNum)
C_TEXT:C284($tmpVal; $PictureFile)
ARRAY OBJECT:C1221($arrField; 0x0000)
C_LONGINT:C283($i)
C_PICTURE:C286($Img)
C_COLLECTION:C1488($result)
$result:=New collection:C1472

C_TEXT:C284($p_Field_ID; $p_Field_name; $p_Field_type_name; $p_Field_limiting_length; $p_Field_indexed; \
$p_Field_text_switch_size; $p_Field_blob_switch_size; $p_Field_multi_line; \
$p_Field_uuid; $p_Field_enumeration_id; $p_Field_enumeration_name; $p_Field_position; $p_Field_comment; \
$p_Field_tip)
C_BOOLEAN:C305($p_Field_pk; $p_Field_unique; $p_Field_autosequence; $p_Field_not_null; $p_Field_never_null; $p_Field_autogenerate; \
$p_Field_hide_in_REST; $p_Field_visible; $p_Field_enterable; $p_Field_modifiable; $p_Field_mandatory; \
$p_Field_compressed)

ARRAY TEXT:C222($arrChoiceListName; 0x0000)
ARRAY LONGINT:C221($arrNb; 0x0000)
LIST OF CHOICE LISTS:C957($arrNb; $arrChoiceListName)

$oTable:=$1
OB GET ARRAY:C1229($1; "Field"; $arrField)
$TableNum:=OB Get:C1224($1; "id")
$size:=Size of array:C274($arrField)
$Listbox_Name:="lb_result"

For ($i; 1; $size)
	
	$p_Field_name:=$arrField{$i}.name
	$p_Field_ID:=$arrField{$i}.id
	$tmpVal:=$arrField{$i}.type
	
	$p_Field_Type:=$tmpVal
	Case of 
		: ($tmpVal="1")
			$p_Field_Type_name:="Boolean"
		: ($tmpVal="3")
			$p_Field_Type_name:="Integer"
		: ($tmpVal="4")
			$p_Field_Type_name:="Long integer"
		: ($tmpVal="5")
			$p_Field_Type_name:="Integer 64-bits"
		: ($tmpVal="6")
			$p_Field_Type_name:="Real"
		: ($tmpVal="7")
			$p_Field_Type_name:="Float"
		: ($tmpVal="8")
			$p_Field_Type_name:="Date"
		: ($tmpVal="9")
			$p_Field_Type_name:="Time"
		: ($tmpVal="10")
			$p_Field_Type_name:="Text"
		: ($tmpVal="12")
			$p_Field_Type_name:="Picture"
		: ($tmpVal="13")
			$p_Field_Type_name:="UUID"
		: ($tmpVal="15")
			$p_Field_Type_name:="Subtable Source"
		: ($tmpVal="16")
			$p_Field_Type_name:="Subtable Destination"
		: ($tmpVal="18")
			$p_Field_Type_name:="BLOB"
		: ($tmpVal="21")
			$p_Field_Type_name:="Object"
			
		Else 
			ALERT:C41("Field type unknown: "+$tmpVal)
	End case 
	
	// Assign a picture to the collection
	$p_Field_limiting_length:=$arrField{$i}.limiting_length
	
	Case of 
		: ($p_Field_limiting_length#"")
			$tmpVal:=$tmpVal+"_1"
		: ($tmpVal="16")  // Same picture than type 15
			$tmpVal:="15"
	End case 
	//$tmpVal:=$tmpVal+".png"
	//$PictureFile:=Get 4D folder(Current resources folder)+Replace string("fields/"+$tmpVal;"/";Folder separator)
	//READ PICTURE FILE($PictureFile;$Img)
	//If (OK=1)
	//$p_Field_picture:=$Img
	//End if 
	// Choose(This.NbPJ>0;PJ;Vide) // <--- formule de la colonne image
	
	
	$p_Field_uuid:=$arrField{$i}.uuid
	
	// http://forums.4d.com/Post/FR/22754707/3/22791299
	If (OB Is defined:C1231($arrField{$i}; "store_as_UUID")=True:C214)
		//$PictureFile:=Get 4D folder(Current resources folder)+Replace string("fields/13.png"; "/"; Folder separator)
		$PictureFile:=Folder:C1567(fk resources folder:K87:11).file("fields/13.png").platformPath
		READ PICTURE FILE:C678($PictureFile; $Img)
		If (OK=1)
			$p_Field_picture:=$Img
		End if 
		$p_Field_limiting_length:=""
	End if 
	
	If (OB Is defined:C1231($arrField{$i}; "pk")=True:C214)
		$p_Field_pk:=True:C214
	Else 
		$p_Field_pk:=False:C215
	End if 
	
	$TypeIndex_t:=""
	C_COLLECTION:C1488($coll; $result)
	$coll:=Form:C1466.oStructure.index
	
	If (OB Is defined:C1231($arrField{$i}; "index_ref")=True:C214)
		$TypeIndex_t:=GetIndexType(Field:C253(Num:C11($TableNum); Num:C11($p_Field_ID)))
	End if 
	$p_Field_indexed:=$TypeIndex_t
	
	$Tmp:=$arrField{$i}.unique
	$p_Field_unique:=Choose:C955($Tmp=""; False:C215; True:C214)
	
	$Tmp:=$arrField{$i}.autosequence
	$p_Field_autosequence:=Choose:C955($Tmp=""; False:C215; True:C214)
	
	$Tmp:=$arrField{$i}.not_null
	$p_Field_not_null:=Choose:C955($Tmp=""; False:C215; True:C214)
	
	$p_Field_text_switch_size:=$arrField{$i}.text_switch_size
	$p_Field_BLOB_switch_size:=$arrField{$i}.BLOB_switch_size
	
	$Tmp:=$arrField{$i}.never_null
	$p_Field_never_null:=Choose:C955($Tmp=""; False:C215; True:C214)
	
	$Tmp:=$arrField{$i}.autogenerate
	$p_Field_autogenerate:=Choose:C955($Tmp=""; False:C215; True:C214)
	
	$Tmp:=$arrField{$i}.hide_in_REST
	$p_Field_hide_in_REST:=Choose:C955($Tmp=""; False:C215; True:C214)
	
	$Tmp:=$arrField{$i}.visible
	$p_Field_visible:=Choose:C955($Tmp=""; True:C214; False:C215)
	
	$Tmp:=$arrField{$i}.enterable
	$p_Field_enterable:=Choose:C955($Tmp=""; True:C214; False:C215)
	
	$Tmp:=$arrField{$i}.modifiable
	$p_Field_modifiable:=Choose:C955($Tmp=""; True:C214; False:C215)
	
	$Tmp:=$arrField{$i}.mandatory
	$p_Field_mandatory:=Choose:C955($Tmp=""; False:C215; True:C214)
	
	$Tmp:=$arrField{$i}.multi_line
	$p_Field_multi_line:=Choose:C955($Tmp=""; "default"; $Tmp)
	
	$Tmp:=$arrField{$i}.compressed
	$p_Field_compressed:=Choose:C955($Tmp=""; False:C215; True:C214)
	
	$p_Field_eNumeration_id:=""
	$p_Field_eNumeration_name:=""
	If (OB Is defined:C1231($arrField{$i}; "enumeration_id")=True:C214)
		$tmpVal:=$arrField{$i}.enumeration_id
		$p_Field_eNumeration_id:=$tmpVal
		If ((Num:C11($tmpVal)<(Size of array:C274($arrChoiceListName)+1)) & (Num:C11($tmpVal)>0))
			$p_Field_eNumeration_name:=$arrChoiceListName{Num:C11($tmpVal)}
		End if 
	End if 
	
	$p_Field_Position:=$arrField{$i}.position
	$p_Field_comment:=$arrField{$i}.comment
	$p_Field_tip:=$arrField{$i}.tip
	
	$result.push(New object:C1471("id"; $p_Field_ID; \
		"name"; $p_Field_name; \
		"type"; $p_Field_type_name; \
		"length"; $p_Field_limiting_length; \
		"indexed"; $p_Field_indexed; \
		"b_pk"; $p_Field_pk; \
		"b_unique"; $p_Field_unique; \
		"b_auto_Sequence"; $p_Field_autosequence; \
		"b_not_Null"; $p_Field_not_null; \
		"b_never_Null"; $p_Field_never_null; \
		"b_auto_Generate"; $p_Field_autogenerate; \
		"b_hide_In_REST"; $p_Field_hide_in_REST; \
		"b_visible"; $p_Field_visible; \
		"b_enterable"; $p_Field_enterable; \
		"b_modifiable"; $p_Field_modifiable; \
		"b_mandatory"; $p_Field_mandatory; \
		"b_compressed"; $p_Field_compressed; \
		"text_Swuitch_Size"; $p_Field_text_switch_size; \
		"BLOB_switch_Size"; $p_Field_blob_switch_size; \
		"multiLine"; $p_Field_multi_line; \
		"enum_ID"; $p_Field_enumeration_id; \
		"enum_Name"; $p_Field_enumeration_name; \
		"position"; $p_Field_position; \
		"UUID"; $p_Field_uuid; \
		"comment"; $p_Field_comment; \
		"tips"; $p_Field_tip))
	
End for 

//$foreground:=color RGB black
//$background:=color RGB white

//If (OB Is defined($oTable;"color")=True)
//C_LONGINT($red;$green;$blue)
//$otmp:=$oTable.color
//$red:=Num($otmp.red) << 16
//$green:=Num($otmp.green) << 8
//$blue:=Num($otmp.blue)

//$rgb:=$red+$green*$blue

//If ($rgb=color RGB black) | ($rgb=color RGB white)  // automatique

//$foreground:=color RGB black
//$background:=color RGB white

//Else 

//Col_RGBtoHSL ($rgb;->$teinte;->$saturation;->$luminance)

//$saturation:=40
//$luminance:=40
//$foreground:=Col_HSLtoRGB ($teinte;$saturation;$luminance)

//$saturation:=10
//$luminance:=100
//$background:=Col_HSLtoRGB ($teinte;$saturation;$luminance)

//End if 

//End if 
//Form.colorBackground:=Substring(Str_longToHexa ($background);3)
//Form.colorText:=Substring(Str_longToHexa ($foreground);3)

$Listbox_Name:="lb_result"
LB_Init_Start($Listbox_Name)

If ($result.length>0)
	LB_buildByCollection($result; $Listbox_Name)
	
	ARRAY TEXT:C222($tabPropertyNames; 0x0000)
	OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
	
	For ($i; 1; Size of array:C274($tabPropertyNames))
		
		If (Substring:C12($tabPropertyNames{$i}; 1; 2)="b_")
			$tabPropertyNames{$i}:=Substring:C12($tabPropertyNames{$i}; 3)
		End if 
		OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); Uppercase:C13($tabPropertyNames{$i}))
		OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "QS_Col_"+$tabPropertyNames{$i}; Align center:K42:3)
		LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 50)
		OBJECT SET ENTERABLE:C238(*; "QS_Col_"+$tabPropertyNames{$i}; False:C215)
		
		Case of 
			: ($i=1)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 30)
				OBJECT SET FONT STYLE:C166(*; "QS_Col_"+$tabPropertyNames{$i}; Bold:K14:2)
				
			: ($i=2)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 170)
				OBJECT SET FONT STYLE:C166(*; "QS_Col_"+$tabPropertyNames{$i}; Bold:K14:2)
				
			: ($i=2) | ($i=20) | ($i=21) | ($i=22)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 120)
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "QS_Col_"+$tabPropertyNames{$i}; Align left:K42:2)
				
			: ($i=3)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 85)
				
			: ($i>=6) & ($i<=17)
				OBJECT SET HORIZONTAL ALIGNMENT:C706(*; "QS_Col_"+$tabPropertyNames{$i}; Align center:K42:3)
				
			: ($i=5) | ($i=18)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 70)
				
			: ($i>=24)
				LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 100)
		End case 
		
	End for 
	
End if 

LB_setHeights($Listbox_Name; 3; 1)
OBJECT SET VISIBLE:C603(*; $Listbox_Name; True:C214)
OBJECT SET ENTERABLE:C238(*; $Listbox_Name; False:C215)
LB_BlockEvents($Listbox_Name)
displayInfo("")