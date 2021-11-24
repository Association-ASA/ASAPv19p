C_LONGINT:C283($position)

If (Form:C1466.posCurrentTable>0)
	$position:=Form:C1466.posCurrentTable-1
	If (Storage:C1525.structureTable[$position].id>0)
		$NumTable:=Storage:C1525.structureTable[$position].id
		OBJECT SET VISIBLE:C603(*;"NbEnrTable";$NumTable>0)
		Form:C1466.numTable:=$NumTable
		If ($NumTable>0)
			  //ZptTable:=Table($NumTable)
			(OBJECT Get pointer:C1124(Object named:K67:5;"NbEnrTable"))->:=Records in table:C83(Table:C252($NumTable)->)
		End if 
	End if 
	  //ZptChamp:=Field(Table($NumTable);)
	
	  // RESOLVE POINTER(ZptChamp;$vaNomVar;$vlNumTable;$vlNumChamp)
End if 

$RefMenu:=Create menu:C408

  //If (Not(Storage.QS_TBX_SHARED_DATA.QS_TBX_Component_Mode))

  //APPEND MENU ITEM($RefMenu;"-")
  //SET MENU ITEM PARAMETER($RefMenu;-1;"100")

  //APPEND MENU ITEM($RefMenu;"-")
  //SET MENU ITEM PARAMETER($RefMenu;-1;"100")

  //APPEND MENU ITEM($RefMenu;"Export Index (JSON)";*)
  //SET MENU ITEM PARAMETER($RefMenu;-1;"9")

  //APPEND MENU ITEM($RefMenu;"Import Index (JSON)";*)
  //SET MENU ITEM PARAMETER($RefMenu;-1;"13")

  //APPEND MENU ITEM($RefMenu;"-")
  //SET MENU ITEM PARAMETER($RefMenu;-1;"101")

  //End if 


APPEND MENU ITEM:C411($RefMenu;"Open CSM")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"1")

APPEND MENU ITEM:C411($RefMenu;"Compact Data file")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"6")

APPEND MENU ITEM:C411($RefMenu;"Open Application properties")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"2")

APPEND MENU ITEM:C411($RefMenu;"-")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"101")

APPEND MENU ITEM:C411($RefMenu;"Restore Debugger buttons")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"7")

$referenceLigne:=Dynamic pop up menu:C1006($RefMenu)
RELEASE MENU:C978($RefMenu)

Case of 
	: ($referenceLigne="1")
		OPEN SECURITY CENTER:C1018
		
	: ($referenceLigne="2")
		OPEN SETTINGS WINDOW:C903("/")
		
	: ($referenceLigne="6")
		TOOLS_CompactDB 
		
	: ($referenceLigne="7")
		TOOLS_ResetDebugButtons 
		
	: ($referenceLigne="9")
		TOOLS_ExportIndexAsJSON 
		
	: ($referenceLigne="13")
		TOOLS_ReadOnly ("TOOLS_ImportIndexAsJSON")
		
End case 
