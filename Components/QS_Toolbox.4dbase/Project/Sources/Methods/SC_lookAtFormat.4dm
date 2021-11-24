//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 06/12/17
  // ----------------------------------------------------
  // Méthode : SC_lookAtFormat
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------

ARRAY TEXT:C222($TbForms;0x0000)
ARRAY TEXT:C222($rT_Paths;0x0000)
ARRAY TEXT:C222($tTxt_objects;0x0000)
ARRAY POINTER:C280($tPtr_var;0x0000)
ARRAY LONGINT:C221($tLon_pages;0x0000)
ARRAY TEXT:C222($tableau2D;0x0000;0x0000)
C_COLLECTION:C1488($result;$indice)

C_LONGINT:C283($NbTable;$NbForms;$tableID)
C_BOOLEAN:C305($newForm;$NewTable)
C_TEXT:C284($textCode)
C_OBJECT:C1216($method;$table)

$Listbox_Name:="LB_Information"
LB_Init_Start ($Listbox_Name)

$NbTable:=0
$NbForms:=0
$newForm:=False:C215
$NewTable:=False:C215
$result:=New collection:C1472

BASE_getTablesList 

For each ($table;Storage:C1525.structureTable)  // For each Table
	
	CLEAR VARIABLE:C89($TbForms)
	$tableID:=$table.id
	
	If ($tableID>0)
		FORM GET NAMES:C1167(Table:C252($tableID)->;$TbForms;*)
		$tableName:="["+Table name:C256($tableID)+"]/"
	Else 
		FORM GET NAMES:C1167($TbForms;*)
		$tableName:=""
	End if 
	
	  //TRACE
	
	For ($sale;1;Size of array:C274($TbForms))  // For each form
		
		$Formulare:=$TbForms{$sale}
		FE_getObjectsAndMethods ($tableID;$Formulare;->$tTxt_objects;->$tPtr_var;->$tLon_pages)
		
		For ($a;1;Size of array:C274($tTxt_objects))  // Check each object and fill an array with all Events
			
			$objet:=$tTxt_objects{$a}
			
			If (OBJECT Get format:C894(*;$objet)#"")
				$indice:=Storage:C1525.objectType.indices("val = :1";String:C10(OBJECT Get type:C1300(*;$objet)))
				If ($indice.length>0)
					$result.push(New object:C1471("method";Choose:C955($tableID>0;$tableName;"")+$Formulare;"object name";$objet;"type";String:C10(OBJECT Get format:C894(*;$objet));"name";Storage:C1525.objectType[$indice[0]];"empty";""))
				End if 
			End if 
			
		End for 
		
		FORM UNLOAD:C1299  // Release the form
		
	End for 
	
End for each 

  // Now, work on Methods
  // ---------------------
  // Look at for 'String' usage by regex in all methods
  // String = command name (10)(text;"format";{time})
$Pattern:="(?mi-s)(?<!sub|replace\\s|get\\slocalizes\\s)"+Command name:C538(10)+"(?:C10)?[^\\s|\\:\\=|ify].+?(;[^\\(][^)|;]*)"
$token:=":C10"

For each ($method;Storage:C1525.allMethods)  // For each method
	If ($method.commandToken.indexOf($token)#-1)  // We check only if we already found the STRING command
		$textCode:=$method.clearCode
		If (REGEX_ExtractText ($Pattern;$texteMethode;"0 1 2";->$tableau2D;0)=0)
			For ($i;1;Size of array:C274($tableau2D))
				
				If ($tableau2D{$i}{2}#"")
					$result.push(New object:C1471("method";"Method";"object name";$rT_Paths{$a};"type";$tableau2D{$i}{1}+" ---> "+Substring:C12($tableau2D{$i}{2};2);"name";"";"empty";""))
				End if 
			End for 
		End if 
	End if 
End for each 

  // *******************************************

If ($result.length>0)
	LB_buildByCollection ($result;$Listbox_Name)
	Form:C1466.result:=$result.copy().orderBy("type desc")
	ARRAY TEXT:C222($tabPropertyNames;0x0000)
	OB GET PROPERTY NAMES:C1232($result[0];$tabPropertyNames)
	
	For ($i;1;Size of array:C274($tabPropertyNames))
		
		Case of 
			: ($i=1)
				LISTBOX SET COLUMN WIDTH:C833(*;"QS_Col_"+$tabPropertyNames{$i};300)
				OBJECT SET TITLE:C194(*;"QS_header"+String:C10($i);"Table Name\rMethod Path Name\rObject name")
				
			: ($i=2)
				LISTBOX SET COLUMN WIDTH:C833(*;"QS_Col_"+$tabPropertyNames{$i};200)
				OBJECT SET TITLE:C194(*;"QS_header"+String:C10($i);"Object Name")
				
			: ($i=3)
				LISTBOX SET COLUMN WIDTH:C833(*;"QS_Col_"+$tabPropertyNames{$i};200)
				OBJECT SET TITLE:C194(*;"QS_header"+String:C10($i);"Format defined")
				
			: ($i=4)
				LISTBOX SET COLUMN WIDTH:C833(*;"QS_Col_"+$tabPropertyNames{$i};200)
				OBJECT SET TITLE:C194(*;"QS_header"+String:C10($i);"Object type")
				
			: ($i=5)
				OBJECT SET TITLE:C194(*;"QS_header"+String:C10($i);"")
				
		End case 
		
	End for 
	ARRAY LONGINT:C221($MyEventsOnLB;2)
	$MyEventsOnLB{1}:=On Clicked:K2:4
	$MyEventsOnLB{2}:=On Double Clicked:K2:5
	OBJECT SET EVENTS:C1239(*;$Listbox_Name;$MyEventsOnLB;Enable events disable others:K42:37)
	
	$info:=String:C10($result.length)+" variables with a 'Format set' have been found."
Else 
	
	$info:="No variable with 'Format set' has been found."
	
End if 
displayInfo ($Info)