//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}


Case of 
		
	: (Form event code:C388=On Clicked:K2:4)
		var $bottom; $left; $right; $Size; $top : Integer
		
		// Size of the variable to display. Can be set as parameters
		// TO DO
		$Size:=600
		
		// -- Do not touch anything after this line
		If (Form:C1466.collapseExpand=True:C214)  // collapse
			$Size:=-1*$Size
		End if 
		//Form.collapseExpand:=Choose(Form.collapseExpand=False;True;False)
		$is_collapseExpand:=Not:C34(Form:C1466.collapseExpand)
		Form:C1466.collapseExpand:=$is_collapseExpand
		
		OBJECT SET VISIBLE:C603(*; "webZone"; Form:C1466.collapseExpand=True:C214)
		OBJECT GET COORDINATES:C663(*; "webZone"; $l; $t; $r; $b)
		OBJECT SET COORDINATES:C1248(*; "webZone"; $l; $t; $l+$Size-1; $b)
		GET WINDOW RECT:C443($left; $top; $right; $bottom)
		SET WINDOW RECT:C444($left; $top; $right+$Size; $bottom)
		FORM SET HORIZONTAL RESIZING:C892(True:C214)
		
		If ($is_collapseExpand)
			SET WINDOW RECT:C444($left; $top; $right+$Size; $bottom)
			RESIZE FORM WINDOW:C890($Size; 0)
		Else 
			SET WINDOW RECT:C444($left; $top; $right-($r-$l); $bottom)
			RESIZE FORM WINDOW:C890($Size-($r-$l); 0)
		End if 
End case 

