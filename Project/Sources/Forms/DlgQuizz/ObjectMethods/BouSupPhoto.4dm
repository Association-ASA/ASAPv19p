If (Records in set:C195("$ListboxSetP")=1)
	CUT NAMED SELECTION:C334([QuizzPhotos:36];"selp")
	USE SET:C118("$ListboxSetP")
	CONFIRM:C162("Détruire la photo "+[QuizzPhotos:36]NumPhotoA:3+" ???")
	If (OK=1)
		DELETE RECORD:C58([QuizzPhotos:36])
	End if 
	USE NAMED SELECTION:C332("selp")
End if 
