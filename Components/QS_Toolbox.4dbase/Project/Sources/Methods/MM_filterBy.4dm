//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_DATE:C307($limitedDate)
C_LONGINT:C283($cb1;$cb2;$cb3;$cb4;$cb5;$cb6;$cb7;$cb8)
C_TEXT:C284($preemptive;$title)
C_BOOLEAN:C305($visible)

$Menu:=Create menu:C408  // Main menu

  // --------------------
$RefMenu:=Create menu:C408  // Submenu Method Properties
APPEND MENU ITEM:C411($RefMenu;"Invisible")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"101")

APPEND MENU ITEM:C411($RefMenu;"Visible")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"111")

APPEND MENU ITEM:C411($RefMenu;"WEB")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"102")

APPEND MENU ITEM:C411($RefMenu;"SOAP")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"103")

APPEND MENU ITEM:C411($RefMenu;"WSDL")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"104")

APPEND MENU ITEM:C411($RefMenu;"Shared")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"105")

APPEND MENU ITEM:C411($RefMenu;"Available through SQL")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"106")

APPEND MENU ITEM:C411($RefMenu;"Execute on Server")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"107")

APPEND MENU ITEM:C411($RefMenu;"-")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"1000")

APPEND MENU ITEM:C411($RefMenu;"preemptive: capable")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"108")

APPEND MENU ITEM:C411($RefMenu;"preemptive: indifferent")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"109")

APPEND MENU ITEM:C411($RefMenu;"preemptive: incapable")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"110")

APPEND MENU ITEM:C411($Menu;"Filter methods by properties";$RefMenu)
RELEASE MENU:C978($RefMenu)

  // --------------------
$RefMenu:=Create menu:C408  // Submenu Method type
APPEND MENU ITEM:C411($RefMenu;"Project method")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"50")

APPEND MENU ITEM:C411($RefMenu;"Project form")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"51")

APPEND MENU ITEM:C411($RefMenu;"Database method")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"52")

APPEND MENU ITEM:C411($RefMenu;"Table form")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"53")

APPEND MENU ITEM:C411($RefMenu;"Path trigger")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"54")

If (QS_miniVersionR (3))
	$prefix:=""
Else 
	$prefix:="("
End if 
APPEND MENU ITEM:C411($RefMenu;$prefix+"Class")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"55")

APPEND MENU ITEM:C411($Menu;"Filter methods type";$RefMenu)
RELEASE MENU:C978($RefMenu)

  // --------------------
$RefMenu:=Create menu:C408  // Submenu
APPEND MENU ITEM:C411($RefMenu;"Today")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"1")

APPEND MENU ITEM:C411($RefMenu;"3 days")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"2")

APPEND MENU ITEM:C411($RefMenu;"7 days")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"3")

APPEND MENU ITEM:C411($RefMenu;"15 days")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"4")

APPEND MENU ITEM:C411($RefMenu;"30 days")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"5")

APPEND MENU ITEM:C411($RefMenu;"60 days")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"6")

APPEND MENU ITEM:C411($RefMenu;"90 days")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"7")

APPEND MENU ITEM:C411($RefMenu;"180 days")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"8")

APPEND MENU ITEM:C411($Menu;"Modified within the last...";$RefMenu)
RELEASE MENU:C978($RefMenu)

For ($indice;1;8)
	$name:="cb"+String:C10($indice)
	(OBJECT Get pointer:C1124(Object named:K67:5;$name))->:=0
End for 
  // --------------------
If (Form:C1466.currentElement#Null:C1517)
	
	APPEND MENU ITEM:C411($Menu;"-")
	SET MENU ITEM PARAMETER:C1004($Menu;-1;"10")
	
	APPEND MENU ITEM:C411($Menu;"Callees for '"+Form:C1466.currentElement.name+"'";*)
	SET MENU ITEM PARAMETER:C1004($Menu;-1;"11")
	
	APPEND MENU ITEM:C411($Menu;"Callers for '"+Form:C1466.currentElement.name+"'";*)
	SET MENU ITEM PARAMETER:C1004($Menu;-1;"12")
End if 

If (Form:C1466.methodSelected.length>0)
	APPEND MENU ITEM:C411($Menu;"-")
	SET MENU ITEM PARAMETER:C1004($Menu;-1;"13")
	
	APPEND MENU ITEM:C411($Menu;"Reduce to selection")
	SET MENU ITEM PARAMETER:C1004($Menu;-1;"15")
End if 

APPEND MENU ITEM:C411($Menu;"-")
SET MENU ITEM PARAMETER:C1004($Menu;-1;"13")

APPEND MENU ITEM:C411($Menu;"Display all")
SET MENU ITEM PARAMETER:C1004($Menu;-1;"14")

  // --------------------
  //If (Bool(Storage.QS_TBX_SHARED_DATA.hostInProjectMode)=True)
$RefMenu:=Create menu:C408  // Submenu Folders

APPEND MENU ITEM:C411($RefMenu;"<no folder>")
SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"201-")

$coll:=Storage:C1525.allMethods.filter("CM_displayByType";"Path project method").distinct("folder")

For each ($c;$coll)
	APPEND MENU ITEM:C411($RefMenu;$c)
	SET MENU ITEM PARAMETER:C1004($RefMenu;-1;"201-"+$c)
End for each 

APPEND MENU ITEM:C411($Menu;"Folder...";$RefMenu)
RELEASE MENU:C978($RefMenu)
  //End if 

  // --------------------

APPEND MENU ITEM:C411($Menu;"-")
SET MENU ITEM PARAMETER:C1004($Menu;-1;"13")

APPEND MENU ITEM:C411($Menu;"Reload symbols file")
SET MENU ITEM PARAMETER:C1004($Menu;-1;"20")

  // --------------------

$ref_line:=Dynamic pop up menu:C1006($Menu)
RELEASE MENU:C978($Menu)


If ($ref_line#"")
	
	  // -------------------- Now, analyse the selected menu
	  // Configuration of variable before selection
	C_LONGINT:C283($num_ref_line)
	$num_ref_line:=Num:C11($ref_line)
	Case of 
		: ($num_ref_line=1)
			$limitedDate:=Current date:C33
			
		: ($num_ref_line=2)
			$limitedDate:=Add to date:C393(Current date:C33;0;0;-3)
			
		: ($num_ref_line=3)
			$limitedDate:=Add to date:C393(Current date:C33;0;0;-7)
			
		: ($num_ref_line=4)
			$limitedDate:=Add to date:C393(Current date:C33;0;0;-15)
			
		: ($num_ref_line=5)
			$limitedDate:=Add to date:C393(Current date:C33;0;0;-30)
			
		: ($num_ref_line=6)
			$limitedDate:=Add to date:C393(Current date:C33;0;0;-60)
			
		: ($num_ref_line=7)
			$limitedDate:=Add to date:C393(Current date:C33;0;0;-90)
			
		: ($num_ref_line=8)
			$limitedDate:=Add to date:C393(Current date:C33;0;0;-180)
			
		: ($num_ref_line=101)
			(OBJECT Get pointer:C1124(Object named:K67:5;"cb1"))->:=1
			OBJECT SET TITLE:C194(*;"cb1";"Invisible")
			
		: ($num_ref_line=102)
			(OBJECT Get pointer:C1124(Object named:K67:5;"cb2"))->:=1
			
		: ($num_ref_line=103)
			(OBJECT Get pointer:C1124(Object named:K67:5;"cb3"))->:=1
			
		: ($num_ref_line=104)
			(OBJECT Get pointer:C1124(Object named:K67:5;"cb4"))->:=1
			
		: ($num_ref_line=105)
			(OBJECT Get pointer:C1124(Object named:K67:5;"cb5"))->:=1
			
		: ($num_ref_line=106)
			(OBJECT Get pointer:C1124(Object named:K67:5;"cb6"))->:=1
			
		: ($num_ref_line=107)
			(OBJECT Get pointer:C1124(Object named:K67:5;"cb7"))->:=1
			
		: ($num_ref_line=108)
			(OBJECT Get pointer:C1124(Object named:K67:5;"cb8"))->:=1
			OBJECT SET TITLE:C194(*;"cb8";"preemptive: capable")
			
		: ($num_ref_line=109)
			(OBJECT Get pointer:C1124(Object named:K67:5;"cb8"))->:=1
			OBJECT SET TITLE:C194(*;"cb8";"preemptive: indifferent")
			
		: ($num_ref_line=110)
			(OBJECT Get pointer:C1124(Object named:K67:5;"cb8"))->:=1
			OBJECT SET TITLE:C194(*;"cb8";"preemptive: incapable")
			
		: ($num_ref_line=111)
			(OBJECT Get pointer:C1124(Object named:K67:5;"cb1"))->:=1
			OBJECT SET TITLE:C194(*;"cb1";"Visible")
			
	End case 
	
	  // Now, execution of the selection
	Case of 
		: (Num:C11($num_ref_line)<9)  // Easier way to work with
			Form:C1466.listboxDisplayed:=Storage:C1525.allMethods.filter("CM_filterByDate";$limitedDate).orderBy("name")
			
		: ($num_ref_line=11)  // Callees: Methodes appelées 
			Form:C1466.listboxDisplayed:=Storage:C1525.allMethods.filter("CM_filterCalleesCallers";Form:C1466.currentElement.callees).orderBy("name")
			
		: ($num_ref_line=12)  // Callers: Méthodes appelantes
			Form:C1466.listboxDisplayed:=Storage:C1525.allMethods.filter("CM_filterCalleesCallers";Form:C1466.currentElement.callers).orderBy("name")
			
		: ($num_ref_line=14)
			Form:C1466.listboxDisplayed:=Storage:C1525.allMethods.filter("CM_displayAll").orderBy("name")
			
		: ($num_ref_line=15)
			Form:C1466.listboxDisplayed:=Form:C1466.methodSelected.orderBy("name")
			
		: ($num_ref_line=20)
			C_OBJECT:C1216($declaration)
			$declaration:=New shared object:C1526
			
			$signal:=New signal:C1641
			signal_setNew ($signal;1)
			CALL WORKER:C1389("QST_readSymbolFile";"TOOLS_readSymbolFile";False:C215;$declaration;False:C215;$signal)
			
			$signal.wait()
			MM_restoreList 
			MM_updateInformation 
			
		: ($num_ref_line=50) | ($num_ref_line=51) | ($num_ref_line=52) | ($num_ref_line=53) | ($num_ref_line=54) | ($num_ref_line=55)
			For ($id;50;54)
				(OBJECT Get pointer:C1124(Object named:K67:5;"rd"+String:C10($id)))->:=0
			End for 
			(OBJECT Get pointer:C1124(Object named:K67:5;"rd"+$ref_line))->:=1
			MM_restoreList 
			Form:C1466.fromWhen:=-1
			
			  // Check cb values
		: ($num_ref_line>100) & ($num_ref_line<200)
			$cb1:=(OBJECT Get pointer:C1124(Object named:K67:5;"cb1"))->
			$cb2:=(OBJECT Get pointer:C1124(Object named:K67:5;"cb2"))->
			$cb3:=(OBJECT Get pointer:C1124(Object named:K67:5;"cb3"))->
			$cb4:=(OBJECT Get pointer:C1124(Object named:K67:5;"cb4"))->
			$cb5:=(OBJECT Get pointer:C1124(Object named:K67:5;"cb5"))->
			$cb6:=(OBJECT Get pointer:C1124(Object named:K67:5;"cb6"))->
			$cb7:=(OBJECT Get pointer:C1124(Object named:K67:5;"cb7"))->
			$cb8:=(OBJECT Get pointer:C1124(Object named:K67:5;"cb8"))->
			
			  // Everything is unchecked
			If (($cb1+$cb2+$cb3+$cb4+$cb5+$cb6+$cb7+$cb8)=0)
				Form:C1466.listboxDisplayed:=Storage:C1525.allMethods.filter("CM_displayAll").orderBy("name")
				
				  // at least, one
			Else 
				$title:=OBJECT Get title:C1068(*;"cb8")
				$preemptive:=Substring:C12($title;Position:C15(":";$title)+2)
				$visible:=(OBJECT Get title:C1068(*;"cb1")="Visible")
				Form:C1466.listboxDisplayed:=Storage:C1525.allMethods.filter("CM_displayOne";$cb1;$cb2;$cb3;$cb4;$cb5;$cb6;$cb7;$cb8;$preemptive;$visible).orderBy("name")
			End if 
			
		: ($num_ref_line=201)
			$folder:=Substring:C12($ref_line;Position:C15("-";$ref_line)+1)
			If ($folder="<no folder>")
				$folder:=""
			End if 
			Form:C1466.listboxDisplayed:=Storage:C1525.allMethods.query("folder =:1 and path ='Path project method' and orderBy name";$folder)
			
	End case 
	MM_updateInformation 
	
End if 