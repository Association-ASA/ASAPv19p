//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------------------------
  // name: LB_STATUS_BAR
  // description: Draws a status bar with a percentage in SVG.
  // will get the List Box column and width dimensions to draw the
  // status bar with a random gradient color effect and percentage.
  // parameters:
  // $1 (TEXT) - List Box object name height
  // $2 (TEXT) - List Box column name for column width
  // $3 (LONGINT) - Percent count to display the progress status 1-100%
  // output:
  // $0 (PICTURE) - Picture with progress and percentage
  // ----------------------------------------------------------------------
  // http://kb.4d.com/assetid=77217
  //
  // EXAMPLE
  // ------------
  // c_LONGINT($percentage1;$percentage2;$percentage3;$percentage4)
  // ARRAY PICTURE(Column1;4)
  // $percentage1:=15
  // $percentage2:=78
  // $percentage3:=44
  // $percentage4:=2
  // column1{1}:=LB_STATUS_BAR("List Box";"Column1";$percentage1)
  // column1{2}:=LB_STATUS_BAR("List Box";"Column1";$percentage2)
  // column1{3}:=LB_STATUS_BAR("List Box";"Column1";$percentage3)
  // column1{4}:=LB_STATUS_BAR ("List Box";"Column1";$percentage4)

C_TEXT:C284($1)  // list Box Object
C_TEXT:C284($2)  // list Box Column Object
C_TEXT:C284($Color1;$Color2)  // colors for gradient
C_LONGINT:C283($minWidth;$maxWidth)  // count to display
C_PICTURE:C286($0;$generated_picure)  // output of the status bar
C_LONGINT:C283($height;$length;$posx1;$posx2;$posy1;$posy2)
C_REAL:C285($3;$value)  // percentage status

$height:=LISTBOX Get rows height:C836(*;$1;lk pixels:K53:22)
$length:=LISTBOX Get column width:C834(*;$2;$minWidth;$maxWidth)+1

$vID_SVG:=SVG_New ($length;$height)

$posx1:=0
$posx2:=(($3*$length)/100)
$posy1:=0
$posy2:=0

$value:=Round:C94($3;1)  // showing the percentage

  // random color for gradient
$Color1:="#"+UTIL_DecToHex ((Random:C100%239)+16)+UTIL_DecToHex ((Random:C100%239)+16)+UTIL_DecToHex ((Random:C100%239)+16)
$Color2:="#"+UTIL_DecToHex ((Random:C100%239)+16)+UTIL_DecToHex ((Random:C100%239)+16)+UTIL_DecToHex ((Random:C100%239)+16)

SVG_Define_linear_gradient ($vID_SVG;"gradient";$Color1;$Color2)  // set the gradient

  // draw the status bar
$idLine:=SVG_New_line ($vID_SVG;$posx1;$posy1;$posx2;$posy2;"gradient";$height*1.9)

  // show percentage
$idText:=SVG_New_text ($vID_SVG;String:C10($value)+"%";$length/2.1;($height/3)-5;"";-1;-1;-1;"Black")

SVG EXPORT TO PICTURE:C1017($vID_SVG;$generated_picure;Copy XML data source:K45:17)
$0:=$generated_picure