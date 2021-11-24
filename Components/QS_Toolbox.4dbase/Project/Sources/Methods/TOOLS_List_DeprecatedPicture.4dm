//%attributes = {"invisible":true,"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_TEXT:C284($Mess;$Meth)

$Meth:="TOOLS_PictureFromLibrary"
$mess:=""

QS_TOOL_Execute_OnHost ($Meth;$Mess)

ARRAY TEXT:C222($colNames_at;0x0000)
ARRAY TEXT:C222($headerNames_at;0x0000)
ARRAY POINTER:C280($colVars_ap;0x0000)
ARRAY POINTER:C280($headerVars_ap;0x0000)
ARRAY BOOLEAN:C223($colsVisible_ab;0x0000)
ARRAY POINTER:C280($styles_ap;0x0000)

$lbName_t:="LB_Information"
LISTBOX GET ARRAYS:C832(*;$lbName_t;$colNames_at;$headerNames_at;$colVars_ap;$headerVars_ap;$colsVisible_ab;$styles_ap)
$numRows_l:=Size of array:C274($colVars_ap{1}->)

  // *** From PICT_Convert (JPR) ***
For ($a;1;$numRows_l)
	$format:=$colVars_ap{5}->{$a}
	Case of 
		: (($format="?@") | ($format="@;?@"))  //?23774  or 1;12;?5004;64;5(Picture button) or One;0;?7003;5;1;0;4;0...(3D Radio)
			$format:="Library -> "+$format  //or Bouton;?7203;0;0;0;1;3;0;0;0;0;0(3D Button)
			
		: (($format=":@") | ($format="@;:@"))
			$format:="Resource -> "+$format  //:15000  resource  (or ::::)
			
		: (($format="#images@") | ($format="file:@"))
			$format:="File -> "+$format  //#images/676.pict  file
			
		Else 
			$format:="Static -> "+$format
	End case 
	$colVars_ap{5}->{$a}:=$format
	
End for 

If ($numRows_l>0)
	$txt:=String:C10($numRows_l)+" pictures are NOT compatible with 64-bit version."
	displayInfo ($txt;"red")
Else 
	$txt:="No picture to update has been found."
	displayInfo ($txt;"blue")
End if 