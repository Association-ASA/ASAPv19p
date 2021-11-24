Class constructor
	
	
Function cracheNumLaboN($identificateur : Text; $type : Text)->$num : Integer
/*
 $num = n° labo ou numéro d'adhérent 
 $identificateur = chaine à décoder = le mot de passe 10 caractères
 $type = "labo" ou "adh" 
*/
	
	Case of 
		: ($type="adh")  // on cherche le n° d'adhérent
			$A:=Substring:C12($identificateur; 1; 5)
			
		: ($type="labo")  // on cherche le n° de laboratoire
			$A:=Substring:C12($identificateur; 6; 5)
			
	End case 
	
	
	$Chiffre:=""
	Case of 
		: ($A="H@") | ($A="R@")  // le code adherent n'a qu'un seul caractère
			$Chiffre:=String:C10(Character code:C91($A[[2]])-112)
			
		: ($A="U@") | ($A="P@")  // le code adherent 2 caractères
			$Chiffre:=String:C10(((Character code:C91($A[[2]])-112)*10)+(Character code:C91($A[[3]])-80))
			
		: ($A="F@") | ($A="S@")  // le code adherent 3 caractères
			$Chiffre:=String:C10(((Character code:C91($A[[2]])-112)*100)+((Character code:C91($A[[3]])-80)*10)+(Character code:C91($A[[4]])-80))
			
		: ($A="G@") | ($A="Z@")  // le code adherent 4 caractères
			$Chiffre:=String:C10(((Character code:C91($A[[2]])-112)*1000)+((Character code:C91($A[[3]])-80)*100)+((Character code:C91($A[[4]])-80)*10)+(Character code:C91($A[[5]])-80))
			
	End case 
	
	$num:=Num:C11($Chiffre)