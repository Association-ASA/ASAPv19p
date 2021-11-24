//%attributes = {"lang":"fr"}
// ----------------------------------------------------
// Nom utilisateur (OS) : iMacASA2017
// Date et heure : 20/04/21, 06:57:30
// ----------------------------------------------------
// Méthode : QuizzSuiviQuestionnaires
// Description
// 
//
// Paramètres
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT; $Fumé; $L; $SFT)
// Retrouvons les questionnaires concernés
QUERY:C277([QuizzQuestionnaires:35]; [QuizzQuestionnaires:35]QuizzGeneral:6=True:C214)
SELECTION TO ARRAY:C260([QuizzQuestionnaires:35]ID:1; $TbIdQuestionnaireQ\
; [QuizzQuestionnaires:35]Auteur:2; $TbAuteurQ\
; [QuizzQuestionnaires:35]Titre:3; $TbTitreQ)
RELATE MANY SELECTION:C340([QuizzSuivi:32]IDQuestionnaire:2)
SELECTION TO ARRAY:C260([QuizzSuivi:32]IDQuestionnaire:2; $TbIdQuestionnaireS\
; [QuizzSuivi:32]DateDebut:3; $TbDateS\
; [QuizzSuivi:32]IdSessionVisiteur:9; $TbIdSessionVisiteurS\
; [QuizzSuivi:32]Ordre:8; $TbOrdreS)
$FT:=Size of array:C274($TbIdQuestionnaireQ)
ARRAY LONGINT:C221($TbIDQuestionnaireBilan; 0)
ARRAY LONGINT:C221($TbOccurrenceBilan; 0)
ARRAY TEXT:C222($TbDepartementBilan; 0)
ARRAY DATE:C224($TbDateBilan; 0)
For ($Salé; 1; $FT)  // Pour chaque questionnaire
	QUERY:C277([QuizzSuivi:32]; [QuizzSuivi:32]IDQuestionnaire:2=$TbIdQuestionnaireQ{$Salé}; *)
	QUERY:C277([QuizzSuivi:32];  & [QuizzSuivi:32]IdSessionVisiteur:9="@.gouv.fr@")
	DISTINCT VALUES:C339([QuizzSuivi:32]IdSessionVisiteur:9; $TbIdSessionVisiteurVD)
	$SFT:=Size of array:C274($TbIdSessionVisiteurVD)
	For ($Fumé; 1; $SFT)
		$SessionCourante:=$TbIdSessionVisiteurVD{$Fumé}
		$L:=Find in array:C230($TbIdSessionVisiteurS; $SessionCourante)
		// Extraction du département de $SessionCourante
		$Pos:=Position:C15(".gouv.fr"; $SessionCourante)
		$Departement:=Substring:C12($SessionCourante; 1; ($Pos-1))
		// Elimination de l'abattoir
		$Pos:=Position:C15(Char:C90(Arobase:K15:46); $Departement)
		$Departement:=Substring:C12($Departement; ($Pos+1))
		// Recherche du questionnaire concerné
		$IQuestionnaireCourant:=$TbIdQuestionnaireS{$L}
		// et la date d'utilisation
		$Date:=$TbDateS{$L}
		APPEND TO ARRAY:C911($TbIDQuestionnaireBilan; $IQuestionnaireCourant)
		APPEND TO ARRAY:C911($TbDepartementBilan; $Departement)
		APPEND TO ARRAY:C911($TbDateBilan; $Date)
	End for 
End for 

// Bilan : par mois, par questionnaire combien de session dans quel(s) département(s)
// fabrication du tableau des mois
$FT:=Size of array:C274($TbDateBilan)
ARRAY TEXT:C222($TbMoisBilan; $FT)
ARRAY TEXT:C222($TbCombineMoisIdQ; $FT)
ARRAY TEXT:C222($TbMoisBilanVD; 0)
For ($Salé; 1; $FT)
	$TbMoisBilan{$Salé}:=Substring:C12(String:C10(Year of:C25($TbDateBilan{$Salé})); 3; 2)+"-"+String:C10(Month of:C24($TbDateBilan{$Salé}); "00")
	$TbCombineMoisIdQ{$Salé}:=$TbMoisBilan{$Salé}+String:C10($TbIDQuestionnaireBilan{$Salé})
	If (Find in array:C230($TbMoisBilanVD; $TbMoisBilan{$Salé})<0)
		APPEND TO ARRAY:C911($TbMoisBilanVD; $TbMoisBilan{$Salé})
	End if 
End for 

SORT ARRAY:C229($TbMoisBilanVD; >)
$Rapport:="Périodes"+<>ZTab+ZTableauVersTexte(->$TbMoisBilanVD; <>ZTab)+<>ZCR
$SFT:=Size of array:C274($TbMoisBilanVD)

$FT:=Size of array:C274($TbTitreQ)
For ($Salé; 1; $FT)
	$IdQCourant:=$TbIdQuestionnaireQ{$Salé}
	$Rapport:=$Rapport+<>ZCR+"Questionnaire : "+$TbTitreQ{$Salé}+" Auteur : "+$TbAuteurQ{$Salé}
	For ($Fumé; 1; $SFT)
		$PériodeCourante:=$TbMoisBilanVD{$Fumé}
		$Combine:=$PériodeCourante+String:C10($IdQCourant)
		$L:=0
		$Compteur:=0
		Repeat 
			$L:=Find in array:C230($TbCombineMoisIdQ; $Combine; ($L+1))
			If ($L>0)
				$Compteur:=$Compteur+1
			End if 
		Until ($L<0)
		$Rapport:=$Rapport+<>ZTab+String:C10($Compteur)
	End for 
End for 
SET TEXT TO PASTEBOARD:C523($Rapport)