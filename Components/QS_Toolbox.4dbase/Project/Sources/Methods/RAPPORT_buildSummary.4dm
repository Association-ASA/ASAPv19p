//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// Nom utilisateur (OS) : Patrick EMANUEL
// Date et heure : 23/04/20, 16:14:24
// ----------------------------------------------------
// Méthode : RAPPORT_buildSummary
// Description
//
// Paramètres
// ----------------------------------------------------

// QS - Patrick EMANUEL, 01/09/21 - 18:42:35
#DECLARE($sourceDocument : Object; $_styleNames; $_styleNamesSummary : Collection)

var $summary; $SummaryRange : Object
var $styleSheet; $text : Text
ARRAY TEXT:C222($w_bookmarks; 0x0000)

$SummaryRange:=New object:C1471

WP GET BOOKMARKS:C1417($sourceDocument; $w_bookmarks)
$p:=Find in array:C230($w_bookmarks; "Summary")
If ($p>0)
	$summaryRange:=WP Bookmark range:C1416($sourceDocument; "Summary")
	$summaryRange:=WP Text range:C1341($sourceDocument; $summaryRange.start; $summaryRange.end)
Else 
	$SummaryRange:=WP Text range:C1341($sourceDocument; wk start text:K81:165; wk start text:K81:165)
End if 
// WP SET TEXT($SummaryRange;"";wk replace;wk include in range)

$shift:=0
$bookmarkIndex:=0

For ($i; 1; 2)
	$summary:=WP New:C1317
	RAPPORT_WP_Settings($summary)
	// WP IMPORT STYLE SHEETS($summary;$sourceDocument)
	
	// Very too slow -> changed to work with Bookmarks. Still slow, but really faster than that
	//$_paragraphs:=WP Get elements(WP Get body($sourceDocument);wk type paragraph)
	
	$range:=WP Text range:C1341($summary; wk start text:K81:165; wk start text:K81:165)
	WP SET TEXT:C1574($range; "Summary"; wk append:K81:179; wk include in range:K81:180)
	WP INSERT BREAK:C1413($range; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)
	WP INSERT BREAK:C1413($range; wk paragraph break:K81:259; wk append:K81:179; wk exclude from range:K81:181)
	WP SET ATTRIBUTES:C1342($range; wk style sheet:K81:63; "Chapter")
	
	//For each ($paragraph;$_paragraphs)
	For ($a; 1; Size of array:C274($w_bookmarks))
		
		$paragraph:=WP Bookmark range:C1416($sourceDocument; $w_bookmarks{$a})
		
		WP GET ATTRIBUTES:C1345($paragraph; wk style sheet:K81:63; $styleSheet)
		$index:=$_styleNames.indexOf($styleSheet)
		
		If ($index>=0)
			$range:=WP Text range:C1341($summary; wk end text:K81:164; wk end text:K81:164)
			// WP Get position is very Slow
			
			$start:=Current time:C178
			$o:=WP Get position:C1577($paragraph; wk 4D Write Pro layout:K81:176)
			$label:=WP Get text:C1575($paragraph; wk expressions as value:K81:255)
			
			$l:=Length:C16($label)
			If ($l>0)
				If ($label[[$l]]="\r")
					$label:=Substring:C12($label; 1; $l-1)
				End if 
				
				$text:=$label+Char:C90(Tab:K15:37)+String:C10($o.page+$shift)
				WP SET TEXT:C1574($range; $text; wk append:K81:179; wk include in range:K81:180)
				WP INSERT BREAK:C1413($range; wk paragraph break:K81:259; wk append:K81:179; wk include in range:K81:180)
				
				If ($i=1)
					WP SET ATTRIBUTES:C1342($range; wk style sheet:K81:63; $_styleNamesSummary[$index])
				Else 
					WP SET ATTRIBUTES:C1342($range; wk style sheet:K81:63; $_styleNamesSummary[$index])
					$linkRange:=WP Text range:C1341($summary; $range.start; $range.start+Length:C16($label))
					$bookmarkIndex:=$bookmarkIndex+1
					$bookmarkName:="#_Summary_"+String:C10($bookmarkIndex)
					WP NEW BOOKMARK:C1415($paragraph; $bookmarkName)
					WP SET ATTRIBUTES:C1342($linkRange; wk link url:K81:202; $bookmarkName)
					
				End if 
			End if 
			
		End if 
	End for 
	//End for each
	
	//  // Remove last wk paragraph mark
	//$range:=WP Text range($summary;wk end text;wk end text)
	//$range:=WP Text range($summary;$range.end-1;$range.end)
	//WP SET TEXT($range;"";wk replace;wk include in range)
	
	If ($i=1)
		$o:=WP Get position:C1577($range; wk 4D Write Pro layout:K81:176)
		$shift:=$o.page
	End if 
End for 

$text:=WP Get text:C1575($summary; wk expressions as value:K81:255)

WP INSERT DOCUMENT:C1411($summaryRange; $summary; wk prepend:K81:178; wk include in range:K81:180)
WP INSERT BREAK:C1413($summaryRange; wk page break:K81:188; wk append:K81:179)
WP NEW BOOKMARK:C1415($summaryRange; "Summary")
