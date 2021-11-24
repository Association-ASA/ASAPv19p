//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"capable"}
  // $0↜$txt:=x_method_textParseToComments($1↝$method;$2↝$methodName;{$3↝$isStyled};{$4↝$is_parms_inline};{$5↝$is_parms_lines})

  // $method:=$1
  // $methodName:=$2
  // $ptr_comments:= $3

  // $isStyled:={$4}
  // $is_parms_inline:={$5}
  // $is_parms_lines:={$6}
  // $nbParamsPerLine:={$7}
  // $0:=$isUnlocked


$method:=$1
$methodName:=$2
$ptr_comments:=$3

$isStyled:=(Count parameters:C259>=4)
If ($isStyled)
	$isStyled:=$4
End if 
$is_parms_inline:=(Count parameters:C259>=5)
If ($is_parms_inline)
	$is_parms_inline:=$5
End if 
$is_parms_lines:=(Count parameters:C259>=6)
If ($is_parms_lines)
	$is_parms_lines:=$6
End if 
If (Count parameters:C259>=7)
	$nbParamsPerLine:=$7
Else 
	$nbParamsPerLine:=0
End if 

If ($nbParamsPerLine=0)
	$nbParamsPerLine:=4
End if 

  //$is_parms_inline:=True
  //$is_parms_lines:=True

$isUnlocked:=True:C214

$txt:=""
$method:=Replace string:C233($method;Char:C90(Tab:K15:37);"")  // Remove tab
$co_linesMethod:=Split string:C1554($method;Char:C90(Carriage return:K15:38);sk ignore empty strings:K86:1+sk trim spaces:K86:2)
$co_linesMethod.shift()  // Remove the first line -- 4D

  // Array {$n}
C_LONGINT:C283($startDollar;$startDollarNum;$lengthDollar;$lengthDollarNum)
ARRAY LONGINT:C221($T_opt_dollars;0x0000)
ARRAY LONGINT:C221($T_dollars;0x0000)
ARRAY TEXT:C222($T_dollars_var;0x0000)
ARRAY TEXT:C222($T_dollars_comment;0x0000)

C_LONGINT:C283($startDollar;$startDollarNum;$lengthDollar;$lengthDollarNum)
  // Parse lines
$is_dollarZero:=False:C215
$is_comment:=False:C215  // set to True if you would like to get comment
$is_first:=True:C214
$is_first_dollar:=True:C214
$secondCondition:=Command name:C538(1389)+"@"
For each ($line_txt;$co_linesMethod)
	
	  // First part: Analyse all lines except comment lines and CALL FORM lines
	Case of 
		: (Position:C15("//";$line_txt)=1)
		: ($line_txt=$secondCondition)
			
		Else 
			
			If (Match regex:C1019("\\(Count parameters>=\\d{1,4}\\)";$line_txt;1;$startDollar;$lengthDollar))
				$noDollar:=Num:C11(Substring:C12($line_txt;$startDollar+1;$lengthDollar))
				APPEND TO ARRAY:C911($T_opt_dollars;$noDollar)
			End if 
			
			$start:=1
			Repeat 
				
				$isOkDollar:=Match regex:C1019("\\$\\d{1,4}";$line_txt;$start;$startDollar;$lengthDollar)
				If ($isOkDollar)
					$noDollar:=Num:C11(Substring:C12($line_txt;$startDollar+1;$lengthDollar))
					$is_dollar:=(Find in array:C230($T_dollars;$noDollar)>0)
					
					If (Not:C34($is_dollar))
						APPEND TO ARRAY:C911($T_dollars;$noDollar)
						APPEND TO ARRAY:C911($T_dollars_var;"")
						APPEND TO ARRAY:C911($T_dollars_comment;"")
					End if 
					$start:=$startDollar+$lengthDollar
				End if 
			Until (Not:C34($isOkDollar))
			
	End case 
	
	  // Second part of the analysis
	$isOkDollar:=Match regex:C1019(":=\\$\\d{1,4}";$line_txt;1;$startDollar;$lengthDollar)
	$isOk:=False:C215
	
	Case of 
		: ($line_txt="") & ($is_first)
			  // Skip
		: ($line_txt=$secondCondition)
			
		: (Position:C15("//%ogTools";$line_txt)=1)
			$k1:=Position:C15("{";$line_txt)
			$k2:=Position:C15("}";$line_txt)
			
			If ($k1>1) & ($k2>$k1)
				$line_txt:=Substring:C12($line_txt;$k1;$k2-$k1+1)
				C_OBJECT:C1216($ob)
				$ob:=JSON Parse:C1218($line_txt)
				If (OB Is defined:C1231($ob;"locked"))
					$isUnlocked:=Not:C34(OB Get:C1224($ob;"locked";Is boolean:K8:9))
				End if 
				If (OB Is defined:C1231($ob;"styled"))
					$isStyled:=OB Get:C1224($ob;"styled";Is boolean:K8:9)
				End if 
				If (OB Is defined:C1231($ob;"inLine"))
					$is_parms_inline:=OB Get:C1224($ob;"inLine";Is boolean:K8:9)
				End if 
				If (OB Is defined:C1231($ob;"lines"))
					$is_parms_lines:=OB Get:C1224($ob;"lines";Is boolean:K8:9)
				End if 
				If (OB Is defined:C1231($ob;"perLine"))
					$nbParamsPerLine:=OB Get:C1224($ob;"perLine";Is longint:K8:6)
				End if 
			End if 
			
			
		: (Position:C15("//%";$line_txt)=1)
			  // Skip
			
		: (Position:C15("//";$line_txt)=1)
			$line_txt:=Substring:C12($line_txt;3)
			$isOk:=$is_comment
			$is_first:=False:C215
			
		: ($isOkDollar)
			$isOkDollarNum:=Match regex:C1019("\\d{1,4}";$line_txt;$startDollar;$startDollarNum;$lengthDollarNum)
			$noDollar:=Num:C11(Substring:C12($line_txt;$startDollar+1;$lengthDollar))
			
			If ($noDollar#0)
				$k:=Find in array:C230($T_dollars;$noDollar)
				$is_dollar:=($k>0)
				$vara_name:=Substring:C12($line_txt;1;$startDollar-1)
				$comment:=Substring:C12($line_txt;$startDollar+$lengthDollar+1)
				If ($is_dollar)
					If ($vara_name#"")
						$T_dollars_var{$k}:=$vara_name
					End if 
					$T_dollars_comment{$k}:=$comment
				Else 
					APPEND TO ARRAY:C911($T_dollars_var;$vara_name)
					APPEND TO ARRAY:C911($T_dollars;$noDollar)
					APPEND TO ARRAY:C911($T_dollars_comment;$comment)
				End if 
				If ($is_first_dollar)
					$line_txt:=Char:C90(Carriage return:K15:38)+$line_txt
					$is_first_dollar:=False:C215
				End if 
				$is_first:=False:C215
				$is_optDollar:=(Find in array:C230($T_opt_dollars;$noDollar)>0)
				If ($is_optDollar)
					If ($isOkDollarNum)
						$temp:=Substring:C12($line_txt;1;$startDollarNum-2)
						$temp:=$temp+"{"+Substring:C12($line_txt;$startDollarNum-1;$lengthDollarNum+1)+"}"
						$temp:=$temp+Substring:C12($line_txt;$startDollarNum+$lengthDollarNum)
						$line_txt:=$temp
					Else 
						$line_txt:=$line_txt+" {optionnal}"
					End if 
				End if 
				
			End if 
			
			  // ---
			
		: (Position:C15("$0:=$";$line_txt)=1)
			
			If ($is_first_dollar)
				$line_txt:=Char:C90(Carriage return:K15:38)+$line_txt
				$is_first_dollar:=False:C215
			End if 
			
			$vara_name:=Substring:C12($line_txt;5)
			$k:=Find in array:C230($T_dollars;0)
			$is_dollar:=($k>0)
			
			If ($is_dollar)
				If ($vara_name#"")
					$T_dollars_var{$k}:=$vara_name
					$T_dollars_comment{$k}:="// ??"
				End if 
				
			Else 
				APPEND TO ARRAY:C911($T_dollars_var;$vara_name)
				APPEND TO ARRAY:C911($T_dollars;$noDollar)
				APPEND TO ARRAY:C911($T_dollars_comment;"// ??")
			End if 
			
			$is_first:=False:C215
		Else 
			
			$is_comment:=False:C215
	End case 
	
	If ($isOk)
		  // $line_txt:=x_trim_left ($line_txt) // NO need anymore -> sk trim spaces
		
		If ($isStyled)
			  //$line_txt:=x_ST_escape ($line_txt)
			  //$line_txt:=HTML_escapeCharacters ($line_txt) // No need for comment Markdown
			
			  //$textUnstyled:=ST Get plain text($line_txt)
			  //$k:=Position($methodName;$textUnstyled)
			  //If ($k>0)
			  //$k1:=Length($methodName)
			  //ST SET ATTRIBUTES($line_txt;$k;$k+$k1;Attribute bold style;1)
			  //End if 
		Else 
			$line_txt:="// "+$line_txt
		End if 
		$txt:=$txt+$line_txt+Char:C90(Carriage return:K15:38)
	End if 
	
End for each 

  // HEADER

SORT ARRAY:C229($T_dollars;$T_dollars_var;$T_dollars_comment;>)
$line_txt:="## "


  // If the method return a $0 as parameter
$start:=1
$tt:=Size of array:C274($T_dollars)
$is_dollarZero:=False:C215
If ($tt>=1)
	If ($T_dollars{1}=0)
		$is_dollarZero:=True:C214
		$line_txt:=$line_txt+"$0"
		If ($is_parms_inline)
			$vara_name:=$T_dollars_var{1}
			If ($vara_name#"")
				$line_txt:=$line_txt+"↜"+$vara_name
			End if 
		End if 
		$line_txt:=$line_txt+":="
		$start:=2
	End if 
End if 


If ($isStyled)
	  // ST SET ATTRIBUTES($methodName;ST Start text;ST End text;Attribute bold style;1)
Else 
	$line_txt:="// "+$line_txt
End if 


  // Then add Method name and parameters
$line_txt:=$line_txt+$methodName
$is_params:=($tt>=$start)
If ($is_params)
	$line_txt:=$line_txt+"("
End if 
$isSep:=False:C215
For ($line;$start;$tt)
	If ($isSep)
		$line_txt:=$line_txt+";"
	Else 
		$isSep:=True:C214
	End if 
	If ($line#$start)
		If ((($line-1)%$nbParamsPerLine)=0)
			$line_txt:=$line_txt+Char:C90(Carriage return:K15:38)
		End if 
	End if 
	$noDollar:=$T_dollars{$line}
	$is_optDollar:=(Find in array:C230($T_opt_dollars;$noDollar)>0)
	If ($is_optDollar)
		$line_txt:=$line_txt+"{"
	End if 
	
	$line_txt:=$line_txt+"$"+String:C10($noDollar)
	If ($is_parms_inline)
		$vara_name:=$T_dollars_var{$line}
		  //$vara_name:=x_ST_escape ($vara_name)
		  //$vara_name:=HTML_escapeCharacters ($vara_name)
		If ($vara_name#"")
			$line_txt:=$line_txt+"↝"+$vara_name
		End if 
	End if 
	If ($is_optDollar)
		$line_txt:=$line_txt+"}"
	End if 
End for 

If ($is_params)
	$line_txt:=$line_txt+")"
End if 

If ($is_parms_lines)
	$line_txt:=$line_txt+(2*Char:C90(Carriage return:K15:38))
	For ($line;$start;$tt)
		$noDollar:=$T_dollars{$line}
		$is_optDollar:=(Find in array:C230($T_opt_dollars;$noDollar)>0)
		If (Not:C34($isStyled))
			$line_txt:=$line_txt+"// "
		End if 
		$vara_name:=$T_dollars_var{$line}
		If ($vara_name="")
			$vara_name:="undefined"
		End if 
		  //$vara_name:=x_ST_escape ($vara_name)
		  //$vara_name:=HTML_escapeCharacters ($vara_name)
		
		$line_txt:=$line_txt+"* "+$vara_name+":="
		If ($is_optDollar)
			$line_txt:=$line_txt+"{"
		End if 
		$line_txt:=$line_txt+"$"+String:C10($noDollar)
		If ($is_optDollar)
			$line_txt:=$line_txt+"}"
		End if 
		$comment:=$T_dollars_comment{$line}
		
		If ($comment#"")
			  //$comment:=x_ST_escape ($comment)
			  //$comment:=HTML_escapeCharacters ($comment)
			$line_txt:=$line_txt+" "+$comment
		End if 
		$line_txt:=$line_txt+Char:C90(Carriage return:K15:38)
	End for 
	
	If ($is_dollarZero)
		If (Not:C34($isStyled))
			$line_txt:=$line_txt+"// "
		End if 
		$line_txt:=$line_txt+"* "+"$"+String:C10($T_dollars{1})+":="
		$vara_name:=$T_dollars_var{1}
		If ($vara_name="")
			$vara_name:="undefined"
		End if 
		  //$vara_name:=x_ST_escape ($vara_name)
		  //$vara_name:=HTML_escapeCharacters ($vara_name)
		$line_txt:=$line_txt+$vara_name
		$line_txt:=$line_txt+Char:C90(Carriage return:K15:38)
	End if 
End if 

$txt:=$line_txt+Char:C90(Carriage return:K15:38)+$txt

$ptr_comments->:=$txt+Char:C90(Carriage return:K15:38)+"---"
$0:=$isUnlocked