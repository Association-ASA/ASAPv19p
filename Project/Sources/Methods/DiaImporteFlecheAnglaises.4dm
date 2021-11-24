//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 14/08/16, 15:39:25
// ----------------------------------------------------
// Méthode : Ad3ImporteFlecheAnglaises
// Description
// Permet d'importer le texte des flèches en anglais
// à partir du fichier Contenu flèches diapos final.txt
// ----------------------------------------------------
C_TEXT:C284($C1; $C2; $C3; $Tab; $CR)

$Tab:=Char:C90(Tabulation:K15:37)
$CR:=Char:C90(Retour chariot:K15:38)

USE CHARACTER SET:C205("Macintosh"; 1)
READ WRITE:C146([Diapositives:40])
$Doc:=Open document:C264(""; Mode lecture:K24:5)
If (OK=1)
	RECEIVE PACKET:C104($Doc; $C1; $CR)
	RECEIVE PACKET:C104($Doc; $C2; $CR)
	RECEIVE PACKET:C104($Doc; $C3; $CR)
	$Prem:="N°R@"
	If (($C1+$C2)#$Prem)
		ALERT:C41("Désolé, le fichier "+document+" n'est pas le bon...")
	Else 
		RECEIVE PACKET:C104($Doc; $C1; $CR)
		RECEIVE PACKET:C104($Doc; $C2; $CR)
		RECEIVE PACKET:C104($Doc; $C3; $CR)
		Repeat 
			
			$NumDiapo:=Num:C11($C1)
			If ($NumDiapo>0)
				$NumLigneTb:=Num:C11($C2)
				QUERY:C277([Diapositives:40]; [Diapositives:40]NumOrdreDiapos:1=$NumDiapo)
				ARRAY TEXT:C222($TbFleches; 0)
				ZBlobVersVariable(->[Diapositives:40]BlobFleches:21; ->$TbFleches; ->$TbLHT; ->$TbTCa)
				If (Size of array:C274($TbFleches)<$NumLigneTb)
					// TRACE
				Else 
					$Fleche:=$TbFleches{$NumLigneTb}
					If (Length:C16($Fleche)>3)
						$Pos:=Position:C15("£"; $Fleche)
						If ($pos=0)
							$TbFleches{$NumLigneTb}:=$TbFleches{$NumLigneTb}+"£"+$C3
						Else 
							$TbFleches{$NumLigneTb}:=Substring:C12($Fleche; 1; $Pos)+$C3
						End if 
						ARRAY TEXT:C222($TbLHT; 0)
						ARRAY TEXT:C222($TbTCa; 0)
						ZVariableVersBlob(->[Diapositives:40]BlobFleches:21; ->$TbFleches; ->$TbLHT; ->$TbTCa)
						SAVE RECORD:C53([Diapositives:40])
					End if 
				End if 
			End if 
			RECEIVE PACKET:C104($Doc; $C1; $CR)
			If (Length:C16($C1)=5)
				RECEIVE PACKET:C104($Doc; $C2; $CR)
				RECEIVE PACKET:C104($Doc; $C3; $CR)
			End if 
		Until (Length:C16($C1)#5)
		
	End if 
End if 
USE CHARACTER SET:C205(*; 1)