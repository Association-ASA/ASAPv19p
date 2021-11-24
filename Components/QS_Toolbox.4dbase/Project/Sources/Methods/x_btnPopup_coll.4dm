//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Olivier GRIMBERT
  // Date et heure : 15/04/16, 11:27:17
  // ----------------------------------------------------
  // Méthode : ogX_imgPopup_val
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
  // Entrée $1 : evenement formulaire
  // $2 <PTR> : champ/var valeur num | possible sur nil !
  // $3 <PTR> : bouton image
  // ${4} <STR> : nom icons
  // ${5} <COL> : Collection "label", "menu", "is_valid"
  // ${6} <TXT> : text for idle item on last state

  // $0 : vrai si Write

C_LONGINT:C283($evt;$1)
C_POINTER:C301($ptrField;$2;$ptrBtn;$3)
C_COLLECTION:C1488($menu_coll;$5)
C_TEXT:C284($strIcons;$4)
C_OBJECT:C1216($ent)

$evt:=$1
$ptrField:=$2
$ptrBtn:=$3

If (Count parameters:C259>=5)
	$strIcons:=$4
	$menu_coll:=$5
End if 

C_BOOLEAN:C305($isIdleItem)
C_TEXT:C284($idleItemTxt)
$isIdleItem:=(Count parameters:C259>=6)
If ($isIdleItem)
	$idleItemTxt:=$6
End if 


C_BOOLEAN:C305($isOk;$isNilField;$isNilBtn;$isModif)
$isOk:=False:C215
$isNilField:=Is nil pointer:C315($ptrField)
$isNilBtn:=Is nil pointer:C315($ptrBtn)

Case of 
	: ($evt=On Load:K2:1)
		
		If ($isIdleItem)
			If ($isNilField)
				  //$value:=Size of array($menu_coll->)
				$value_menu:=$menu_coll.length()
			Else 
				$value_menu:=$ptrField->
			End if 
			
		Else 
			
			If ($isNilField)
				$value_menu:=""
			Else 
				$value_menu:=$ptrField->
			End if 
		End if 
		
		If (Not:C34($isNilBtn))
			x_btn_toggleSetTxt ($ptrBtn;$value_menu)
		End if 
		
		
	: ($evt=On Clicked:K2:4)
		
		C_TEXT:C284($cheminPictos;$cheminPictos01)
		$cheminPictos:="file:"+$strIcons
		$cheminPictos01:="file:images/icons/icn_magik_info.png"
		
		C_BOOLEAN:C305($isField)
		$isField:=Not:C34(Is a variable:C294($ptrField))
		$isModif:=True:C214
		Case of 
			: ($isNilField)
				If (Not:C34($isNilBtn))
					$value_menu:=x_btn_toggleReadTxt ($ptrBtn)
				Else 
					$value_menu:=""
				End if 
				
			: ($isNilBtn)
				$value_menu:=$ptrField->
			Else 
				If ($ptrField->="")
					$value_menu:=""
				Else 
					$value_menu:=x_btn_toggleReadTxt ($ptrBtn)
				End if 
		End case 
		
		C_TEXT:C284($refMenu)
		C_LONGINT:C283($i;$start;$tt)
		C_TEXT:C284($label)
		$start:=0
		ARRAY TEXT:C222($T_labels;0)
		COLLECTION TO ARRAY:C1562($menu_coll;$T_labels;"label")
		If ($isIdleItem)
			APPEND TO ARRAY:C911($T_labels;$idleItemTxt)
		End if 
		$T_labels{0}:="Select an action/option..."
		
		ARRAY TEXT:C222($T_menus;0)
		COLLECTION TO ARRAY:C1562($menu_coll;$T_menus;"menu")
		
		ARRAY BOOLEAN:C223($T_isValid;0)
		For each ($ent;$menu_coll)
			$is_valid:=Not:C34(OB Is defined:C1231($ent;"isValid"))
			If (Not:C34($is_valid))
				$is_valid:=$ent.isValid
			End if 
			APPEND TO ARRAY:C911($T_isValid;$is_valid)
		End for each 
		
		$tt:=Size of array:C274($T_labels)
		$refMenu:=Create menu:C408
		For ($i;$start;$tt)
			$idx:=$i-1
			If ($i=0)
				$label:=""
				$label:=$T_labels{$i}
				If ($label="")
					$label:=Get localized string:C991("menu_choose")
				End if 
			Else 
				$label:=$T_labels{$i}
				$menu:=$T_menus{$i}
				$is_valid:=$T_isValid{$i}
				$is_separator:=($menu="")
			End if 
			$label:=$label+(" "*Num:C11(Length:C16($label)=0))  // Espace si vide
			APPEND MENU ITEM:C411($refMenu;$label;*)
			
			If ($i=0)
				SET MENU ITEM ICON:C984($refMenu;-1;$cheminPictos01)
				  //DISABLE MENU ITEM($refMenu;-1)
			Else 
				If ($is_separator)
					DISABLE MENU ITEM:C150($refMenu;-1)
				Else 
					SET MENU ITEM PARAMETER:C1004($refMenu;-1;$menu)
					SET MENU ITEM ICON:C984($refMenu;-1;$cheminPictos+$menu+".png")
					If ($value_menu=$menu)
						SET MENU ITEM MARK:C208($refMenu;-1;Char:C90(18))
					End if 
					If (Not:C34($is_valid))
						DISABLE MENU ITEM:C150($refMenu;-1)
					End if 
				End if 
			End if 
		End for 
		
		C_TEXT:C284($answerMenu)
		$answerMenu:=Dynamic pop up menu:C1006($refMenu)
		RELEASE MENU:C978($refMenu)
		$isOk:=(""#$answerMenu)
		If ($isOk)
			$isOk:=($value_menu#$answerMenu)
			If ($isOk)
				If ($isModif)
					If (Not:C34($isNilField))
						$ptrField->:=$answerMenu
					End if 
					If (Not:C34($isNilBtn))
						x_btn_toggleSetTxt ($ptrBtn;$answerMenu)
					End if 
				Else 
					$isOk:=False:C215
					BEEP:C151
				End if 
			End if 
		End if 
		  //End if 
		
End case 
$0:=$isOk



