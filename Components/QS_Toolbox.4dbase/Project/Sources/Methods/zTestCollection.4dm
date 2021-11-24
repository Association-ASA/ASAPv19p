//%attributes = {"invisible":true,"preemptive":"capable"}
C_COLLECTION:C1488($col;$colResult)
C_LONGINT:C283($i;$colLength;$start;$stop;$idx;$count)
C_OBJECT:C1216($obj)
$col:=New collection:C1472
$obj:=New object:C1471
$colLength:=125000

For ($i;1;$colLength)
	$col.push("key"+String:C10($i))
	$obj["key"+String:C10($i)]:=$col.length-1
End for 

$col.remove(0;10)  // remove/delete first 10 items in collection
  // stored idx addresses in $obj no longer correct
$start:=Milliseconds:C459
$idx:=$col.indexOf("key3000")  // search from startToEnd idx 0-3000 (fast)
$stop:=Milliseconds:C459
ALERT:C41("Result idx:"+String:C10($idx)+"\r"+$col[$idx]+"\rTime: "+String:C10($stop-$start)+"ms")

$start:=Milliseconds:C459
$idx:=$col.indexOf("key123000")  // search from startToEnd idx 0-123000 (slow)
$stop:=Milliseconds:C459
ALERT:C41("Result idx:"+String:C10($idx)+"\r"+$col[$idx]+"\rTime: "+String:C10($stop-$start)+"ms")

  // gets wrong idx (old idx adresses not changed when collection is changed),
  // because the first 10 removed items changes all idxAdresses after firstTen:
  // from 0-224999 to 0-224989
$start:=Milliseconds:C459
$idx:=$obj["key123000"]
$stop:=Milliseconds:C459
ALERT:C41("Result idx:"+String:C10($idx)+"\r"+$col[$idx]+"\rTime: "+String:C10($stop-$start)+"ms")

  // other example
$col:=New collection:C1472
$colLength:=125000
For ($i;1;$colLength)
	$col.push(New object:C1471("key";"key"+String:C10($i);"calleesList";New object:C1471("key"+String:C10(Random:C100+1);True:C214;"key"+String:C10(Random:C100+32768);True:C214;"key"+String:C10(Random:C100+92233);True:C214)))
End for 
  // search all collection items which object CalleesList contains searched key
$start:=Milliseconds:C459
$colResult:=$col.query("calleesList.key123000 # null")
$stop:=Milliseconds:C459
ALERT:C41("Result collection:\r"+JSON Stringify:C1217($colResult)+"\rTime: "+String:C10($stop-$start)+"ms")
  // ...do not forget only found key123000 if random creates it in calleesList
TRACE:C157