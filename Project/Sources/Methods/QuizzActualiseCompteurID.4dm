//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 24.10.19, 04:46:16
// ----------------------------------------------------
// Méthode : QuizzActualiseCompteurID
// Description
// Méthode qui actualise les compteurs d'incrémentation des ID
//  des tables de Quizz
// ----------------------------------------------------

ALL RECORDS:C47([QuizzPhotos:36])
ORDER BY:C49([QuizzPhotos:36]; [QuizzPhotos:36]ID:1; <)
SET DATABASE PARAMETER:C642([QuizzPhotos:36]; 31; [QuizzPhotos:36]ID:1)

ALL RECORDS:C47([QuizzQuestionnaires:35])
ORDER BY:C49([QuizzQuestionnaires:35]; [QuizzQuestionnaires:35]ID:1; <)
SET DATABASE PARAMETER:C642([QuizzQuestionnaires:35]; 31; [QuizzQuestionnaires:35]ID:1)

ALL RECORDS:C47([QuizzQuestions:34])
ORDER BY:C49([QuizzQuestions:34]; [QuizzQuestions:34]ID:1; <)
SET DATABASE PARAMETER:C642([QuizzQuestions:34]; 31; [QuizzQuestions:34]ID:1)

ALL RECORDS:C47([QuizzReponses:33])
ORDER BY:C49([QuizzReponses:33]; [QuizzReponses:33]ID:1; <)
SET DATABASE PARAMETER:C642([QuizzReponses:33]; 31; [QuizzReponses:33]ID:1)

ALL RECORDS:C47([QuizzSuivi:32])
ORDER BY:C49([QuizzSuivi:32]; [QuizzSuivi:32]ID:1; <)
SET DATABASE PARAMETER:C642([QuizzSuivi:32]; 31; [QuizzSuivi:32]ID:1)

