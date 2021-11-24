//%attributes = {"invisible":true}
C_OBJECT:C1216($style;$QS_data;$param)

$style:=New object:C1471
$style.blank:=New object:C1471
$style.red:=New object:C1471("fill";"red")
$style.yellow:=New object:C1471("fill";"yellow")
$style.gainsboro:=New object:C1471("fill";"#DCDCDC";"stroke";"#DCDCDC")
$style.canary:=New object:C1471("fill";"orange")
$style.green:=New object:C1471("fill";"#D0F5A9")
$style.nearGreen:=New object:C1471("fill";"#6be3ab")  // near green color
Form:C1466.colors:=$style

$QS_data:=Storage:C1525.QS_TBX_SHARED_DATA
$param:=New object:C1471
$param.ComplexLow:=$QS_data.QS_SETUP_COMPLEX_LOW
$param.ComplexMedium:=$QS_data.QS_SETUP_COMPLEX_MEDIUM
$param.ComplexHigh:=$QS_data.QS_SETUP_COMPLEX_HIGH
$param.CommentLow:=$QS_data.QS_SETUP_COMMENT_LOW
$param.CommentMedium:=$QS_data.QS_SETUP_COMMENT_MEDIUM
$param.CommentHigh:=$QS_data.QS_SETUP_COMMENT_HIGH
Form:C1466.param:=$param