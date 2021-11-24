//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
$chemin:=Data file:C490
SET TEXT TO PASTEBOARD:C523($chemin)
$FenetreInformation:="The database filename is ready to be paste.\n"+$chemin
displayInfo ($FenetreInformation)