//%attributes = {"publishedWeb":true}
PRINT SETTINGS:C106
If (OK=1)
	FIRST RECORD:C50([Diapositives:40])
	$FT:=Records in selection:C76([Diapositives:40])
	For ($salé;1;$FT)
		RELATE MANY:C262([Diapositives:40]NumOrdreDiapos:1)
		$CDNomImage:=Get 4D folder:C485(Dossier base:K5:14)+"dossier Photos"+Séparateur dossier:K24:12+String:C10([Diapositives:40]NumOrdreDiapos:1)+".jpg"
		READ PICTURE FILE:C678($CDNomImage;VarDia1)
		VarCom1:=[Diapositives:40]Commentaires:7
		VarNum1:=[Diapositives:40]NumOrdreDiapos:1
		VarTri1:=DiaAfficheTriplette 
		NEXT RECORD:C51([Diapositives:40])
		If (End selection:C36([Diapositives:40]))
			$salé:=$FT
		End if 
		RELATE MANY:C262([Diapositives:40]NumOrdreDiapos:1)
		$CDNomImage:=Get 4D folder:C485(Dossier base:K5:14)+"dossier Photos"+Séparateur dossier:K24:12+String:C10([Diapositives:40]NumOrdreDiapos:1)+".jpg"
		READ PICTURE FILE:C678($CDNomImage;VarDia2)
		VarCom2:=[Diapositives:40]Commentaires:7
		VarNum2:=[Diapositives:40]NumOrdreDiapos:1
		VarTri2:=DiaAfficheTriplette 
		NEXT RECORD:C51([Diapositives:40])
		Print form:C5([Diapositives:40];"Atlas")
		If (End selection:C36([Diapositives:40]))
			$salé:=$FT
		End if 
	End for 
	PAGE BREAK:C6
End if 