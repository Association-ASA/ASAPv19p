//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// Method: "progressBar_getSvg" written by Olivier Grimbert
// Date and time: 22/03/20, 13:22:16
// ----------------------------------------------------
// Description: display a progress bar for the given size
//   
// ----------------------------------------------------

C_LONGINT:C283($svg_width; $svg_height)
C_REAL:C285($progress; $3)
C_LONGINT:C283($type)
$svg_width:=$1
$svg_height:=$2
$progress:=$3
If (Count parameters:C259>=4)
	$type:=$4
Else 
	$type:=0
End if 


C_TEXT:C284($svg_id; $idLine)
$svg_id:=SVG_New($svg_width; $svg_height)
C_LONGINT:C283($centerX; $centerY)
$centerX:=$svg_width/2
$centerY:=$svg_height/2

C_LONGINT:C283($width; $borderX; $posx1; $posx2; $posy1; $posy2; $stroke)
C_LONGINT:C283($start; $end; $value; $radius)

C_TEXT:C284($color_fill_svg; $color_stroke_svg)
C_LONGINT:C283($color_stroke)
Case of 
	: ($progress<0.25)
		$color_stroke:=250
	: ($progress<0.5)
		$color_stroke:=60
	: ($progress<0.75)
		$color_stroke:=188
	: ($progress<1)
		$color_stroke:=3
	Else 
		$color_stroke:=144
End case 
$color_fill_svg:="LightGrey"
//$color_stroke_svg:=wog_colorMDtoSVG ($color_stroke)
$color_stroke_svg:="DarkGrey"

//$type:=1
Case of 
	: ($type=0)  // Bar
		
		$width:=$svg_width  // *0.7
		$borderX:=($svg_width-$width)/2
		$posx1:=$borderX
		$posx2:=$posx1+($progress*$width)
		$stroke:=4
		$posy1:=$stroke
		$posy2:=$svg_height/3  //+$stroke
		
		$value:=Round:C94($progress*100; 0)  // Showing the percentage
		
		// Draw the status bar
		$idLine:=SVG_New_line($svg_id; $posx1; $posy1; $posx1+$width; $posy1; $color_fill_svg; $stroke)
		$idLine:=SVG_New_line($svg_id; $posx1; $posy1; $posx2; $posy1; $color_stroke_svg; $stroke)
		// Show percentage
		// $idText:=SVG_New_text ($svg_id;String($value)+"%";$centerX;$posy2;"Police Système";8;1;3;"Black")
		
	: ($type=1)  // Cercle
		
		$radius:=Choose:C955($centerX<$centerY; $centerY; $centerX)*0.7
		$start:=0
		$end:=360*$progress
		$width:=2
		
		$value:=Round:C94($progress*100; 0)  // Showing the percentage
		
		// Draw the status bar
		$idLine:=SVG_New_circle($svg_id; $centerX; $centerY; $radius; $color_fill_svg; $color_fill_svg; $width)
		$idLine:=SVG_New_arc($svg_id; $centerX; $centerY; $radius; $start; $end; $color_stroke_svg; $color_stroke_svg; $width)
		$idLine:=SVG_New_line($svg_id; $centerX; $centerY; $centerX; $centerY-$radius; $color_fill_svg; 1)
		// Show percentage
		// $idText:=SVG_New_text ($svg_id;String($value)+"%";$centerX;$svg_height/3;"Police Système";10;1;3;"Black")
		
End case 

C_PICTURE:C286($generated_picture)
SVG EXPORT TO PICTURE:C1017($svg_id; $generated_picture; Copy XML data source:K45:17)
$0:=$generated_picture
