//%attributes = {"invisible":true}
// PM: "zGetConstants" (new LV 16.09.20, 15:34:12)
// $0 - C_COLLECTION - $colConstants
// Get all 4D-Constant-Names
// -- A call example in javascript with callback function to assign result to jsVar myCommandNames:
//      $4d.zGetConstants(function(names){myCommandNames = names;});
// Last change: LV 16.09.20, 15:34:00

C_COLLECTION:C1488($colConstants;$0)

$colConstants:=New collection:C1472
// return empty collection, than the ready defined defaults used in /mode/4d/parse4d.js
// otherwise place in here any code which returns a collection of your wished cmds (language and 4D version specific)

$0:=$colConstants

// - EOF -