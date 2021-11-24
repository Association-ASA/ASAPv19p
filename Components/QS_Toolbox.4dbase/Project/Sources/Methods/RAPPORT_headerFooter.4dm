//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
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

$section:=WP Get section:C1581($wpDoc;2)
$coverRange:=WP Text range:C1341($wpDoc;wk start text:K81:165;wk start text:K81:165)

  // Header 
$header:=WP New header:C1586($section)
WP SET ATTRIBUTES:C1342($header;wk text align:K81:49;wk center:K81:99)
WP SET ATTRIBUTES:C1342($header;wk font bold:K81:68;wk true:K81:174)
WP SET TEXT:C1574($header;$title;wk append:K81:179)

  // Footer
$footer:=WP New footer:C1587($section)
WP SET TEXT:C1574($footer;"Last execution on "+String:C10(Current date:C33)+" @ "+String:C10(Current time:C178)+".\t";wk append:K81:179)
  // #TODO: ST Insert Expression -> wp insert formula v18R2
  // WP INSERT FORMULA($footer;formula(this.pageNumber);wk append)
ST INSERT EXPRESSION:C1281($footer;"$wp_pageNumber";ST End text:K78:16)
WP SET TEXT:C1574($footer;" / ";wk append:K81:179;wk include in range:K81:180)
  // WP INSERT FORMULA($footer;formula(this.pageCound);wk append)
ST INSERT EXPRESSION:C1281($footer;"$wp_pageCount";ST End text:K78:16)

$tab:=New object:C1471
$tab[wk type:K81:189]:=wk right:K81:96
$tab[wk offset:K81:280]:="16cm"
$tab[wk leading:K81:281]:=""
WP SET ATTRIBUTES:C1342($footer;wk tab default:K81:279;$tab)
