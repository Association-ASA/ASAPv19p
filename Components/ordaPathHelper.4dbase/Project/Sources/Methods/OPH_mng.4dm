//%attributes = {"shared":true}
  //OPH_mng (obj) -> obj
  //"OrdaPathHelper"

  //© Arnaud * 26/10/2021 * mise au point from component




$out_o:=New object:C1471()
If (Count parameters:C259>0)
	$in_o:=$1
Else 
	$in_o:=FORM Event:C1606
End if 

ASSERT:C1129(Not:C34(Windows Alt down:C563))

Case of   //MAIN
		
	: ($in_o=Null:C1517)  //run button of the method
		OPH_mng (New object:C1471("objectName";"K_processNew_t"))
		
	: ($in_o.objectName="K_processNew_t")  //run button of the method
		$pss:=Process number:C372(Current method name:C684)
		If ($pss=0)
			CALL WORKER:C1389(Current method name:C684;Current method name:C684;New object:C1471("objectName";"K_FormOpen_t"))
		Else 
			BRING TO FRONT:C326($pss)
		End if 
		
	: ($in_o.objectName="K_FormOpen_t")
		$win:=Open form window:C675("OrdaPathHelper";Plain form window:K39:10)
		  //$win:=Open form window("OrdaPathHelper"; Palette form window)
		$editmenu:=True:C214  //en attendant…
		If ($editmenu)
			SET MENU BAR:C67(Mnu_LoadFromFile ("editor";Get 4D folder:C485(Current resources folder:K5:16)+"menus.xml"))  //MMM
		End if 
		$formData_o:=New object:C1471()
		DIALOG:C40("OrdaPathHelper";$formData_o)
		  //If (Current process name="P_@")  //running in its own process
		  //DIALOG("OrdaPathHelper"; $formData_o)
		  //Else   //use the current process
		  //DIALOG("OrdaPathHelper"; $formData_o; *)
		  //End if 
		If ($editmenu)
			Mnu_Release (Get menu bar reference:C979(Current process:C322))  //MMM
		End if 
		CLOSE WINDOW:C154($win)
		KILL WORKER:C1390(Current method name:C684)
		
	: ($in_o.objectName="OrdaPathHelper")
		Case of 
			: ($in_o.code=On Load:K2:1)
				SET WINDOW TITLE:C213("OrdaPathHelper";Current form window:C827)
				OPH_mng (New object:C1471("objectName";"modeSettings"))
				OPH_mng (New object:C1471("objectName";"dataclassesLoad"))
				Form:C1466.dataclass:=""
				Form:C1466.path:=""
				Form:C1466.pathItems:=New collection:C1472()
				OBJECT SET RGB COLORS:C628(*;"rectangle";Form:C1466.colorSet.background;Form:C1466.colorSet.background)
				OBJECT SET RGB COLORS:C628(*;"dataclass";Form:C1466.colorSet.stroke)  //; Form.colorSet.fill)
				OBJECT SET RGB COLORS:C628(*;"path";Form:C1466.colorSet.stroke)  //; Form.colorSet.fill)
		End case 
		
	: ($in_o.objectName="dataclass")
		Case of 
			: ($in_o.code=On Before Keystroke:K2:6)
				$keystroke:=Keystroke:C390
				$edit:=Get edited text:C655
				$charCode:=Character code:C91(Keystroke:C390)
				
			: ($in_o.code=On After Keystroke:K2:26)
				$keystroke:=Keystroke:C390
				$edit:=Get edited text:C655
				$charCode:=Character code:C91(Keystroke:C390)
				$listOn:=OBJECT Get visible:C1075(*;"LB_dcList")
				If ($listOn)
					  //LISTBOX SELECT ROW(*; "LB_dcList"; 0; lk remove from selection)
					If (Form:C1466.LB_dcList_currentPos=Null:C1517)
						Form:C1466.LB_dcList_currentPos:=0
					End if 
					Case of 
						: ($charCode=31) & (Form:C1466.LB_dcList_currentPos<Form:C1466.LB_dcList.length)  //arrow down
							Form:C1466.LB_dcList_currentPos:=Form:C1466.LB_dcList_currentPos+1
							Form:C1466.dataclass:=Form:C1466.LB_dcList[Form:C1466.LB_dcList_currentPos-1].name
							LISTBOX SELECT ROW:C912(*;"LB_dcList";Form:C1466.LB_dcList_currentPos;lk replace selection:K53:1)
						: ($charCode=30) & (Form:C1466.LB_dcList_currentPos>1)  //arrow up
							Form:C1466.LB_dcList_currentPos:=Form:C1466.LB_dcList_currentPos-1
							Form:C1466.dataclass:=Form:C1466.LB_dcList[Form:C1466.LB_dcList_currentPos-1].name
							LISTBOX SELECT ROW:C912(*;"LB_dcList";Form:C1466.LB_dcList_currentPos;lk replace selection:K53:1)
						Else 
							
					End case 
				End if 
				
			: ($in_o.code=On Losing Focus:K2:8)  //return key
				OPH_mng (New object:C1471("objectName";"LB_dcList";"code";On Clicked:K2:4))
				OBJECT SET VISIBLE:C603(*;"LB_dcList";False:C215)
				Form:C1466.LB_dcList_currentPos:=0
				
			: ($in_o.code=On After Edit:K2:43)  //contenu modifié
				$keystroke:=Keystroke:C390
				$edit:=Get edited text:C655
				$charCode:=Character code:C91(Keystroke:C390)
				GET HIGHLIGHT:C209(*;"dataclass";$start;$end)
				If ($charCode=Backspace key:K12:29)
					$end:=$end-1
				End if 
				Form:C1466.LB:=New collection:C1472()  //raz attributs
				$test:=OPH_mng (New object:C1471("objectName";"dataclassIdentify";"identifier";$edit))
				If ($test.dataclass#Null:C1517)
					Form:C1466.dataclass:=$test.dataclass
					HIGHLIGHT TEXT:C210(*;"dataclass";$end;MAXLONG:K35:2)
				End if 
				
			: ($in_o.code=On Data Change:K2:15)  //fin de saisie, init path
				Form:C1466.pathItems:=New collection:C1472
				Form:C1466.path:=""
				$test:=OPH_mng (New object:C1471("objectName";"dataclassIdentify";"identifier";Form:C1466.dataclass))
				If ($test.dataclass#Null:C1517)
					Form:C1466.dataclass:=$test.dataclass
					HIGHLIGHT TEXT:C210(*;"dataclass";1;MAXLONG:K35:2)
					OPH_mng (New object:C1471("objectName";"dataclassDisplay"))
				Else 
					Form:C1466.LB:=New collection:C1472()
				End if 
		End case 
		
	: ($in_o.objectName="path")
		Case of 
			: ($in_o.code=On Getting Focus:K2:7)
				HIGHLIGHT TEXT:C210(*;"path";1;MAXLONG:K35:2)  //easier for drag'n drop
			: ($in_o.code=On Begin Drag Over:K2:44)
				SET TEXT TO PASTEBOARD:C523(Form:C1466.path)
		End case 
		
	: ($in_o.objectName="pathMenu")  //all levels ⏬
		If (Form:C1466.pathItems.length=0)
			BEEP:C151
		Else 
			$menu:=Form:C1466.pathItems.extract("dataclass").join(";")
			$i:=Pop up menu:C542($menu)
			If ($i>0)
				Form:C1466.dataclass:=Form:C1466.pathItems[$i-1].dataclass
				Form:C1466.pathItems.remove($i-1;Form:C1466.pathItems.length)  //$2 too big: no bug in 19R2
				  //see https://discuss.4d.com/t/the-way-howmany-parameter-works-in-remove/20153/7
				If (Form:C1466.pathItems.length>0)
					Form:C1466.path:=Form:C1466.pathItems.extract("name").join(".")
				Else 
					Form:C1466.path:=""
				End if 
				  //Form.dataclass:=Form.pathItems[Form.pathItems.length-1].dataclass
				OPH_mng (New object:C1471("objectName";"dataclassDisplay"))
				OPH_mng (New object:C1471("objectName";"enterable"))
			End if 
		End if 
		
	: ($in_o.objectName="previous")  //previous level ◀️
		If (Form:C1466.pathItems.length>0)
			Form:C1466.dataclass:=Form:C1466.pathItems[Form:C1466.pathItems.length-1].dataclass
			Form:C1466.pathItems.pop()
			Form:C1466.path:=Form:C1466.pathItems.extract("name").join(".")
			OPH_mng (New object:C1471("objectName";"dataclassDisplay"))
		Else 
			BEEP:C151
			GOTO OBJECT:C206(*;"dataclass")
		End if 
		OPH_mng (New object:C1471("objectName";"enterable"))
		
	: ($in_o.objectName="LB")  //listbox dataclass attributes
		Case of 
			: ($in_o.code=On Clicked:K2:4)
				If (Form:C1466.LB_current#Null:C1517)
					  //delete last item if storage
					$i:=Form:C1466.pathItems.length-1
					If ($i>=0)
						Case of 
							: (Form:C1466.pathItems[$i].kind="storage")
								Form:C1466.pathItems.pop()
							: (Form:C1466.pathItems[$i].name=Form:C1466.LB_current.name)
								BEEP:C151
								Form:C1466.pathItems.pop()
						End case 
					End if 
					If (Form:C1466.LB_current.kind="storage")
						Form:C1466.pathItems.push(New object:C1471("name";Form:C1466.LB_current.name;"dataclass";Form:C1466.dataclass;"kind";Form:C1466.LB_current.kind))
						Form:C1466.path:=Form:C1466.pathItems.extract("name").join(".")
					Else   //related
						Form:C1466.pathItems.push(New object:C1471("name";Form:C1466.LB_current.name;"dataclass";Form:C1466.dataclass;"kind";Form:C1466.LB_current.kind))
						Form:C1466.path:=Form:C1466.pathItems.extract("name").join(".")
						Form:C1466.dataclass:=Form:C1466.LB_current.relatedDataClass
					End if 
					OPH_mng (New object:C1471("objectName";"dataclassDisplay"))
					OPH_mng (New object:C1471("objectName";"enterable"))
				End if 
				LISTBOX SELECT ROW:C912(*;"LB";0;lk remove from selection:K53:3)
		End case 
		
	: ($in_o.objectName="LB_dcList")  //choisir dataclass sélectionnée
		Case of 
			: ($in_o.code=On Clicked:K2:4)
				BEEP:C151
				If (Form:C1466.LB_dcList_current#Null:C1517)
					Form:C1466.dataclass:=Form:C1466.LB_dcList_current.name
					OPH_mng (New object:C1471("objectName";"dataclassDisplay"))
					OBJECT SET VISIBLE:C603(*;"LB_dcList";False:C215)
					Form:C1466.LB_dcList_currentPos:=0
				End if 
		End case 
		
	: ($in_o.objectName="dataclassIdentify")  //trouver la table 
		ASSERT:C1129($in_o.identifier#Null:C1517)
		Form:C1466.LB_dcList:=New collection:C1472()
		If ($in_o.identifier#"")
			Form:C1466.LB_dcList:=Form:C1466.dataclasses.query("name = :1";$in_o.identifier+"@")
		End if 
		If (Form:C1466.LB_dcList.length>0)  //afficher la liste, sélection de la 1ère
			$out_o.dataclass:=Form:C1466.LB_dcList[0].name
			
			OBJECT GET COORDINATES:C663(*;"dataclass";$left_l;$top_l;$right_l;$bottom_l)
			OBJECT SET COORDINATES:C1248(*;"LB_dcList";$left_l;$bottom_l;*)  //; $right_l;$bottom_l)
			OBJECT SET VISIBLE:C603(*;"LB_dcList";True:C214)
			Form:C1466.LB_dcList_currentPos:=1
		Else 
			OBJECT SET VISIBLE:C603(*;"LB_dcList";False:C215)
			Form:C1466.LB_dcList_currentPos:=0
		End if 
		
	: ($in_o.objectName="dataclassDisplay")
		$dc_o:=ds:C1482[Form:C1466.dataclass]
		If (OB Is defined:C1231($dc_o))
			Form:C1466.LB:=New collection:C1472()
			For each ($attribute;$dc_o)
				$o:=New object:C1471
				$o.name:=$dc_o[$attribute].name
				$o.kind:=$dc_o[$attribute].kind
				Case of 
					: ($o.kind="relatedEntity")
						$o.order:=1  //first group
						$o.meta:=New object:C1471("stroke";Form:C1466.colorSet.stroke1)
						$o.relatedDataClass:=$dc_o[$attribute].relatedDataClass
					: ($o.kind="relatedEntities")
						$o.order:=2  //second group
						$o.meta:=New object:C1471("stroke";Form:C1466.colorSet.strokeN)
						$o.relatedDataClass:=$dc_o[$attribute].relatedDataClass
					: ($o.kind="storage")  //last group
						$o.order:=3
						$o.meta:=New object:C1471("stroke";Form:C1466.colorSet.strokeStorage)
						$storage:=Form:C1466.icons.indices("fieldType = :1";$dc_o[$attribute].fieldType)
						If ($storage.length>0)
							$o.relatedDataClass:=Choose:C955(Form:C1466.darkMode;Form:C1466.icons[$storage[0]].iconDark;Form:C1466.icons[$storage[0]].iconLight)
						End if 
					Else 
						TRACE:C157  //ne doit pas se produire
				End case 
				Form:C1466.LB.push($o)
			End for each 
			Form:C1466.LB:=Form:C1466.LB.orderBy("order asc, name asc")
		End if 
		
	: ($in_o.objectName="enterable")
		OBJECT SET ENTERABLE:C238(*;"dataclass";Form:C1466.pathItems.length=0)
		
	: ($in_o.objectName="dataclassesLoad")
		Form:C1466.dataclasses:=New collection:C1472()
		For ($table_l;1;Get last table number:C254)
			If (Is table number valid:C999($table_l))
				Form:C1466.dataclasses.push(New object:C1471("name";Table name:C256($table_l);"num";$table_l))
			End if 
		End for 
		Form:C1466.dataclasses:=Form:C1466.dataclasses.orderBy("name asc")
		
	: ($in_o.objectName="modeSettings")  //mode clair/sombre
		Form:C1466.icons:=xxRes_fieldIcons 
		Form:C1466.darkMode:=OSmac_darkMode 
		If (Windows Alt down:C563)
			Form:C1466.darkMode:=Not:C34(Form:C1466.darkMode)
		End if 
		Form:C1466.colorSet:=New object:C1471
		If (Form:C1466.darkMode)
			Form:C1466.colorSet.stroke:="#dddddd"
			Form:C1466.colorSet.background:="#2F2F2F"
			Form:C1466.colorSet.stroke1:="PaleGreen"
			Form:C1466.colorSet.strokeN:="PowderBlue"
			Form:C1466.colorSet.strokeStorage:="LavenderBlush"
		Else   //light
			Form:C1466.colorSet.stroke:="#222222"
			Form:C1466.colorSet.background:="Gainsboro"
			Form:C1466.colorSet.stroke1:="DarkGreen"
			Form:C1466.colorSet.strokeN:="DarkBlue"
			Form:C1466.colorSet.strokeStorage:="DarkRed"
		End if 
		
End case 

$0:=$out_o
