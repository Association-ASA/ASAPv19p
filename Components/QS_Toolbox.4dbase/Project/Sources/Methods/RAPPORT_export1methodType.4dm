//%attributes = {"invisible":true}
#DECLARE($data : Object; $option : Object; $signalToCheck : Object)

var $IsGraphvizInstalled : Boolean
var $pas; $Progression : Real
var $param; $QS_data; $wpDoc : Object
var $coll; $result : Collection
var $window : Integer
var $targetFolder : Text

$result:=New collection:C1472
$withGraphviz:=$option.withGraphviz
$case:=$option.format

Graphviz_check

$param:=New object:C1471("title"; "Export"; "icon"; "btn_phpword.png"; "type"; 0)
QST_progress_start($param)
$window:=$param.window
PROCESS_sleep(5)

$QS_data:=Storage:C1525.QS_TBX_SHARED_DATA
$IsGraphvizInstalled:=$QS_data.QS_TBX_Graphviz
$pas:=1/($data.length+1)
$Progression:=0
$firstPage:=True:C214
$started:=True:C214
$path:=""
$inter:=""
$previous:=""
$fileName:="all methods"
SET CURRENT PRINTER:C787(Generic PDF driver:K47:15)
$graphvizPicturePath:=Folder:C1567(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Reports; fk platform path:K87:2).folder("All Project Methods")

// $case
/*
1 = docx
2 = print pdf
3 = wp format
*/

var $end; $start : Time

For each ($e; $data)
	$Progression:=$Progression+$pas
	$param.value:=$Progression
	$param.content:="Export of "+$e.name
	CALL FORM:C1391($window; "progressBar_update"; $param)
	PROCESS_sleep(5)
	
	If ($e.path="Path table form")
		$coll:=Split string:C1554($e.name; "/")
		$inter:=$coll[1]
		If ($inter#$previous)
			
			$toSave:=True:C214
			If ($previous#"")
				$fileName:="Table "+$previous
			Else 
				$fileName:=$path
			End if 
			$previous:=$inter
		End if 
	End if 
	
	If ($path#$e.path) & (Not:C34($started))
		$firstPage:=True:C214
		$previous:=$inter
		$param.content:="Summary creation in progress."
		$param.value:=-1
		CALL FORM:C1391($window; "progressBar_update"; $param)
		PROCESS_sleep(5)
		
		Case of 
			: ($path="Path project method")
				$fileName:="Project Methods"
				
			: ($path="Path project form")
				$fileName:="Project form Methods"
				
			: ($path="Path database method")
				$fileName:="Database Methods"
				
			: ($path="Path trigger")
				$fileName:="Trigger Methods"
				
			: ($path="Path Class")
				$fileName:="Class Methods"
				
		End case 
		$toSave:=True:C214
		
	End if 
	
	If ($started)
		$started:=False:C215
		$path:=$e.path
		$toSave:=False:C215
	End if 
	
	If ($toSave)
		$param.content:="Summary creation in process"
		CALL FORM:C1391($window; "progressBar_update"; $param)
		PROCESS_sleep(5)
		
		$start:=Current time:C178
		RAPPORT_buildSummary($wpDoc; New collection:C1472("Method Title"); New collection:C1472("Summary Title"; "Code"; "Chapter"); $param)
		$end:=Current time:C178
		$result.push(New object:C1471("path"; $path; "action"; "buildSummary"; "start"; $start; "end"; $end; "duration"; String:C10($end-$start; HH MM SS:K7:1); "-"; ""))
		
		$param.content:="Export in progress"
		CALL FORM:C1391($window; "progressBar_update"; $param)
		PROCESS_sleep(5)
		
		$folderPath:=Folder:C1567(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Reports; fk platform path:K87:2).folder("Reports/Methods")
		$targetFolder:=$folderPath.file($fileName).platformPath
		
		$start:=Current time:C178
		Case of 
			: ($case=1)
				WP EXPORT DOCUMENT:C1337($WPdoc; $targetFolder; wk docx:K81:277; wk normal:K81:7)
				
			: ($case=2)
				SET PRINT OPTION:C733(Destination option:K47:7; 3; $targetFolder+".pdf")
				WP PRINT:C1343($wpDoc; wk 4D Write Pro layout:K81:176)
				
			: ($case=3)
				WP EXPORT DOCUMENT:C1337($WPdoc; $targetFolder; wk 4wp:K81:4; wk normal:K81:7)  // Works well
				
		End case 
		$end:=Current time:C178
		$result.push(New object:C1471("path"; $path; "action"; "buildSummary"; "start"; $start; "end"; $end; "duration"; String:C10($end-$start; HH MM SS:K7:1); "-"; ""))
		
		$toSave:=False:C215
		$firstPage:=True:C214
		
	End if 
	
	If ($firstPage)
		$firstPage:=False:C215
		$path:=$e.path
		
		// Initialisation
		$wpDoc:=WP New:C1317
		$wpDoc.author:="QS_Toolbox"
		$wpDoc.title:=$title
		$wpDoc.subject:="Automated created document"
		$title:="Methods of "+$QS_data.QS_TBX_DBName+"\r"+$e.path
		
		RAPPORT_WP_Settings($wpdoc)
		RAPPORT_coverPage($wpDoc; $title)
		RAPPORT_headerFooter($wpDoc; $title)
	End if 
	
	$newMethod:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
	WP SET ATTRIBUTES:C1342($newMethod; wk style sheet:K81:63; "Method Title")
	WP SET TEXT:C1574($newMethod; $e.name; wk append:K81:179; wk include in range:K81:180)
	WP NEW BOOKMARK:C1415($newMethod; $e.name)
	WP INSERT BREAK:C1413($newMethod; wk paragraph break:K81:259; wk append:K81:179; wk exclude from range:K81:181)
	WP INSERT BREAK:C1413($newMethod; wk paragraph break:K81:259; wk append:K81:179; wk exclude from range:K81:181)
	
	$text:=$e.code
	$Collect:=New collection:C1472
	$Collect:=Split string:C1554($text; "\r"; sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	$Collect.shift()  // remove the first line reserved by 4d
	$text:=$Collect.join("\n")+("\n"*3)
	$wpCode:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
	WP SET ATTRIBUTES:C1342($wpCode; wk style sheet:K81:63; "Code")
	WP SET TEXT:C1574($wpCode; $text; wk append:K81:179; wk include in range:K81:180)
	WP INSERT BREAK:C1413($wpCode; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)
	
	If (($IsGraphvizInstalled) & ($withGraphviz))
		$wpPicture:=WP Text range:C1341($wpDoc; wk end text:K81:164; wk end text:K81:164)
		
		var $ScreenShot : Picture
		
		$e.ext:=".svg"
		$e.path:=$graphvizPicturePath.platformPath
		$graphvizFile:=$graphvizPicturePath.file($e.name+$e.ext)
		Graphviz_neightbouring($e)
		
		//If (Test path name($graphvizPicturePath)=Is a document)
		If ($graphvizFile.exists=True:C214)
			
			$bigSize:=False:C215
			READ PICTURE FILE:C678($graphvizFile.platformPath; $ScreenShot; *)
			PICTURE PROPERTIES:C457($ScreenShot; $largeurImg; $hauteurImg)
			$Width:=400
			
			If ($hauteurImg>800)  // Big picture
				$bigSize:=True:C214
				$Wdth:=800
				$ratio:=$largeurImg/$Width
				TRANSFORM PICTURE:C988($ScreenShot; Scale:K61:2; 1; (1/$ratio))
			End if 
			If ($largeurImg>$Width)  // Big picture
				$bigSize:=True:C214
				$Wdth:=400
				$ratio:=$largeurImg/$Width
				TRANSFORM PICTURE:C988($ScreenShot; Scale:K61:2; (1/$ratio); 1)
				// landscape?
			End if 
			WP INSERT PICTURE:C1437($wpPicture; $ScreenShot; wk append:K81:179)
			WP INSERT BREAK:C1413($wpPicture; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)
			WP INSERT BREAK:C1413($wpPicture; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)
			WP INSERT BREAK:C1413($wpPicture; wk page break:K81:188; wk append:K81:179; wk include in range:K81:180)
			WP SET ATTRIBUTES:C1342($wpPicture; wk text align:K81:49; wk center:K81:99)
			
		End if 
	End if 
	
End for each 

Case of 
	: ($path="Path project method")
		$fileName:="Project Methods"
		
	: ($path="Path project form")
		$fileName:="Project form Methods"
		
	: ($path="Path database method")
		$fileName:="Database Methods"
		
	: ($path="Path table form")
		$fileName:="Table "+$previous
		
	: ($path="Path trigger")
		$fileName:="Trigger Methods"
		
End case 

$param.content:="Summary creation in process"
$param.value:=-1
CALL FORM:C1391($window; "progressBar_update"; $param)
PROCESS_sleep(5)

$start:=Current time:C178
RAPPORT_buildSummary($wpDoc; New collection:C1472("Method Title"); New collection:C1472("Summary Title"; "Code"; "Chapter"))
$end:=Current time:C178
$result.push(New object:C1471("path"; $path; "action"; "buildSummary"; "start"; $start; "end"; $end; "duration"; String:C10($end-$start; HH MM SS:K7:1); "-"; ""))

$param.content:="Export in progress"
CALL FORM:C1391($window; "progressBar_update"; $param)
PROCESS_sleep(5)

$folderPath:=Folder:C1567(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Reports; fk platform path:K87:2).folder("Reports/Methods")
$targetFolder:=$folderPath.file($fileName).platformPath

$start:=Current time:C178
Case of 
	: ($case=1)
		WP EXPORT DOCUMENT:C1337($wpDoc; $targetFolder; wk docx:K81:277; wk normal:K81:7)
		
	: ($case=2)
		SET PRINT OPTION:C733(Destination option:K47:7; 3; $targetFolder+".pdf")
		WP PRINT:C1343($wpDoc; wk 4D Write Pro layout:K81:176)
		
	: ($case=3)
		WP EXPORT DOCUMENT:C1337($wpDoc; $targetFolder; wk 4wp:K81:4; wk normal:K81:7)  // Works well
		
End case 
$end:=Current time:C178
$result.push(New object:C1471("path"; $path; "action"; "buildSummary"; "start"; $start; "end"; $end; "duration"; String:C10($end-$start; HH MM SS:K7:1); "-"; ""))

var $signal : Object
$signal:=New signal:C1641
CALL WORKER:C1389("QST_setCollToDiamond"; "WKR_setCollToDiamond"; $result; 4; $signal)  //3
$signal.wait()

$signal:=New signal:C1641
CALL WORKER:C1389("QST_setCollToDiamond"; "WKR_setCollToDiamond"; "method"; 2; $signal)
$signal.wait()

signal_addResult($signalToCheck; Current method name:C684)