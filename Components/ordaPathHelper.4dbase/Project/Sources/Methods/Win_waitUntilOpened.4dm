//%attributes = {}
  //Win_waitUntilOpened (title_t {;timeOutTicks_l) -> long
  //Waits until a window of the expected title $1 is at frontmost
  //  and returns the reference of that window
  //$0 window ref * #0 if obtained, else 0
  //$1 window title * can use @
  //$2 optional timeOut * default is 120 ticks
C_LONGINT:C283($0)
C_TEXT:C284($1)
C_LONGINT:C283($2)

C_TEXT:C284($winTitle_t)
C_LONGINT:C283($timeOut_l;$pss_l;$frontmost_l)
  //_
$0:=0
$winTitle_t:=$1
$timeOut_l:=280  //WAN may need a loooonnnng time
If (Count parameters:C259>1)
	$timeOut_l:=$2
End if 
$pss_l:=Current process:C322
$timeOut_l:=Tickcount:C458+$timeOut_l
Repeat 
	DELAY PROCESS:C323($pss_l;2)
	$frontmost_l:=Frontmost window:C447
Until ((Get window title:C450($frontmost_l)=$winTitle_t) | (Tickcount:C458>$timeOut_l))
If (Get window title:C450($frontmost_l)=$winTitle_t)
	$0:=Frontmost window:C447
End if 
  //_
