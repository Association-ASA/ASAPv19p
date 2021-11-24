
$evt:=Form event code:C388
Case of 
	: ($evt=Sur chargement:K2:1)
		DiaACInit
		VarPOD:=1
		LIST TO ARRAY:C288("Auteurs"; PUMAuteurAC)
		SORT ARRAY:C229(PUMAuteurAC; >)
		APPEND TO ARRAY:C911(PUMAuteurAC; "-")
		LIST TO ARRAY:C288("Especes"; <>PUMEspèce)
		LIST TO ARRAY:C288("Organes"; <>PUMOrgane)
		SORT ARRAY:C229(<>PUMOrgane; >)
		VarNomLésion:=""
		OBJECT SET VISIBLE:C603(*; "BouSupPhotos"; False:C215)
		$Type:="AjoutDia"+(Num:C11(VarPOD=1)*"POD")
		QUERY:C277([DiaData:45]; [DiaData:45]XType:5=$Type)
		VarNumSérie:=Max:C3([DiaData:45]XValeur:4)+1
		
End case 
