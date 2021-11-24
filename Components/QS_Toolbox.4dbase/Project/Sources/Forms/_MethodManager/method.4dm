C_LONGINT:C283($evt)
$evt:=Form event code:C388

Case of 
	: ($evt=On Load:K2:1)
		
		// Load all project method names, code and their attributes 
		Form:C1466.listboxDisplayed:=New collection:C1472
		Form:C1466.toggleSort:=False:C215
		Form:C1466.hasBeenModified:=False:C215
		Form:C1466.toSave:=False:C215  // Based on 4DMethod presentation
		Form:C1466.currentMethod:=""
		Form:C1466.currentMethod_selected:=-1
		Form:C1466.fromWhen:=-1
		Form:C1466.myProgress:=0
		Form:C1466.searchInMethod:=0
		Form:C1466.emoji:=emoji("1F4C4")
		Form:C1466.menu:=New list:C375
		
		OBJECT SET VISIBLE:C603(*; "btnSave"; False:C215)
		(OBJECT Get pointer:C1124(Object named:K67:5; "searchMethod"))->:=""
		(OBJECT Get pointer:C1124(Object named:K67:5; "rd50"))->:=1
		
		APPEND TO LIST:C376(Form:C1466.menu; "List"; 1)
		APPEND TO LIST:C376(Form:C1466.menu; "Preview"; 2)
		APPEND TO LIST:C376(Form:C1466.menu; "Comment"; 3)
		
		MM_option_manager(2; False:C215)
		MM_option_manager(3; False:C215)
		MM_initDecorate
		
		SET TIMER:C645(5)
		gerror:=0
		
	: ($evt=On Page Change:K2:54)
		
		Case of 
			: (FORM Get current page:C276=1)
				Form:C1466.listboxDisplayed:=Form:C1466.listboxDisplayed
				LISTBOX SELECT ROW:C912(*; "MethodsPaths"; 0; lk remove from selection:K53:3)
				If (Form:C1466.currentMethod_selected>0)
					LISTBOX SELECT ROW:C912(*; "MethodsPaths"; Form:C1466.currentMethod_selected; lk add to selection:K53:2)
				End if 
				
			Else   // Page 2 or 3
				OBJECT SET TITLE:C194(*; "methodTitle"; Form:C1466.currentMethod)
		End case 
		OBJECT SET VISIBLE:C603(*; "methodTitle"; FORM Get current page:C276>1)
		
		
	: ($evt=On Timer:K2:25)
		SET TIMER:C645(0)  // Stop immediatly the timer
		Form:C1466.start:=False:C215
		MM_restoreList
		MM_updateInformation
		
	: ($evt=On Close Box:K2:21)
		
		CLEAR LIST:C377(Form:C1466.menu; *)
		
		If (Form:C1466.toSave)
			$action:=False:C215
			If (x_io_confirm_yesNo("Do you want to save attributes before leaving?"; ->$action))
				CALL WORKER:C1389("QST_job"; "MM_saveMethodsAttributes"; Form:C1466.methodSelected)
				Form:C1466.toSave:=False:C215
			End if 
		End if 
		
		KILL WORKER:C1390
End case 