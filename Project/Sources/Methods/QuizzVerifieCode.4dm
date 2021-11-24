//%attributes = {}
  // ----------------------------------------------------
  // Pas de paramètre
  // ----------------------------------------------------
  // Méthode : QuizzVerifieCode
  // Description
  //   Méthode qui vérifie que l'architecture des codes 
  //   est conforme : pas de trou, au moins deux réponses par question
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 29/05/20, 15:50:08
C_LONGINT:C283($Salé;$FT;$Fumé;$L;$SFT)
$OK:=QuizzRectifieCode (True:C214)
If ($OK)
	QuizzFabriqueTbGeneraux 
	$FT:=Size of array:C274(<>TbQuestionCodeQuestion)
	For ($Salé;1;$FT)
		$L:=Find in array:C230(<>TbQuestionnaireId;<>TbQuestionIdQuestionnaire{$Salé})
		$IntituléQuestionnaire:=<>TbQuestionnaireInstitution{$L}+"-"+<>TbQuestionnaireTitre{$L}
		$CodeQuestionCourante:=<>TbQuestionCodeQuestion{$Salé}
		$IDQuestionCourante:=<>TbQuestionId{$Salé}
		$CompteurRéponse:=0
		ARRAY LONGINT:C221($TbDerIndice;0)
		$L:=Find in array:C230(<>TbReponseIdQuestion;$IDQuestionCourante)
		While ($L>0)
			$CodeRéponseCourante:=<>TbReponseCodeReponse{$L}
			If ($CodeRéponseCourante#($CodeQuestionCourante+".@"))
				VarRapportQD:=VarRapportQD+"Le code de la réponse "+$CodeRéponseCourante
				VarRapportQD:=VarRapportQD+" du questionnaire "+$IntituléQuestionnaire+" est incohérent avec celui de la question "+$CodeQuestionCourante+<>ZCR
			End if 
			If (<>TbReponseLibelReponse{$L}="")
				VarRapportQD:=VarRapportQD+"Le libellé de la réponse à la question "
				VarRapportQD:=VarRapportQD+$CodeQuestionCourante+" du questionnaire "+$IntituléQuestionnaire+" est vide"+<>ZCR
			Else 
				$ValeurRéponseCourante:=<>TbReponseValeurReponse{$L}
				If ($ValeurRéponseCourante=0)
					VarRapportQD:=VarRapportQD+"La réponse "+<>TbReponseLibelReponse{$L}+" à la question "
					VarRapportQD:=VarRapportQD+$CodeQuestionCourante+" du questionnaire "+$IntituléQuestionnaire+" n'est pas évaluée"+<>ZCR
				End if 
			End if 
			
			ARRAY TEXT:C222($TbIndices;0)
			ZTexteVersTableau ($CodeRéponseCourante;->$TbIndices;".")
			APPEND TO ARRAY:C911($TbDerIndice;Num:C11($TbIndices{Size of array:C274($TbIndices)}))
			$CompteurRéponse:=$CompteurRéponse+1
			$L:=Find in array:C230(<>TbReponseIdQuestion;$IDQuestionCourante;($L+1))
		End while 
		  // Test du nombre de réponses proposées
		If ($CompteurRéponse<2)
			VarRapportQD:=VarRapportQD+"Le nombre de réponse à la question "+$CodeQuestionCourante
			VarRapportQD:=VarRapportQD+" du questionnaire "+$IntituléQuestionnaire+" est inférieur à 2"+<>ZCR
		Else 
			  // Test du premier indice
			SORT ARRAY:C229($TbDerIndice;>)
			If ($TbDerIndice{1}#1)
				VarRapportQD:=VarRapportQD+"L'indice des réponses à la question "+$CodeQuestionCourante
				VarRapportQD:=VarRapportQD+" du questionnaire "+$IntituléQuestionnaire+" commence à "+String:C10($TbDerIndice{1})+<>ZCR
			End if 
			  // Test de séquence complète
			$SFT:=Size of array:C274($TbDerIndice)
			For ($Fumé;2;$SFT)
				If ($TbDerIndice{$Fumé}#($TbDerIndice{$Fumé-1}+1))
					VarRapportQD:=VarRapportQD+"L'indice de réponse à la question "+$CodeQuestionCourante
					VarRapportQD:=VarRapportQD+" du questionnaire "+$IntituléQuestionnaire+" n'est pas séquentiel"+<>ZCR
					$Fumé:=$SFT
				End if 
			End for 
		End if 
	End for 
End if 
