$T:=Find in array:C230(TbNomsAuteurs; "Pierre TASSIN")
QUERY:C277([DiaData:45]; [DiaData:45]XNom:1=TbNomsAuteurs{$T}; *)
QUERY:C277([DiaData:45];  & [DiaData:45]XType:5="Aut")
VarPedigree:=[DiaData:45]XTexte:7
VarImageAuteur:=[DiaData:45]XImage:6
TbNomsAuteurs:=$T
FORM GOTO PAGE:C247(2)