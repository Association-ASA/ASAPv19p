//%attributes = {"invisible":true,"preemptive":"capable"}
/* This method builds the master list of items used by the Quick Open module. Rather than use built in
commands, we simply scan the file system for what is needed. The idea is to build a collection that
has a list of classes, methods, forms, database methods, and triggers with knowledge about what
folder each one is in and whether each has documentation (i.e. a .md file) associated with it.

In addition to these 4D items, the code checks to see if there is a DevDocs folder located at the
same level as 4D's Documentation folder. This folder can be used to store a hierarchy of .md files
which describe a project in ways that aren't easily directly associated with a method, class, or form.

The following is built:
- masterList (a collection of objects, each of which has the following keys)
  - type (Class, Method, Form, DB Method, Trigger, DevDoc)
  - name
  - folder (just the folder it is in—not the hierarchy. For DevDocs, this will be the relative path
    to the .md file. It is relative to the DevDocs folder and always starts with a "/". Examples:
    index.md at the top level of DevDocs: "/". example.md in a subfolder: "/subfolder/".
  - hasDocs (True if the item already has an associated .md file)

4D documentation on a project's file structure can be found in these places:
  - https://developer.4d.com/docs/en/Project/architecture.html
  - https://developer.4d.com/docs/en/Project/documentation.html

Note that table forms are not included in the list. Why? Well, because I don't use them. If anyone
still does, they can add them to the code as desired.
*/

C_COLLECTION:C1488($0; $cMasterList; $collDocs; $collPath; $cType)
C_LONGINT:C283($a; $lTableNumber)
C_TEXT:C284($tBasePath; $tSourcesPath; $tDocumentationPath; $tItemsPath; $tDocsPath; $tFolderName)
C_TEXT:C284($tJSONString; $tName; $tDevDocsPath)
C_OBJECT:C1216($oItem; $oFolders; $oThisFolder; $oFoldersJSON; $oPath; $oType)
ARRAY TEXT:C222($tabProperties; 0x0000)

$cMasterList:=New collection:C1472

/* Calculate paths to where all the sources and the documentation will be. This code allows for a
DevDocs folder to be at the same level as the Documentation folder in case the developer has a series
of developer documentation as .md files that are organized a different way than direct association
with methods, forms, classes, etc.
*/

$tBasePath:=Folder:C1567(Folder:C1567(fk database folder:K87:14; *).platformPath; fk platform path:K87:2; *).path
$tSourcesPath:=$tBasePath+"Project/Sources/"
$tDocumentationPath:=$tBasePath+"Documentation/"
$tDevDocsPath:=$tBasePath+"DevDocs/"


/* We want to show what folder methods, classes, and forms are in. To do this we first parse the folders.json
file and sort of invert it into a new object so we can do very fast lookups later on to see what folder at
item is in. The resulting object looks like this:
- $oFolders
  - classes (an object which has a subobject for each class where the key is the class name and the value is
    the folder.
  - methods (same as classes, except for methods)
  - forms (same as classes, except for forms)

The folders.json file is organized as a large object with each folder as a top level object, the key name
the same as the folder name. Even if a folder is a sub-folder in the 4D Explorer, it will be in this file
at the top level. Within each folder object are potentially several objects. We care about the following,
each of which is a value collection of method/class/form names that belong to the folder:
  - classes
  - methods
  - forms
*/
$oFolders:=New object:C1471  //Prepare the object

// Now we can load the folders.json file and loop through each folder, adding info to the inverted object
$oFoldersJson:=File:C1566($tSourcesPath+"folders.json")

If ($oFoldersJson.exists)  // File exist, so let's go
	
	$tJSONString:=$oFoldersJson.getText("UTF-8")
	$oFoldersJSON:=JSON Parse:C1218($tJSONString)
	
	For each ($tFolderName; $oFoldersJSON)
		
		$oThisFolder:=$oFoldersJSON[$tFolderName]
		
		If (Not:C34(OB Is empty:C1297($oThisFolder)))
			
			CLEAR VARIABLE:C89($tabProperties)  // Reset the variable to its declaration status
			OB GET PROPERTY NAMES:C1232($oThisFolder; $tabProperties)
			
			For ($a; 1; Size of array:C274($tabProperties))
				If ($oFolders[$tabProperties{$a}]=Null:C1517)
					$oFolders[$tabProperties{$a}]:=New object:C1471
				End if 
				
				
				For each ($tName; $oThisFolder[$tabProperties{$a}])
					$oFolders[$tabProperties{$a}][$tName]:=$tFolderName
				End for each 
				
			End for 
			
		End if 
		
	End for each 
End if 


/* Parse the **path** and add them to the collection. 
Table specificity: File names are based on table number:
- table_1.4dm for the trigger
- table1.md for the documentation

Class: It could be interesting to parse out the function names in the future and add them to the search results...

Database methods, methods and forms: 
- xxx.4dm for the method
- xxx.md for the documentation
*/

$cType:=New collection:C1472(\
New object:C1471("path"; "Classes/"; "type"; "Class"); \
New object:C1471("path"; "DatabaseMethods/"; "type"; "DB Method"); \
New object:C1471("path"; "Methods/"; "type"; "Method"); \
New object:C1471("path"; "Triggers/"; "type"; "Trigger"); \
New object:C1471("path"; "Forms/"; "type"; "Form")\
)

$collPath:=New collection:C1472
$collDocs:=New collection:C1472
OB GET PROPERTY NAMES:C1232($oFolders; $tabProperties)  // Assigne Folders to $tabProperties

For each ($oType; $cType)
	
	$tItemsPath:=$tSourcesPath+$oType.path
	$tDocsPath:=$tDocumentationPath+$oType.path
	$collPath.clear()
	$collDocs.clear()
	
	If (Test path name:C476(Folder:C1567($tItemsPath).platformPath)=Is a folder:K24:2)
		$collPath:=Folder:C1567($tItemsPath).files(fk ignore invisible:K87:22)
		
		If (Test path name:C476(Folder:C1567($tDocsPath).platformPath)=Is a folder:K24:2)
			$collDocs:=Folder:C1567($tDocsPath).files(fk ignore invisible:K87:22)
		End if 
		
		For each ($oPath; $collPath)
			
			// Common to all paths
			$oItem:=New object:C1471
			$oItem.type:=$oType.type
			
			// Manage specificity
			Case of 
				: ($oType.type="Trigger")  // Specific Trigger case
					
					$lTableNumber:=Num:C11($oPath.name)
					
					If ($lTableNumber>0)
						$oItem.name:=Table name:C256($lTableNumber)
						$oItem.hasDocs:=Bool:C1537($collDocs.indexOf("table"+String:C10($lTableNumber)+".md")>=0)
						$oItem.folder:=""  //Not put in folders
					End if 
					
				: ($oType.type="new Type, if any")  // could be the class specific analysis ;-)
					
					
				Else   // Standard actions
					
					$oItem.name:=$oPath.name
					$oItem.hasDocs:=Bool:C1537($collDocs.indexOf($oPath.fullName)>=0)
					
					$oItem.folder:="-"  // no folder by default
					For ($a; 1; Size of array:C274($tabProperties))
						If ($oFolders[$tabProperties{$a}][$oItem.name]#Null:C1517)  // If the folder/'object' exists
							$oItem.folder:=String:C10($oFolders[$tabProperties{$a}][$oItem.name])  // Assign the item
							$a:=Size of array:C274($tabProperties)+1  // move away from the loop
						End if 
					End for 
					
			End case 
			
			$cMasterList.push($oItem)
		End for each 
	End if 
End for each 

/* Parse the DevDocs and add them to the collection. This can be a hierarchal set of .md files (and other
file types, but they will be ignored). All files will still be presented in a flat list, but the folder
will contain the relative path. We look only for files with a .md extension.
- filename.md
*/

If (Test path name:C476(Folder:C1567($tDevDocsPath).platformPath)=Is a folder:K24:2)  // based on documentation
	$collPath:=Folder:C1567($tDevDocsPath).files(fk ignore invisible:K87:22+fk recursive:K87:7)
	
	For each ($oPath; $collPath)
		$oItem:=New object:C1471
		$oItem.type:="DevDoc"
		$oItem.name:=$oPath.fullName
		$oItem.folder:=$oPath.parent.platformPath
		$oItem.hasDocs:=True:C214  //Always true
		$cMasterList.push($oItem)
	End for each 
End if 

/* Now that the list is built, let's sort it so it only has to be done once
*/
C_COLLECTION:C1488($result)
$result:=New collection:C1472

Use ($result)
	OB_CopyToSharedCollection($cMasterList; $result)
End use 

$0:=$result