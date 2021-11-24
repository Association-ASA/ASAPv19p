//%attributes = {"invisible":true}
/* QST_initStorage
 Parameters:
        
  ----------------------------------------------------
 Creation: QualiSoft - Patrick EMANUEL, 12/09/21, 22:08:57
 ----------------------------------------------------
 Description:
            
*/

var $ServerMode : Boolean
var $param; $SharedData : Object
var $projectMode : Integer

ON ERR CALL:C155("Base_NoError")
CALL WORKER:C1389("QST_debug"; "floatWindow_send"; Current process name:C1392; "(1) - "+Current method name:C684)

$SoftName:="QS_ToolBox"

var $path : Object
$path:=QS_s_Get_DB_Name  // From the server

$QS_TBX_Reports:=System folder:C487(Documents folder:K41:18)+Replace string:C233($SoftName+"/"+$path.name; "/"; Folder separator:K24:12)
$QS_TBX_Reports:=$QS_TBX_Reports+Choose:C955(Is Windows:C1573; Folder separator:K24:12; "")
$ServerMode:=(Application type:C494=4D Remote mode:K5:5)  // Need to keep global to use it with the server

$projectMode:=Get database parameter:C643(Is host database a project:K37:99)  //  1 = project, else 0
$componentProjectMode:=Get database parameter:C643(Is current database a project:K37:98)  //  1 = project, else 0

$language:=Uppercase:C13(Choose:C955(Command name:C538(1)="Somme"; "fr"; "en"))
If ($language="")
	$language:="EN"
End if 

var $obVersion : Object
$obVersion:=New object:C1471
SUPPORT_VersionApplication($obVersion)

// Then we set free the Storage container
// Assigne the New shared object to an object
// An now, we work on the object (which refered to the shared object => instance counting ;-) )

$param:=New object:C1471
$param.VCS_QS_TBX_DBName:=$path.name+$path.extension
$param.QS_TBX_DBName:=$path.name
$param.SoftName:=$SoftName
$param.QS_TBX_crossReference:=False:C215
$param.QS_TBX_Debug:=False:C215
$param.QS_TBX_MAX_LOOP:=30
$param.QS_TBX_Componant_Version:=___version
$param.QS_TBX_4DVersion:="4D v"+$obVersion.version
$param.QS_TBX_4DMajeur:=$obVersion.major
$param.QS_TBX_4DMineur:=$obVersion.minor
$param.QS_TBX_4DVersionR:=$obVersion.rVersion
$param.QS_TBX_Component_Mode:=(Structure file:C489=Structure file:C489(*))
$param.QS_TBX_ServerMode:=$ServerMode  // Set in Storage. Access will be easier/ Be careful, One Storage for the Server, another one for each Client
$param.QS_TBX_END_TAG:="</span>"
$param.QS_TBX_COLOR_GREEN:="#229922"
$param.QS_TBX_COLOR_RED:="#FF0000"
$param.QS_TBX_COLOR_BLUE:="#222299"
$param.QS_TBX_COLOR_BLACK:="#000000"
$param.QS_TBX_LANGUAGE:=$language
$param.QS_TBX_Reports:=$QS_TBX_Reports  // Local
$param.QS_initDone:=False:C215
$param.QS_componentInProjectMode:=$componentProjectMode
$param.QS_hostInProjectMode:=$projectMode  // By default
$param.QS_LH_commands:=0
$param.maxWorkers:=4  // Max number of parallel workers authorized -> run more fatser than with other number on my computers
$param.appPath:=Get 4D folder:C485(Database folder:K5:14; *)

Use (Storage:C1525)
	Storage:C1525.QS_TBX_SHARED_DATA:=New shared object:C1526
	Use (Storage:C1525.QS_TBX_SHARED_DATA)
		OB_CopyToSharedObject($param; Storage:C1525.QS_TBX_SHARED_DATA)
	End use 
End use 

If (Count parameters:C259=1)
	var $1 : Object
	signal_addResult($1; Current method name:C684)
End if 