//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 21/09/14, 21:04:40
// ----------------------------------------------------
// méthode : FE_GetObjectDetails
// description
// NOTE UPDATE: cf command "FORM Convert to dynamic" for next version ==>   >17R3
//
// paramètres
// ----------------------------------------------------

// OBJECT GET SCROLL POSITION --> Not needed for introspection
// OBJECT GET SUBFORM CONTAINER SIZE-->Not needed for introspection
// OBJECT Get three states checkbox --> Not needed for introspection

#DECLARE($formDetail : Object; $Objet : Text)->$myColl : Collection

var $subFormDetail; $subFormListe : Text
var $horizontal; $modifier; $typeObject; $vertical; $vlNumChamp; $vlNumTable : Integer
var $ptr : Pointer
var $déposable; $déposableAuto; $glissable; $glissableAuto; $hor; $Ver : Boolean
ARRAY TEXT:C222($tbProperties; 0x0000)
ARRAY TEXT:C222($tbPropertiesValue; 0x0000)
ARRAY LONGINT:C221($tabEvenement; 0x0000)

$myColl:=New collection:C1472
$type:=FORM_LH_getDataSource($formDetail; $Objet)
If ($type="")  // May we can get it by the old way
	$type:=Object_GetType($objet)
End if 

$ptr:=OBJECT Get data source:C1265(*; $objet)
RESOLVE POINTER:C394($ptr; $vaNomVar; $vlNumTable; $vlNumChamp)
QS_pushPropertiesValue($myColl; "Data source (Variable Name)"; $vaNomVar)

$typeObject:=-1
$ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $Objet)
Case of 
	: ((Not:C34(Is nil pointer:C315($ptr))) & ($type#"subform"))
		$typeObject:=Type:C295(($ptr)->)
		
	: ($type="subform")
		$typeObject:=39
		
End case 

QS_pushPropertiesValue($myColl; "Title"; String:C10(OBJECT Get title:C1068(*; $objet)))

OBJECT GET COORDINATES:C663(*; $objet; $gauche; $haut; $droite; $bas)
$chaine:=String:C10($gauche)+" / "+String:C10($droite)+" / "+String:C10($haut)+" / "+String:C10($bas)
QS_pushPropertiesValue($myColl; "Coordinates: Left / Right / Top / Bottom"; $chaine)

$list:="static text,button,text input,group,checkbox,subform"
If (Position:C15($type; $list)>0)
	OBJECT GET BEST SIZE:C717(*; $objet; $horizontal; $vertical)
	$chaine:=String:C10($horizontal)+" / "+String:C10($vertical)
	QS_pushPropertiesValue($myColl; "Object Best Size: Width / Height"; $chaine)
End if 

If (OBJECT Get list reference:C1267(*; $objet)>0)
	QS_pushPropertiesValue($myColl; "List Reference"; String:C10(OBJECT Get list reference:C1267(*; $objet)))
End if 

If (OBJECT Get list name:C1072(*; $objet; $modifier)#"")
	QS_pushPropertiesValue($myColl; "Enumeration name -> list"; OBJECT Get list name:C1072(*; $objet))
	$chaine:=Choose:C955($modifier; "Choice list"; "Excluded list"; "Required list")
	QS_pushPropertiesValue($myColl; "List type"; $chaine)
End if 

$hor:=OBJECT Get enterable:C1067(*; $objet)
QS_pushPropertiesValue($myColl; "Enterable"; String:C10($hor))

OBJECT GET RESIZING OPTIONS:C1176(*; $objet; $horizontal; $vertical)
$list:=Choose:C955($horizontal; "None"; "Grow"; "Move")+" / "+Choose:C955($vertical; "None"; "Grow"; "Move")
QS_pushPropertiesValue($myColl; "Resize: Horizontal / Vertical"; $list)

OBJECT GET SCROLLBAR:C1076(*; $objet; $horizontal; $vertical)
$list:=Choose:C955($horizontal; "Hidden"; "Visible"; "Automatic")+" / "+Choose:C955($vertical; "Hidden"; "Visible"; "Automatic")
QS_pushPropertiesValue($myColl; "Scrollbar: Horizontal / Vertical"; $list)

QS_pushPropertiesValue($myColl; "Standard Action"; Object_GetAction($objet))

$list:="button,default button,3D button, invisible button,highlight button,radio button,3D radio button,"+\
"picture button,checkbox,3D checkbox,hierarchical popup,popup dropdown list,Combobox,ruler"
If (Position:C15($type; $list)>0)
	QS_pushPropertiesValue($myColl; "Enabled"; String:C10(OBJECT Get enabled:C1079(*; $objet)))
End if 

$list:="Combobox,static text,groupbox,hierarchical popup,popup dropdown list,field,Listbox,button"
If (Position:C15($type; $list)>0)
	$list:=Choose:C955(OBJECT Get horizontal alignment:C707(*; $objet); "Align default"; "Align left"; "Align center"; "Align right"; "wk justify")+" / "
	$list:=$list+Choose:C955(OBJECT Get vertical alignment:C1188(*; $objet); ""; "Align top"; "Align center"; "Align bottom")
	QS_pushPropertiesValue($myColl; "Alignement: Horizontal / Vertical"; $list)
End if 

$list:="text,picture,Listbox,hierarchical popup,subform"
If (Position:C15($type; $list)>0)
	C_BOOLEAN:C305($hor)
	OBJECT GET SCROLLBAR:C1076(*; $objet; $horizontal; $vertical)
	$list:=Choose:C955($horizontal; "Hidden"; "Visible"; "Automatic")+" / "
	$list:=$list+Choose:C955($vertical; "Hidden"; "Visible"; "Automatic")
	QS_pushPropertiesValue($myColl; "Scrollbar: Horizontal / Vertical"; $list)
End if 

$list:="Checkbox"
If (Position:C15($type; $list)>0)
	$hor:=OBJECT Get three states checkbox:C1250(*; $objet)
	QS_pushPropertiesValue($myColl; "State checkbox"; String:C10($hor))
End if 

$list:=OBJECT Get keyboard layout:C1180(*; $objet)
QS_pushPropertiesValue($myColl; "Keyboard layout"; Choose:C955($list#""; $list; "No configure"))

OBJECT GET SHORTCUT:C1186(*; $objet; $caractere; $modifier)
$result:=$modifier/256
Case of 
		
	: ($result=0)
		$list:="None"
		
	: ($result=1)
		$list:="Command/CTRL key mask"
		
	: ($result=2)
		$list:="Shift key mask"
		
	: ($result=3)
		$list:="CTRL/Command + Shift keys mask"
		
	: ($result=8)
		$list:="ALT/Option key mask"
		
	: ($result=9)
		$list:="ALT/Option + CTRL/Commande keys mask"
		
	: ($result=10)
		$list:="ALT/Option + Shift keys mask"
		
	: ($result=16)
		$list:="Control key mask (mac)"
		
	: ($result=17)
		$list:="Control (mac) + CTRL/Commande keys mask"
		
	: ($result=18)
		$list:="Control (mac) + Shift keys mask"
		
	: ($result=24)
		$list:="Control (mac) + ALT/Option keys mask"
		
End case 

If ($caractere#"")
	$list:=$list+" - "+$caractere
End if 

QS_pushPropertiesValue($myColl; "Keyboard shortcut"; $list)
QS_pushPropertiesValue($myColl; "Spellcheck"; String:C10(OBJECT Get auto spellcheck:C1174(*; $objet)))


If (OBJECT Get filter:C1073(*; $objet)#"")
	QS_pushPropertiesValue($myColl; "Filter"; OBJECT Get filter:C1073(*; $objet))
End if 

// The OBJECT Get format command returns the current display format applied to the object specified in the object parameter.
If (OBJECT Get format:C894(*; $objet)#"")
	QS_pushPropertiesValue($myColl; "Format"; String:C10(OBJECT Get format:C894(*; $objet)))
End if 

QS_pushPropertiesValue($myColl; "Context menu activated"; String:C10(OBJECT Get context menu:C1252(*; $objet)))

If (OBJECT Get help tip:C1182(*; $objet)#"")
	QS_pushPropertiesValue($myColl; "Help tip"; OBJECT Get help tip:C1182(*; $objet))
End if 

If (OBJECT Get placeholder:C1296(*; $objet)#"")
	QS_pushPropertiesValue($myColl; "Placeholder"; OBJECT Get placeholder:C1296(*; $objet))
End if 

OBJECT GET DRAG AND DROP OPTIONS:C1184(*; $objet; $glissable; $glissableAuto; $déposable; $déposableAuto)
QS_pushPropertiesValue($myColl; "Draggable"; String:C10($glissable))
QS_pushPropertiesValue($myColl; "Automatic Drag"; String:C10($glissableAuto))
QS_pushPropertiesValue($myColl; "Droppable"; String:C10($déposable))
QS_pushPropertiesValue($myColl; "Automatic Drop"; String:C10($déposableAuto))

$hor:=OBJECT Is styled text:C1261(*; $objet)
If ($hor)
	QS_pushPropertiesValue($myColl; "Is styled text"; String:C10($hor))
End if 

QS_pushPropertiesValue($myColl; "Style sheet"; OBJECT Get style sheet:C1258(*; $objet))

$list:="static picture,write pro area,view pro area"
If (Position:C15($type; $list)=0)
	QS_pushPropertiesValue($myColl; "Font name"; OBJECT Get font:C1069(*; $objet))
	QS_pushPropertiesValue($myColl; "Font size"; String:C10(OBJECT Get font size:C1070(*; $objet)))
	QS_pushPropertiesValue($myColl; "Font style"; BASE_GetPoliceStyle(OBJECT Get font style:C1071(*; $objet)))
	
	$Num:=OBJECT Get text orientation:C1283(*; $objet)
	$list:="Orientation "+String:C10($num)+"°"
	QS_pushPropertiesValue($myColl; "Text orientation"; $list)
	
	$modifier:=OBJECT Get multiline:C1254(*; $objet)
	$list:=Choose:C955($modifier; "Automatic"; "No"; "Yes")
	QS_pushPropertiesValue($myColl; "Multilines"; $list)
	
	$hor:=OBJECT Get focus rectangle invisible:C1178(*; $objet)
	QS_pushPropertiesValue($myColl; "Focus rectangle invisible"; String:C10($hor))
End if 

QS_pushPropertiesValue($myColl; "Border style"; Object_GetBordureType(OBJECT Get border style:C1263(*; $objet)))

OBJECT GET PRINT VARIABLE FRAME:C1241(*; $objet; $hor)
QS_pushPropertiesValue($myColl; "Print variable frame"; String:C10($hor))
QS_pushPropertiesValue($myColl; "Visible"; String:C10(OBJECT Get visible:C1075(*; $objet)))

$hor:=OBJECT Get context menu:C1252(*; $objet)
QS_pushPropertiesValue($myColl; "Context menu"; String:C10($hor))

$list:="rounded rectangle"
If (Position:C15($type; $list)>0)
	QS_pushPropertiesValue($myColl; "Corner radius"; String:C10(OBJECT Get corner radius:C1324(*; $objet)))
End if 

$list:="ruler"
If (Position:C15($type; $list)>0)
	QS_pushPropertiesValue($myColl; "Indicator type"; Choose:C955(OBJECT Get indicator type:C1247(*; $objet); ""; "Progress bar"; "Barber shop"; "Asynchronous progress bar"))
End if 

If ($typeObject#-1)
	Case of 
		: ($typeObject=Is date:K8:7)
			C_DATE:C307($aDate)
			OBJECT GET MAXIMUM VALUE:C1245(*; $objet; $aDate)
			QS_pushPropertiesValue($myColl; "Maximum value"; String:C10($aDate))
			
			OBJECT GET MINIMUM VALUE:C1243(*; $objet; $aDate)
			QS_pushPropertiesValue($myColl; "Minimum value"; String:C10($aDate))
			
		: ($typeObject=Is time:K8:8)
			C_TIME:C306($aTime)
			OBJECT GET MAXIMUM VALUE:C1245(*; $objet; $aTime)
			QS_pushPropertiesValue($myColl; "Maximum value"; String:C10($aTime))
			
			OBJECT GET MINIMUM VALUE:C1243(*; $objet; $aTime)
			QS_pushPropertiesValue($myColl; "Minimum value"; String:C10($aTime))
			
		: (($typeObject=Is picture:K8:10) | ($typeObject=Is object:K8:27) | ($typeObject=Is undefined:K8:13))
			
			// DO nothing
			
		Else 
			
			OBJECT GET MAXIMUM VALUE:C1245(*; $objet; $horizontal)
			QS_pushPropertiesValue($myColl; "Maximum value"; String:C10($horizontal))
			
			OBJECT GET MINIMUM VALUE:C1243(*; $objet; $horizontal)
			QS_pushPropertiesValue($myColl; "Minimum value"; String:C10($horizontal))
	End case 
	
End if 

OBJECT GET RGB COLORS:C1074(*; $objet; $modifier; $horizontal; $vertical)
QS_pushPropertiesValue($myColl; "Foreground color"; String:C10($modifier))
QS_pushPropertiesValue($myColl; "Background color"; String:C10($horizontal))
QS_pushPropertiesValue($myColl; "Background color alternative"; String:C10($vertical))

$list:="Subform"
If (Position:C15($type; $list)>0)
	OBJECT GET SUBFORM:C1139(*; $Objet; $ptr; $subFormDetail; $subFormListe)
	QS_pushPropertiesValue($myColl; "SubForm table"; Str_GetTableOrProjectForm(Table:C252($ptr)))
	QS_pushPropertiesValue($myColl; "SubForm detail"; Choose:C955($subFormDetail#""; $subFormDetail; "N/A"))
	QS_pushPropertiesValue($myColl; "SubForm list"; Choose:C955($subFormListe#""; $subFormListe; "N/A"))
	
	OBJECT GET PRINT VARIABLE FRAME:C1241(*; $objet; $hor; $modifier)
	QS_pushPropertiesValue($myColl; "Print variable frame"; String:C10($hor))
	QS_pushPropertiesValue($myColl; "Subform print frame option"; Choose:C955($modifier; "Print Frame fixed with multiple records"; "Print Frame fixed with truncation"))
End if 

$list:="listbox"
If (Position:C15($type; $list)>0)
	QS_pushPropertiesValue($myColl; "Listbox header heigh"; String:C10(LISTBOX Get headers height:C1144(*; $Objet; lk pixels:K53:22))+" px")
	QS_pushPropertiesValue($myColl; "Listbox footer height"; String:C10(LISTBOX Get footers height:C1146(*; $Objet; lk pixels:K53:22))+" px")
	QS_pushPropertiesValue($myColl; "Listbox hor scrollbar height"; String:C10(LISTBOX Get property:C917(*; $Objet; lk hor scrollbar height:K53:7)))
	QS_pushPropertiesValue($myColl; "Listbox ver scrollbar width"; String:C10(LISTBOX Get property:C917(*; $Objet; lk ver scrollbar width:K53:9)))
	QS_pushPropertiesValue($myColl; "Listbox display header"; Choose:C955(LISTBOX Get property:C917(*; $Objet; lk display header:K53:4); "Hidden"; "Shown"))
	QS_pushPropertiesValue($myColl; "Listbox display footer"; Choose:C955(LISTBOX Get property:C917(*; $Objet; lk display footer:K53:20); "Hidden"; "Shown"))
	QS_pushPropertiesValue($myColl; "Listbox display hor scrollbar"; Choose:C955(LISTBOX Get property:C917(*; $Objet; _o_lk display hor scrollbar:K53:6); "Hidden"; "Shown"))
	QS_pushPropertiesValue($myColl; "Listbox display ver scrollbar"; Choose:C955(LISTBOX Get property:C917(*; $Objet; _o_lk display ver scrollbar:K53:8); "Hidden"; "Shown"))
	QS_pushPropertiesValue($myColl; "Detail form name"; LISTBOX Get property:C917(*; $Objet; 19))
	QS_pushPropertiesValue($myColl; "Named selection"; LISTBOX Get property:C917(*; $Objet; 28))
	
	$x:=LISTBOX Get property:C917(*; $Objet; 10)
	Case of 
		: ($x=0)
			$txt:="None"
		: ($x=1)
			$txt:="Single"
		: ($x=2)
			$txt:="Multiple"
	End case 
	QS_pushPropertiesValue($myColl; "Listbox selection mode"; $txt)
	
	QS_pushPropertiesValue($myColl; "Single click edit"; Choose:C955(LISTBOX Get property:C917(*; $Objet; lk single click edit:K53:70); "No"; "Yes"))
	QS_pushPropertiesValue($myColl; "Sortablet"; Choose:C955(LISTBOX Get property:C917(*; $Objet; lk sortable:K53:45); "No"; "Yes"))
	QS_pushPropertiesValue($myColl; "Truncate"; Choose:C955(LISTBOX Get property:C917(*; $Objet; lk truncate:K53:37); "Without ellipsis"; "With ellipsis"))
	QS_pushPropertiesValue($myColl; "Listbox resizing mode"; Choose:C955(LISTBOX Get property:C917(*; $Objet; lk resizing mode:K53:36); "Manual"; "Automatic"))
	QS_pushPropertiesValue($myColl; "Listbox header height"; String:C10(LISTBOX Get headers height:C1144(*; $Objet; lk pixels:K53:22))+" px")
	QS_pushPropertiesValue($myColl; "Listbox footer height"; String:C10(LISTBOX Get footers height:C1146(*; $Objet; lk pixels:K53:22))+" px")
	QS_pushPropertiesValue($myColl; "Listbox row height unit"; Choose:C955(LISTBOX Get property:C917(*; $Objet; lk display header:K53:4); "Pixel"; "Line"))
	QS_pushPropertiesValue($myColl; "Listbox hor scrollbar height"; String:C10(LISTBOX Get property:C917(*; $Objet; lk hor scrollbar height:K53:7))+" px")
	QS_pushPropertiesValue($myColl; "Listbox ver scrollbar width"; String:C10(LISTBOX Get property:C917(*; $Objet; lk ver scrollbar width:K53:9))+" px")
	QS_pushPropertiesValue($myColl; "Listbox display header"; Choose:C955(LISTBOX Get property:C917(*; $Objet; lk display header:K53:4); "Hidden"; "Shown"))
	QS_pushPropertiesValue($myColl; "Listbox display footer"; Choose:C955(LISTBOX Get property:C917(*; $Objet; lk display footer:K53:20); "Hidden"; "Shown"))
	
	OBJECT GET SCROLLBAR:C1076(*; $Objet; $Hor; $Ver)
	QS_pushPropertiesValue($myColl; "Listbox display hor scrollbar"; String:C10($hor))
	QS_pushPropertiesValue($myColl; "Listbox display ver scrollbar"; String:C10($Ver))
	
	QS_pushPropertiesValue($myColl; "background color expression"; String:C10(LISTBOX Get property:C917(*; $Objet; lk background color expression:K53:47)))  // lk background color expression
	QS_pushPropertiesValue($myColl; "double click on row"; String:C10(LISTBOX Get property:C917(*; $Objet; lk double click on row:K53:43)))  // lk double click on row
	QS_pushPropertiesValue($myColl; "Hide extra blank rows"; Choose:C955(LISTBOX Get property:C917(*; $Objet; lk extra rows:K53:38); "Display"; "Hide"))  // lk extra rows
	QS_pushPropertiesValue($myColl; "Font color expression"; LISTBOX Get property:C917(*; $Objet; lk font color expression:K53:48))
	QS_pushPropertiesValue($myColl; "Font style expression"; LISTBOX Get property:C917(*; $Objet; lk font style expression:K53:49))
	QS_pushPropertiesValue($myColl; "Hide selection highlight"; Choose:C955(LISTBOX Get property:C917(*; $Objet; lk hide selection highlight:K53:41); "No"; "Yes"))
	QS_pushPropertiesValue($myColl; "Hilghlight set"; String:C10(LISTBOX Get property:C917(*; $Objet; lk highlight set:K53:66)))
	
	// -----------
	//  Apply to: Column
	// -----------
	QS_pushPropertiesValue($myColl; "Allow wordwrap"; Choose:C955(LISTBOX Get property:C917(*; $Objet; lk allow wordwrap:K53:39); "no"; "yes"))
	QS_pushPropertiesValue($myColl; "Column min width"; String:C10(LISTBOX Get property:C917(*; $Objet; lk column min width:K53:50)))
	QS_pushPropertiesValue($myColl; "Column max width"; String:C10(LISTBOX Get property:C917(*; $Objet; lk column max width:K53:51)))
	QS_pushPropertiesValue($myColl; "Column resizable"; String:C10(LISTBOX Get property:C917(*; $Objet; lk column resizable:K53:40)))
	
	Case of 
		: (($typeObject=Is longint:K8:6) | ($typeObject=Is boolean:K8:9) | ($typeObject=Is date:K8:7) | ($typeObject=Is time:K8:8) | ($typeObject=Is real:K8:4) | \
			($typeObject=_o_Is float:K8:26) | ($typeObject=Is integer:K8:5) | ($typeObject=Is integer 64 bits:K8:25))
			QS_pushPropertiesValue($myColl; "Display type"; Choose:C955(LISTBOX Get property:C917(*; $Objet; lk display type:K53:46); "Numeric format"; "As three-state checkboxes"))
	End case 
	
	QS_pushPropertiesValue($myColl; "Multi style"; Choose:C955(LISTBOX Get property:C917(*; $Objet; lk multi style:K53:71); "No"; "Yes"))  // lk multi style
	
	// Require 4D View
	If (Is license available:C714(4D View license:K44:4))
		QS_pushPropertiesValue($myColl; "4D View Pro properties"; "")
		QS_pushPropertiesValue($myColl; "auto row height"; String:C10(LISTBOX Get property:C917(*; $Objet; 31)))  // lk auto row height
	End if 
	
End if 

OBJECT GET EVENTS:C1238(*; $objet; $tabEvenement)

If (Size of array:C274($tabEvenement)>0)
	For ($a; 1; Size of array:C274($tabEvenement))
		QS_pushPropertiesValue($myColl; "Event #"+String:C10($a); Konstant_getName(2; $tabEvenement{$a}))
	End for 
End if 
