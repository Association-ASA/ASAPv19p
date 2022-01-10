//%attributes = {"lang":"fr"}
// wgetStorageFromServer("tableaux")

// RELOAD PROJECT

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

// OPH_mng  // aide à l'écriture des requetes orda

// -------- 

// $es:=ds.Personnes.query("CampagneParticipations_Personnes.WebConnexions_CampagneParticipations.DateConnexion =:1"; !05/10/2021!)

//$es2:=ds.WebConnexions.query("DateConnexion =:1"; !05/10/2021!)
//$neededRelations:=ob_getByPath($es2; "CampagneParticipations_WebConnexions.Personnes_CampagneParticipations")

//$es1:=ds.WebConnexions.query("DateConnexion =:1"; !03/10/2021!)
//$neededRelations:=ob_getByPath($es1; "CampagneParticipations_WebConnexions.Personnes_CampagneParticipations.NomLong")

// 72A
$e:=ds:C1482.Personnes.query("UUID =:1 and CampagneParticipations_Personnes.UUID =:2"; "F90226EF5C4C72469E12661209E02D6D"; "351DF12F37734D75ABA674CB6B6E2424")
$e:=ds:C1482.Personnes.query("CampagneParticipations_Personnes.UUID =:1"; "351DF12F37734D75ABA674CB6B6E2424")


$e2:=