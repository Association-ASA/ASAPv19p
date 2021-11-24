Case of 
	: (Form event code:C388=On Clicked:K2:4)
		
		LB_displayCellContent 
		
		  // Right clic management
		If (Right click:C712)
			
			$type:=Value type:C1509(Form:C1466.currentElement[Form:C1466.column])
			$object:=(OBJECT Get pointer:C1124(Object named:K67:5;"txtMenu"))->
			$object:=Substring:C12($object;Position:C15(":";$object)+2;Position:C15("(";$object)-(Position:C15(":";$object)+3))
			
			Case of 
				: ($type=2)
					C_TEXT:C284($value)
					$value:=Form:C1466.currentElement[Form:C1466.column]
					
				: ($type=6)
					C_BOOLEAN:C305($bool)
					$bool:=Form:C1466.currentElement[Form:C1466.column]
					
			End case 
			
			C_COLLECTION:C1488($menu)
			C_POINTER:C301($Nil)
			C_TEXT:C284($action_txt)
			$action_txt:=""
			$path_icons:="images/methods/icn_upd_"
			$isOk:=True:C214
			C_TEXT:C284($dbName)
			$dbName:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName
			
			$menu:=New collection:C1472
			QS_menu_pushItem ($menu;"Copy All";"all")
			QS_menu_pushItem ($menu;"Distinct values of column contents";"distinct")
			QS_menu_pushItem ($menu;"-----------";"")
			QS_menu_pushItem ($menu;"Export to .HTML";"html")
			QS_menu_pushItem ($menu;"Export to .JSON";"json")
			QS_menu_pushItem ($menu;"Export to .XML";"xml")
			QS_menu_pushItem ($menu;"Export to .CSV";"csv")
			QS_menu_pushItem ($menu;"Export to .TXT";"txt")
			QS_menu_pushItem ($menu;"Export to .MD";"md")
			
			
			$isOk:=x_btnPopup_coll (On Clicked:K2:4;->$action_txt;$Nil;$path_icons;$menu)
			If ($isOk)
				
				Case of 
						
					: ($action_txt="all")
						Form:C1466.result:=Form:C1466.resultCopy.copy()
						
					: ($action_txt="distinct")
						Case of 
							: ($type=2)
								Form:C1466.result:=Form:C1466.resultCopy.query(Form:C1466.column+" = :1";$value)
								
							: ($type=6)
								Form:C1466.result:=Form:C1466.resultCopy.query(Form:C1466.column+" = :1";$bool)
						End case 
						
					: ($action_txt="html")
						Collection_toHTML (Form:C1466.result;$object+" of "+$dbName)
						
					: ($action_txt="json")
						Collection_ToJSON (Form:C1466.result;$object+" of "+$dbName)
						
					: ($action_txt="csv")
						Collection_toCSV (Form:C1466.result;$object+" of "+$dbName)
						
					: ($action_txt="xml")
						Collection_ToXML (Form:C1466.result;$object+" of "+$dbName)
						
					: ($action_txt="txt")
						Collection_toTXT (Form:C1466.result;$object+" of "+$dbName)
						
					: ($action_txt="md")
						Collection_toMd (Form:C1466.result;$object+" of "+$dbName)
						
				End case 
			End if 
		End if 
		
		
	: (Form event code:C388=On Double Clicked:K2:5)
		METHOD OPEN PATH:C1213(Form:C1466.currentElement.method;*)
		
End case 