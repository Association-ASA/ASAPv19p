//%attributes = {}
  //Ad2MajusculeCommentaire
C_LONGINT:C283($Salé;$FT)
$FT:=Size of array:C274(TbTb)
For ($Salé;1;4)
	$t:=TbTb{$Salé}
	If ($T#"")
		$Pos:=Position:C15(" ";$T)
		$NF:=Substring:C12($T;1;($Pos-1))
		$T:=Substring:C12($T;($Pos+1))
		$Pos:=Position:C15(" ";$T)
		$X:=Substring:C12($T;1;($Pos-1))
		$T:=Substring:C12($T;($Pos+1))
		$Pos:=Position:C15(" ";$T)
		$Y:=Substring:C12($T;1;($Pos-1))
		$T:=Substring:C12($T;($Pos+1))
		$Pos:=Position:C15(" ";$T)
		While ($Pos=1)
			$T:=Substring:C12($T;($Pos+1))
			$Pos:=Position:C15(" ";$T)
		End while 
		For ($Fumé;1;1000)
			$Code:=Character code:C91(Substring:C12($T;$Fumé;1))
			If ($Code>35)
				$Rang:=$Fumé
				$Fumé:=1000
			End if 
		End for 
		If ($Rang>1)
			$Texte:=Substring:C12($T;1;($Rang-1))
		Else 
			$Texte:=""
		End if 
		$Texte:=$Texte+Uppercase:C13(Substring:C12($T;$Rang;1))+Substring:C12($T;($Rang+1))
		TbTb{$Salé}:=$NF+" "+$X+" "+$Y+" "+$Texte
	End if 
End for 
ZVariableVersBlob (->[Diapositives:40]BlobFleches:21;->TbTb;->TbLHT;->TbTCa)
[Diapositives:40]DiapoCommentaire:26:=(BLOB size:C605([Diapositives:40]BlobFleches:21)>0)
SAVE RECORD:C53([Diapositives:40])
