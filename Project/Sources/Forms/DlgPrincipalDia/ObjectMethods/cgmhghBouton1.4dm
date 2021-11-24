QUERY:C277(\
[DiaData:45];\
[DiaData:45]XNom:1=\
"IVC";\
*\
)\

QUERY:C277(\
[DiaData:45];\
 & \
[DiaData:45]XType:5=\
"IVC")\

ZVerrouAttendre (->[DiaData:45])
DELETE SELECTION:C66(\
[DiaData:45])\

READ ONLY:C145(\
[DiaData:45])\


$CD4:=\
Get 4D folder:C485+\
"D4.TXT"\

$TD4:=\
(\
Test path name:C476(\
$CD4)\
=\
1)\

$DC:=\
Current date:C33-\
45
$HC:=\
Current time:C178
$DM:=\
$DC+\
1
If (\
$TD4)\

	SET DOCUMENT PROPERTIES:C478(\
		$CD4;\
		False:C215;\
		True:C214;\
		$DC;\
		$HC;\
		$DM;\
		$HC)\
		
	DELETE DOCUMENT:C159(\
		$CD4)\
		
End if 