//%attributes = {"invisible":true,"shared":true}
  // from : https://blog.4d.com/display-a-collection-in-a-listbox/

C_OBJECT:C1216($0;$cells;$event)
$event:=FORM Event:C1606

  // Very very bad idea -> lost all meta if disabled=true, and not able to set up them back when enabled (disabled=false)
  // $cells:=New object("disabled";true)

$cells:=New object:C1471("cell";New object:C1471)

  // Work done on ROW
  // --------------------
  // Treadsafe method, but not yet flagged as well 
If ((This:C1470.isThread=True:C214) & (This:C1470.attributes.preemptive#"capable"))
	$cells:=Form:C1466.colors.nearGreen
End if 

  // Treadsafe method 
If (This:C1470.attributes.preemptive="capable")
	$cells:=Form:C1466.colors.green
End if 

  // All lines are comments
If (This:C1470.nbLines=(This:C1470.nbComment+This:C1470.nbEmpty))
	$cells:=Form:C1466.colors.red
End if 

If (This:C1470.nbLines=0)
	$cells:=Form:C1466.colors.red
	  //$cells.cell.attrNbLines:=Form.colors.red
End if 


  // Work done on CELL
  // -----------------

  // Method never called
Case of 
	: (This:C1470.nbNested=0) & (This:C1470.path="Path project method")
		$cells.cell.AttrNbNested:=Form:C1466.colors.red
		
	: (This:C1470.nbNested=0) & (This:C1470.path#"Path project method")
		$cells.cell.AttrNbNested:=Form:C1466.colors.gainsboro
End case 


If (This:C1470.attributes.invisible=Null:C1517)
	$cells.cell.AttrInvisible:=Form:C1466.colors.gainsboro
	$cells.cell.AttrPreemptive:=Form:C1466.colors.gainsboro
	$cells.cell.AttrOnServer:=Form:C1466.colors.gainsboro
	$cells.cell.AttrShared:=Form:C1466.colors.gainsboro
	$cells.cell.AttrWEB:=Form:C1466.colors.gainsboro
	$cells.cell.AttrSOAP:=Form:C1466.colors.gainsboro
	$cells.cell.AttrWDSL:=Form:C1466.colors.gainsboro
	$cells.cell.AttrSQL:=Form:C1466.colors.gainsboro
End if 

  // Comments
Case of 
		
	: ((This:C1470.nbComment>=Form:C1466.param.CommentLow) & (This:C1470.nbComment<Form:C1466.param.CommentMedium))
		$cells.cell.AttrNbComment:=Form:C1466.colors.canary
		
	: ((This:C1470.nbComment>=Form:C1466.param.CommentMedium) & (This:C1470.nbComment<Form:C1466.param.CommentHigh))
		$cells.cell.AttrNbComment:=Form:C1466.colors.yellow
		
	: (This:C1470.nbComment>=Form:C1466.param.CommentHigh)
		$cells.cell.AttrNbComment:=Form:C1466.colors.red
	Else 
		$cells.cell.AttrNbComment:=Form:C1466.colors.blank
		
End case 

  // Complexity
Case of 
		
	: ((This:C1470.Complexity>=Form:C1466.param.ComplexLow) & (This:C1470.Complexity<Form:C1466.param.ComplexMedium))
		$cells.cell.AttrComplexity:=Form:C1466.colors.canary
		
	: ((This:C1470.Complexity>=Form:C1466.param.ComplexMedium) & (This:C1470.Complexity<Form:C1466.param.ComplexHigh))
		$cells.cell.AttrComplexity:=Form:C1466.colors.yellow
		
	: (This:C1470.Complexity>=Form:C1466.param.ComplexHigh)
		$cells.cell.AttrComplexity:=Form:C1466.colors.red
		
	Else 
		$cells.cell.AttrComplexity:=Form:C1466.colors.blank
		
End case 

  //Case of 
  //: ($event.code=On Display Detail)
  //If ($event.isRowSelected)
  //$cells.fill:="lightblue"
  //End if 
  //End case 

  // Finally, update the row & cells
$0:=$cells