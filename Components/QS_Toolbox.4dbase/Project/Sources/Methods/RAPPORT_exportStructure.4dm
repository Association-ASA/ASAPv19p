//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_OBJECT:C1216($param; $QS_data)
C_LONGINT:C283($window)
$param:=New object:C1471("title"; "Export"; "icon"; "btn_phpword.png"; "type"; 0)
QST_progress_start($param)
$window:=$param.window

$file:="Report Validation/Struture definition"
$QS_data:=Storage:C1525.QS_TBX_SHARED_DATA
$targetFolder:=$QS_data.QS_TBX_DestinationPath+Replace string:C233($file; "/"; Folder separator:K24:12)

If (Structure file:C489#Structure file:C489(*))  // This is not a composant. Go ahead
	
	C_OBJECT:C1216($oStructure; $o)
	C_PICTURE:C286($ScreenShot)
	ARRAY TEXT:C222($choiceListName; 0x0000)
	ARRAY LONGINT:C221($arrNb; 0x0000)
	C_TEXT:C284($vTStruc; $fieldName; $uuid)
	C_LONGINT:C283($height; $width)
	C_BOOLEAN:C305($stop)
	C_REAL:C285($pas)
	
	$stop:=False:C215
	$oStructure:=STRCT_GetDatabaseStructure
	$startTime:=Current time:C178
	$counter:=0
	
	$QS_TBX_DBName:=$QS_data.QS_TBX_DBName
	$Progression:=0
	$pas:=1/($oStructure.table.length+1)
	$Indicateur:="Creating picture of the database"
	
	$param.value:=$Progression
	$param.content:=$Indicateur
	$param.title:="Parsing "+$QS_TBX_DBName
	CALL FORM:C1391($window; "progressBar_update"; $param)
	
	If ($oStructure.table.length>0)  // Just in case
		
		$title:="Structure definition of "+$QS_TBX_DBName
		
		// Initialisation
		C_OBJECT:C1216($param; $wpDoc)
		$wpDoc:=WP New:C1317
		RAPPORT_WP_Settings($wpdoc)
		RAPPORT_coverPage($wpDoc; $title)
		RAPPORT_headerFooter($wpDoc; $title)
		
		$startTime:=Current time:C178
		$sectionNum:=1
		$section:=WP Get section:C1581($wpDoc; $sectionNum)
		$coverRange:=WP Text range:C1341($wpDoc; wk start text:K81:165; wk end text:K81:164)
		
		// Setting tab
		$tab:=New object:C1471
		$tab[wk type:K81:189]:=wk left:K81:95
		$tab[wk offset:K81:280]:="0.3cm"
		$tab[wk leading:K81:281]:=""
		WP SET ATTRIBUTES:C1342($wpDoc; wk tab default:K81:279; $tab)
		
		WP GET ATTRIBUTES:C1345($wpDoc; wk page width:K81:262; $width; wk page height:K81:263; $height)
		
		// ------------------------------
		// New Section
		$sectionNum:=$sectionNum+1
		
		$section:=WP Get section:C1581($wpDoc; $sectionNum)
		$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
		WP SET ATTRIBUTES:C1342($pageRange; wk style sheet:K81:63; "Code")
		
		EXPORT STRUCTURE:C1311($vTStruc)
		TEXT TO DOCUMENT:C1237("myStructure.xml"; $vTStruc)
		$ScreenShot:=SUPPORT_Draw_Structure("myStructure.xml"; "")  // "" return the picture
		DELETE DOCUMENT:C159("myStructure.xml")
		
		PICTURE PROPERTIES:C457($ScreenShot; $QS_TBX_largeur; $QS_TBX_hauteur)
		If ($QS_TBX_largeur>$QS_TBX_hauteur)
			If ($QS_TBX_largeur>600)
				$ratio:=Round:C94((600/$QS_TBX_largeur); 2)
				TRANSFORM PICTURE:C988($ScreenShot; Scale:K61:2; (1*$ratio); (1*$ratio))
			End if 
			
		Else 
			WP SET ATTRIBUTES:C1342($section; wk page orientation:K81:264; wk landscape:K81:275)
			If ($QS_TBX_hauteur>600)
				$ratio:=Round:C94((600/$QS_TBX_hauteur); 2)
				TRANSFORM PICTURE:C988($ScreenShot; Scale:K61:2; (1*$ratio); (1*$ratio))
			End if 
		End if 
		
		// Add Picture of the page
		WP INSERT PICTURE:C1437($pageRange; $ScreenShot; wk append:K81:179)
		
		$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
		WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)
		WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)
		WP INSERT BREAK:C1413($pageRange; wk page break:K81:188; wk append:K81:179; wk exclude from range:K81:181)
		
		// ------------------------------
		
		LIST OF CHOICE LISTS:C957($arrNb; $choiceListName)
		$counter:=0
		
		For each ($e; $oStructure.table) Until ($stop)
			
			$counter:=$counter+1
			$Progression:=$Progression+$pas
			
			$currentT:=Current time:C178
			$delta:=$currentT-$startTime
			$timeNeededEvaluated:=String:C10(Time:C179(($oStructure.table.length-$counter)*($delta/$counter)); HH MM SS:K7:1)
			$Indicateur:=$timeNeededEvaluated+" estimated time - "+$e.name
			$param.value:=$Progression
			$param.content:=$Indicateur
			CALL FORM:C1391($window; "progressBar_update"; $param)
			PROCESS_sleep
			
			$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
			WP SET TEXT:C1574($pageRange; "Table: "+$e.name; wk append:K81:179)
			WP SET ATTRIBUTES:C1342($pageRange; wk style sheet:K81:63; "Method Title")
			
			$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
			WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179)
			WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179)
			
			// Description part
			$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
			$text:=$e.name+" #: "+String:C10($e.id)
			$text:=$text+"\n"+"UUID: "+$e.uuid
			$text:=$text+"\n"+"Number of fields: "+String:C10($e.Field.length)
			WP SET TEXT:C1574($pageRange; $text; wk append:K81:179)
			WP SET ATTRIBUTES:C1342($pageRange; wk style sheet:K81:63; "Code")
			
			$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
			WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179)
			WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179)
			
			If (OB Is defined:C1231($e; "Table_sql_schema_id"))
				$Tmp:=$e.Table_sql_schema_id
			Else 
				$tmp:="-"
			End if 
			$text:=$text+"\n"+"SQL schema id: "+$tmp
			
			If (OB Is defined:C1231($e; "Table_sql_schema_name"))
				$Tmp:=$e.Table_sql_schema_name
			Else 
				$tmp:="-"
			End if 
			$text:=$text+"\n"+"SQL schema name: "+$tmp
			
			If (OB Is defined:C1231($e; "Table_comment"))
				$Tmp:=$e.Table_comment
			Else 
				$tmp:="-"
			End if 
			$text:=$text+"\n"+"Table comment: "+$tmp
			$text:=$text+("\n"*2)
			
			$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
			$wpTable:=WP Insert table:C1473($pageRange; wk append:K81:179; wk include in range:K81:180)
			$wpRow:=WP Table append row:C1474($wpTable; "Tag on delete"; "Keep record sync info"; "Hide in REST"; "Prevent journaling"; "Visible"; "Trigger insert"; "Trigger delete"; "Trigger update"; "Trashed")
			WP SET ATTRIBUTES:C1342($wpRow; wk style sheet:K81:63; "Row little")
			
			$cell:=WP Table get columns:C1476($wpTable; 1; 9)  // All to 100
			WP SET ATTRIBUTES:C1342($cell; wk width:K81:45; "100 pt")
			
			$cell:=WP Table get columns:C1476($wpTable; 2; 8)  // All to 150, except 1st column
			WP SET ATTRIBUTES:C1342($cell; wk width:K81:45; "150 pt")
			
			$cell:=WP Table get columns:C1476($wpTable; 3; 2)  // 3 & 4
			WP SET ATTRIBUTES:C1342($cell; wk width:K81:45; "100 pt")
			
			$cell:=WP Table get columns:C1476($wpTable; 5)
			WP SET ATTRIBUTES:C1342($cell; wk width:K81:45; "50 pt")
			
			$cell:=WP Table get columns:C1476($wpTable; 9)
			WP SET ATTRIBUTES:C1342($cell; wk width:K81:45; "50 pt")
			
			If (OB Is defined:C1231($e; "leave_tag_on_delete"))
				$tagOnDelete:=$e.leave_tag_on_delete
			Else 
				$tagOnDelete:="-"
			End if 
			
			$wpRow:=WP Table append row:C1474($wpTable; $tagOnDelete; \
				EXPORT_addBoolFromObject($e; "keep_record_sync_info"; True:C214); \
				EXPORT_addBoolFromObject($e; "hide_in_REST"; True:C214); \
				EXPORT_addBoolFromObject($e; "prevent_journaling"; True:C214); \
				EXPORT_addBoolFromObject($e; "visible"; True:C214); \
				EXPORT_addBoolFromObject($e; "trigger_insert"; True:C214); \
				EXPORT_addBoolFromObject($e; "trigger_delete"; True:C214); \
				EXPORT_addBoolFromObject($e; "trigger_update"; True:C214); \
				EXPORT_addBoolFromObject($e; "trashed"; True:C214))
			WP SET ATTRIBUTES:C1342($wpRow; wk font bold:K81:68; wk false:K81:173)
			WP SET ATTRIBUTES:C1342($wpRow; wk text align:K81:49; wk center:K81:99)
			
			$cell:=WP Table get rows:C1475($wpTable; 1; 1)
			WP SET ATTRIBUTES:C1342($cell; wk background color:K81:20; "#D3D3D3")
			
			$cell:=WP Table get rows:C1475($wpTable; 2; 1)
			WP SET ATTRIBUTES:C1342($cell; wk background color:K81:20; "#FFFFFF")
			
			WP INSERT BREAK:C1413($wpTable; wk paragraph break:K81:259; wk append:K81:179)
			WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179)
			
			If ($e.Field.length>0)
				// Field definitions & parameters
				
				$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
				$text:="Fields definition"
				WP SET TEXT:C1574($pageRange; $text; wk append:K81:179)
				WP SET ATTRIBUTES:C1342($pageRange; wk style sheet:K81:63; "Method Title")
				
				$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
				WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179)
				WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179)
				
				$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
				$wpTable:=WP Insert table:C1473($pageRange; wk append:K81:179; wk include in range:K81:180)
				$wpRow:=WP Table append row:C1474($wpTable; "#"; "Name"; "Type"; "Type Name"; "UUID"; "Store as UUID"; "length"; "Text Switch size"; "BLOB Switch size"; "Enumeration ID"; "Enumeration Name"; "TIPS"; \
					"Multi line"; "Position"; "Comment"; "Indexed"; "PK"; "Unique"; "Auto Inc."; "not NULL"; "never NULL"; "REST"; "Auto Generate"; "Visible"; "Enterable"; "Modifiable"; "Mandatory"; "Compressed")
				WP SET ATTRIBUTES:C1342($wpRow; wk style sheet:K81:63; "Row little")
				
				$cell:=WP Table get columns:C1476($wpTable; 1; 30)
				WP SET ATTRIBUTES:C1342($cell; wk width:K81:45; "50 pt")
				
				$cell:=WP Table get columns:C1476($wpTable; 2; 1)
				WP SET ATTRIBUTES:C1342($cell; wk width:K81:45; "120 pt")
				
				$cell:=WP Table get columns:C1476($wpTable; 4; 1)
				WP SET ATTRIBUTES:C1342($cell; wk width:K81:45; "150 pt")
				
				$cell:=WP Table get columns:C1476($wpTable; 11; 1)
				WP SET ATTRIBUTES:C1342($cell; wk width:K81:45; "150 pt")
				
				$cell:=WP Table get columns:C1476($wpTable; 5; 2)
				WP SET ATTRIBUTES:C1342($cell; wk width:K81:45; "100 pt")
				
				$cell:=WP Table get columns:C1476($wpTable; 12)
				WP SET ATTRIBUTES:C1342($cell; wk width:K81:45; "100 pt")
				
				$cell:=WP Table get columns:C1476($wpTable; 15; 2)
				WP SET ATTRIBUTES:C1342($cell; wk width:K81:45; "100 pt")
				
				$lTableNumber:=Num:C11($e.id)
				
				For each ($tableNumberInStructure; $e.Field)
					
					$id:=String:C10($tableNumberInStructure.id)
					$fieldName:=$tableNumberInStructure.name
					$type:=$tableNumberInStructure.type
					
					$tmp:=$type
					Case of 
						: ($tmp="1")
							$typeName:="T/F"
						: ($tmp="3")
							$typeName:="I"
						: ($tmp="4")
							$typeName:="L"
						: ($tmp="5")
							$typeName:="L64"
						: ($tmp="6")
							$typeName:="R"
						: ($tmp="7")
							$typeName:="F"
						: ($tmp="8")
							$typeName:="D"
						: ($tmp="9")
							$typeName:="H"
						: ($tmp="10")
							$typeName:="T"
						: ($tmp="12")
							$typeName:="P"
						: ($tmp="15")
							$typeName:="Sub. Source"
						: ($tmp="16")
							$typeName:="Sub. Dest"
						: ($tmp="18")
							$typeName:="B"
						: ($tmp="21")
							$typeName:="{}"
						Else 
							$typeName:="??"
					End case 
					
					$uuid:=$tableNumberInStructure.uuid
					$store:=EXPORT_addBoolFromObject($tableNumberInStructure; "store_as_UUID"; False:C215)
					
					If (OB Is defined:C1231($tableNumberInStructure; "limiting_length"))
						$limiting:=$tableNumberInStructure.limiting_length
					Else 
						$limiting:=""
					End if 
					
					If (OB Is defined:C1231($tableNumberInStructure; "text_switch_size"))
						$txtSwitch:=$tableNumberInStructure.text_switch_size
					Else 
						$txtSwitch:=""
					End if 
					
					If (OB Is defined:C1231($tableNumberInStructure; "BLOB_switch_size"))
						$BlobSwitch:=$tableNumberInStructure.BLOB_switch_size
					Else 
						$BlobSwitch:=""
					End if 
					
					If (OB Is defined:C1231($tableNumberInStructure; "enumeration_id"))
						$enumeration_id:=$tableNumberInStructure.enumeration_id
					Else 
						$enumeration_id:=""
					End if 
					
					If ((Num:C11($tmp)<(Size of array:C274($choiceListName)+1)) & (Num:C11($tmp)>0))
						$enumName:=$choiceListName{Num:C11($tmp)}
					Else 
						$enumName:=""
					End if 
					
					If (OB Is defined:C1231($tableNumberInStructure; "tip"))
						$tip:=$tableNumberInStructure.tip
					Else 
						$tip:=""
					End if 
					
					If (OB Is defined:C1231($tableNumberInStructure; "multi_line"))
						$multiLine:=$tableNumberInStructure.multi_line
					Else 
						$multiLine:=""
					End if 
					
					If (OB Is defined:C1231($tableNumberInStructure; "position"))
						$position:=$tableNumberInStructure.position
					Else 
						$position:=""
					End if 
					
					If (OB Is defined:C1231($tableNumberInStructure; "comment"))
						$comment:=$tableNumberInStructure.comment
					Else 
						$comment:=""
					End if 
					
					If (OB Is defined:C1231($tableNumberInStructure; "index_ref")=True:C214)
						$indexID:=GetIndexType(Field:C253(Num:C11($e.id); Num:C11($tableNumberInStructure.id)))
					Else 
						$indexID:=""
					End if 
					
					$pk:=EXPORT_addBoolFromObject($tableNumberInStructure; "pk"; False:C215)
					$unique:=EXPORT_addBoolFromObject($tableNumberInStructure; "uuid"; False:C215)
					$autoSequence:=EXPORT_addBoolFromObject($tableNumberInStructure; "autosequence"; False:C215)
					$notNull:=EXPORT_addBoolFromObject($tableNumberInStructure; "not_null"; False:C215)
					$neverNull:=EXPORT_addBoolFromObject($tableNumberInStructure; "never_null"; False:C215)
					$hideInRest:=EXPORT_addBoolFromObject($tableNumberInStructure; "hide_in_REST"; False:C215)
					$autoGenerate:=EXPORT_addBoolFromObject($tableNumberInStructure; "autogenerate"; False:C215)
					$visible:=EXPORT_addBoolFromObject($tableNumberInStructure; "visible"; False:C215)
					$enterable:=EXPORT_addBoolFromObject($tableNumberInStructure; "enterable"; False:C215)
					$modifiable:=EXPORT_addBoolFromObject($tableNumberInStructure; "modifiable"; False:C215)
					$mandatory:=EXPORT_addBoolFromObject($tableNumberInStructure; "mandatory"; False:C215)
					$compressed:=EXPORT_addBoolFromObject($tableNumberInStructure; "compressed"; False:C215)
					
					$wpRow:=WP Table append row:C1474($wpTable; $id; $fieldName; $type; $typeName; $uuid; $store; $limiting; $txtSwitch; $BlobSwitch; $enumeration_id; $enumName; $tip; $multiLine; $position; $comment; \
						$indexID; $pk; $unique; $autoSequence; $notNull; $neverNull; $hideInRest; $autoGenerate; $visible; $enterable; $modifiable; $mandatory; $compressed)
				End for each 
				
				$cell:=WP Table get columns:C1476($wpTable; 1; 4)
				WP SET ATTRIBUTES:C1342($cell; wk text align:K81:49; wk center:K81:99)
				
				$cell:=WP Table get columns:C1476($wpTable; 6; 5)
				WP SET ATTRIBUTES:C1342($cell; wk text align:K81:49; wk center:K81:99)
				
				$cell:=WP Table get columns:C1476($wpTable; 12; 3)
				WP SET ATTRIBUTES:C1342($cell; wk text align:K81:49; wk center:K81:99)
				
				$cell:=WP Table get columns:C1476($wpTable; 16; 13)
				WP SET ATTRIBUTES:C1342($cell; wk text align:K81:49; wk center:K81:99)
			End if 
			
			WP INSERT BREAK:C1413($wpTable; wk paragraph break:K81:259; wk append:K81:179)
			WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179)
			
			If ($oStructure.relation.length>0)
				
				$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
				$text:="Relations definition"
				WP SET TEXT:C1574($pageRange; $text; wk append:K81:179)
				WP SET ATTRIBUTES:C1342($pageRange; wk style sheet:K81:63; "Method Title")
				
				$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
				WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179)
				WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179)
				
				For each ($e; $oStructure.relation)
					
					$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
					$text:="Relations "+$e.name_Nto1+" & "+$e.name_1toN
					WP SET TEXT:C1574($pageRange; $text; wk append:K81:179)
					WP SET ATTRIBUTES:C1342($pageRange; wk style sheet:K81:63; "Code")
					
					$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
					WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179)
					
					$text:="Relation N to 1: "+$e.name_Nto1
					WP SET TEXT:C1574($pageRange; $text; wk append:K81:179)
					WP SET ATTRIBUTES:C1342($pageRange; wk style sheet:K81:63; "Code")
					
					$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
					WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179)
					
					$text:="uuid: "+$e.uuid
					WP SET TEXT:C1574($pageRange; $text; wk append:K81:179)
					WP SET ATTRIBUTES:C1342($pageRange; wk style sheet:K81:63; "Code")
					
					$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
					WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179)
					WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179)
					
					$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
					$wpTable:=WP Insert table:C1473($pageRange; wk append:K81:179; wk include in range:K81:180)
					$wpRow:=WP Table append row:C1474($wpTable; "Color"; "Integrity"; "Choice field"; "Auto load Nto1"; "Auto load 1toN"; "Wildcard"; "Entry create"; "Auto fill")
					WP SET ATTRIBUTES:C1342($wpRow; wk style sheet:K81:63; "Row little")
					
					If (OB Is defined:C1231($e; "color")=True:C214)
						$color:="0x00"+UTIL_RGB_2_HEX(Num:C11($e.color.red); Num:C11($e.color.green); Num:C11($e.color.blue))
					Else 
						$color:="0x00FFFFFF"
					End if 
					
					If (OB Is defined:C1231($e; "integrity")=True:C214)
						$integrity:=$e.integrity
					Else 
						$integrity:="None"
					End if 
					
					If (OB Is defined:C1231($e; "choice_field")=True:C214)
						$choice_field:=$e.choice_field
					Else 
						$choice_field:="None"
					End if 
					
					$auto_load_Nto1:=EXPORT_addBoolFromObject($tableNumberInStructure; "auto_load_Nto1"; False:C215)
					$auto_load_1toN:=EXPORT_addBoolFromObject($tableNumberInStructure; "auto_load_1toN"; False:C215)
					$entry_wildchar:=EXPORT_addBoolFromObject($tableNumberInStructure; "entry_wildchar"; False:C215)
					$entry_create:=EXPORT_addBoolFromObject($tableNumberInStructure; "entry_create"; False:C215)
					$entry_autofill:=EXPORT_addBoolFromObject($tableNumberInStructure; "entry_autofill"; False:C215)
					$wpRow:=WP Table append row:C1474($wpTable; $color; $integrity; $choice_field; $auto_load_Nto1; $auto_load_1toN; $entry_wildchar; $entry_create; $entry_autofill)
					
					WP INSERT BREAK:C1413($wpTable; wk paragraph break:K81:259; wk append:K81:179)
					WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179)
					
					$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
					$wpTable:=WP Insert table:C1473($pageRange; wk append:K81:179; wk include in range:K81:180)
					$wpRow:=WP Table append row:C1474($wpTable; "KInd"; "Table name"; "Field"; "UUID")
					WP SET ATTRIBUTES:C1342($wpRow; wk style sheet:K81:63; "Row little")
					
					For each ($o; $e.related_field)
						
						$wpRow:=WP Table append row:C1474($wpTable; $o.kind; $o.table_name; $o.name; $o.uuid)
					End for each 
					
					WP INSERT BREAK:C1413($wpTable; wk paragraph break:K81:259; wk append:K81:179)
					WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179)
					
				End for each 
				
			End if 
			
		End for each 
		
		$param.value:=-1
		$param.content:="Export document in process"
		CALL FORM:C1391($window; "progressBar_update"; $param)
		PROCESS_sleep
		WP EXPORT DOCUMENT:C1337($wpDoc; $targetFolder; wk docx:K81:277; wk normal:K81:7)
		
	End if 
	
End if 

signal_addResult($1; Current method name:C684)