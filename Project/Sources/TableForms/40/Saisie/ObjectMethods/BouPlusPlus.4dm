C_LONGINT:C283($Salé; $FT)
QUERY:C277([DiaLesions:44]; [DiaLesions:44]NomLesion:1=[Diapositives:40]NomLesion:4)
If ([DiaLesions:44]NPC:9#"")
	ARRAY TEXT:C222($TbNPC; 0)
	ZTexteVersTableau([DiaLesions:44]NPC:9; ->$TbNPC)
	$FT:=Size of array:C274($TbNPC)
	
	For ($Salé; 1; $FT)
		If (Find in array:C230(ZdDNLR; $TbNPC{$Salé})<0) & ([Diapositives:40]NomLesion:4#$TbNPC{$Salé})
			APPEND TO ARRAY:C911(ZdDNLR; $TbNPC{$Salé})
		End if 
	End for 
End if 
