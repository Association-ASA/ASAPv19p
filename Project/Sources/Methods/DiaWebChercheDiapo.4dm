//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 24/07/16, 16:13:09
// ----------------------------------------------------
// Méthode : WebChercheDiapo
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT)

$Message:=$1
$Langue:=$Message[[12]]
$Critère:="@"+Substring:C12($Message; 13)+"@"

If ($Langue#"F")
	QUERY:C277([Diapositives:40]; [Diapositives:40]NomLesion:4#"Ecoffrage"; *)
End if 
QUERY:C277([Diapositives:40];  & [Diapositives:40]NumOrdreDiapos:1>0; *)
QUERY:C277([Diapositives:40];  & [Diapositives:40]NumOrdreDiapos:1<80000)  // on enlève les gibiers
LONGINT ARRAY FROM SELECTION:C647([Diapositives:40]; $TbNumEnrDiaPossibles)

If (Length:C16($Message)>12)  // rien dans le champ de recherche -> tout afficher les photos sf gibier
	If ($Langue="F")  // recherche directe
		QUERY:C277([Diapositives:40]; [Diapositives:40]NomLesion:4=$Critère; *)
		QUERY:C277([Diapositives:40];  | [Diapositives:40]Espece:3=$Critère; *)
		QUERY:C277([Diapositives:40];  | [Diapositives:40]Organe:2=$Critère; *)
		QUERY:C277([Diapositives:40];  | [Diapositives:40]Commentaires:7=$Critère)
	Else   // langue étrangère, passons par les tableaux de concaténation <>TbDiaposRecherche
		ARRAY LONGINT:C221(TbNumDiaN; 0)
		$L:=0
		$PtTb:=Get pointer:C304("<>TbDiaposRecherche"+$Langue)
		LONGINT ARRAY FROM SELECTION:C647([Diapositives:40]; $TbNumEnrDia)
		$FT:=Size of array:C274($TbNumEnrDiaPossibles)
		$Critère:=Substring:C12($Message; 13)
		For ($Salé; 1; $FT)
			$L2:=Find in array:C230(<>TbNumEnrDiapos; $TbNumEnrDia{$Salé})
			$BloudiboulgaCourant:=$PtTb->{$L2}
			If (Position:C15($Critère; $BloudiboulgaCourant)>0)
				APPEND TO ARRAY:C911(TbNumDiaN; $TbNumEnrDia{$Salé})
			End if 
		End for 
		CREATE SELECTION FROM ARRAY:C640([Diapositives:40]; TbNumDiaN)
	End if 
End if 
$THTML:=String:C10(Records in selection:C76([Diapositives:40]))+"£"+DiaWebCreationHTMLListeDiapos($Langue)
WEB SEND TEXT:C677($THTML)