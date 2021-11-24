//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 09/06/18, 08:58:32
  // ----------------------------------------------------
  // Paramètres
  // $1 (POINTER) - Pointer to an array to list the blank fonts assigned
  // $2 (POINTER) - Pointer to an array to list the page in the form
  // ----------------------------------------------------
  // Méthode : UTIL_FindObjectWithNoFont
  // Description: Method will add retrieve the objects in a form that
  // have blank fonts assigned in the properties
  //

  // Sample:
  //ARRAY TEXT(arrObjNoFont;0)
  //ARRAY LONGINT(arrObjNoFontPage;0)
  //UTIL_FindObjectWithNoFont (->arrObjNoFont;->arrObjNoFontPage)


C_POINTER:C301($1;$arrPtrObj)
C_POINTER:C301($2;$arrPtrPage)
C_LONGINT:C283($i)
C_TEXT:C284($blank)
ARRAY TEXT:C222($arrObj;0)
ARRAY POINTER:C280($arrVar;0)
ARRAY LONGINT:C221($arrPage;0)

If (Count parameters:C259=2)
	$arrPtrObj:=$1
	$arrPtrPage:=$2
	
	FORM GET OBJECTS:C898($arrObj;$arrVar;$arrPage)
	
	For ($i;1;Size of array:C274($arrObj))
		$blank:=OBJECT Get font:C1069(*;$arrObj{$i})
		
		If ($blank="")
			APPEND TO ARRAY:C911($arrPtrObj->;$arrObj{$i})
			APPEND TO ARRAY:C911($arrPtrPage->;$arrPage{$i})
		End if 
	End for 
	
End if 