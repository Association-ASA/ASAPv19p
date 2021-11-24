//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 22/05/19, 17:24:12
// ----------------------------------------------------
// Méthode : Ad3TrouveVisiteur
// Description
// Méthode qui renvoie le type de visiteur
//  en fonction du login
// Paramètres$1=login
// ----------------------------------------------------
$login:=$1
Case of 
	: ($login="@gouv.fr")
		$visiteur:="Abattoirs"
		
	: ($login="@alfort.fr")
		$visiteur:="ENVA"
		
	: ($login="@vetagro-sup.fr")
		$visiteur:="ENVL"
		
	: ($login="@oniris-nantes.fr")
		$visiteur:="ENVN"
		
	: ($login="@envt.fr")
		$visiteur:="ENVT"
		
	: ($login="@ulg.ac.be") | ($login="ulg") | ($login="@uliege.be")
		$visiteur:="ULG"
		
	: ($login="cegeheme@wanadoo.fr") | ($login="coucou, c'est Papa") | ($login="Cegehem@wanadoo.fr") | ($login="claude.grandmontagne@gmail.com")
		$visiteur:="CGM"
		
	Else 
		$visiteur:="Autres"
		
End case 
$0:=$visiteur