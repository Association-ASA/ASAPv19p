//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_OBJECT:C1216($FormDetail; $1)
$FormDetail:=$1

C_OBJECT:C1216($prop; $QS_data; $wpDoc)
C_COLLECTION:C1488($event; $pages)
C_TEXT:C284($formName; $tableName; $text)
C_BOOLEAN:C305($QS_TBX_hauteurFixe; $QS_TBX_largeurFixe)
C_LONGINT:C283($height; $PrintOrientation; $QS_TBX_hauteur; $QS_TBX_largeur; $QS_TBX_nbPages; $QS_TBX_NbPages; $width)

$QS_data:=Storage:C1525.QS_TBX_SHARED_DATA

FE_formLoad($FormDetail.tableNum; $FormDetail.formName)
GET PRINT OPTION:C734(Orientation option:K47:2; $PrintOrientation)
$formName:=$FormDetail.formName
$dbName:=$QS_data.QS_TBX_DBName

If ($FormDetail.tableNum=0)
	If (Not:C34($QS_data.QS_TBX_Component_Mode))
		FE_getFormAttributes($FormDetail)
		$QS_TBX_largeur:=Num:C11($FormAttributes.largeur)
		$QS_TBX_hauteur:=Num:C11($FormAttributes.hauteur)
		$QS_TBX_nbPages:=Num:C11($FormAttributes.nbpages)
		$QS_TBX_largeurFixe:=$FormAttributes.largeurfixe
		$QS_TBX_hauteurFixe:=$FormAttributes.hauteurfixe
		$QS_TBX_titre:=$FormAttributes.titre
	Else 
		FORM GET PROPERTIES:C674($formName; $QS_TBX_largeur; $QS_TBX_hauteur; $QS_TBX_nbPages; $QS_TBX_largeurFixe; $QS_TBX_hauteurFixe; $QS_TBX_titre)
	End if 
Else 
	$ZptTable:=Table:C252($FormDetail.tableNum)
	FORM GET PROPERTIES:C674($ZptTable->; $formName; $QS_TBX_largeur; $QS_TBX_hauteur; $QS_TBX_nbPages; $QS_TBX_largeurFixe; $QS_TBX_hauteurFixe; $QS_TBX_titre)
End if 

If ($QS_TBX_titre="")
	$QS_TBX_titre:="{No form title defined}"
End if 
FORM UNLOAD:C1299

C_OBJECT:C1216($param)
$param:=New object:C1471("pageNum"; 1; "table"; $FormDetail.tableNum; "project"; Bool:C1537($FormDetail.tableNum=0); "formName"; $FormDetail.formName)
$FormImage:=TOOL_getScreenShot($param)


//$signal:=$2
// New document
$text:=Choose:C955($FormDetail.tableName=""; "{Project Form}"; $FormDetail.tableName)+"/"+$FormDetail.formName
$title:="Database: "+$dbName+" -> "+$text

$wpDoc:=WP New:C1317
RAPPORT_WP_Settings($wpdoc)
RAPPORT_coverPage($wpDoc; $text)
RAPPORT_headerFooter($wpDoc; $title)

WP SET ATTRIBUTES:C1342($wpDoc; wk page orientation:K81:264; wk portrait:K81:274)
WP GET ATTRIBUTES:C1345($wpDoc; wk page width:K81:262; $width; wk page height:K81:263; $height)

// Insert screenshot of first page
$headerImage:=WP Add picture:C1536($wpDoc; $FormImage)
$headerImage[wk anchor page:K81:231]:=1  //anchor the image in the first page only
$headerImage[wk anchor horizontal align:K81:237]:=wk center:K81:99
$headerImage[wk anchor vertical align:K81:239]:=wk center:K81:99
$ratio:=Round:C94((500/$QS_TBX_largeur); 2)
$headerImage[wk width:K81:45]:=String:C10(Round:C94($QS_TBX_largeur*$ratio; 0))+"px"
$headerImage[wk height:K81:46]:=String:C10(Round:C94($QS_TBX_hauteur*$ratio; 0))+"px"

// New Page
$methodRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
WP INSERT BREAK:C1413($methodRange; wk paragraph break:K81:259; wk append:K81:179)
// WP INSERT BREAK($methodRange;wk section break;wk append;wk exclude from range)

// ------------------------------
// General Information about Formulare
$generalInfo:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
$text:="General Information"
WP SET ATTRIBUTES:C1342($generalInfo; wk style sheet:K81:63; "Method Title")
WP SET TEXT:C1574($generalInfo; $text; wk append:K81:179; wk include in range:K81:180)
WP INSERT BREAK:C1413($generalInfo; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)
WP INSERT BREAK:C1413($generalInfo; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)

// Insert table with general information
$genTable:=WP New:C1317
RAPPORT_WP_Settings($genTable)
// Update tab Setting
$tab:=New object:C1471
$tab[wk type:K81:189]:=wk left:K81:95
$tab[wk offset:K81:280]:="0.3cm"
$tab[wk leading:K81:281]:=""
WP SET ATTRIBUTES:C1342($wpDoc; wk tab default:K81:279; $tab)

$wpTable:=WP Insert table:C1473($genTable; wk append:K81:179; wk include in range:K81:180)
$wpRow:=WP Table append row:C1474($wpTable; "Property"; "Value")
WP SET ATTRIBUTES:C1342($wpRow; wk style sheet:K81:63; "Row little")

//  width of 1st column  250 pixels
$cell:=WP Table get columns:C1476($wpTable; 1)
WP SET ATTRIBUTES:C1342($cell; wk width:K81:45; "150 pt")
WP SET ATTRIBUTES:C1342($cell; wk font bold:K81:68; wk true:K81:174)
WP SET ATTRIBUTES:C1342($cell; wk background color:K81:20; "#D3D3D3")

//  width of 2d column 445 pixels
$cell:=WP Table get columns:C1476($wpTable; 2)
WP SET ATTRIBUTES:C1342($cell; wk width:K81:45; "200 pt")
WP SET ATTRIBUTES:C1342($cell; wk font bold:K81:68; wk true:K81:174)
WP SET ATTRIBUTES:C1342($cell; wk padding left:K81:16; "0.5cm")
WP SET ATTRIBUTES:C1342($cell; wk padding top:K81:18; "0cm")

// Center first row
$col:=WP Table get rows:C1475($wpTable; 1; 1)
WP SET ATTRIBUTES:C1342($col; wk text align:K81:49; wk center:K81:99)

ARRAY TEXT:C222($propertiesName; 0x0000)
ARRAY LONGINT:C221($propertiesType; 0x0000)
OB GET PROPERTY NAMES:C1232($FormDetail; $propertiesName; $propertiesType)
$formMethod:=False:C215
//$n:=0

For ($a; 1; Size of array:C274($propertiesName))
	
	If ($propertiesName{$a}#"method")
		Case of 
			: ($propertiesType{$a}=Is collection:K8:32) | ($propertiesType{$a}=Is object:K8:27) | ($propertiesType{$a}=Object array:K8:28) | ($propertiesType{$a}=Is null:K8:31)
				// do nothing
				
			: ($propertiesType{$a}=Is boolean:K8:9) | ($propertiesType{$a}=Is real:K8:4)
				$wpRow:=WP Table append row:C1474($wpTable; $propertiesName{$a}; String:C10($FormDetail[$propertiesName{$a}]))
				
			: ($propertiesType{$a}=Is text:K8:3)
				$wpRow:=WP Table append row:C1474($wpTable; $propertiesName{$a}; $FormDetail[$propertiesName{$a}])
				
		End case 
		WP SET ATTRIBUTES:C1342($wpRow; wk font bold:K81:68; wk false:K81:173)
		
	Else 
		$formMethod:=True:C214
	End if 
End for 

If ($FormDetail.events#Null:C1517)
	$event:=$FormDetail.events.copy()
	$wpRow:=WP Table append row:C1474($wpTable; "Event(s)"; $event.join("\r"))
End if 
WP INSERT BREAK:C1413($wpTable; wk paragraph break:K81:259; wk append:K81:179)
WP INSERT DOCUMENT:C1411($generalInfo; $genTable; wk append:K81:179)

// Get Methods
ARRAY TEXT:C222($tabMethodsPath; 0x0000)
$formName:=$FormDetail.formName
If ($FormDetail.tableNum>0)
	$tableName:=$FormDetail.tableName
	$zpt:=Table:C252($FormDetail.tableNum)
	METHOD GET PATHS FORM:C1168($zpt->; $tabMethodsPath; $formName; *)
Else 
	METHOD GET PATHS FORM:C1168($tabMethodsPath; $formName; *)
End if 

// Add formMethod
If ($formMethod)
	$methodRange:=WP Text range:C1341($generalInfo; wk end text:K81:164; wk end text:K81:164)
	
	// Check if there is at leat 1 method
	If (Size of array:C274($tabMethodsPath)>0)
		If ($tabMethodsPath{1}="@{formMethod}")  // There is a formMeethod available
			
			$text:="Form Method"
			$methodRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
			WP SET ATTRIBUTES:C1342($methodRange; wk style sheet:K81:63; "Method Title")
			WP SET TEXT:C1574($methodRange; $text; wk append:K81:179; wk include in range:K81:180)
			WP NEW BOOKMARK:C1415($methodRange; $text)
			WP INSERT BREAK:C1413($methodRange; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)
			WP INSERT BREAK:C1413($methodRange; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)
			
			METHOD GET CODE:C1190($tabMethodsPath{1}; $text; *)
			$Collect:=New collection:C1472
			$Collect:=Split string:C1554($text; "\r"; sk ignore empty strings:K86:1+sk trim spaces:K86:2)
			$Collect.shift()  // Remove the first line
			$text:=$Collect.join("\r")+"\r"*2
			
			$methodRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
			WP SET TEXT:C1574($methodRange; $text; wk append:K81:179; wk include in range:K81:180)
			WP SET ATTRIBUTES:C1342($methodRange; wk style sheet:K81:63; "Code")
			WP INSERT BREAK:C1413($methodRange; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)
		End if 
	End if 
	
End if 

// Page introspection
If ($FormDetail.pages#Null:C1517)
	
	$pages:=$FormDetail.pages.copy()
	C_OBJECT:C1216($page)
	C_COLLECTION:C1488($mycoll)
	$mycoll:=New collection:C1472
	ARRAY TEXT:C222($propObject; 0x0000)
	ARRAY LONGINT:C221($propObjType; 0x0000)
	$pageNum:=-1
	
	For each ($page; $pages)
		
		$pageNum:=$pageNum+1
		If (Not:C34(OB Is empty:C1297($page)))
			$pageRange:=WP Text range:C1341($generalInfo; wk end text:K81:164; wk end text:K81:164)
			$genTable:=WP New:C1317
			$text:="Page "+String:C10($pageNum)
			
			WP SET ATTRIBUTES:C1342($pageRange; wk style sheet:K81:63; "Method Title")
			WP SET TEXT:C1574($pageRange; $text; wk append:K81:179; wk include in range:K81:180)
			WP NEW BOOKMARK:C1415($pageRange; $text)
			WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)
			WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)
			
			// Add Picture of the page
			$pageRange:=WP Text range:C1341($generalInfo; wk end text:K81:164; wk end text:K81:164)
			C_OBJECT:C1216($param)
			$param:=New object:C1471("pageNum"; $pageNum; "table"; $FormDetail.tableNum; "project"; Bool:C1537($FormDetail.tableNum=0); "formName"; $FormDetail.formName)
			$FormImage:=TOOL_getScreenShot($param)
			TRANSFORM PICTURE:C988($FormImage; Scale:K61:2; (1*$ratio); (1*$ratio))
			WP INSERT PICTURE:C1437($pageRange; $FormImage; wk append:K81:179; wk include in range:K81:180)
			WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)
			WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)
			WP INSERT BREAK:C1413($pageRange; wk page break:K81:188; wk append:K81:179; wk include in range:K81:180)
			WP SET ATTRIBUTES:C1342($pageRange; wk text align:K81:49; wk center:K81:99)
			//
			
			CLEAR VARIABLE:C89($propertiesName)
			CLEAR VARIABLE:C89($propertiesType)
			OB GET PROPERTY NAMES:C1232($page.objects; $propertiesName)
			
			If (Size of array:C274($propertiesName)>0)  // $propertiesName is an object itself
				
				For ($a; 1; Size of array:C274($propertiesName))
					
					$text:="Object: "+$propertiesName{$a}
					$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
					WP SET ATTRIBUTES:C1342($pageRange; wk style sheet:K81:63; "title2")
					WP SET TEXT:C1574($pageRange; $text; wk append:K81:179; wk include in range:K81:180)
					WP NEW BOOKMARK:C1415($pageRange; $text)
					WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)
					WP INSERT BREAK:C1413($pageRange; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)
					
					$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
					$wpTable:=WP Insert table:C1473($pageRange; wk append:K81:179; wk include in range:K81:180)
					$wpRow:=WP Table append row:C1474($wpTable; "Property"; "Value")
					
					WP SET ATTRIBUTES:C1342($wpRow; wk font size:K81:66; 8)
					WP SET ATTRIBUTES:C1342($wpRow; wk font bold:K81:68; wk true:K81:174)
					
					//  width of 1st column 150 pixels
					$cell:=WP Table get columns:C1476($wpTable; 1)
					WP SET ATTRIBUTES:C1342($cell; wk width:K81:45; "150 pt")
					WP SET ATTRIBUTES:C1342($cell; wk font bold:K81:68; wk true:K81:174)
					WP SET ATTRIBUTES:C1342($cell; wk background color:K81:20; "#D3D3D3")
					
					//  width of 2d column 200 pixels
					$cell:=WP Table get columns:C1476($wpTable; 2)
					WP SET ATTRIBUTES:C1342($cell; wk width:K81:45; "200 pt")
					WP SET ATTRIBUTES:C1342($cell; wk font bold:K81:68; wk true:K81:174)
					WP SET ATTRIBUTES:C1342($cell; wk padding left:K81:16; "0.5cm")
					WP SET ATTRIBUTES:C1342($cell; wk padding top:K81:18; "0cm")
					
					// Center first row
					$col:=WP Table get rows:C1475($wpTable; 1; 1)
					WP SET ATTRIBUTES:C1342($col; wk text align:K81:49; wk center:K81:99)
					
					OB GET PROPERTY NAMES:C1232($page.objects[$propertiesName{$a}]; $propObject; $propObjType)
					
					For ($b; 1; Size of array:C274($propObject))
						Case of 
								
							: ($propObjType{$b}=Is text:K8:3)
								$list:="shortcutKey;method"
								If (Position:C15($propObject{$b}; $list)=0)
									$wpRow:=WP Table append row:C1474($wpTable; $propObject{$b}; $page.objects[$propertiesName{$a}][$propObject{$b}])
								End if 
								
						End case 
						WP SET ATTRIBUTES:C1342($wpRow; wk font bold:K81:68; wk false:K81:173)
					End for 
					$wpRow:=WP Table append row:C1474($wpTable; ""; "")
					
					// Others information about the widget
					$mycoll.clear()
					FE_formLoad($FormDetail.tableNum; $FormDetail.formName; "project"; Bool:C1537($FormDetail.tableNum=0))
					$mycoll:=FE_GetObjectDetails($FormDetail; $propertiesName{$a})
					FORM UNLOAD:C1299
					For each ($prop; $mycoll)
						$wpRow:=WP Table append row:C1474($wpTable; $prop.properties; $prop.value)
					End for each 
					
					WP INSERT DOCUMENT:C1411($wpDoc; $genTable; wk append:K81:179)
					WP INSERT BREAK:C1413($wpTable; wk page break:K81:188; wk append:K81:179)
					WP SET ATTRIBUTES:C1342($genTable; wk table align:K81:200; wk center:K81:99)
					
					// Insert Method if any here
					$pos:=Find in array:C230($tabMethodsPath; "@/"+$propertiesName{$a})
					
					If ($pos>0)
						$pageRange:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
						$end:=$pageRange.end
						
						METHOD GET CODE:C1190($tabMethodsPath{$pos}; $text; *)
						$Collect:=New collection:C1472
						$Collect:=Split string:C1554($text; "\r"; sk ignore empty strings:K86:1+sk trim spaces:K86:2)
						$Collect.shift()  // Remove the first line
						$text:=$Collect.join("\r")+("\r"*2)
						
						ST SET PLAIN TEXT:C1136($wpDoc; $text; $end+1)
						$end:=$end+Length:C16($text)+1
						$methodRange:=WP Text range:C1341($wpDoc; $end-Length:C16($text); $end)
						$methodRange[wk font size:K81:66]:=10
						$methodRange[wk font bold:K81:68]:=wk false:K81:173
						$methodRange[wk text align:K81:49]:=wk left:K81:95
						WP INSERT BREAK:C1413($wpDoc; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)
						
					End if 
					
				End for 
				
			End if 
			
			WP INSERT BREAK:C1413($wpDoc; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)
			WP INSERT BREAK:C1413($wpDoc; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)
			
		End if 
		
		If ($pageNum<($pages.length-1))
			WP INSERT BREAK:C1413($wpDoc; wk page break:K81:188; wk append:K81:179; wk include in range:K81:180)
		End if 
	End for each 
	
End if 

// Export file as DOCX
$Path:=Folder:C1567(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Reports; fk platform path:K87:2).folder("Reports/Forms")

$file:=Choose:C955($FormDetail.tableName=""; "Project form"; $FormDetail.tableName)+" - "+$FormDetail.formName
RAPPORT_buildSummary($wpDoc; New collection:C1472("Method Title"; "title2"); New collection:C1472("Summary Title"; "Summary Title2"); $param)

$targetFolder:=$path.file($file).platformPath

$param.value:=-1
$param.content:=$file+" export in process"
CALL FORM:C1391(Storage:C1525.windows.progress; "progressBar_update"; $param)
PROCESS_sleep(5)

WP EXPORT DOCUMENT:C1337($wpDoc; $targetFolder; wk docx:K81:277; wk normal:K81:7)

If (Current process name:C1392="QST_exportForm")
	SHOW ON DISK:C922($targetFolder+".docx")
End if 

KILL WORKER:C1390("QST_Progress")

If (Count parameters:C259=2)
	C_OBJECT:C1216($2)
	signal_addResult($2; Current method name:C684)
Else 
	KILL WORKER:C1390
End if 