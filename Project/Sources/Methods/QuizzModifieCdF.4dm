//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 29/04/19, 10:47:45
// ----------------------------------------------------
// Méthode : QuizzModifieCdF
// Description
//   Méthode qui crée ou detruit des questions 
//    ou des réponses d'un questionnaire
// Paramètre : $1 = Message AJAX type 'modifiechemindefer' + id du bouton d'origine
//  exemple : modifiechemindeferRS2365 : R -> table [QuizzReponses] S -> suppression
//            2365 concerne l'enregistrement n°2365 de la table [QuizzReponses]
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT; $L; $L2; $Fumé; $NumTableInitial; $NumTable; $procheIndiceN)
//Si (Macintosh commande enfoncée)
// TRACE
//Fin de si 
$Mess:=$1
$idA:=Substring:C12($Mess; 19)  // suppression de modifiechemindefer

// REPERAGE DE LA BONNE TABLE ET DU BON ENREGISTREMENT
// table concernée 
$Tble:=$idA[[1]]
$Action:=$idA[[2]]  // V pour Voir la question, I pour insérer une question ou une réponse
//  A pour ajouter une question ou une réponse, S pour supprimer une question ou une réponse
$NumTableInitial:=Table:C252(->[QuizzQuestionnaires:35])  // N° de la table [QuizzQuestionnaires]
$NumTable:=(Num:C11($Tble="E")*Table:C252(->[QuizzQuestionnaires:35]))\
+(Num:C11($Tble="Q")*Table:C252(->[QuizzQuestions:34]))\
+(Num:C11($Tble="R")*Table:C252(->[QuizzReponses:33]))\
+(Num:C11($Tble="P")*Table:C252(->[QuizzPhotos:36]))
$PtTable:=Table:C252($Numtable)
// enregistrement concerné
$PtChampRecherche:=Field:C253($NumTable; 1)  // Le champ de recherche est le premier champ = clef primaire
$TestN:=Num:C11($idA)

// Les [QuizzQuestions]  pour pouvoir les repérer
READ WRITE:C146([QuizzQuestions:34])
ALL RECORDS:C47([QuizzQuestions:34])
SELECTION TO ARRAY:C260([QuizzQuestions:34]IDReponseMere:4; $TbIdReponseMere; [QuizzQuestions:34]ID:1; $TbIdQuestions)

READ WRITE:C146([QuizzReponses:33])
READ WRITE:C146([QuizzPhotos:36])
QUERY:C277($PtTable->; $PtChampRecherche->=$TestN)
// NumEnrConcerné:=Numéro enregistrement($PtTable->)
If ($NumTable=$NumTableInitial)
	$IdQuestionnaire:=[QuizzQuestionnaires:35]ID:1
Else 
	$PtChampChapitre:=Field:C253($NumTable; 5)  // le code est toujours en position 5 !!!)
	$Chapitre:=$PtChampChapitre->
	ARRAY TEXT:C222($TbIndicesChapitre; 0)
	ZTexteVersTableau($Chapitre; ->$TbIndicesChapitre; ".")
	$IdQuestionnaire:=Num:C11($TbIndicesChapitre{1})
End if 
CUT NAMED SELECTION:C334($PtTable->; "SelCouCdF")
QuizzExport(String:C10($IdQuestionnaire); $Mess)
USE NAMED SELECTION:C332("SelCouCdF")
//CRÉER ENREGISTREMENT([XTachesDeFond])
//[XTachesDeFond]DateTache:=Date du jour
//[XTachesDeFond]HeureTache:=Heure courante
//[XTachesDeFond]NomTache:=Chaîne($IdQuestionnaire)
//[XTachesDeFond]NomProcedure:="QuizzExport"
//STOCKER ENREGISTREMENT([XTachesDeFond])
Case of 
	: ($Tble="Q")
		Case of 
				
			: ($Action="I")  // insertion d'une question principale
				$CodeQuestionAppelante:=[QuizzQuestions:34]CodeQuestion:5
				ARRAY TEXT:C222($TbIndicesChapitre; 0)
				ZTexteVersTableau($CodeQuestionAppelante; ->$TbIndicesChapitre; ".")
				$RangCodeAChanger:=2
				$ValeurCodeAChangerN:=Num:C11($TbIndicesChapitre{$RangCodeAChanger})
				// selection des réponses concernées
				QUERY:C277([QuizzReponses:33]; [QuizzReponses:33]CodeReponse:5=($TbIndicesChapitre{1}+".@"))
				UNLOAD RECORD:C212([QuizzReponses:33])
				SELECTION TO ARRAY:C260([QuizzReponses:33]CodeReponse:5; $TbCo)
				$FT:=Size of array:C274($TbCo)
				For ($Salé; 1; $FT)
					$CodeCourant:=$TbCo{$Salé}
					ARRAY TEXT:C222($TbIndicesChapitre; 0)
					ZTexteVersTableau($CodeCourant; ->$TbIndicesChapitre; ".")
					If (Num:C11($TbIndicesChapitre{2})>=$ValeurCodeAChangerN)  // On ne change l'indice que pour les indices concernés
						$TbIndicesChapitre{2}:=String:C10(Num:C11($TbIndicesChapitre{2})+1)  // Incrémentation du chapitre initial
						$TbCo{$Salé}:=ZTableauVersTexte(->$TbIndicesChapitre; ".")
					End if 
				End for 
				ARRAY TO SELECTION:C261($TbCo; [QuizzReponses:33]CodeReponse:5)
				
				QUERY:C277([QuizzQuestions:34]; [QuizzQuestions:34]CodeQuestion:5=($TbIndicesChapitre{1}+".@"))
				UNLOAD RECORD:C212([QuizzQuestions:34])
				SELECTION TO ARRAY:C260([QuizzQuestions:34]CodeQuestion:5; $TbCo)
				$FT:=Size of array:C274($TbCo)
				For ($Salé; 1; $FT)
					$CodeCourant:=$TbCo{$Salé}
					ARRAY TEXT:C222($TbIndicesChapitre; 0)
					ZTexteVersTableau($CodeCourant; ->$TbIndicesChapitre; ".")
					If (Num:C11($TbIndicesChapitre{2})>=$ValeurCodeAChangerN)  // On ne change l'indice que pour les indices concernés
						$TbIndicesChapitre{2}:=String:C10(Num:C11($TbIndicesChapitre{2})+1)  // Incrémentation du chapitre initial
						$TbCo{$Salé}:=ZTableauVersTexte(->$TbIndicesChapitre; ".")
					End if 
				End for 
				ARRAY TO SELECTION:C261($TbCo; [QuizzQuestions:34]CodeQuestion:5)
				
				QUERY:C277([QuizzPhotos:36]; [QuizzPhotos:36]CodePhoto:5=($TbIndicesChapitre{1}+".@"))
				UNLOAD RECORD:C212([QuizzPhotos:36])
				SELECTION TO ARRAY:C260([QuizzPhotos:36]CodePhoto:5; $TbCo)
				$FT:=Size of array:C274($TbCo)
				For ($Salé; 1; $FT)
					$CodeCourant:=Replace string:C233($TbCo{$Salé}; "P"; ".")
					ARRAY TEXT:C222($TbIndicesChapitre; 0)
					ZTexteVersTableau($CodeCourant; ->$TbIndicesChapitre; ".")
					If (Num:C11($TbIndicesChapitre{2})>=$ValeurCodeAChangerN)  // On ne change l'indice que pour les indices concernés
						$TbIndicesChapitre{2}:=String:C10(Num:C11($TbIndicesChapitre{2})+1)  // Incrémentation du chapitre initial
						$TbCo{$Salé}:=ZTableauVersTexte(->$TbIndicesChapitre; ".")
					End if 
				End for 
				ARRAY TO SELECTION:C261($TbCo; [QuizzPhotos:36]CodePhoto:5)
				
				// création de la question à insérer 
				CREATE RECORD:C68([QuizzQuestions:34])
				[QuizzQuestions:34]CodeQuestion:5:=$CodeQuestionAppelante
				[QuizzQuestions:34]IDQuestionnaire:2:=$IdQuestionnaire
				SAVE RECORD:C53([QuizzQuestions:34])
				// et ses deux réponses
				CREATE RECORD:C68([QuizzReponses:33])
				[QuizzReponses:33]IDQuestion:2:=[QuizzQuestions:34]ID:1
				[QuizzReponses:33]LibelReponse:3:=""
				[QuizzReponses:33]CodeReponse:5:=[QuizzQuestions:34]CodeQuestion:5+".1"
				SAVE RECORD:C53([QuizzReponses:33])
				CREATE RECORD:C68([QuizzReponses:33])
				[QuizzReponses:33]IDQuestion:2:=[QuizzQuestions:34]ID:1
				[QuizzReponses:33]LibelReponse:3:=""
				[QuizzReponses:33]CodeReponse:5:=[QuizzQuestions:34]CodeQuestion:5+".2"
				SAVE RECORD:C53([QuizzReponses:33])
				// Envoi du chemin de fer
				QUERY:C277([QuizzQuestionnaires:35]; [QuizzQuestionnaires:35]ID:1=$IdQuestionnaire)
				$Envoi:=QuizzEcritHTMLCdF  // recalcul du chemin de fer
				WEB SEND TEXT:C677($Envoi)
				
				
			: ($Action="S")  // Suppression d'une question
				$CodeQuestion:=[QuizzQuestions:34]CodeQuestion:5
				ARRAY TEXT:C222($TbIndicesChapitreCodeInitial; 0)
				ZTexteVersTableau($CodeQuestion; ->$TbIndicesChapitreCodeInitial; ".")
				$RangCodeAchanger:=Size of array:C274($TbIndicesChapitreCodeInitial)
				$ValeurRangAChangerInitialN:=Num:C11($TbIndicesChapitreCodeInitial{$RangCodeAchanger})
				COPY ARRAY:C226($TbIndicesChapitreCodeInitial; $TbCodes)
				DELETE FROM ARRAY:C228($TbCodes; $RangCodeAchanger)
				$Prefixe:=ZTableauVersTexte(->$TbCodes; ".")+"."
				// Suppression des questions concernées,  réponses et photos liées
				$Test:=$CodeQuestion+".@"
				$IdQuestion:=[QuizzQuestions:34]ID:1
				// Supression de toute la lignée des réponses
				READ WRITE:C146([QuizzReponses:33])
				QUERY:C277([QuizzReponses:33]; [QuizzReponses:33]CodeReponse:5=$Test)
				DELETE SELECTION:C66([QuizzReponses:33])
				// Supression de toutes les photos
				READ WRITE:C146([QuizzPhotos:36])
				QUERY:C277([QuizzPhotos:36]; [QuizzPhotos:36]IDQuestion:2=$IdQuestion)
				DELETE SELECTION:C66([QuizzPhotos:36])
				// suppression de la question elle-même
				READ WRITE:C146([QuizzQuestions:34])
				QUERY:C277([QuizzQuestions:34]; [QuizzQuestions:34]CodeQuestion:5=$CodeQuestion)
				DELETE RECORD:C58([QuizzQuestions:34])
				// suppression de toute la lignée des questions autres que celle désignée
				QUERY:C277([QuizzQuestions:34]; [QuizzQuestions:34]CodeQuestion:5=$Test)
				RELATE MANY SELECTION:C340([QuizzReponses:33]IDQuestion:2)
				DELETE SELECTION:C66([QuizzReponses:33])
				RELATE MANY SELECTION:C340([QuizzPhotos:36]IDQuestion:2)
				DELETE SELECTION:C66([QuizzPhotos:36])
				DELETE SELECTION:C66([QuizzQuestions:34])
				// rétablir la codification
				// d'abord les réponses
				$TestCode:=$Prefixe+"@"
				QUERY:C277([QuizzReponses:33]; [QuizzQuestions:34]CodeQuestion:5=$TestCode)
				ORDER BY:C49([QuizzReponses:33]; [QuizzReponses:33]CodeReponse:5; >)
				SELECTION TO ARRAY:C260([QuizzReponses:33]CodeReponse:5; $TbCo\
					; [QuizzReponses:33]IDQuestion:2; $TbIdQuestionsRéponse\
					; [QuizzReponses:33]ID:1; $TbIdReponseQuestionnaire)
				$FT:=Size of array:C274($TbCo)
				$ValeurIndiceAchangerAncienne:=$ValeurRangAChangerInitialN-1
				// $ValeurRangAChangerN:=$ValeurRangAChangerInitialN-1
				For ($Salé; 1; $FT)
					$CodeCourant:=$TbCo{$Salé}
					ARRAY TEXT:C222($TbIndicesChapitreCodeCourant; 0)
					ZTexteVersTableau($CodeCourant; ->$TbIndicesChapitreCodeCourant; ".")
					$ValeurRangAChangerCourantN:=Num:C11($TbIndicesChapitreCodeCourant{$RangCodeAchanger})
					If ($ValeurRangAChangerCourantN>$ValeurRangAChangerInitialN)  // Seules les question parès celle de la suppression sont concernées
						$ValeurIndiceAchangerCourant:=Num:C11($TbIndicesChapitreCodeCourant{$RangCodeAchanger})
						If ($ValeurIndiceAchangerCourant#$ValeurIndiceAchangerAncienne)
							$ValeurRangAChangerN:=$ValeurIndiceAchangerCourant-1
							$ValeurIndiceAchangerAncienne:=$ValeurIndiceAchangerCourant
						End if 
						COPY ARRAY:C226($TbIndicesChapitreCodeCourant; $TbCodes)
						For ($Fumé; 1; $RangCodeAchanger)
							DELETE FROM ARRAY:C228($TbCodes; 1)
						End for 
						$Suffixe:="."+ZTableauVersTexte(->$TbCodes; ".")
						$AncCodeRéponse:=$TbCo{$Salé}
						$TbCo{$Salé}:=$Prefixe+String:C10($ValeurRangAChangerN)+$Suffixe
						If ($TbCo{$Salé}="@.1")  //  le code correpond directement à une question
							QUERY:C277([QuizzQuestions:34]; [QuizzQuestions:34]ID:1=$TbIdQuestionsRéponse{$Salé})
							ARRAY TEXT:C222($TbCodeReponseQuestionCourant; 0)
							ZTexteVersTableau($TbCo{$Salé}; ->$TbCodeReponseQuestionCourant; ".")
							DELETE FROM ARRAY:C228($TbCodeReponseQuestionCourant; Size of array:C274($TbCodeReponseQuestionCourant))
							[QuizzQuestions:34]CodeQuestion:5:=ZTableauVersTexte(->$TbCodeReponseQuestionCourant; ".")
							SAVE RECORD:C53([QuizzQuestions:34])
						End if 
					End if 
				End for 
				ARRAY TO SELECTION:C261($TbCo; [QuizzReponses:33]CodeReponse:5)
				// rappel du questionnaire
				QUERY:C277([QuizzQuestionnaires:35]; [QuizzQuestionnaires:35]ID:1=$IdQuestionnaire)
				$Envoi:=QuizzEcritHTMLCdF  // recalcul du chemin de fer
				WEB SEND TEXT:C677($Envoi)
				
				
			: ($Action="R")  // ajouter une réponse en bas de liste
				QUERY:C277([QuizzReponses:33]; [QuizzReponses:33]IDQuestion:2=[QuizzQuestions:34]ID:1)
				//TRIER([QuizzReponses];[QuizzReponses]CodeReponse;>)
				SELECTION TO ARRAY:C260([QuizzReponses:33]CodeReponse:5; $TbCodeRéponse)
				$DerRéponse:=$TbCodeRéponse{Size of array:C274($TbCodeRéponse)}
				ARRAY TEXT:C222($TbIndicesChapitreCodeCourant; 0)
				ZTexteVersTableau($DerRéponse; ->$TbIndicesChapitreCodeCourant; ".")
				$TT:=Size of array:C274($TbIndicesChapitreCodeCourant)
				$FT:=Size of array:C274($TbCodeRéponse)
				ARRAY LONGINT:C221($TbDerIndicesChapitreCodeCourant; $FT)
				For ($Salé; 1; $FT)
					ARRAY TEXT:C222($TbIndices; 0)
					ZTexteVersTableau($TbCodeRéponse{$Salé}; ->$TbIndices; ".")
					$TbDerIndicesChapitreCodeCourant{$Salé}:=Num:C11($TbIndices{$TT})
				End for 
				$procheIndiceN:=Max:C3($TbDerIndicesChapitreCodeCourant)+1
				$TbIndicesChapitreCodeCourant{$TT}:=String:C10($procheIndiceN)
				CREATE RECORD:C68([QuizzReponses:33])
				[QuizzReponses:33]CodeReponse:5:=ZTableauVersTexte(->$TbIndicesChapitreCodeCourant; ".")
				[QuizzReponses:33]IDQuestion:2:=[QuizzQuestions:34]ID:1
				SAVE RECORD:C53([QuizzReponses:33])
				QUERY:C277([QuizzQuestionnaires:35]; [QuizzQuestionnaires:35]ID:1=$IdQuestionnaire)
				$Envoi:=QuizzEcritHTMLCdF  // recalcul du chemin de fer
				WEB SEND TEXT:C677($Envoi)
		End case 
		
	: ($Tble="R")
		Case of 
				
			: ($Action="I")  // Insertion d'une réponse
				// recueil des données intiales
				// La [QuizzReponses] en cours
				$CodeReponse:=[QuizzReponses:33]CodeReponse:5
				$IDQuestionReponse:=[QuizzReponses:33]IDQuestion:2
				// Les caractéritiques de son chapitre
				ARRAY TEXT:C222($TbIndicesChapitreCodeInitial; 0)
				ZTexteVersTableau([QuizzReponses:33]CodeReponse:5; ->$TbIndicesChapitreCodeInitial; ".")
				$RangDernierIndiceInitialN:=Size of array:C274($TbIndicesChapitreCodeInitial)
				$ValeurDernierIndiceN:=Num:C11($TbIndicesChapitreCodeInitial{$RangDernierIndiceInitialN})
				$ValeurNouvelIndiceN:=$ValeurDernierIndiceN-1  // Va servir pour le test d'incrémentation
				// $IndicePrécedentInitial:=$TbIndicesChapitre{$RangDernierIndiceInitial-1}
				//$IndiceA:=$TbIndicesChapitre{$RangDernierIndiceInitial}
				//$IndiceN:=Num($TbIndicesChapitre{$RangDernierIndiceInitial})
				
				// recherche de toutes les [QuizzReponses] de la [QuizzQuestions]
				// LECTURE ÉCRITURE([QuizzReponses])
				COPY ARRAY:C226($TbIndicesChapitreCodeInitial; $Tbindexcode)
				DELETE FROM ARRAY:C228($Tbindexcode; Size of array:C274($Tbindexcode))  // suppression du dernier rang
				$Préfixe:=ZTableauVersTexte(->$Tbindexcode; ".")+"."
				$Test:=$Préfixe+"@"
				QUERY:C277([QuizzReponses:33]; [QuizzReponses:33]CodeReponse:5=$Test)  // toutes les réponses de la question
				
				// Fabrication du tableau des codes
				ORDER BY:C49([QuizzReponses:33]; [QuizzReponses:33]CodeReponse:5; >)
				SELECTION TO ARRAY:C260([QuizzReponses:33]CodeReponse:5; $TbCo\
					; [QuizzReponses:33]IDQuestion:2; $TbIdQuestionsRéponse\
					; [QuizzReponses:33]ID:1; $TbIdReponseQuestionnaire)
				$L:=Find in array:C230($TbCo; $CodeReponse)  // On se place sur la première valeur à changer
				$FT:=Size of array:C274($TbCo)
				For ($Salé; $L; $FT)
					// Actualisation du code dans les tableaux
					$CodeCourant:=$TbCo{$Salé}
					ARRAY TEXT:C222($TbIndicesChapitreCodeCourant; 0)
					ZTexteVersTableau($CodeCourant; ->$TbIndicesChapitreCodeCourant; ".")
					$ValeurIndiceCourantN:=Num:C11($TbIndicesChapitreCodeCourant{$RangDernierIndiceInitialN})
					$RangDernierIndiceCourant:=Size of array:C274($TbIndicesChapitreCodeCourant)
					$Suffixe:=""
					If ($RangDernierIndiceCourant>$RangDernierIndiceInitialN)  // Pas de même rang donc un suffixe
						COPY ARRAY:C226($TbIndicesChapitreCodeCourant; $TbIndexCode)
						For ($Sec; 1; $RangDernierIndiceInitialN)
							DELETE FROM ARRAY:C228($TbIndexCode; 1)  // suppression du premier rang
						End for 
						$Suffixe:="."+ZTableauVersTexte(->$TbIndexCode; ".")
					End if 
					// On a le préfixe et le suffixe, reste à déterminer l'indice central 
					If ($ValeurIndiceCourantN#$ValeurNouvelIndiceN)  // même rang que la réponse insérée : on incrémente
						$ValeurNouvelIndiceN:=$ValeurDernierIndiceN
						$ValeurDernierIndiceN:=$ValeurDernierIndiceN+1
					End if 
					$TbCo{$Salé}:=$Préfixe+String:C10($ValeurDernierIndiceN)+$Suffixe
					// actualisation du code de [QuizzQuestions] 
					If ($TbCo{$Salé}="@.1")  //  le code correpond directement à une question
						QUERY:C277([QuizzQuestions:34]; [QuizzQuestions:34]ID:1=$TbIdQuestionsRéponse{$Salé})
						ARRAY TEXT:C222($TbCodeReponseQuestionCourant; 0)
						ZTexteVersTableau($TbCo{$Salé}; ->$TbCodeReponseQuestionCourant; ".")
						DELETE FROM ARRAY:C228($TbCodeReponseQuestionCourant; Size of array:C274($TbCodeReponseQuestionCourant))
						[QuizzQuestions:34]CodeQuestion:5:=ZTableauVersTexte(->$TbCodeReponseQuestionCourant; ".")
						SAVE RECORD:C53([QuizzQuestions:34])
					End if 
				End for 
				ARRAY TO SELECTION:C261($TbCo; [QuizzReponses:33]CodeReponse:5)  // actualisation des codes des réponses
				// création de la nouvelle
				CREATE RECORD:C68([QuizzReponses:33])
				[QuizzReponses:33]CodeReponse:5:=$CodeReponse
				[QuizzReponses:33]IDQuestion:2:=$IDQuestionReponse
				SAVE RECORD:C53([QuizzReponses:33])
				// rappel du questionnaire
				QUERY:C277([QuizzQuestionnaires:35]; [QuizzQuestionnaires:35]ID:1=$IdQuestionnaire)
				$Envoi:=QuizzEcritHTMLCdF  // recalcul du chemin de fer
				WEB SEND TEXT:C677($Envoi)
				
				
			: ($Action="S")  // supprimer la réponse
				$IDQuestionReponse:=[QuizzReponses:33]IDQuestion:2
				$CodeReponseInitiale:=[QuizzReponses:33]CodeReponse:5
				// suppression de la réponse indiquée
				DELETE RECORD:C58([QuizzReponses:33])
				// Initialisation des variables utiles
				ARRAY TEXT:C222($TbIndicesChapitreCodeInitial; 0)
				ZTexteVersTableau($CodeReponseInitiale; ->$TbIndicesChapitreCodeInitial; ".")
				$RangDernierIndiceInitialN:=Size of array:C274($TbIndicesChapitreCodeInitial)  // seul indice à changer
				$ValeurDernierIndiceInitialN:=Num:C11($TbIndicesChapitreCodeInitial{$RangDernierIndiceInitialN})
				COPY ARRAY:C226($TbIndicesChapitreCodeInitial; $TbCodes)
				DELETE FROM ARRAY:C228($TbCodes; $RangDernierIndiceInitialN)
				$Préfixe:=ZTableauVersTexte(->$TbCodes; ".")+"."
				// suppression des réponses liées
				$Test:=$CodeReponseInitiale+"@"
				QUERY:C277([QuizzReponses:33]; [QuizzReponses:33]CodeReponse:5=$Test)
				SELECTION TO ARRAY:C260([QuizzReponses:33]IDQuestion:2; $TbIdQuestionsRéponse)
				QUERY WITH ARRAY:C644([QuizzQuestions:34]ID:1; $TbIdQuestionsRéponse)
				DELETE SELECTION:C66([QuizzQuestions:34])  // suppression des questions liées aux [QuizzReponses] supprimées
				DELETE SELECTION:C66([QuizzReponses:33])
				// réaffectation des codes de la question
				$Test:=$Prefixe+"@"
				QUERY:C277([QuizzReponses:33]; [QuizzReponses:33]CodeReponse:5=$Test)  // Rappel des réponses à la question
				ORDER BY:C49([QuizzReponses:33]; [QuizzReponses:33]CodeReponse:5; >)
				SELECTION TO ARRAY:C260([QuizzReponses:33]CodeReponse:5; $TbCo\
					; [QuizzReponses:33]IDQuestion:2; $TbIdQuestionsRéponse\
					; [QuizzReponses:33]ID:1; $TbIdReponse)
				$FT:=Size of array:C274($TbCo)
				$NouvelleValeurRangAchangerN:=$ValeurDernierIndiceInitialN
				$ValeurRangAChangerN:=$ValeurDernierIndiceInitialN
				For ($Salé; 1; $FT)  // on commence au rang de la question supprimée = la première réponse à traiter
					$CodeCourant:=$TbCo{$Salé}
					ARRAY TEXT:C222($TbIndicesChapitreCodeCourant; 0)
					ZTexteVersTableau($CodeCourant; ->$TbIndicesChapitreCodeCourant; ".")
					$ValeurIndiceCourantN:=Num:C11($TbIndicesChapitreCodeCourant{$RangDernierIndiceInitialN})
					If ($ValeurIndiceCourantN>$ValeurDernierIndiceInitialN)  // on ne traite que des réponses situées après la réponse supprimée
						If ($ValeurIndiceCourantN#$NouvelleValeurRangAchangerN)
							$ValeurIndiceCourantN:=$ValeurIndiceCourantN-1
							$NouvelleValeurRangAchangerN:=$ValeurIndiceCourantN
						End if 
						If ($RangDernierIndiceInitialN=Size of array:C274($TbIndicesChapitreCodeCourant))
							$Suffixe:=""
						Else 
							COPY ARRAY:C226($TbIndicesChapitreCodeCourant; $TbCodes)
							For ($Fumé; 1; $RangDernierIndiceInitialN)
								DELETE FROM ARRAY:C228($TbCodes; 1)
							End for 
							$Suffixe:="."+ZTableauVersTexte(->$TbCodes; ".")
						End if 
						$TbCo{$Salé}:=$Préfixe+String:C10($ValeurIndiceCourantN)+$Suffixe
						// Réajjustement des Codes des questions liées
						If ($TbCo{$Salé}="@.1")  // il existe une question liée
							QUERY:C277([QuizzQuestions:34]; [QuizzQuestions:34]ID:1=$TbIdQuestionsRéponse{$Salé})
							ARRAY TEXT:C222($TbCodeReponseQuestionCourant; 0)
							ZTexteVersTableau($TbCo{$Salé}; ->$TbCodeReponseQuestionCourant; ".")
							DELETE FROM ARRAY:C228($TbCodeReponseQuestionCourant; Size of array:C274($TbCodeReponseQuestionCourant))
							[QuizzQuestions:34]CodeQuestion:5:=ZTableauVersTexte(->$TbCodeReponseQuestionCourant; ".")
							SAVE RECORD:C53([QuizzQuestions:34])
						End if 
					End if 
				End for 
				ARRAY TO SELECTION:C261($TbCo; [QuizzReponses:33]CodeReponse:5)  //affectation des nouveaux codes
				
				QUERY:C277([QuizzQuestionnaires:35]; [QuizzQuestionnaires:35]ID:1=$IdQuestionnaire)
				$Envoi:=QuizzEcritHTMLCdF  // recalcul du chemin de fer
				WEB SEND TEXT:C677($Envoi)
				
			: ($Action="Q")  // ajouter une question liée à la réponse
				QUERY:C277([QuizzQuestions:34]; [QuizzQuestions:34]ID:1=[QuizzReponses:33]IDQuestion:2)
				$IdReponseAppelante:=[QuizzReponses:33]ID:1
				// une question
				CREATE RECORD:C68([QuizzQuestions:34])
				[QuizzQuestions:34]IDQuestionnaire:2:=$IdQuestionnaire
				// [QuizzQuestions]IDReponseMere:=$IdReponseAppelante
				[QuizzQuestions:34]CodeQuestion:5:=[QuizzReponses:33]CodeReponse:5
				SAVE RECORD:C53([QuizzQuestions:34])
				// deux réponses
				CREATE RECORD:C68([QuizzReponses:33])
				[QuizzReponses:33]IDQuestion:2:=[QuizzQuestions:34]ID:1
				[QuizzReponses:33]LibelReponse:3:=""
				[QuizzReponses:33]CodeReponse:5:=[QuizzQuestions:34]CodeQuestion:5+".1"
				SAVE RECORD:C53([QuizzReponses:33])
				CREATE RECORD:C68([QuizzReponses:33])
				[QuizzReponses:33]IDQuestion:2:=[QuizzQuestions:34]ID:1
				[QuizzReponses:33]LibelReponse:3:=""
				[QuizzReponses:33]CodeReponse:5:=[QuizzQuestions:34]CodeQuestion:5+".2"
				SAVE RECORD:C53([QuizzReponses:33])
				// Chemin de fer
				QUERY:C277([QuizzQuestionnaires:35]; [QuizzQuestionnaires:35]ID:1=$IdQuestionnaire)
				$Envoi:=QuizzEcritHTMLCdF  // recalcul du chemin de fer
				WEB SEND TEXT:C677($Envoi)
		End case 
		
	: ($Tble="E")
		If ($Action="A")  // Ajout d'une question en fin de questionnaire
			QUERY:C277([QuizzQuestions:34]; [QuizzQuestions:34]IDQuestionnaire:2=$IdQuestionnaire)
			SELECTION TO ARRAY:C260([QuizzQuestions:34]CodeQuestion:5; $TbCodeQuestion)
			$FT:=Size of array:C274($TbCodeQuestion)
			ARRAY LONGINT:C221($TbDerIndicesChapitreCodeCourant; $FT)
			For ($Salé; 1; $FT)
				ARRAY TEXT:C222($TbIndices; 0)
				ZTexteVersTableau($TbCodeQuestion{$Salé}; ->$TbIndices; ".")
				If (Size of array:C274($TbIndices)=2)  // seulement les questions principales
					$TbDerIndicesChapitreCodeCourant{$Salé}:=Num:C11($TbIndices{2})
				End if 
			End for 
			$procheIndiceN:=Max:C3($TbDerIndicesChapitreCodeCourant)+1
			//$L:=0
			//$FT:=Taille tableau($TbCodeQuestion)
			//Boucle ($Salé;1;$FT)
			//$CodeCourant:=$TbCodeQuestion{$Salé}
			//$Pos:=Position(".";$CodeCourant)
			//$Reste:=Sous chaîne($CodeCourant;($Pos+1))
			//$Pos:=Position(".";$Reste)
			//$L:=$L+Num($Pos=0)
			//Fin de boucle 
			
			$IndiceA:=String:C10($procheIndiceN)
			CREATE RECORD:C68([QuizzQuestions:34])
			[QuizzQuestions:34]CodeQuestion:5:=String:C10($IdQuestionnaire)+"."+$IndiceA
			[QuizzQuestions:34]IDQuestionnaire:2:=$IdQuestionnaire
			SAVE RECORD:C53([QuizzQuestions:34])
			
			// deux réponses
			CREATE RECORD:C68([QuizzReponses:33])
			[QuizzReponses:33]IDQuestion:2:=[QuizzQuestions:34]ID:1
			[QuizzReponses:33]LibelReponse:3:=""
			[QuizzReponses:33]CodeReponse:5:=[QuizzQuestions:34]CodeQuestion:5+".1"
			SAVE RECORD:C53([QuizzReponses:33])
			CREATE RECORD:C68([QuizzReponses:33])
			[QuizzReponses:33]IDQuestion:2:=[QuizzQuestions:34]ID:1
			[QuizzReponses:33]LibelReponse:3:=""
			[QuizzReponses:33]CodeReponse:5:=[QuizzQuestions:34]CodeQuestion:5+".2"
			SAVE RECORD:C53([QuizzReponses:33])
			// Chemin de fer
			QUERY:C277([QuizzQuestionnaires:35]; [QuizzQuestionnaires:35]ID:1=$IdQuestionnaire)
			$Envoi:=QuizzEcritHTMLCdF  // recalcul du chemin de fer
			WEB SEND TEXT:C677($Envoi)
		End if 
		
	Else 
		// TRACE
End case 
QuizzFabriqueTbGeneraux
ZAmnistieInternationale