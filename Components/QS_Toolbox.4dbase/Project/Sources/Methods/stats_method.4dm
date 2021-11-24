//%attributes = {"invisible":true}
C_VARIANT:C1683($1)
C_LONGINT:C283($2;$param)
$param:=$2

If ($1#Null:C1517)
	Case of 
		: ($param=1)
			Form:C1466.usedCommand:=$1
		: ($param=2)
			Form:C1466.indexes:=Num:C11($1)
		: ($param=3)
			Form:C1466.missingForeignIndex:=Num:C11($1)
		: ($param=4)
			Form:C1466.missingKeyIndex:=Num:C11($1)
		: ($param=5)
			Form:C1466.relations:=Num:C11($1)
		: ($param=6)
			Form:C1466.schemas:=Num:C11($1)
		: ($param=7)
			Form:C1466.prop:=$1
		: ($param=8)
			Form:C1466.table:=$1
		: ($param=9)
			Form:C1466.fields:=$1
		: ($param=10)
			Form:C1466.tableDescription:=$1
		: ($param=11)
			Form:C1466.indexDescription:=$1
		: ($param=12)
			Form:C1466.missingForeignIdxDescription:=$1
		: ($param=13)
			Form:C1466.getForeignKetClusterErr:=$1
		: ($param=14)
			Form:C1466.getUniquenessErr:=$1
		: ($param=15)
			Form:C1466.getCompositeIndex:=$1
			
	End case 
	
End if 