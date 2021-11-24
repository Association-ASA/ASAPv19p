//%attributes = {"invisible":true}
C_TEXT:C284($XMLcode; $pathName)
C_OBJECT:C1216($path)

$XMLcode:="<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"no\" ?>\n"
$XMLcode:=$XMLcode+"<com.4d>\n"
$XMLcode:=$XMLcode+"\t<compiler>\n"
$XMLcode:=$XMLcode+"\t\t<options compilation_path=\"2\" error_file=\"false\" fat_binary=\"false\" symbol_file=\"true\"/>\n"
$XMLcode:=$XMLcode+"\t\t<typage default_for_button=\"2\" default_for_numeric=\"1\"/>\n"
$XMLcode:=$XMLcode+"\t</compiler>\n"
$XMLcode:=$XMLcode+"</com.4d>"

$path:=QS_s_Get_DB_Name
$path:=Folder:C1567(fk documents folder:K87:21; *).folder("QS_Toolbox").folder($path.name).file("template_compiler.xml")
$path.setText($XMLcode)
PROCESS_sleep(10)

If (OK=1)
	// Start the compilation 
	$pathName:=$path.platformPath
	If (Not:C34(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Component_Mode))
		$contents:="BUILD APPLICATION:C871(\""+$pathName+"\")"
		
		$HostMethod:="__QST_HOST_temporary_method"
		$code:=METHOD Get path:C1164(Path project method:K72:1; $HostMethod; *)
		UPDT_WriteMethod($code; $contents)  // paste the method to the Host database
		METHOD SET ATTRIBUTE:C1192($code; Attribute shared:K72:10; True:C214; *)
		If ($path.exists())
			EXECUTE METHOD:C1007($HostMethod; *)
		End if 
		
		$contents:=""
		UPDT_WriteMethod($code; $contents)
		METHOD SET ATTRIBUTE:C1192($code; Attribute shared:K72:10; False:C215; *)
		
	Else 
		BUILD APPLICATION:C871($pathName)
		
	End if 
End if 