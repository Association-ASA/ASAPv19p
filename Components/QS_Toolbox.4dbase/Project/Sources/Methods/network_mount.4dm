//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
ASSERT:C1129(Count parameters:C259#1; "Need 1 parameter")
ASSERT:C1129(Type:C295($1)=Is object:K8:27; "Param $1 must be Object type")

C_OBJECT:C1216($0; $1; $param)
C_BOOLEAN:C305($B_Drive; $B_mount)
C_TEXT:C284($T_Server_path; $T_User; $T_PW; $T_Lettre_Drive)  // path of the folder to be mounted
C_TEXT:C284($in; $out; $error)
C_TEXT:C284($T_LEP; $T_Auth)

$param:=$1

// $param.message will get the information of error, in case of $param.result=0
$param.result:=1
$T_Server_path:=$param.path
$T_User:=$param.user
$T_PW:=$param.pswd
$T_Lettre_Drive:=$param.drive
$B_mount:=$param.mount  // mount if True, Unmount if False

// potential ways on Mac
// sudo mount -t afp afp://user:pass@ipaddress/user /Volumes/Shared
// open smb://<user>:<password>@server/<Volume>

// sudo mkdir /Volumes/mount
// sudo mount -t afp afp://user:pass@ipaddress/SharedDrive /Volumes/mount

$T_Lettre_Drive:=Uppercase:C13($T_Lettre_Drive)
$T_Lettre_Drive:=Replace string:C233($T_Lettre_Drive; ":"; "")
$B_Drive:=(Character code:C91($T_Lettre_Drive)>=65) & (Character code:C91($T_Lettre_Drive)<=90)
ASSERT:C1129($B_Drive; "Wrong letter for the drive")
ASSERT:C1129(Length:C16($T_Server_path)>1; "Path to volume is empty")

$T_Lettre_Drive:=$T_Lettre_Drive+":"

While ($T_Server_path[[1]]="\\")
	
	$T_Server_path:=Substring:C12($T_Server_path; 2)
	
End while 

If (Test path name:C476($T_Lettre_Drive)#Is a folder:K24:2)
	
	Case of 
			
		: ($B_mount) & (Is Windows:C1573)  // mount
			$T_Auth:=Choose:C955($T_User#""; " /user:"+$T_User+" "+$T_PW; "")
			$T_LEP:="net use "+$T_Lettre_Drive+" \\\\"+$T_Server_path+$T_Auth
			
		: (Not:C34($B_mount)) & (Is Windows:C1573)  // delete  // net use M: /delete
			$T_LEP:="net use "+$T_Lettre_Drive+" /delete"
			
	End case 
	
	$in:=""
	
	SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
	LAUNCH EXTERNAL PROCESS:C811($T_LEP; $in; $out; $error)
	
	$param.message:="OUT: "+$out+" ERROR: "+$error
	$param.result:=OK
	
End if 

$0:=$param
