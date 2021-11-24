
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		
		ARRAY TEXT:C222(TbTb;0)
		ARRAY TEXT:C222($TbLHT;0)
		ARRAY TEXT:C222($TbTCa;0)
		QUERY:C277([DiaData:45];[DiaData:45]XType:5="NPC";*)
		QUERY:C277([DiaData:45]; & [DiaData:45]XNom:1=String:C10([Diapositives:40]NumOrdreDiapos:1))
		ZBlobVersVariable (->[Diapositives:40]BlobFleches:21;->TbTb;->$TbLHT;->$TbTCa)
		
End case 
