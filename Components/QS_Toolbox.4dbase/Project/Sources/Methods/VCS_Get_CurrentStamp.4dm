//%attributes = {"invisible":true,"executedOnServer":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"preemptive":"indifferent"}
C_LONGINT:C283($0;$Currentstamp_l)
ARRAY TEXT:C222($paths_at;0x0000)
ARRAY DATE:C224($DateModified_at;0x0000)
ARRAY LONGINT:C221($TimeModified_at;0x0000)

  // just read the minimal, we are only interested by the stamp
$Currentstamp_l:=0
VCS_MethodPaths (->$paths_at;->$DateModified_at;->$TimeModified_at;Path all objects:K72:16;->$Currentstamp_l)
$0:=$Currentstamp_l