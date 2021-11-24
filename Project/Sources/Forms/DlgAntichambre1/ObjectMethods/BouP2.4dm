$Type:="AjoutDia"+(Num:C11(VarPOD=1)*"POD")
QUERY:C277([DiaData:45];[DiaData:45]XType:5=$Type;*)
QUERY:C277([DiaData:45]; & [DiaData:45]XAlpha:14="A traiter")
NbDia:=Records in selection:C76([DiaData:45])