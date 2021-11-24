$NomFleche:=String:C10(VarImageFleche+1)+"1"+(Num:C11(VarImageVerticale)*"V")
PtChampCourant:=Get pointer:C304("VarC"+$NomFleche)
$Pt:=PtChampCourant
C_LONGINT:C283($g1; $h1; $d1; $b1; $larg1; $haut1)
OBJECT GET COORDINATES:C663(PtChampCourant->; $g1; $h1; $d1; $b1)

OBJECT GET BEST SIZE:C717(PtChampCourant->; $larg1; $haut1)

HIGHLIGHT TEXT:C210(PtChampCourant->; 1; Length:C16(PtChampCourant->))
OBJECT SET FONT SIZE:C165(PtChampCourant->; PUMTC{PUMTC})
TbTCa{VarImageFleche+1}:=PUMTC{PUMTC}
