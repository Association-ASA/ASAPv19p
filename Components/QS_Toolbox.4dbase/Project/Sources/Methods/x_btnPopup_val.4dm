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
  // ${5} <PTR> : tableaux label | nombre de valeurs
  // ${6} <TXT> : text for idle item on last state

  // $0 : vrai si Write

C_LONGINT:C283($evt;$1)
C_POINTER:C301($ptrField;$2;$ptrBtn;$3;$ptrT_labels;$5)
C_TEXT:C284($strIcons;$4)

$evt:=$1
$ptrField:=$2
$ptrBtn:=$3

If (Count parameters:C259>=5)
	$strIcons:=$4
	$ptrT_labels:=$5
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
				$ptrT_labels:=$5
				$value:=Size of array:C274($ptrT_labels->)
			Else 
				$value:=$ptrField->
			End if 
			
		Else 
			
			If ($isNilField)
				$value:=0
			Else 
				$value:=$ptrField->
			End if 
		End if 
		
		If (Not:C34($isNilBtn))
			x_btn_toggleSet ($ptrBtn;$value)
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
					$value:=x_btn_toggleRead ($ptrBtn)
				Else 
					$value:=0
				End if 
				
				  //: ($isField)
				  //$table:=Table(Table($ptrField))
				  //$isModif:=x_isTableUnlocked($table)
				  //$value:=$ptrField->
				
			: ($isNilBtn)
				$value:=$ptrField->
				
			Else 
				If ($ptrField-><0)
					$value:=-1
				Else 
					$value:=x_btn_toggleRead ($ptrBtn)
				End if 
		End case 
		
		  //If (Not($isOk))
		  //BEEP
		  //x__btn_toggleSet ($ptrBtn;$ptrField->)
		  //Else 
		
		C_TEXT:C284($refMenu)
		C_LONGINT:C283($i;$start;$tt)
		C_TEXT:C284($label)
		C_BOOLEAN:C305($isArray)
		$isArray:=(Type:C295($ptrT_labels->)=Text array:K8:16)
		$start:=0
		If ($isArray)
			If ($ptrT_labels->{0}="")
				$start:=1
				  //$ptrT_labels->{0}:="Choose an action..."
			End if 
			If ($isIdleItem)
				ARRAY TEXT:C222($T_labels;0)
				COPY ARRAY:C226($ptrT_labels->;$T_labels)
				APPEND TO ARRAY:C911($T_labels;$idleItemTxt)
				$ptrT_labels:=->$T_labels
			End if 
			$tt:=Size of array:C274($ptrT_labels->)
		Else 
			$tt:=$ptrT_labels->+Num:C11($isIdleItem)
		End if 
		
		$refMenu:=Create menu:C408
		For ($i;$start;$tt)
			$idx:=$i-1
			If ($i=0)
				$label:=""
				If ($isArray)
					$label:=$ptrT_labels->{$i}
				End if 
				If ($label="")
					$label:=Get localized string:C991("menu_choose")
				End if 
			Else 
				If ($isArray)
					$label:=$ptrT_labels->{$i}
				Else 
					$label:=""
				End if 
			End if 
			$label:=$label+(" "*Num:C11(Length:C16($label)=0))  // Espace si vide
			APPEND MENU ITEM:C411($refMenu;$label;*)
			SET MENU ITEM PARAMETER:C1004($refMenu;-1;String:C10($idx))
			SET MENU ITEM ICON:C984($refMenu;-1;$cheminPictos+String:C10($idx)+".png")
			If ($i=0)
				SET MENU ITEM ICON:C984($refMenu;-1;$cheminPictos01)
				DISABLE MENU ITEM:C150($refMenu;-1)
			Else 
				If ($idx=$value)
					SET MENU ITEM MARK:C208($refMenu;-1;Char:C90(18))
				End if 
			End if 
		End for 
		
		C_TEXT:C284($answerMenu)
		$answerMenu:=Dynamic pop up menu:C1006($refMenu)
		RELEASE MENU:C978($refMenu)
		C_LONGINT:C283($value;$idx)
		$isOk:=(""#$answerMenu)
		If ($isOk)
			$idx:=Num:C11($answerMenu)
			$isOk:=($idx>=0) & ($value#$idx)
			If ($isOk)
				If ($isModif)
					If (Not:C34($isNilField))
						$ptrField->:=$idx
					End if 
					If (Not:C34($isNilBtn))
						x_btn_toggleSet ($ptrBtn;$idx)
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



