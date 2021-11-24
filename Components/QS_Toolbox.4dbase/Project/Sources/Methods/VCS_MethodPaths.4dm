//%attributes = {"invisible":true,"executedOnServer":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // user name (OS): jpupier
  // date and time: 23/03/11, 14:23:18
  // ----------------------------------------------------
  // method: VCS_MethodPaths
  // description
  // modifié par : Association QualiSoft (03/12/2016)
  //
  //
  // parameters

C_POINTER:C301($1;$methodPaths_at_p)
C_POINTER:C301($2;$methodDate_at_p)
C_POINTER:C301($3;$methodTime_at_p)
C_LONGINT:C283($4;$selector_l;$stamp_l)  // if 0:all types

  // path Database method
  // path Project form
  // path Project method
  // path Table form
  // path Trigger
  // path Class (v18R3)

C_POINTER:C301($5;$stamp_l_p)  // in & out parameter
C_TEXT:C284($6;$folder_t)

C_LONGINT:C283($stamp_l)

If (Count parameters:C259>=1)
	$methodPaths_at_p:=$1
End if 

If (Count parameters:C259>=2)
	$methodDate_at_p:=$2
End if 

If (Count parameters:C259>=3)
	$methodTime_at_p:=$3
End if 

$selector_l:=Path all objects:K72:16

If (Count parameters:C259>=4)  // 2->4
	$selector_l:=$4
End if 

$stamp_l:=0

If (Count parameters:C259>=5)  // 3->5
	$stamp_l_p:=$5
	$stamp_l:=$stamp_l_p->
End if 

$folder_t:=""
If (Count parameters:C259>=6)  // 4->6
	$folder_t:=$6
End if 

$ErrorMethod_t:=Method called on error:C704
ON ERR CALL:C155("BASE_noERROR")

If ($folder_t#"")
	METHOD GET PATHS:C1163($folder_t;$selector_l;$methodPaths_at_p->;$stamp_l;*)
	METHOD GET MODIFICATION DATE:C1170($methodPaths_at_p->;$methodDate_at_p->;$methodTime_at_p->;*)
Else 
	METHOD GET PATHS:C1163($selector_l;$methodPaths_at_p->;$stamp_l;*)
	METHOD GET MODIFICATION DATE:C1170($methodPaths_at_p->;$methodDate_at_p->;$methodTime_at_p->;*)
End if 

If (Not:C34(Is nil pointer:C315($stamp_l_p)))
	$stamp_l_p->:=$stamp_l
End if 

ON ERR CALL:C155($ErrorMethod_t)
