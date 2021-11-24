//%attributes = {"invisible":true}
// PM: "zGetCommands" (new LV 16.09.20, 15:34:12)
// $0 - C_COLLECTION - $colCommands
// Get all 4D-Command-Names
// -- A call example in javascript with callback function to assign result to jsVar myCommandNames:
//      $4d.zGetCommands(function(names){myCommandNames = names;});
// Last change: LV 16.09.20, 15:34:00

C_COLLECTION:C1488($colCommands;$0)

$colCommands:=New collection:C1472
// return empty collection, than the ready defined defaults used in /mode/4d/parse4d.js
// otherwise place in here any code which returns a collection of your wished cmds (language and 4D version specific)

$0:=$colCommands

// - EOF -