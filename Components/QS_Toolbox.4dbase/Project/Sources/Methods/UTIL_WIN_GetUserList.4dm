//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // Method: Util_WIN_GetUsersList
  //
  // Parameters: 
  // $1 - Pointer to Text Array to Recieve Results
  //
  // ---------------------------------------------------
  // http://kb.4d.com/assetid=78049
  // ARRAY TEXT($res_at;0)
  // UTIL_WIN_GetUserList (->$res_at)

C_POINTER:C301($1)

C_TEXT:C284($lepI_t)
C_TEXT:C284($lepO_t)
C_TEXT:C284($lepErr_t)
C_BOOLEAN:C305($match_b)
C_BOOLEAN:C305($end_b)
C_LONGINT:C283($lenFound_l;$posFound_l)
ARRAY TEXT:C222($users_at;0)

SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")
LAUNCH EXTERNAL PROCESS:C811("net user";$lepI_t;$lepO_t;$lepErr_t)
$match_b:=Match regex:C1019("\r\n\r\n-+\r\n";$lepO_t;1;$posFound_l;$lenFound_l)
$list_t:=Substring:C12($lepO_t;$posFound_l+$lenFound_l)
$list_t:=Replace string:C233($list_t;"\r\n";"")


While ($end_b=False:C215)
	$user_t:=Substring:C12($list_t;1;25)
	$user_t:=Replace string:C233($user_t;" ";"")
	APPEND TO ARRAY:C911($users_at;$user_t)
	$list_t:=Substring:C12($list_t;26)
	
	  //Exit Condition
	If ($list_t="The command completed successfully.")
		$end_b:=True:C214
	End if 
	
End while 

COPY ARRAY:C226($users_at;$1->)