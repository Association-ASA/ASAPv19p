ALL RECORDS:C47([QuizzSuivi:32])
DISTINCT VALUES:C339([QuizzSuivi:32]IdSessionVisiteur:9; PUMSuivi)
PUMSuivi:=1
QuizzPUMSuivi
OBJECT SET VISIBLE:C603(*; "ListBoxSuiviConcepteur"; Macintosh command down:C546)
QUERY:C277([DiaData:45]; [DiaData:45]XType:5="LoginConcepteur"; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XNom:1#"CGM"; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XNom:1#"")
SELECTION TO ARRAY:C260([DiaData:45]XNom:1; TbQui; [DiaData:45]XDate:3; TbQuand; [DiaData:45]XAlpha:14; TbQuoi)
