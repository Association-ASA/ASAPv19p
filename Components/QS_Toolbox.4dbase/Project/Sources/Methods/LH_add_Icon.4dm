//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_POINTER:C301($1; $3)  // pointer on List ID, pointer on picture
C_LONGINT:C283($2)  // ID of the list element
C_PICTURE:C286($combine; $pic_current)

PICTURE PROPERTIES:C457($3->; $l; $h)
If ($h>22)
	$ratio:=Round:C94($h\22; 0)+1
	TRANSFORM PICTURE:C988($3->; Scale:K61:2; (1/$ratio); (1/$ratio))
End if 

GET LIST ITEM ICON:C951($1->; $2; $pic_current)
SET LIST ITEM PROPERTIES:C386($1->; $2; False:C215; Plain:K14:1; 0; 0x00FF7F7F)
COMBINE PICTURES:C987($combine; $3->; Horizontal concatenation:K61:8; $pic_current; 16)
SET LIST ITEM ICON:C950($1->; $2; $combine)