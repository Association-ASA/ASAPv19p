//%attributes = {}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : iMacASA2017
  // Date et heure : 24/07/19, 11:43:16
  // ----------------------------------------------------
  // Méthode : ASAPEcritAdresseFacturation
  // Description
  //   Méthode qui renvoie l'adresse de facturation
  // d'après l'enregistrement de [PersonnesAdresses] pertinent
  // ----------------------------------------------------
$Nom:=[Personnes:12]NomLong:2
$Adr1:=[PersonnesAdresses:11]LigneAdresse1:3
If ($Nom#$Adr1)
	$Adr:=[Personnes:12]NomLong:2+<>ZCR
Else 
	$Adr:=""
End if 
If ([PersonnesAdresses:11]LigneAdresse1:3#"")
	$Adr:=$Adr+[PersonnesAdresses:11]LigneAdresse1:3+<>ZCR
End if 
If ([PersonnesAdresses:11]LigneAdresse2:4#"")
	$Adr:=$Adr+[PersonnesAdresses:11]LigneAdresse2:4+<>ZCR
End if 
If ([PersonnesAdresses:11]LigneAdresse3:5#"")
	$Adr:=$Adr+[PersonnesAdresses:11]LigneAdresse3:5+<>ZCR
End if 
If ([PersonnesAdresses:11]LigneAdresse4:10#"")
	$Adr:=$Adr+[PersonnesAdresses:11]LigneAdresse4:10+<>ZCR
End if 
If ([PersonnesAdresses:11]CodePostal:6#"")
	$Adr:=$Adr+[PersonnesAdresses:11]CodePostal:6+" - "+[PersonnesAdresses:11]Ville:7
End if 
If ([PersonnesAdresses:11]Pays:8#"") & ([PersonnesAdresses:11]Pays:8#"France")
	$Adr:=$Adr+<>ZCR+[PersonnesAdresses:11]Pays:8
End if 

$0:=$Adr