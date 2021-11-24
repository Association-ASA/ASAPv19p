C_LONGINT:C283($Trouve)
_O_ARRAY STRING:C218(80; ZdDNL; 0)
COPY ARRAY:C226(TbNomLésions; $TbNomLésions)
$Val:=Get edited text:C655+"@"
$Trouve:=Find in array:C230($TbNomLésions; $Val)
While ($Trouve>0)
	If ($TbNomLésions{$Trouve}=$Val)
		ZAjoutLigne(->ZdDNL; $TbNomLésions{$Trouve})
	End if 
	DELETE FROM ARRAY:C228($TbNomLésions; 1; $Trouve)
	$Trouve:=Find in array:C230($TbNomLésions; $Val)
End while 