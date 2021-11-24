//ZLBMFListes 
//ZNbEnr:=Taille tableau(TbPerNum)
//ZFenetreActualiseTitre (Vrai)
//  //OBJET FIXER VISIBLE(PUMNumCampagneSuivi;(ZAvantProc#"@Adh"))
//OBJET FIXER VISIBLE(PUMNumCampagneSuivi;Faux)
//OBJET FIXER VISIBLE(*;"@InvisibleEnsemble";(ZAvantProc#"@Adh"))

ZLBMFListes
ZNbEnr:=Size of array:C274(TbPerNum)
ZFenetreActualiseTitre(True:C214)
//OBJET FIXER VISIBLE(PUMNumCampagneSuivi;(ZAvantProc#"@Adh"))
OBJECT SET VISIBLE:C603(PUMNumCampagneSuivi; False:C215)
If (ZAvantProc="@Labo")
	OBJECT SET VISIBLE:C603(*; "@InvisibleEnsemble"; True:C214)
Else 
	OBJECT SET VISIBLE:C603(*; "@InvisibleEnsemble"; False:C215)
End if 

