//%attributes = {"invisible":true,"preemptive":"capable"}
  // METHODS_hasDescription
  // Parameters:
  // $1: object
  // ----------------------------------------------------
  // Description:
  // 
  // ----------------------------------------------------
  // Creation: Patrick EMANUEL, 26/11/20, 21:51:54
  //

C_OBJECT:C1216($1)
C_TEXT:C284($MethText)
C_COLLECTION:C1488($collPath)

$BasePath:=Storage:C1525.QS_TBX_SHARED_DATA.appPath
$DocumentationPath:=$BasePath+"Documentation"+Folder separator:K24:12

$currentName:=$1.name
$collPath:=New collection:C1472
$collPath:=Split string:C1554($currentName;"/")

Case of 
	: ($1.path="Path project method")
		$sourcePath:="methods"+Folder separator:K24:12+$collPath[0]
		
	: ($1.path="Path database method")
		$sourcePath:="DatabaseMethods"+Folder separator:K24:12+$collPath[1]
		
	: ($1.path="Path project form")
		$sourcePath:="Forms/"+$collPath[1]+"/"+Choose:C955($collPath[2]="{formMethod}";"method";"ObjectMethods/"+$collPath[2])
		
	: ($1.path="Path trigger")
		$sourcePath:="Triggers/table_"+String:C10(Storage:C1525.structureTable.query("name = :1";$collPath[1])[0].id)
		
	: ($1.path="Path table form")
		$sourcePath:="TableForms/"+String:C10(Storage:C1525.structureTable.query("name = :1";$collPath[1])[0].id)+"/"+$collPath[2]+"/"+Choose:C955($collPath[3]="{formMethod}";"method";"ObjectMethods/"+$collPath[3])
		
	: ($1.path="Path Class")
		$sourcePath:="Classes"+Folder separator:K24:12+$collPath[1]
		
End case 
$sourcePath:=$DocumentationPath+Replace string:C233($sourcePath;"/";Folder separator:K24:12)+".md"

If (Test path name:C476($sourcePath)=Is a document:K24:1)
	$1.hasDescription:=True:C214
Else 
	$1.hasDescription:=False:C215
End if 