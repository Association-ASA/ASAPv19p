//%attributes = {"lang":"fr"}
//$ValeurCourante:="@cuire@"

//QUERY([Personnes]; [PersonnesAdresses]LigneAdresse1=$ValeurCourante; *)
//QUERY([Personnes];  | [PersonnesAdresses]LigneAdresse2=$ValeurCourante; *)
//QUERY([Personnes];  | [PersonnesAdresses]LigneAdresse3=$ValeurCourante)
////RELATE ONE SELECTION([PersonnesAdresses]; [Personnes])


//$es:=ds.Personnes.query("PersonnesAdresses_Personnes.LigneAdresse1 =:1 "+\
"or PersonnesAdresses_Personnes.LigneAdresse2 =:1 "+\
"or PersonnesAdresses_Personnes.LigneAdresse1 =:1"; $ValeurCourante)

//$ValeurCourante:="@alfort@"
//$es2:=ds.Personnes.query("PersonnesAdresses_Personnes.LigneAdresse1 =:1 "+\
"or PersonnesAdresses_Personnes.LigneAdresse2 =:1 "+\
"or PersonnesAdresses_Personnes.LigneAdresse1 =:1"; $ValeurCourante)

//$res:=$es.or($es2)

OPH_mng  // aide à l'écriture des requetes orda

// -------- 

// $es:=ds.Personnes.query("CampagneParticipations_Personnes.WebConnexions_CampagneParticipations.DateConnexion =:1"; !05/10/2021!)

//$es2:=ds.WebConnexions.query("DateConnexion =:1"; !05/10/2021!)
//$neededRelations:=ob_getByPath($es2; "CampagneParticipations_WebConnexions.Personnes_CampagneParticipations")

//$es1:=ds.WebConnexions.query("DateConnexion =:1"; !03/10/2021!)
//$neededRelations:=ob_getByPath($es1; "CampagneParticipations_WebConnexions.Personnes_CampagneParticipations.NomLong")
