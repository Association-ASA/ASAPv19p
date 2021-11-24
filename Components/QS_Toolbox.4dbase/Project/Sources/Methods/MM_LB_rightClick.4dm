//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_COLLECTION:C1488($menu;$result;$collPath)
C_POINTER:C301($Nil)
C_TEXT:C284($action_txt)
$action_txt:=""
$sourcePath_icons:="images/methods/icn_upd_"
$isOk:=True:C214
$callees:=Form:C1466.currentElement.callees.length
$callers:=Form:C1466.currentElement.callers.length
$currentName:=Form:C1466.currentElement.name

$BasePath:=Storage:C1525.QS_TBX_SHARED_DATA.appPath
$DocumentationPath:=$BasePath+"Documentation"+Folder separator:K24:12
$SourcesPath:=$BasePath+"Project"+Folder separator:K24:12+"Sources"+Folder separator:K24:12
$collPath:=Split string:C1554($currentName;"/")

$path:=Form:C1466.currentElement.path

Case of 
	: ($path="Path project method")
		$title:="Path project method"
		$sourcePath:="methods"+Folder separator:K24:12+$collPath[0]
		
	: ($path="Path database method")
		$title:="Path database method"
		$sourcePath:="DatabaseMethods"+Folder separator:K24:12+$collPath[1]
		
	: ($path="Path project form")
		$title:="Path project form"
		$sourcePath:="Forms/"+$collPath[1]+"/"+Choose:C955($collPath[2]="{formMethod}";"method";"ObjectMethods/"+$collPath[2])
		
	: ($path="Path trigger")
		$title:="Path trigger"
		$sourcePath:="Triggers/table_"+String:C10(Storage:C1525.structureTable.query("name = :1";$collPath[1])[0].id)
		
	: ($path="Path table form")
		$title:="Path table form"
		$sourcePath:="TableForms/"+String:C10(Storage:C1525.structureTable.query("name = :1";$collPath[1])[0].id)+"/"+$collPath[2]+"/"+Choose:C955($collPath[3]="{formMethod}";"method";"ObjectMethods/"+$collPath[3])
		
	: ($path="Path Class")
		$title:="Classes"
		$sourcePath:="Classes"+Folder separator:K24:12+$collPath[1]
		
End case 
$sourcePath:=Replace string:C233($sourcePath;"/";Folder separator:K24:12)

$menu:=New collection:C1472
QS_menu_pushItem($menu;"Copy method name";"name")
QS_menu_pushItem($menu;"Copy method code";"code")

If (QS_miniVersionR(3))
	QS_menu_pushItem($menu;"Copy method comment";"comment";Form:C1466.currentElement.hasDescription)
End if 
QS_menu_pushItem($menu;"----------------------";"")

If (QS_miniVersionR(3))
	QS_menu_pushItem($menu;"Show method on disk";"showMethod")
	
	$continue:=True:C214
	Case of 
		: (OBJECT Get pointer:C1124(Object named:K67:5;"rd51")->=1)
			If ($collPath[2]#"{formMethod}")
				$continue:=False:C215
			End if 
			
		: (OBJECT Get pointer:C1124(Object named:K67:5;"rd53")->=1)
			If ($collPath[3]#"{formMethod}")
				$continue:=False:C215
			End if 
			
	End case 
	
	If ($continue)
		$continue:=Test path name:C476($DocumentationPath+$sourcePath+".md")=Is a document:K24:1
		QS_menu_pushItem($menu;"Show method comment on disk";"showComment";$continue)
		QS_menu_pushItem($menu;"Create method comment on disk";"createComment";Not:C34($continue))
	End if 
	
	QS_menu_pushItem($menu;"----------------------";"")
End if 

QS_menu_pushItem($menu;"List Callees";"callees";($callees>0))
QS_menu_pushItem($menu;"List Callers";"callers";($callers>0))
QS_menu_pushItem($menu;"Export Closer neighbors schema";"closer";(($callees+$callers)>0))
QS_menu_pushItem($menu;"----------------------";"")
QS_menu_pushItem($menu;"Export all to .HTML";"html")
QS_menu_pushItem($menu;"Export all to .CSV";"csv")
QS_menu_pushItem($menu;"Export all to .TXT";"txt")

$isOk:=x_btnPopup_coll(On Clicked:K2:4;->$action_txt;$Nil;$sourcePath_icons;$menu)

If ($isOk)
	
	TOOL_TRACE_On
	
	Case of 
			
		: ($action_txt="name")  // Copy method name 
			SET TEXT TO PASTEBOARD:C523($currentName)
			
		: ($action_txt="code")  // Copy method code
			$code:=Form:C1466.currentElement.code
			MM_removeFirstLine(->$code)
			SET TEXT TO PASTEBOARD:C523($code)
			
		: ($action_txt="comment")  // Copy method comment
			METHOD GET COMMENTS:C1189($currentName;$code;*)
			$code:=ST Get plain text:C1092($code)
			SET TEXT TO PASTEBOARD:C523($code)
			
		: ($action_txt="callees")  // Callees: Methodes appelées 
			$result:=Storage:C1525.allMethods.filter("CM_filterCalleesCallers";Form:C1466.currentElement.callees)
			If ($result.length>0)
				Form:C1466.listboxDisplayed:=$result
			Else 
				displayInfo("No call reference found for "+$currentName;"red")
			End if 
			
		: ($action_txt="callers")  // Callers: Méthodes appelantes
			$result:=Storage:C1525.allMethods.filter("CM_filterCalleesCallers";Form:C1466.currentElement.callers)
			If ($result.length>0)
				Form:C1466.listboxDisplayed:=$result
			Else 
				displayInfo("No caller found for "+$currentName;"red")
			End if 
			
		: ($action_txt="closer")
			Graphviz_neighboresCreation
			
		: ($action_txt="showMethod")
			$sourcePath:=$SourcesPath+$sourcePath+".4dm"
			SHOW ON DISK:C922($sourcePath)
			
		: ($action_txt="showComment")
			$sourcePath:=$DocumentationPath+$sourcePath+".md"
			SHOW ON DISK:C922($sourcePath)
			
		: ($action_txt="createComment")
			$signal:=New signal:C1641
			CALL WORKER:C1389("QST_job";"MM_magikCommentExecution";Form:C1466.methodSelected;Current form window:C827;$signal)
			$signal.wait()
			Use (Storage:C1525.allMethods)
				METHODS_hasDescription(Storage:C1525.allMethods.query("name =:1";$currentName)[0])
			End use 
			Use (Form:C1466.currentElement)
				Form:C1466.currentElement.hasDescription:=True:C214
			End use 
			MM_getCodeToDisplay(Form:C1466.currentElement)
			MM_option_manager(3;True:C214)
			
		: ($action_txt="html") | ($action_txt="csv") | ($action_txt="txt")
			
			Case of 
				: ($action_txt="html")
					Collection_toHTML(Form:C1466.listboxDisplayed;$title+" of "+Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName)
					
				: ($action_txt="csv")
					Collection_toCSV(Form:C1466.listboxDisplayed;$title+" of "+Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName)
					
				: ($action_txt="txt")
					Collection_toTXT(Form:C1466.listboxDisplayed;$title+" of "+Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName)
					
				: ($action_txt="md")
					Collection_toMd(Form:C1466.listboxDisplayed;$title+" of "+Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName)
					
			End case 
			
	End case 
End if 