$L:=Find in array:C230(<>TbNomInstitution;[QuizzQuestionnaires:35]Institution:4)
$Sigle:=<>TbSigleInstitution{$L}
If (<>Ajar)
	$URL:="https://association.asa-spv.fr/creationquizz"+$Sigle+"_"
Else 
	$URL:="localhost:8080/creationquizz"+$Sigle
End if 
OPEN URL:C673($URL)