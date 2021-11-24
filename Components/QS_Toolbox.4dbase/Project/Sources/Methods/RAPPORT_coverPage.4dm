//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // $1 : WP document reference
  // $2 : Title
  // ----------------------------------------------------
  // Méthode : RAPPORT_coverPage
  // Description
  // 
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 26/04/20, 08:42:07
  // Paramètres

C_OBJECT:C1216($1;$wpDoc)
C_TEXT:C284($2;$title)

$wpDoc:=$1
$title:=$2

  // Cover Page & title
$coverRange:=WP Text range:C1341($wpDoc;wk start text:K81:165;wk start text:K81:165)
WP INSERT BREAK:C1413($coverRange;wk paragraph break:K81:259;wk append:K81:179;wk include in range:K81:180)
WP INSERT BREAK:C1413($coverRange;wk paragraph break:K81:259;wk append:K81:179;wk include in range:K81:180)
WP INSERT BREAK:C1413($coverRange;wk paragraph break:K81:259;wk append:K81:179;wk include in range:K81:180)

$range:=WP Text range:C1341($coverRange;wk end text:K81:164;wk end text:K81:164)
WP SET TEXT:C1574($range;"QS_Toolbox report";wk append:K81:179)
WP SET ATTRIBUTES:C1342($range;wk style sheet:K81:63;"Cover Page")
$linkRange:=WP Text range:C1341($coverRange;$range.start;$range.end)
WP SET ATTRIBUTES:C1342($linkRange;wk link url:K81:202;"http://association-qualisoft.eu/qs_toolbox/")

$range:=WP Text range:C1341($coverRange;wk end text:K81:164;wk end text:K81:164)
WP INSERT BREAK:C1413($range;wk paragraph break:K81:259;wk append:K81:179;wk include in range:K81:180)
WP INSERT BREAK:C1413($range;wk paragraph break:K81:259;wk append:K81:179;wk include in range:K81:180)
WP INSERT BREAK:C1413($range;wk paragraph break:K81:259;wk append:K81:179;wk include in range:K81:180)

$range:=WP Text range:C1341($coverRange;wk end text:K81:164;wk end text:K81:164)
WP SET TEXT:C1574($range;$title;wk append:K81:179)
WP SET ATTRIBUTES:C1342($range;wk style sheet:K81:63;"Cover Title")

$range:=WP Text range:C1341($coverRange;wk end text:K81:164;wk end text:K81:164)
WP INSERT BREAK:C1413($range;wk paragraph break:K81:259;wk append:K81:179;wk include in range:K81:180)
WP INSERT BREAK:C1413($range;wk paragraph break:K81:259;wk append:K81:179;wk include in range:K81:180)
WP INSERT BREAK:C1413($range;wk section break:K81:187;wk append:K81:179;wk exclude from range:K81:181)

$range:=WP Text range:C1341($coverRange;wk end text:K81:164;wk end text:K81:164)
WP SET TEXT:C1574($range;"";wk append:K81:179)
WP NEW BOOKMARK:C1415($range;"Summary")
