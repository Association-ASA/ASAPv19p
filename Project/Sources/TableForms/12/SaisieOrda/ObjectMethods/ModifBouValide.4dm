//C_BOOLEAN($LettrePasEnvoyée)
//$LettrePasEnvoyée:=OB Get([Personnes]Arguments; "LettreCodeMdPAEnvoyer"; Is boolean)
//If ($LettrePasEnvoyée)
//CONFIRM("Editer la lettre contenant le code et le mot de passe ?")
//If (OK=1)
//ASAPImprimeLettreCodeMdP
//End if 
//End if 

Form:C1466.changed:=True:C214