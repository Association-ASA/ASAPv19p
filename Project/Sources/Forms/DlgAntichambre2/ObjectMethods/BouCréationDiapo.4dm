
  // ----------------------------------------------------
  // Nom utilisateur : cgm
  // Date et heure : 06/09/18, 08:25:09
  // ----------------------------------------------------
  // Méthode : DlgAntichambreP.BouCréationDiapo
  // Description
  // Va créer (ou modifier) les diapositives qui ont la colonne KO à faux
  // ----------------------------------------------------

C_LONGINT:C283($Salé;$FT)

READ WRITE:C146([DiaData:45])
ALL RECORDS:C47([Diapositives:40])
DISTINCT VALUES:C339([Diapositives:40]Espece:3;TbNomEspece)
DISTINCT VALUES:C339([Diapositives:40]Organe:2;TbNomOrgane)

QUERY:C277([Diapositives:40];[Diapositives:40]NumOrdreDiapos:1>60000)
SELECTION TO ARRAY:C260([Diapositives:40]NumOrdreDiapos:1;TbNumDiapoExistantes)

ARRAY LONGINT:C221($TbNumEnr;0)
LONGINT ARRAY FROM SELECTION:C647([DiaData:45];$TbNumEnr)
$FT:=Size of array:C274($TbNumEnr)

  // Ecriture des photos
$FT:=Size of array:C274(TbNumEnrDia)
ARRAY LONGINT:C221($TbNumDia;$FT)
ARRAY LONGINT:C221($TbNumCas;$FT)
For ($Salé;1;$FT)
	If (TbCouleurFondA2{$Salé}=Antichambre2Verte)
		GOTO RECORD:C242([DiaData:45];TbNumEnrDia{$Salé})
		$Cas:=DiaACCreationDiapo 
		If ($Cas>0)
			$TbNumCas{$Salé}:=$Cas
			$TbNumDia:=[Diapositives:40]NumOrdreDiapos:1
		End if 
	End if 
End for 

  // repérage des cas similaires
SORT ARRAY:C229($TbNumCas;$TbNumDia;>)
$FT:=Size of array:C274($TbNumCas)-1
For ($Salé;2;$FT)
	If ($TbNumCas{$Salé}=$TbNumCas{$Salé-1})  // même cas
		$VarCas:=$TbNumCas{$Salé}
		ARRAY LONGINT:C221($TbNE;1)
		$DiaposLiées:=String:C10($TbNumDia{$Salé-1})+" "
		$TbNE{1}:=$TbNumDia{$Salé-1}
		$Compteur:=2
		While ($VarCas=$TbNumCas{$Salé})
			$DiaposLiées:=String:C10($TbNumDia{$Salé-1})+" "
			$Salé:=$Salé+1
			APPEND TO ARRAY:C911($TbNE;$TbNumDia{$Salé-1})
		End while 
		QUERY WITH ARRAY:C644([Diapositives:40]NumOrdreDiapos:1;$TbNE)
		APPLY TO SELECTION:C70([Diapositives:40];[Diapositives:40]DiaposLiees:22:=$DiaposLiées)
	End if 
End for 
ZAmnistieInternationale 