//%attributes = {}
  //Mnu_LoadFromFile (barreID_t;chemin_t) ->txt
  //Description
  //charge une barre de menu décrite en fichier.xml chemin_t
  //retourne la ref du menu créé à utiliser avec Mnu_release
  //© Vincent de Lachaux * 04/02/09
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_TEXT:C284($Dom_menuBar;$Dom_root;$refMenu_t;$Txt_ID;$Txt_path)

If (False:C215)
	C_TEXT:C284(Mnu_LoadFromFile ;$0)
	C_TEXT:C284(Mnu_LoadFromFile ;$1)
	C_TEXT:C284(Mnu_LoadFromFile ;$2)
End if 
  //_
$refMenu_t:=Create menu:C408
$Txt_ID:=$1
If (Count parameters:C259>=2)
	$Txt_path:=$2
Else 
	$Txt_path:=Get 4D folder:C485(Current resources folder:K5:16)+"menus.xml"
End if 

If (Asserted:C1132(Test path name:C476($Txt_path)=Is a document:K24:1;Current method name:C684+" document non trouvé "+$Txt_path))
	$Dom_root:=DOM Parse XML source:C719($Txt_path)
	If (OK=1)
		$Dom_menuBar:=DOM Find XML element by ID:C1010($Dom_root;$Txt_ID)
		If (OK=1)
			Mnu_Load ($refMenu_t;$Dom_menuBar)
		Else 
			TRACE:C157
		End if 
		DOM CLOSE XML:C722($Dom_root)
	Else 
		TRACE:C157
	End if 
End if 

$0:=$refMenu_t
  //_

