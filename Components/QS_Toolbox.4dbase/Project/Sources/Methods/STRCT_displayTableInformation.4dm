//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 08/01/18, 19:31:03
  // ----------------------------------------------------
  // Méthode : TOOLS_DisplayTableInformation
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------

C_LONGINT:C283($position)
C_POINTER:C301($ZptTable)

$start:=""
$position:=Form:C1466.posCurrentTable-1
If ($position>=0)
	
	$FenetreInformation:="Parsing of Table: "+Storage:C1525.structureTable[$position].name
	displayInfo ($FenetreInformation)
	
	If (Storage:C1525.structureTable[$position].id>0)
		$NumTable:=Storage:C1525.structureTable[$position].id
		OBJECT SET VISIBLE:C603(*;"NbEnrTable";$NumTable>0)
		If ($NumTable>0)
			$ZptTable:=Table:C252($NumTable)
			(OBJECT Get pointer:C1124(Object named:K67:5;"NbEnrTable"))->:=Records in table:C83(Table:C252($NumTable)->)
		End if 
		
		ARRAY OBJECT:C1221($arrTable;0x0000)
		OB GET ARRAY:C1229(Form:C1466.oStructure;"table";$arrTable)
		
		For ($i;1;Size of array:C274($arrTable))
			If ($arrTable{$i}.name=Table name:C256($ZptTable))
				$oTable:=$arrTable{$i}
				$i:=Size of array:C274($arrTable)+1
			End if 
		End for 
		
		STRCT_getColorTable ($oTable)
		
		If (Form:C1466.tableProperties)
			STRCT_displayTableInfo ($oTable)
			
		Else 
			  // Display Fields Information
			If ($NumTable>0)
				STRCT_displayField ($oTable)
				
				ARRAY LONGINT:C221($MyEventsOnLB;1)
				$MyEventsOnLB{1}:=On Double Clicked:K2:5
				OBJECT SET EVENTS:C1239(*;"ExploreStructure";$MyEventsOnLB;Enable events others unchanged:K42:38)
				
				$Red:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_COLOR_RED
				$Green:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_COLOR_GREEN
				$EndTag:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_END_TAG
				
				$Jounalise:=IsTableJournaled (Storage:C1525.structureTable[Form:C1466.posCurrentTable-1].name)
				$FenetreInformation:="Table: "+Storage:C1525.structureTable[Form:C1466.posCurrentTable-1].name+Choose:C955($Jounalise;HTP_Util_GiveStyleTag ($Green;"";"")+" is Journaled";HTP_Util_GiveStyleTag ($Red;"";"")+" is NOT Journaled")+$EndTag
				(OBJECT Get pointer:C1124(Object named:K67:5;"FenetreInformation"))->:=$start+$FenetreInformation+Choose:C955($start#"";$EndTag;"")
			End if 
			
		End if 
		
		OBJECT SET VISIBLE:C603(*;"lb_result";True:C214)
		OBJECT SET VISIBLE:C603(*;"Zone_Web";False:C215)
		
	End if 
End if 
