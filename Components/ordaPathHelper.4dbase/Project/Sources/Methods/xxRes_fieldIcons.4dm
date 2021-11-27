//%attributes = {}
  //xxRes_fieldIcons -> coll

  //© Arnaud * 30/10/2021






$out_c:=New collection:C1472
$folder:=Folder:C1567(Convert path system to POSIX:C1106(Application file:C491)+\
"/Contents/Resources/Images/StructureEditor/";fk posix path:K87:1)

If ($folder.isFolder)
	$file_c:=$folder.files(fk ignore invisible:K87:22)
	For each ($file_o;$file_c)
		$o:=New object:C1471
		$getIt_b:=True:C214
		Case of 
			: ($file_o.name="Field_10@")
				$o.fieldType:=_o_Is float:K8:26
			: ($file_o.name="Field_11@")
				$o.fieldType:=Is BLOB:K8:12
			: ($file_o.name="Field_12@")
				$o.fieldType:=Is picture:K8:10
			: ($file_o.name="Field_13@")
				$o.fieldType:=Is subtable:K8:11
			: ($file_o.name="Field_14@")
				$o.fieldType:=Is object:K8:27
			: ($file_o.name="Field_1@")
				$o.fieldType:=Is alpha field:K8:1
			: ($file_o.name="Field_2@")
				$o.fieldType:=Is text:K8:3
			: ($file_o.name="Field_3@")
				$o.fieldType:=Is date:K8:7
			: ($file_o.name="Field_4@")
				$o.fieldType:=Is time:K8:8
			: ($file_o.name="Field_5@")
				$o.fieldType:=Is boolean:K8:9
			: ($file_o.name="Field_6@")
				$o.fieldType:=Is integer:K8:5
			: ($file_o.name="Field_7@")
				$o.fieldType:=Is longint:K8:6
			: ($file_o.name="Field_8@")
				$o.fieldType:=Is integer 64 bits:K8:25
			: ($file_o.name="Field_9@")
				$o.fieldType:=Is real:K8:4
			Else 
				$getIt_b:=False:C215
		End case 
		If ($getIt_b)
			READ PICTURE FILE:C678($file_o.platformPath;$pict_i)
			$indices:=$out_c.indices("fieldType = :1";$o.fieldType)
			If ($indices.length=0)
				If ($file_o.name="@dark@")
					$o.iconDark:=$pict_i
				Else 
					$o.iconLight:=$pict_i
				End if 
				$out_c.push($o)
			Else 
				If ($file_o.name="@dark@")
					$out_c[$indices[0]].iconDark:=$pict_i
				Else 
					$out_c[$indices[0]].iconLight:=$pict_i
				End if 
			End if 
		End if 
	End for each 
End if 
$0:=$out_c
