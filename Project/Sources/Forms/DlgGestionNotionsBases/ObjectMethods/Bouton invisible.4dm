  // remise à plat des ordres
$FT:=Size of array:C274(Colonne3N)-1
If ($FT>=0)
	Colonne3N{1}:=100000
	$PrecedentA:="100000"
	For ($Salé;1;$FT)
		Case of 
			: (Colonne2N{$Salé+1}<Colonne2N{$Salé})
				For ($Fumé;1;$Salé)
					$Rang:=$Salé-$Fumé+1
					If (Colonne2N{$Rang}=Colonne2N{$Salé+1})
						$PrecedentOA:=String:C10(Colonne3N{$Rang})
						$CompteurN:=Num:C11(Substring:C12($PrecedentOA;1;(Colonne2N{$Salé}-1)))+1
						Colonne3N{$Salé+1}:=$CompteurN*(10^(6-Colonne2N{$Salé+1}))
						$Fumé:=$Salé
					End if 
				End for 
				
			: (Colonne2N{$Salé+1}=Colonne2N{$Salé})
				$CompteurN:=Num:C11(Substring:C12($PrecedentA;1;(Colonne2N{$Salé})))+1
				Colonne3N{$Salé+1}:=$CompteurN*(10^(6-Colonne2N{$Salé+1}))
				
			: (Colonne2N{$Salé+1}>Colonne2N{$Salé})
				$CompteurN:=Num:C11(Substring:C12($PrecedentA;1;(Colonne2N{$Salé}+1)))+1
				Colonne3N{$Salé+1}:=$CompteurN*(10^(6-Colonne2N{$Salé+1}))
				
		End case 
		
		$PrecedentA:=String:C10(Colonne3N{$Salé+1})
		
	End for 
	
	
	
End if 