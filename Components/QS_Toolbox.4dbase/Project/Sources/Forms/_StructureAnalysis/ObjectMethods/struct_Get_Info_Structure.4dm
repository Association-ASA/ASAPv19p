If (Not:C34(Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_Component_Mode))
	C_COLLECTION:C1488($col)
	$col:=New collection:C1472
	
	$col.push("Display Structure picture")
	$col.push(Char:C90(1)+"Export Structure picture (jpg)")
	$col.push(Char:C90(1)+"Export Structure picture (svg)")
	$referenceLigne:=Pop up menu:C542($col.join(";"))
	$NomImage:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName
	
	OBJECT SET VISIBLE:C603(*;"lb_result";$referenceLigne>1)
	OBJECT SET VISIBLE:C603(*;"Zone_Web";$referenceLigne=1)
	
	$extension:=".jpg"
	$NomImage:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DestinationPath+$NomImage
	
	Case of 
		: ($referenceLigne=1)
			$NomImage:=Temporary folder:C486+$NomImage
			TOOLS_Export_Drawn_Structure ($NomImage;$extension)
			$NomImage:=Convert path system to POSIX:C1106($NomImage+$extension)  // -- Compatibility with MacOS
			WA OPEN URL:C1020(*;"Zone_Web";"file:///"+$NomImage)
			
		: ($referenceLigne=2)
			TOOLS_Export_Drawn_Structure ($NomImage;$extension)
			SHOW ON DISK:C922($NomImage+$extension)
			
		: ($referenceLigne=3)
			$extension:=".svg"
			TOOLS_Export_Drawn_Structure ($NomImage;$extension)
			SHOW ON DISK:C922($NomImage+$extension)
			
	End case 
	
Else 
	$txt:="You're in component mode. No table exist!"
	displayInfo ($txt;$Red)
	
End if 