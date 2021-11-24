C_LONGINT:C283($C; $L)
LISTBOX GET CELL POSITION:C971(ListBoxMotifs; $C; $L)

$evt:=Form event code:C388
Case of 
	: ($evt=Sur clic:K2:4)
		If (PUMListe=1)  // DGAL
			
			QUERY:C277([DiaMotifSaisieDGAL:42]; [DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1=Colonne2{$L})
			$LL:=[DiaMotifSaisieDGAL:42]LesionsLiees:12
			$Pos:=Position:C15(<>ZCR; $LL)
			If ($Pos>0)
				OBJECT SET VISIBLE:C603(PUMLes; True:C214)
				Repeat 
					$les:=Substring:C12($LL; 1; ($Pos-1))
					If ($les#"")
						APPEND TO ARRAY:C911(PUMLes; $les)
					End if 
					$LL:=Substring:C12($LL; ($Pos+1))
					$Pos:=Position:C15(<>ZCR; $LL)
				Until ($Pos=0)
				If ($les#"")
					APPEND TO ARRAY:C911(PUMLes; Substring:C12($LL; 1; ($Pos-1)))
				End if 
				SORT ARRAY:C229(PUMLes; >)
			Else 
				If ($LL#"")
					VarNomLes:=$LL
					DiaWebTextesDetailLesion
					If (VarNomLésion="")
						VarNomLésion:=$LL
					End if 
				End if 
			End if 
			VarNomMotif:=[DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1
			
		Else   // ENV
			OBJECT SET VISIBLE:C603(PUMLes; False:C215)
			VarNomLes:=Colonne2{$L}
			DiaWebTextesDetailLesion
			VarNomLésion:=Colonne2{$L}
			$test:="@"+Colonne2{$L}+"@"
			If (VarNomMotif="")
				QUERY:C277([DiaMotifSaisieDGAL:42]; [DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1=$test)
				VarNomMotif:=[DiaMotifSaisieDGAL:42]LibelleMotifSaisieDGAL:1
			End if 
		End if 
		
		
	: ($evt=Sur double clic:K2:5)
		// FIXER TEXTE DANS CONTENEUR(Colonne2{$L})
End case 

