//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 01/10/19, 06:24:50
  // ----------------------------------------------------
  // Méthode : QuizzNoteSuivi
  // Description
  // Méthode qui crée et stocke un neregistrement de [QuizzSuivi]
  //  suite à une action du visiteur
  // Paramètres : $1 = action   
  //              $2 = chaine AJAX reçue  type "xxxquizz11_IDSession"
  //                   où 11 = ID de la réponse
  //               type "montrequestionnaireoeil1"  = lancement du questionnaire n°1
  //               type "repquizz11_ASABF0F7F2F75154EB097E1EDC4D505944E"  = réponse à une question
  //               type "retourquizzVetAgro SupCF42FBCF8AE74A53B5EEAA2F78B7A66B" = retour sur la question précédente
  //               type "multiplelancequizz£casequizz66,casequizz67,casequizz297521,_ASABF0F7F2F75154EB097E1EDC4D505944E"
  //                      = Réponse à une question à réponses multiples
  //              $3 = Id du suivi de la session
  //             {$4} note le code de la réponse dans [QuizzSuivi]Argument;"CodeRéponse"
  //             {$5} note le tableau des questions restantes
  // ----------------------------------------------------
$Action:=$1
$Ajax:=$2
$IDSuivi:=$3
ARRAY LONGINT:C221($TbIdQuestionsRestantes;0)
QUERY:C277([QuizzSuivi:32];[QuizzSuivi:32]IdSessionVisiteur:9=$IDSuivi)
If (Records in selection:C76([QuizzSuivi:32])=0)
	$IDQuestionnaire:=[QuizzQuestionnaires:35]ID:1
Else 
	$IDQuestionnaire:=[QuizzSuivi:32]IDQuestionnaire:2
	SELECTION TO ARRAY:C260([QuizzSuivi:32]Argument:6;$TbArg;[QuizzSuivi:32]Ordre:8;$TbOrd)
	SORT ARRAY:C229($TbOrd;$TbArg;<)
	OB GET ARRAY:C1229($TbArg{1};"TbQuestionsRestante";$TbIdQuestionsRestantes)
End if 
$FT:=Records in selection:C76([QuizzSuivi:32])
CREATE RECORD:C68([QuizzSuivi:32])
[QuizzSuivi:32]IdSessionVisiteur:9:=$IDSuivi
[QuizzSuivi:32]Action:5:=$1
[QuizzSuivi:32]DateDebut:3:=Current date:C33
[QuizzSuivi:32]HeureDebut:4:=Current time:C178
[QuizzSuivi:32]IDQuestionnaire:2:=$IDQuestionnaire
[QuizzSuivi:32]IDQuestion:7:=[QuizzQuestions:34]ID:1
[QuizzSuivi:32]Ordre:8:=$FT+1
If ($Ajax="rep@")
	[QuizzSuivi:32]ValeurReponse:10:=[QuizzReponses:33]ValeurReponse:6
End if 
OB SET:C1220([QuizzSuivi:32]Argument:6;"ChaineAjax";$2)
If (Count parameters:C259=4)
	If ($4#"")
		OB SET:C1220([QuizzSuivi:32]Argument:6;"CodeRéponse";$4)
	End if 
End if 
If (Count parameters:C259=5)
	OB SET ARRAY:C1227([QuizzSuivi:32]Argument:6;"TbQuestionsRestante";$5->)
Else 
	If (Size of array:C274($TbIdQuestionsRestantes)>0)
		OB SET ARRAY:C1227([QuizzSuivi:32]Argument:6;"TbQuestionsRestante";$TbIdQuestionsRestantes)
	End if 
End if 
SAVE RECORD:C53([QuizzSuivi:32])