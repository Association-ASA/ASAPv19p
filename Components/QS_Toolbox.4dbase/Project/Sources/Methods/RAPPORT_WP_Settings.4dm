//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
#DECLARE($wpDoc : Object)

WP SET ATTRIBUTES:C1342($wpDoc; wk layout unit:K81:78; wk unit cm:K81:135)
WP SET ATTRIBUTES:C1342($wpDoc; wk header and footer autofit:K81:303; True:C214)  // True is the default value

// Setting tab
$tab:=New object:C1471
$tab[wk type:K81:189]:=wk left:K81:95
$tab[wk offset:K81:280]:="0.3cm"
$tab[wk leading:K81:281]:=""
WP SET ATTRIBUTES:C1342($wpDoc; wk tab default:K81:279; $tab)
// WP SET ATTRIBUTES($wpDoc;wk tabs;New collection(2;8;13) // UNit is cm

// STYLE SHEETS
var $styleCode : Object
$styleCode:=WP New style sheet:C1650($wpDoc; wk type paragraph:K81:191; "Code")
WP SET ATTRIBUTES:C1342($styleCode; wk font size:K81:66; "10pt")
WP SET ATTRIBUTES:C1342($styleCode; wk font bold:K81:68; wk false:K81:173)
WP SET ATTRIBUTES:C1342($styleCode; wk text align:K81:49; wk left:K81:95)
WP SET ATTRIBUTES:C1342($styleCode; wk tab default:K81:279; $tab)


// Setting Method Title
var $styleMethodTitle : Object
$styleMethodTitle:=WP New style sheet:C1650($wpDoc; wk type paragraph:K81:191; "Method Title")
WP SET ATTRIBUTES:C1342($styleMethodTitle; wk font size:K81:66; "14pt")
WP SET ATTRIBUTES:C1342($styleMethodTitle; wk font bold:K81:68; wk true:K81:174)
WP SET ATTRIBUTES:C1342($styleMethodTitle; wk text align:K81:49; wk left:K81:95)

var $styleMethodTitle2 : Object
$styleMethodTitle2:=WP New style sheet:C1650($wpDoc; wk type paragraph:K81:191; "title2")
WP SET ATTRIBUTES:C1342($styleMethodTitle2; wk font size:K81:66; "12pt")
WP SET ATTRIBUTES:C1342($styleMethodTitle2; wk font bold:K81:68; wk true:K81:174)
WP SET ATTRIBUTES:C1342($styleMethodTitle2; wk text align:K81:49; wk left:K81:95)

var $summaryTitle : Object
$summaryTitle:=WP New style sheet:C1650($wpDoc; wk type paragraph:K81:191; "Summary Title")
WP SET ATTRIBUTES:C1342($summaryTitle; wk font size:K81:66; "12pt")
WP SET ATTRIBUTES:C1342($summaryTitle; wk font bold:K81:68; wk false:K81:173)
WP SET ATTRIBUTES:C1342($summaryTitle; wk text align:K81:49; wk left:K81:95)

$tab:=New object:C1471
$tab[wk type:K81:189]:=wk right:K81:96
$tab[wk offset:K81:280]:="16cm"
$tab[wk leading:K81:281]:="."
WP SET ATTRIBUTES:C1342($summaryTitle; wk tab default:K81:279; $tab)

var $summaryTitle2 : Object
$summaryTitle2:=WP New style sheet:C1650($wpDoc; wk type paragraph:K81:191; "Summary Title2")
WP SET ATTRIBUTES:C1342($summaryTitle2; wk font size:K81:66; "10pt")
WP SET ATTRIBUTES:C1342($summaryTitle2; wk font bold:K81:68; wk false:K81:173)
WP SET ATTRIBUTES:C1342($summaryTitle2; wk text align:K81:49; wk left:K81:95)
$tab:=New object:C1471
$tab[wk type:K81:189]:=wk right:K81:96
$tab[wk offset:K81:280]:="16cm"
$tab[wk leading:K81:281]:="."
WP SET ATTRIBUTES:C1342($summaryTitle2; wk tab default:K81:279; $tab)

var $chapter : Object
$chapter:=WP New style sheet:C1650($wpDoc; wk type paragraph:K81:191; "Chapter")
WP SET ATTRIBUTES:C1342($chapter; wk font size:K81:66; "24pt")
WP SET ATTRIBUTES:C1342($chapter; wk font bold:K81:68; wk false:K81:173)
WP SET ATTRIBUTES:C1342($chapter; wk text align:K81:49; wk center:K81:99)
WP SET ATTRIBUTES:C1342($chapter; wk text underline style:K81:73; wk solid:K81:115)

var $coverPage : Object
$coverPage:=WP New style sheet:C1650($wpDoc; wk type paragraph:K81:191; "Cover Page")
$coverPage[wk text align:K81:49]:=wk center:K81:99
$coverPage[wk font size:K81:66]:=32
$coverPage[wk font bold:K81:68]:=wk true:K81:174

var $coverTitle : Object
$coverTitle:=WP New style sheet:C1650($wpDoc; wk type paragraph:K81:191; "Cover Title")
$coverTitle[wk text align:K81:49]:=wk center:K81:99
$coverTitle[wk font size:K81:66]:=20

var $wpRow : Object
$wpRow:=WP New style sheet:C1650($wpDoc; wk type paragraph:K81:191; "Row little")
WP SET ATTRIBUTES:C1342($wpRow; wk font size:K81:66; 8)
WP SET ATTRIBUTES:C1342($wpRow; wk font bold:K81:68; wk true:K81:174)
WP SET ATTRIBUTES:C1342($wpRow; wk text align:K81:49; wk center:K81:99)
