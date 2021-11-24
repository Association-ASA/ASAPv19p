//%attributes = {"invisible":true,"preemptive":"capable"}
C_COLLECTION:C1488($1)
C_OBJECT:C1216($line)

ARRAY TEXT:C222($tabPropertyNames; 0x0000)
OB GET PROPERTY NAMES:C1232($1[0]; $tabPropertyNames)

$export:=""
For each ($line; $1)
	For ($a; 1; Size of array:C274($tabPropertyNames))
		$export:=$export+$line[$tabPropertyNames{$a}]+"\t"
	End for 
	$export:=$export+"\n"
End for each 

$path:=QS_s_Get_DB_Name
$dbName:=$path.name
$path:=Folder:C1567(fk documents folder:K87:21; *).folder("QS_Toolbox").folder($path.name).file("dbAnalysis.txt")
$path.setText($export)

OPEN URL:C673($path.platformPath)

If (Count parameters:C259=2)
	C_OBJECT:C1216($2)
	signal_addResult($2; Current method name:C684)
Else 
	KILL WORKER:C1390
End if 
