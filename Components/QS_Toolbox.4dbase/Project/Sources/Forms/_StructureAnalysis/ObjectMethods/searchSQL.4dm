$RefMenu:=Create menu:C408
$RefMenu2:=Create menu:C408

APPEND MENU ITEM:C411($RefMenu;"SELECT * FROM ")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"1")

APPEND MENU ITEM:C411($RefMenu;"UPDATE TABLE ")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"2")

APPEND MENU ITEM:C411($RefMenu;"INSERT INTO ")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"3")

APPEND MENU ITEM:C411($RefMenu;"VALUES ")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"4")

APPEND MENU ITEM:C411($RefMenu;"INTO LISTBOX :[LB_Balance]")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"5")

APPEND MENU ITEM:C411($RefMenu;"CREATE VIEW")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"6")

APPEND MENU ITEM:C411($RefMenu;"CONTRAINST")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"7")

APPEND MENU ITEM:C411($RefMenu;"-")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"100")


APPEND MENU ITEM:C411($RefMenu2;"_USER_TABLES")
SET MENU ITEM PARAMETER:C1004($RefMenu2;-1;"10")

APPEND MENU ITEM:C411($RefMenu2;"_USER_COLUMNS")
SET MENU ITEM PARAMETER:C1004($RefMenu2;-1;"11")

APPEND MENU ITEM:C411($RefMenu2;"_USER_CONSTRAINTS")
SET MENU ITEM PARAMETER:C1004($RefMenu2;-1;"12")

APPEND MENU ITEM:C411($RefMenu2;"_USER_INDEXES")
SET MENU ITEM PARAMETER:C1004($RefMenu2;-1;"13")

APPEND MENU ITEM:C411($RefMenu2;"_USER_IND_COLUMNS")
SET MENU ITEM PARAMETER:C1004($RefMenu2;-1;"14")

APPEND MENU ITEM:C411($RefMenu2;"_USER_CONS_COLUMNS")
SET MENU ITEM PARAMETER:C1004($RefMenu2;-1;"15")

APPEND MENU ITEM:C411($RefMenu2;"_USER_SCHEMAS")
SET MENU ITEM PARAMETER:C1004($RefMenu2;-1;"16")

APPEND MENU ITEM:C411($RefMenu2;"_USER_VIEWS")
SET MENU ITEM PARAMETER:C1004($RefMenu2;-1;"17")

APPEND MENU ITEM:C411($RefMenu2;"_USER_VIEW_COLUMNS")
SET MENU ITEM PARAMETER:C1004($RefMenu2;-1;"18")

APPEND MENU ITEM:C411($RefMenu;"Get all data from...";$RefMenu2)
RELEASE MENU:C978($RefMenu2)

APPEND MENU ITEM:C411($RefMenu;"-")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"101")

APPEND MENU ITEM:C411($RefMenu;"CLEAR")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"20")

$referenceLigne:=Dynamic pop up menu:C1006($RefMenu)
RELEASE MENU:C978($RefMenu)

$pbj:=(OBJECT Get pointer:C1124(Object named:K67:5;"SQLCommands"))->

Case of 
	: ($referenceLigne="1")
		$pbj:=$pbj+"SELECT * FROM "
		
	: ($referenceLigne="2")
		$pbj:=$pbj+"UPDATE TABLE "
		
	: ($referenceLigne="3")
		$pbj:=$pbj+"INSERT INTO ("
		
	: ($referenceLigne="4")
		$pbj:=$pbj+") VALUES ("
		
	: ($referenceLigne="5")
		$pbj:=$pbj+" INTO LISTBOX :LB_Balance;"
		
	: ($referenceLigne="6")
		$pbj:=$pbj+"CREATE OR REPLACE VIEW MyVIEW AS SELECT * FROM "
		
	: ($referenceLigne="7")
		$pbj:="CONSTRAINT '{ConstraintName}' PRIMARY KEY('{Field1}', '{Field2}', ... '{FieldN}')"
		
	: ($referenceLigne="10")
		$pbj:="SELECT * FROM '_USER_TABLES' INTO LISTBOX :LB_BALANCE;"
		
	: ($referenceLigne="11")
		$pbj:="SELECT * FROM '_USER_COLUMNS' INTO LISTBOX :LB_BALANCE;"
		
	: ($referenceLigne="12")
		$pbj:="SELECT * FROM '_USER_CONSTRAINTS' INTO LISTBOX :LB_BALANCE;"
		
	: ($referenceLigne="13")
		$pbj:="SELECT * FROM '_USER_INDEXES' INTO LISTBOX :LB_BALANCE;"
		
	: ($referenceLigne="14")
		$pbj:="SELECT * FROM '_USER_IND_COLUMNS' INTO LISTBOX :LB_BALANCE;"
		
	: ($referenceLigne="15")
		$pbj:="SELECT * FROM '_USER_CONS_COLUMNS' INTO LISTBOX :LB_BALANCE;"
		
	: ($referenceLigne="16")
		$pbj:="SELECT * FROM '_USER_SCHEMAS' INTO LISTBOX :LB_BALANCE;"
		
	: ($referenceLigne="17")
		$pbj:="SELECT * FROM '_USER_VIEWS' INTO LISTBOX :LB_BALANCE;"
		
	: ($referenceLigne="18")
		$pbj:="SELECT * FROM '_USER_VIEW_COLUMNS' INTO LISTBOX :LB_BALANCE;"
		
		
	: ($referenceLigne="20")
		$pbj:=""
		
End case 

(OBJECT Get pointer:C1124(Object named:K67:5;"SQLCommands"))->:=$pbj
If (Num:C11($referenceLigne)>=10) & (Num:C11($referenceLigne)<20)
	TOOLS_executeSQLcommands 
End if 