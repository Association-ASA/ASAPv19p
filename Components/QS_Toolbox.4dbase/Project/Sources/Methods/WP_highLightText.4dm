//%attributes = {"invisible":true}
  // WP_highLightText
  // Parameters:
  // $1  // 4D Write Pro object name
  // $2  // Text to find
  // ----------------------------------------------------
  // Description:
  // 
  // ----------------------------------------------------
  // Creation: Patrick EMANUEL, 26/08/20, 08:13:23
  //



C_TEXT:C284($1;$obName_t;$2;$toFind_t)
If (Count parameters:C259>=2)
	$obName_t:=$1  // 4D Write Pro object name
	$toFind_t:=$2  // Text to find
	
	C_POINTER:C301($wp_p)
	$wp_p:=OBJECT Get pointer:C1124(Object named:K67:5;$obName_t)
	
	Case of 
		: (Form:C1466.wpHighlightPosition=Null:C1517) | (Form:C1466.wpSearchedText=Null:C1517)
			Form:C1466.wpHighlightPosition:=0
			
		: (Form:C1466.wpSearchedText#$toFind_t)
			Form:C1466.wpHighlightPosition:=0
			
		Else 
			Form:C1466.wpHighlightPosition:=Form:C1466.wpHighlightPosition+Length:C16($toFind_t)
	End case 
	
	Form:C1466.wpHighlightPosition:=Position:C15($toFind_t;WP Get text:C1575($wp_p->;\
		wk expressions as space:K81:257);Form:C1466.wpHighlightPosition+1)
	
	If (Form:C1466.wpHighlightPosition>0)
		HIGHLIGHT TEXT:C210(*;$obName_t;Form:C1466.wpHighlightPosition;Form:C1466.wpHighlightPosition+Length:C16($toFind_t))
	End if 
	
	Form:C1466.wpSearchedText:=$toFind_t
End if 