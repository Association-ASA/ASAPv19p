//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 25/02/19, 09:38:10
  // ----------------------------------------------------
  // Méthode : MM_getMethodAttributes
  // Description
  // 
  // Parameters
  // ----------------------------------------------------

C_OBJECT:C1216($3;$declaration)
C_COLLECTION:C1488($2;$data)
C_LONGINT:C283($1;$type)
C_OBJECT:C1216($method)
C_LONGINT:C283($i)

$type:=$1
$data:=$2
$declaration:=$3

Case of 
		
	: ($type=Path project method:K72:1)  //1
		$Message:="Path project method"
		
	: ($type=Path database method:K72:2)  // 2
		$Message:="Path database method"
		
	: ($type=Path project form:K72:3)  // 4
		$Message:="Path project form"
		
	: ($type=Path trigger:K72:4)  // 8
		$Message:="Path trigger"
		
	: ($type=Path table form:K72:5)  // 16
		$Message:="Path table form"
		
		  // TODO: replace by constant v19
	: ($type=32)  // Path class
		$Message:="Path Class"
		
End case 

$i:=0
$signal:=New signal:C1641
signal_setNew ($signal;$data.length)

For each ($method;$data)
	
	$i:=$i+1
	CALL WORKER:C1389("QST_mAnalysis_"+String:C10($type)+"_"+String:C10($i);"MM_setMethodAttributes";$method;$Message;$declaration;$signal)
	
	If ($i=Storage:C1525.QS_TBX_SHARED_DATA.maxWorkers)
		$i:=0
	End if 
	
End for each 

  //  // Manage now deleted methods
  //$result:=<>QS_TBX_allMethods.indices("checkOnStart = :1";False)
  //If ($result.length>0)  // one or more methods have been deleted
  //$result:=$result.orderBy(ck descending)
  //For each ($pos;$result)
  //<>QS_TBX_allMethods.remove($pos)
  //End for each 
  //End if 

  //  // Set to False for the next start
  //For each ($method;<>QS_TBX_allMethods)
  //$method.checkOnStart:=False
  //End for each 

$signal.wait()


If (Count parameters:C259=4)
	C_OBJECT:C1216($4)
	signal_addResult ($4;Current method name:C684)
End if 