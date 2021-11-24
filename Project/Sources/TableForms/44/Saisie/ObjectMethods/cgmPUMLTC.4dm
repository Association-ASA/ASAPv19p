  // LTL= nom de la liste hiérarchique

$ES:=Selected list items:C379(LTL)
GET LIST ITEM:C378(LTL;$ES;VarRefEl;VarText)
If (VarRefEl>10)
	$EP:=List item parent:C633(LTL;VarRefEl)
	$NEP:=List item position:C629(LTL;$EP)
	GET LIST ITEM:C378(LTL;$NEP;$VarRefEl;VarTexteEl)
	[DiaLesions:44]TypeLesionnelPrecis:3:=VarText
	[DiaLesions:44]GrandTypeLesionnel:2:=VarTexteEl
Else 
	[DiaLesions:44]TypeLesionnelPrecis:3:=VarText
	[DiaLesions:44]GrandTypeLesionnel:2:=VarText
End if 