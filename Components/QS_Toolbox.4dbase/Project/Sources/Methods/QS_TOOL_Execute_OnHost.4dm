//%attributes = {"invisible":true,"shared":true,"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // date et heure : 26/12/16, 17:50:53
  // ----------------------------------------------------
  // méthode : QS_TOOL_Execute_OnHost
  // description
  // copy the method from $1 to
  // the host database into __QS_TOOLBOX_Export_Library
  // then execute the method.
  // after execution, the method is keep into the host database
  //
  // paramètres
  // ----------------------------------------------------
  // WARNING: In compile

C_TEXT:C284($code)
C_TEXT:C284($contents)
C_TEXT:C284($1;$MethodName)
C_TEXT:C284($2;$AlertMess)

  // check before start
ASSERT:C1129(Count parameters:C259=2;"requires 2 parameters")
ASSERT:C1129(Type:C295($1)=Is text:K8:3;"$1 should be a text variable")
ASSERT:C1129(Type:C295($2)=Is text:K8:3;"$2 should be a text variable")

$MethodName:=$1

If (Not:C34(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Component_Mode))
	$AlertMess:=$2
	$HostMethod:="__QST_HOST_temporary_method"
	
	If ($AlertMess#"")
		CONFIRM:C162($AlertMess)
	End if 
	
	If (OK=1)
		
		$contents:=File:C1566("/RESOURCES/tools/"+$MethodName+".txt").getText("UTF-8")
		$code:=METHOD Get path:C1164(Path project method:K72:1;$HostMethod;*)
		UPDT_WriteMethod ($code;$contents)  // paste the method to the Host database
		METHOD SET ATTRIBUTE:C1192($code;Attribute shared:K72:10;True:C214;*)
		
		If (OK=1)
			EXECUTE METHOD:C1007($HostMethod;*)
		End if 
		
		$contents:=""
		UPDT_WriteMethod ($code;$contents)
		METHOD SET ATTRIBUTE:C1192($code;Attribute shared:K72:10;False:C215;*)
		
	End if 
	
Else   // We are working directly from the componant
	
	$MethodName:=Substring:C12($MethodName;1;Length:C16($MethodName)-3)
	EXECUTE METHOD:C1007($MethodName)
	
End if 