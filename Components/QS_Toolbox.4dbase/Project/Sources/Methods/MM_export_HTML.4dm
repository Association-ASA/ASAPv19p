//%attributes = {"invisible":true,"preemptive":"capable"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 22/02/19, 18:01:45
// paramètres
// ----------------------------------------------------
// méthode : CM_export_HTML
// description
// create HTML files
// All these variables are used into the HTML template file

ON ERR CALL:C155("BASE_noERROR")

C_TEXT:C284($Path; $templateContent)
C_TEXT:C284($docPath_t; $templatePath_t; $w_HTMLfile)
C_TEXT:C284($w_MethodComments_at)  // has been inactivated for the moment.
C_TEXT:C284($w_MethodNames_t)
C_TEXT:C284($w_TabNbLigne)
C_TEXT:C284($w_TabNbVide)
C_TEXT:C284($w_TabNbComment)
C_TEXT:C284($w_TabNbAppel)
C_TEXT:C284($w_Complex)
C_TEXT:C284($w_MethodText_at)
C_TEXT:C284($w_LastDateUpdate)
C_TEXT:C284($w_AttrPremptive)
C_TEXT:C284($w_LastTimeUpdate; $w_Title)
C_TEXT:C284($w_4DMobile; $w_Method_img)
C_LONGINT:C283($FT; $long; $methodCount_l; $N; $ProgressBar; $type; $typeRef; $window)
C_BOOLEAN:C305($stop; $w_AttrInvisible; $w_AttrOnServer; $w_AttrShared; $w_AttrSOAP; $w_AttrSQL; $w_AttrWeb; $w_AttrWSDL; $w_QS_TBX_Graphviz)
C_COLLECTION:C1488($Coll; $data)
C_OBJECT:C1216($method; $QS_data)
C_OBJECT:C1216($DestinationPath)

ARRAY TEXT:C222(w_MethodCallees_at; 0x0000)
ARRAY TEXT:C222(w_MethodCallers_at; 0x0000)
ARRAY TEXT:C222($TabFichiers; 0x0000)

Graphviz_check

$data:=Storage:C1525.allMethods
$QS_data:=Storage:C1525.QS_TBX_SHARED_DATA
// -- Do this just once
$w_StructurePath:=Structure file:C489(*)
$w_DateGenerated:=String:C10(Current date:C33; Date RFC 1123:K1:11; Current time:C178)
$w_title:=$QS_data.QS_TBX_DBName
$w_QS_TBX_Graphviz:=$QS_data.QS_TBX_Graphviz
$DestinationPath:=Folder:C1567($QS_data.QS_TBX_DestinationPath; fk platform path:K87:2).folder("Export HTML")
$templateFile:=$DestinationPath.file("template.htm")
$templateContent:=$templateFile.getText()

//cleaning of Export HTML/methods/ folder
$toClean:=Folder:C1567($QS_data.QS_TBX_DestinationPath; fk platform path:K87:2).folder("Export HTML/methods/")
If ($toClean.exists)
	$toClean.delete(Delete with contents:K24:24)
	$toClean.create()
End if 

$Coll:=New collection:C1472

$startTime:=Current time:C178
$typeRef:=2
$code:=EXPORT_HTML_Start($w_title)

C_COLLECTION:C1488($methodList)
$counter:=0
$Progression:=0
$Pas:=1/($data.length+1)

// Initialisation
C_OBJECT:C1216($param)
$param:=New object:C1471("title"; "HTML export"; "icon"; "btn_attributes.png"; "type"; 0; "window"; 0)
$param:=QST_progress_start($param)  // Reassignation of Param Content
$window:=$param.window

// -- For each thema, we do the analysis
For ($ChoixType; 0; 5)
	
	$type:=$typeRef^$ChoixType  // 2^$choixtype
	
	Case of 
			
		: ($type=Path project method:K72:1)  // 1
			$Message:="Path project method "
			$methodList:=$data.filter("CM_displayByType"; "Path project method")
			
		: ($type=Path database method:K72:2)  // 2
			$Message:="Path database method "
			$methodList:=$data.filter("CM_displayByType"; "Path database method")
			
		: ($type=Path project form:K72:3)  // 4
			$Message:="Path project form "
			$methodList:=$data.filter("CM_displayByType"; "Path project form")
			
		: ($type=Path trigger:K72:4)  // 8
			$Message:="Path trigger "
			$methodList:=$data.filter("CM_displayByType"; "Path trigger")
			
		: ($type=Path table form:K72:5)  // path table form
			$Message:="Path table form "
			$methodList:=$data.filter("CM_displayByType"; "Path table form")
			
		: ($type=Path class:K72:19)  // path Class
			$Message:="Path Class "
			$methodList:=$data.filter("CM_displayByType"; "Path Class")
			
	End case 
	
	$methodList:=$methodList.orderBy("name asc")
	$methodCount_l:=$methodList.length
	$step:=0
	
	For each ($method; $methodList)
		$step:=$step+1
		$counter:=$counter+1
		$currentT:=Current time:C178
		$delta:=$currentT-$startTime
		$timeNeededEvaluated:=String:C10(Time:C179(($data.length-$counter)*($delta/$counter)); HH MM SS:K7:1)
		
		$w_MethodNames_t:=String:C10($method.name)
		If (Round:C94($counter; 1)%5=0)
			$info:=$timeNeededEvaluated+" - "+$w_MethodNames_t
			$Progression:=$Progression+(5*$pas)
			$param.content:=$info
			$param.value:=$Progression
			CALL FORM:C1391($window; "progressBar_update"; $param)
			PROCESS_sleep
		End if 
		
		CLEAR VARIABLE:C89(w_MethodCallers_at)
		CLEAR VARIABLE:C89(w_MethodCallees_at)
		$w_MethodText_at:=Substring:C12($method.code; Position:C15("\r"; $method.code; *)+1)
		$w_MethodText_at:=HTML_escapeCharacters($w_MethodText_at)
		$w_TabNbLigne:=String:C10($method.nbLines)
		$w_TabNbVide:=String:C10($method.nbEmpty)
		$w_TabNbComment:=String:C10($method.nbComment)
		$w_TabNbAppel:=String:C10($method.nbNested)
		$w_Complex:=String:C10($method.Complexity)
		$w_LastDateUpdate:=String:C10(Date:C102($method.lastUpdate))
		$w_LastTimeUpdate:=String:C10(Time:C179($method.timeUpdate))
		
		If ($type=Path project method:K72:1)
			$w_AttrInvisible:=$method.attributes.invisible
			$w_AttrWeb:=$method.attributes.publishedWeb
			$w_AttrSOAP:=$method.attributes.publishedSoap
			$w_AttrWSDL:=$method.attributes.publishedWsdl
			$w_AttrShared:=$method.attributes.shared
			$w_AttrSQL:=$method.attributes.publishedSql
			$w_AttrOnServer:=$method.attributes.executedOnServer
			$w_AttrPremptive:=$method.attributes.preemptive
		Else 
			$w_AttrInvisible:=False:C215
			$w_AttrWeb:=False:C215
			$w_AttrSOAP:=False:C215
			$w_AttrWSDL:=False:C215
			$w_AttrShared:=False:C215
			$w_AttrSQL:=False:C215
			$w_AttrOnServer:=False:C215
			$w_AttrPremptive:=""
		End if 
		
		$w_Bool_Img:=False:C215
		
		If ($method.callees.length=0)
			APPEND TO ARRAY:C911(w_MethodCallees_at; "N/A")
		Else 
			COLLECTION TO ARRAY:C1562($method.callees; w_MethodCallees_at)
			For ($a; 1; Size of array:C274(w_MethodCallees_at))
				TOOL_trimCharacters(->w_MethodCallees_at{$a})
			End for 
		End if 
		
		If ($method.callers.length=0)
			APPEND TO ARRAY:C911(w_MethodCallers_at; "N/A")
		Else 
			COLLECTION TO ARRAY:C1562($method.callers; w_MethodCallers_at)
			For ($a; 1; Size of array:C274(w_MethodCallers_at))
				TOOL_trimCharacters(->w_MethodCallers_at{$a})
			End for 
		End if 
		
		// -- SVG Graphviz creation
		If ($w_QS_TBX_Graphviz)
			$w_Method_img:=Graphviz_exportDocument($method)
			
			If ($w_Method_img#"")
				TOOL_trimCharacters(->$w_Method_img)
				$w_Method_img:=Replace string:C233($w_Method_img; "<!--#4D"; "<!--#4D ")  // to block recursive execution of "PROCESS 4D TAGS"
				
				If (Test path name:C476($w_Method_img)=Is a document:K24:1)
					$txt:=Document to text:C1236($w_Method_img; "UTF-8"; Document with LF:K24:22)
					
					If ($txt#"")
						DELETE DOCUMENT:C159($w_Method_img)  // We don't need it anymore in this specific case
						$Coll:=Split string:C1554($txt; "\r")
						$Coll:=Split string:C1554($Coll[0]; "\n")
						$coll.remove(0; 6)
						$w_Method_img:=$coll.join("\r")
					End if 
					
				Else 
					// in case of something happened between file creation and file exploitation
					$w_Method_img:=""
					
				End if 
			End if 
		End if 
		
		$Path:=$method.name
		TOOL_trimCharacters(->$Path)
		
		// -- Creation of HTML file
		PROCESS 4D TAGS:C816($templateContent; $w_HTMLfile; $w_MethodNames_t; $w_StructurePath; $w_DateGenerated; $w_LastDateUpdate; $w_LastTimeUpdate; $w_AttrInvisible; $w_AttrWeb; $w_AttrSOAP; $w_AttrWSDL; $w_AttrShared; $w_AttrSQL; $w_AttrOnServer; $w_MethodText_at; $w_MethodComments_at; $w_4DMobile; $w_TabNbLigne; $w_TabNbVide; $w_TabNbComment; $w_TabNbAppel; $w_Complex; $w_Method_img; $w_AttrPremptive; $w_QS_TBX_Graphviz; w_MethodCallees_at; w_MethodCallers_at)
		$htmlFile:=$DestinationPath.file("methods/"+String:C10($Path)+".html")
		$htmlFile.setText($w_HTMLfile)  // overwrite the content
		
	End for each 
	
	$code:=$code+EXPORT_HTML_QueryTree($Message; $methodList)
	$ProgressBar:=1
	
End for 

$index:=$DestinationPath.file("index.html")
If (Not:C34($stop))
	// -- Index file creation
	$code:=$code+EXPORT_HTML_End
	$index.setText($code)  // overwrite the content
	
	// -- Open the result in the web browser
	OPEN URL:C673($index.platformPath)
	
Else 
	$toClean.delete(Delete with contents:K24:24)
	If ($index.exists)
		$index.delete()
	End if 
	
End if 
KILL WORKER:C1390("QST_Progress")
