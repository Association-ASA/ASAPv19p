//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
/* ----------------------------------------------------------------------
 Name: UTIL_SET_ATTR_PREEMPTIVE
 Description: Method will set the Preemptive attribute of a method.
 
 Parameters:
 $1 (TEXT) - Method Name
 $2 (LONG INT) - Scope:
 1 - Capable - "Can be run in preemptive processes"
 2 - Incapable - "Cannot be run in preemptive processes" 
 0 - No preference 

 Output:
 $0 (LONG INT) - Status of setting attribute
 0 - Success
 1 - Error: Insufficient parameters
 2 - Error: Found no method name
 ----------------------------------------------------------------------
 Example
 C_LONGINT($status)
$status:=UTIL_SET_ATTR_PREEMPTIVE ("Method1";1)
 ----------------------------------------------------------------------
*/

C_TEXT:C284($1;$method_name;$preemptive_property)
C_LONGINT:C283($2;$choice;$loc_method)
C_LONGINT:C283($0)
C_OBJECT:C1216($attributes)
ARRAY TEXT:C222($arrPaths;0)

If (Count parameters:C259=2)
	
	$method_name:=$1
	$choice:=$2
	
	  //METHOD GET PATHS(Path project method;$arrPaths;*)
	METHOD GET NAMES:C1166($arrPaths;*)
	$loc_method:=Find in array:C230($arrPaths;$method_name;1)
	
	If ($loc_method>0)
		METHOD GET ATTRIBUTES:C1334($arrPaths{$loc_method};$attributes;*)  // Method Attributes
		
		Case of 
			: ($choice=1)
				$preemptive_property:="capable"
			: ($choice=2)
				$preemptive_property:="incapable"
			Else 
				$preemptive_property:="indifferent"
		End case 
		
		OB SET:C1220($attributes;"preemptive";$preemptive_property)
		METHOD SET ATTRIBUTES:C1335($arrPaths{$loc_method};$attributes;*)  // Method Attributes
		$0:=0
	Else 
		$0:=2
	End if 
Else 
	$0:=1
End if 