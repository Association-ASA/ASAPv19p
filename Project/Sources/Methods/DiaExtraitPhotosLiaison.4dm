//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 16/01/16, 11:29:54
// ----------------------------------------------------
// Méthode : ExtraitPhotosLiaison
// Permet d'extraire le(s) n° de photo(s) liée(s)
//  et de la placer dans le champ [Diapositives]DiaposLiees
// de [Diapositives] courant
// ----------------------------------------------------

C_LONGINT:C283($Salé; $FT)
$DC:=[Diapositives:40]Commentaires:7
If (Num:C11($DC)>0)
	$pos:=Position:C15("n°"; $DC)
	If ($pos>0)
		$Num:=Num:C11(Substring:C12($DC; ($pos+2); 5))
		If ($Num>10000) & ($Num<70000)
			[Diapositives:40]DiaposLiees:22:=[Diapositives:40]DiaposLiees:22+String:C10($Num)+<>ZCR
			$DC:=Substring:C12($DC; $Pos+8)
			If (Num:C11($DC)>0)
				Repeat 
					$FT:=Length:C16($DC)
					For ($Salé; 1; $FT)
						$Car:=Character code:C91($DC[[$Salé]])
						If ($Car>47) & ($Car<58)
							$Num:=Num:C11(Substring:C12($DC; $Salé; 5))
							If ($Num>10000) & ($Num<70000)
								[Diapositives:40]DiaposLiees:22:=[Diapositives:40]DiaposLiees:22+String:C10($Num)+<>ZCR
								$FT:=$Salé
							End if 
						End if 
					End for 
					$DC:=Substring:C12($DC; $Salé+1)
				Until (Num:C11($DC)=0)
			End if 
		End if 
	End if 
End if 