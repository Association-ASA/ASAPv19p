//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 26/04/19, 06:24:40
// ----------------------------------------------------
// Méthode : QuizzStockeChangement
// Description
//   Méthode qui stocke dans 4D la valeur changée
//     sans retour sur la page Web
// Paramètre : id de l'élément changé
// ----------------------------------------------------

C_LONGINT:C283($Salé; $FT; $NumTableInitial; $NumTable)
ON ERR CALL:C155("MéthodeErreur")
$Mess:=$1

// l'envoi final à la page Web
$Envoi:=""

$Mess:=Substring:C12($Mess; 17)  // élimination de 'changechampquizz'

// REPERAGE DE LA BONNE TABLE ET DU BON ENREGISTREMENT
// table concernée 
$Tble:=$Mess[[1]]
$InitialChamp:=$Mess[[2]]
$NumTableInitial:=Table:C252(->[QuizzQuestionnaires:35])  // N° de la table [QuizzQuestionnaires]
$NumTable:=(Num:C11($Tble="Q")*34)+(Num:C11($Tble="E")*35)+(Num:C11($Tble="R")*33)+(Num:C11($Tble="P")*36)  // Adieu Patrick !!!!
$PtTable:=Table:C252($Numtable)
// enregistrement concerné
$PtChampRecherche:=Field:C253($NumTable; 1)  // Le champ de recherche est le premier champ = clef primaire
$Pos:=Position:C15("£"; $Mess)
$TestA:=Substring:C12($Mess; 1; ($Pos-1))
$Valeur:=Replace string:C233(Substring:C12($Mess; ($Pos+1)); "£"; <>ZCR)
$TestN:=Num:C11($TestA)
READ WRITE:C146($PtTable->)
QUERY:C277($PtTable->; $PtChampRecherche->=$TestN)


// ATTRIBUTION DE LA VALEUR
Case of 
	: ($Tble="E")  // [QuizzQuestionnaires]
		Case of 
			: ($InitialChamp="A")  // auteur
				[QuizzQuestionnaires:35]Auteur:2:=$Valeur
				
			: ($InitialChamp="T")  // titre
				[QuizzQuestionnaires:35]Titre:3:=$Valeur
				
			Else   // que deux valeurs possibles à changer
				// TRACE
		End case 
		SAVE RECORD:C53([QuizzQuestionnaires:35])
		
	: ($Tble="Q")  // [QuizzQuestions]
		Case of 
			: ($InitialChamp="L")  // Libellé de la question
				[QuizzQuestions:34]LibelQuestion:3:=$Valeur
				SAVE RECORD:C53([QuizzQuestions:34])
				
			: ($InitialChamp="P")  // Liste des photos
				// TRACE
				// Création et envoi des photos à la page Web
				READ WRITE:C146([QuizzPhotos:36])
				RELATE MANY:C262([QuizzQuestions:34]ID:1)
				DELETE SELECTION:C66([QuizzPhotos:36])
				ARRAY TEXT:C222($TbNumDiaposA; 0)
				ZTexteVersTableau($Valeur; ->$TbNumDiaposA; " ")
				$FT:=Size of array:C274($TbNumDiaposA)
				//$Gourrance:=Faux  // Permet de savoir si on a bien une photo qui correspond à chaque valeur
				$ListePhotos:=""
				$CompteurPhoto:=1
				For ($Salé; 1; $FT)
					$L:=Find in array:C230(<>TbNumDia; Num:C11($TbNumDiaposA{$Salé}))
					If ($L>0)
						CREATE RECORD:C68([QuizzPhotos:36])
						[QuizzPhotos:36]CodePhoto:5:=[QuizzQuestions:34]CodeQuestion:5+"P"+String:C10($CompteurPhoto; "00")
						[QuizzPhotos:36]CommentairePhoto:4:=""
						[QuizzPhotos:36]IDQuestion:2:=$TestN
						[QuizzPhotos:36]NumPhotoA:3:=String:C10(<>TbNumDia{$L})
						SAVE RECORD:C53([QuizzPhotos:36])
						$ListePhotos:=$ListePhotos+" "+[QuizzPhotos:36]NumPhotoA:3
						$CompteurPhoto:=$CompteurPhoto+1
					Else   // Une chance au grattage dans les photos exotiques
						$L:=Find in array:C230(<>TbQuizzNumPhotoA; ($TbNumDiaposA{$Salé}))
						If ($L>0)
							CREATE RECORD:C68([QuizzPhotos:36])
							[QuizzPhotos:36]CodePhoto:5:=[QuizzQuestions:34]CodeQuestion:5+"P"+String:C10($CompteurPhoto; "00")
							[QuizzPhotos:36]CommentairePhoto:4:=""
							[QuizzPhotos:36]IDQuestion:2:=$TestN
							[QuizzPhotos:36]NumPhotoA:3:=<>TbQuizzNumPhotoA{$L}
							SAVE RECORD:C53([QuizzPhotos:36])
							$ListePhotos:=$ListePhotos+" "+$TbNumDiaposA{$Salé}
							$CompteurPhoto:=$CompteurPhoto+1
						End if 
						//$Gourrance:=Vrai  // Il s'est trompé : il faudra rectifier le champ des n° de photos
					End if 
				End for 
				$Liste:=Substring:C12($ListePhotos; 2)
				$Envoi:=$Liste+"§"+String:C10($TestN)+"£"+QuizzEcritHTMLPhotos($TestN)
				// STOCKER ENREGISTREMENT([QuizzQuestions])
				
				
				
			Else   // que deux valeurs possibles à changer
				// TRACE
		End case 
		
		
	: ($Tble="R")  // [QuizzReponses]
		Case of 
				
			: ($InitialChamp="T")  // texte de la réponse
				[QuizzReponses:33]LibelReponse:3:=$Valeur
				
			: ($InitialChamp="C")  // argumentation
				[QuizzReponses:33]ArgumentaireReponse:4:=$Valeur
				
			: ($InitialChamp="V")  // valeur de la réponse
				[QuizzReponses:33]ValeurReponse:6:=Num:C11($Valeur)
				
				
		End case 
		SAVE RECORD:C53([QuizzReponses:33])
		
	: ($Tble="P")  // [QuizzPhotos]
		[QuizzPhotos:36]CommentairePhoto:4:=$Valeur
		SAVE RECORD:C53([QuizzPhotos:36])
	Else   // que quatre tables possibles à changer
		// TRACE
End case 
ON ERR CALL:C155("")
WEB SEND TEXT:C677($Envoi)

