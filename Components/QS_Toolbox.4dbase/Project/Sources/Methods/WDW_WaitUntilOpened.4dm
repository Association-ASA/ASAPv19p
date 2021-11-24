//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 27/05/18, 20:36:09
  // ----------------------------------------------------
  // Paramètres
  // $0 = window ref * #0 if obtained, else 0
  // $1 = window title * can use @
  // {$2} = timeOut * default is 60 ticks
  // ----------------------------------------------------
  // Méthode : WDW_WaitUntilOpened
  // Description
  //  
  // Win_waitUntilOpened (title_t {;timeOutTicks_l) -> long
  // Waits until a window of the expected title $1 is at frontmost
  // and returns the reference of that window
  // http://forums.4d.com/Post/FR/24349669/1/24362519

C_TEXT:C284($1;$winTitle_t)
C_LONGINT:C283($0;$2;$timeOut_l;$pss_l;$frontmost_l)

$0:=0
$winTitle_t:=$1
$timeOut_l:=60

If (Count parameters:C259>1)
	$timeOut_l:=$2
End if 

$pss_l:=Current process:C322
$timeOut_l:=Tickcount:C458+$timeOut_l

Repeat 
	PROCESS_sleep (2;$pss_l)
	$frontmost_l:=Frontmost window:C447
Until ((Get window title:C450($frontmost_l)=$winTitle_t) | (Tickcount:C458>$timeOut_l))

If (Get window title:C450($frontmost_l)=$winTitle_t)
	$0:=Frontmost window:C447
End if 