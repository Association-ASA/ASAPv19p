//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 07/05/18, 16:22:57
// ----------------------------------------------------
// Paramètres
// $1 = Chaine à traiter retournée dans $Chaine
// $2 = Type de traitement (Entier long)
// {$3} = Longueur minimale des mots à capitaliser (0 par défaut)
// ----------------------------------------------------
// Méthode : ZCapitaliseChaine
// Description
//  Récupéré initialement de Pole Contact, Mimosa

//  Valeurs possibles pour $2 
//   1 = Enlever les espaces devant
//   2 = Enlever les espaces après
//   3 = Enlever les espaces devant et après
//   4 = Capitalisation de la première de chaque mot
//   8 = Suppression des espaces redoublés
//   15 = Tous les traitements


C_TEXT:C284($1; $Chaine)
C_LONGINT:C283($2; $3; $i; $n; $Position)
C_BOOLEAN:C305($delSpaceBefore; $delSpaceAfter; $capitalizeFiestLetter; $testMinLength; $capitalizeFiestLetter)

$testMinLength:=(Count parameters:C259=3)
$Position:=-10000  //Valeur absurde

$Chaine:=$1
$0:=$Chaine  //Retour par défaut

If ($Chaine#"")
	$delSpaceBefore:=($2%2=1)  //Premier bit
	$2:=$2\2
	$delSpaceAfter:=($2%2=1)  //Second bit
	$2:=$2\2
	$capitalizeFiestLetter:=($2%2=1)  //Troisième bit
	$2:=$2\2
	$capitalizeFiestLetter:=($2%2=1)  //Quatrième bit
	$2:=$2\2
	
	
	If ($capitalizeFiestLetter)
		Repeat 
			$Chaine:=Replace string:C233($Chaine; "  "; " ")  //Suppression des espaces redoublés
		Until (Position:C15("  "; $Chaine)=0)
	End if   //$capitalizeFiestLetter
	
	$n:=Length:C16($Chaine)
	
	If ($delSpaceBefore)
		For ($i; 1; $n)
			If ($Chaine[[$i]]#" ")
				$Chaine:=Substring:C12($Chaine; $i)
				$i:=$n
			End if 
		End for 
	End if   //$SupprimerEspacesAvant
	
	If ($delSpaceAfter)
		$Chaine:="*"+$Chaine  //* pour éviter les indices nuls
		$n:=Length:C16($Chaine)+1
		
		Repeat 
			$n:=$n-1
		Until ($Chaine[[$n]]#" ")
		
		$Chaine:=Substring:C12($Chaine; 2; $n-1)  //On ne prend pas en compte *
	End if   //$delSpaceAfter
	
	If ($capitalizeFiestLetter)
		$n:=Length:C16($Chaine)
		
		If ($n>0)
			$Chaine:=Lowercase:C14($Chaine)  //Tout en minuscules par défaut
			$Chaine[[1]]:=Uppercase:C13($Chaine[[1]])  //Première lettre en majuscules
			
			For ($i; 2; $n-1)  //Pour chaque lettre
				If ($Chaine[[$i]]=" ")  //Espace
					If ($testMinLength)
						If (($i-$Position)<=$3)  //Mot trop court (test toujours faux au premier passage)
							$Chaine[[$Position]]:=Lowercase:C14($Chaine[[$Position]])  //On repasse la capitale du mot précèdent en minuscule
						End if 
					End if 
					
					$Position:=$i+1  //Mémorise la position de la majuscule
					$Chaine[[$Position]]:=Uppercase:C13($Chaine[[$Position]])  //On la passe en majuscule (quitte à changer d'avis si le mot s'avère trop court)
					$i:=$Position
				End if   //Espace
			End for   //$i
			
		End if   //$n>0
	End if   //$capitalizeFiestLetter
	
	$0:=$Chaine
End if   //$1#""