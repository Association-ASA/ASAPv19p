$CD:=Select folder:C670("Désigner l'emplacement à ajouter";<>PermCheDropBox)
If (OK=1)
	$Pos:=Position:C15("DropBox";$CD)
	$CD:=Substring:C12($CD;($Pos+8))
	APPEND TO ARRAY:C911(TbCDEmplacement;$CD)
End if 