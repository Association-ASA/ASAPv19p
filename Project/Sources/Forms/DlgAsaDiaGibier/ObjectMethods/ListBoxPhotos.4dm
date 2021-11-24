
$evt:=Form event code:C388
Case of 
	: ($evt=Sur nouvelle sélection:K2:29)
		C_LONGINT:C283($C;$L)
		LISTBOX GET CELL POSITION:C971(*;"ListBoxPhotos";$C;$L)
		DiaACGibierClicDansTb ($L)
		
	: ($evt=Sur double clic:K2:5)
		If (Test path name:C476(URLCourante)=Est un document:K24:1)
			OPEN URL:C673(URLCourante)
		Else 
			$Pos:=Position:C15(Séparateur dossier:K24:12;URLCourante)
			$CDInitialPhoto:=Substring:C12(URLCourante;1;$Pos)
			$Pos:=Position:C15(Séparateur dossier:K24:12;URLCourante)
			$CDBase:=Get 4D folder:C485(Dossier base:K5:14)
			$Pos:=Position:C15(Séparateur dossier:K24:12;$CDBase)
			$CDInitialOrdi:=Substring:C12($CDBase;1;$Pos)
			$URL:=Replace string:C233(URLCourante;"IMacASA2017HD:Users:asa:";"MBPASA2015:Users:ASA:")
			OPEN URL:C673($URL)
		End if 
End case 
