//%attributes = {"lang":"fr"}
// InitFlechePleinEcran
SensFleche:="Flèche à droite"
OBJECT SET ENTERABLE:C238(*; "C@"; False:C215)
OBJECT SET ENTERABLE:C238(*; "D@"; False:C215)
LesFlechesSontLà:=False:C215
LesOrientationsSontLà:=False:C215
LesDiagnosesSontLà:=False:C215
ARRAY TEXT:C222(TbTb; 0)
ARRAY TEXT:C222(TbLHT; 0)
ARRAY TEXT:C222(TbO; 0)
ARRAY TEXT:C222(TbTb; 8)
ARRAY TEXT:C222(TbLHT; 8)
ARRAY TEXT:C222(TbO; 14)
ARRAY INTEGER:C220(TbTCa; 0)
ARRAY INTEGER:C220(TbTCa; 8)
C_TEXT:C284(LeMotClé; VarC11; VarC21; VarC31; VarC41; VarD11; VarD21; VarD31; VarD41; VarC11V; VarC21V; VarC31V; VarC41V; VarD11V; VarD21V; VarD31V; VarD41V)
LeMotClé:=""
VarC11:=""
VarC21:=""
VarC31:=""
VarC41:=""
VarD11:=""
VarD21:=""
VarD31:=""
VarD41:=""
VarC11V:=""
VarC21V:=""
VarC31V:=""
VarC41V:=""
VarD11V:=""
VarD21V:=""
VarD31V:=""
VarD41V:=""
VarUnLienHypertexte:=False:C215
VarUneFleche:=False:C215
VarUneOrientation:=False:C215
VarUneDiagnose:=False:C215
If (BLOB size:C605([Diapositives:40]BlobFleches:21)>0)
	DiaDecrypteLeBlob  // cherche dans le blob la présence d'éléments d'information
	// modifie VarUnLienHypertexte, VarUneFleche, VarUneOrientation, VarUneDiagnose
End if 
OBJECT SET VISIBLE:C603(*; "Orientation@"; False:C215)
OBJECT SET VISIBLE:C603(*; "MCE@"; False:C215)
OBJECT SET VISIBLE:C603(*; "Write@"; False:C215)
OBJECT SET VISIBLE:C603(*; "Diagnose@"; False:C215)
DiaRepereLesObjets

