//%attributes = {"invisible":true}
  // MM_option_manager
  // Parameters:
  // $1: element of the LH
  // $2: Status of the item
  // ----------------------------------------------------
  // Description:
  // Activate / desactivate buttons from Method Manager tab
  // ----------------------------------------------------
  // Creation: Patrick EMANUEL, 27/11/20, 11:03:24
  //

C_LONGINT:C283($1)
C_BOOLEAN:C305($2)

$level:=$1
$status:=$2

$ptrOnglet1:=OBJECT Get pointer:C1124(Object named:K67:5;"Onglet")
$ptrOnglet1->:=Form:C1466.menu

GET LIST ITEM PROPERTIES:C631($ptrOnglet1->;$1;$saisissable;$style;$icon)
SET LIST ITEM PROPERTIES:C386($ptrOnglet1->;$1;$2;$style;$icon)
