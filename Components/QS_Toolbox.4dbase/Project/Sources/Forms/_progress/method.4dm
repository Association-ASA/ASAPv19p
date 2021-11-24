Case of 
	: (Form event code:C388=On Load:K2:1)
		C_PICTURE:C286($icon)
		C_LONGINT:C283($l;$h)
		
		$path:="images/icons/"
		$icon:=PIC_GetPicture ($path+Form:C1466.icon)
		PICTURE PROPERTIES:C457($icon;$l;$h)
		TRANSFORM PICTURE:C988($icon;Scale:K61:2;(32/$l);(32/$h))
		(OBJECT Get pointer:C1124(Object named:K67:5;"icon"))->:=$icon
		Form:C1466.progress:=0
		
	: (Form event code:C388=On Timer:K2:25)
		C_LONGINT:C283($progress)
		$progress:=Form:C1466.progress
		C_LONGINT:C283($nbSquares)
		$ptr_canvas:=OBJECT Get pointer:C1124(Object named:K67:5;"progress")
		C_LONGINT:C283($left;$top;$right;$bottom)
		OBJECT GET COORDINATES:C663($ptr_canvas->;$left;$top;$right;$bottom)
		C_LONGINT:C283($height;$width)
		$height:=($bottom-$top)
		$width:=$right-$left
		
		C_TEXT:C284($svg_id;$idLine)
		$svg_id:=SVG_New ($width;$height)
		
		$nbSquares:=10*($width)/($height)
		$x:=($progress*3)%($height)
		$y:=$height/4
		$radius:=$y/2
		For ($i;0;$nbSquares+1)
			If ($i ?? 0)
				  //$idLine:=SVG_New_circle ($svg_id;$x;$y;$radius;$colors_f_svg;$colors_s_svg;1)
				$idLine:=SVG_New_circle ($svg_id;$x;$y+2;$radius;"black";"White";1)
				
			Else 
				$idLine:=SVG_New_circle ($svg_id;$x;$y+2;$radius;"black";"White";1)
			End if 
			$x:=$x+$height
		End for 
		SVG EXPORT TO PICTURE:C1017($svg_id;$ptr_canvas->;Copy XML data source:K45:17)
		
		Form:C1466.progress:=$progress-1
		
		
End case 