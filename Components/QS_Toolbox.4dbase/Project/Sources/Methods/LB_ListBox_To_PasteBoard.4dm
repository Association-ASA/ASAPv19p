//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// nom utilisateur (OS) : Association QualiSoft
// date et heure : 15/05/14, 21:00:49
// paramètres
// ----------------------------------------------------
// $1 : Listbox name
// ----------------------------------------------------
// méthode : LB_ListBox_To_PasteBoard

C_TEXT:C284($1; $lbName_t)
C_TEXT:C284($2; $columnSeparator_t)
C_TEXT:C284($3; $rowSeparator_t)
C_TEXT:C284($theData_t; $Cell)

C_LONGINT:C283($i; $numRows_l)
C_LONGINT:C283($j; $numCols_l; $window)
C_BOOLEAN:C305($stop)
C_POINTER:C301($ListBox_Ptr)
C_REAL:C285($Progression)

ARRAY TEXT:C222($colNames_at; 0x0000)
ARRAY TEXT:C222($headerNames_at; 0x0000)
ARRAY POINTER:C280($colVars_ap; 0x0000)
ARRAY POINTER:C280($headerVars_ap; 0x0000)
ARRAY BOOLEAN:C223($colsVisible_ab; 0x0000)
ARRAY POINTER:C280($styles_ap; 0x0000)

// ======================    Initialize and Setup    ================================

ASSERT:C1129(Count parameters:C259=1; "Required 1 parameter as text")
ASSERT:C1129(Type:C295($1)=Is text:K8:3; "$1 should be a text: Listbox name is the attendee.")
$lbName_t:=$1

If (LISTBOX Get number of columns:C831(*; $lbName_t)>0)
	
	//$BarInformation:=THERM_Init ("Copy method list to pasteboard";"";"images/bevels/btn_export.png")
	//Progress SET BUTTON ENABLED ($BarInformation;True)  // affichage du bouton d'arrêt
	//$Progression:=0
	//$stop:=False
	
	// Initialisation
	C_OBJECT:C1216($param)
	$param:=New object:C1471("title"; "Copy method list to pasteboard"; "icon"; "images/icons/btn_attributes.png"; "type"; 0)
	QST_progress_start($param)
	$window:=$param.window
	
	If (Count parameters:C259>1)
		ASSERT:C1129(Count parameters:C259=3; "Required 3 parameter as text")
		ASSERT:C1129(Type:C295($2)=Is text:K8:3; "$2 should be a text.")
		ASSERT:C1129(Type:C295($3)=Is text:K8:3; "$3 should be a text.")
		$columnSeparator_t:=$2
		$rowSeparator_t:=$3
	Else 
		$columnSeparator_t:=Char:C90(Tab:K15:37)
		$rowSeparator_t:=Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40)
	End if 
	
	$ListBox_Ptr:=OBJECT Get pointer:C1124(Object named:K67:5; $lbName_t)  //  now 4D has created a variable for the column and we can get its pointer
	LISTBOX GET ARRAYS:C832(*; $lbName_t; $colNames_at; $headerNames_at; $colVars_ap; $headerVars_ap; $colsVisible_ab; $styles_ap)
	$numRows_l:=Size of array:C274($colVars_ap{1}->)
	$numCols_l:=Size of array:C274($colNames_at)
	
	$theData_t:=""
	
	// For Progress toolbar
	Case of 
			
		: ($numRows_l>100000)
			$step:=400
			
		: ($numRows_l>10000)
			$step:=200
			
		: ($numRows_l>1000)
			$step:=50
			
		Else 
			
			$step:=25
			
	End case 
	
	// ========================    Method Actions    ==================================
	$Max:=$numCols_l*$numRows_l
	$pas:=1/($Max+1)
	
	If (Find in array:C230($ListBox_Ptr->; True:C214)=-1)  // Nothing is selected in particulary
		For ($i; 1; $numRows_l)
			$ListBox_Ptr->{$i}:=True:C214
		End for 
	End if 
	
	// set the headers
	For ($i; 1; $numCols_l)
		$theData_t:=$theData_t+OBJECT Get title:C1068(*; $headerNames_at{$i})+$columnSeparator_t
	End for 
	
	$theData_t:=$theData_t+$rowSeparator_t
	
	// set data
	For ($i; 1; $numRows_l)
		
		If ($ListBox_Ptr->{$i}=True:C214)
			
			For ($j; 1; $numCols_l)
				
				//If (Not(Progress Stopped ($BarInformation)))
				
				$Progression:=$Progression+$pas
				
				If ($j#1)
					$theData_t:=$theData_t+$columnSeparator_t
				End if 
				
				If ((Type:C295($colVars_ap{$j}->{$i})=Is BLOB:K8:12) | (Type:C295($colVars_ap{$j}->{$i})=Is picture:K8:10) | (Type:C295($colVars_ap{$j}->{$i})=Is pointer:K8:14))
					$cell:="Unsupported data type"
				Else 
					$Cell:=String:C10($colVars_ap{$j}->{$i})
				End if 
				
				$Cell:=Replace string:C233($Cell; Char:C90(Carriage return:K15:38)+Char:C90(Line feed:K15:40); " - ")
				$Cell:=Replace string:C233($Cell; Char:C90(Carriage return:K15:38); " - ")
				$Cell:=Replace string:C233($Cell; Char:C90(Tab:K15:37); " -> ")
				
				$theData_t:=$theData_t+$Cell
				
				//Else 
				
				//$j:=$numCols_l+1
				//$stop:=True
				
				//End if 
			End for 
			
			If ($i%$step=0)
				//Progress SET PROGRESS ($BarInformation;$Progression;"line #"+String($i);True)
				$param.value:=$i
				CALL FORM:C1391($window; "progressBar_update"; $param)
			End if 
			
			If ($i<$numRows_l)
				$theData_t:=$theData_t+$rowSeparator_t
			End if 
			
		End if 
		
	End for 
	
	// ========================    Clean up and Exit    =================================
	
	If (Not:C34($stop))
		SET TEXT TO PASTEBOARD:C523($theData_t)
	End if 
	
	//Progress QUIT ($BarInformation)
	KILL WORKER:C1390("QST_Progress")
	
Else 
	
	ALERT:C41("Nothing to copy.")
End if 