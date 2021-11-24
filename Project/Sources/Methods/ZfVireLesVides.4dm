//%attributes = {"publishedWeb":true}

  // ----------------------------------------------------
  // Nom utilisateur : cgm 
  // Date et heure : 21/06/17, 14:04:42
  // ----------------------------------------------------
  // Méthode : ZfVireLesVides
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------


C_LONGINT:C283($VlCar)
$Chaine:=$1
$Lim:=Length:C16($Chaine)
For ($VlCar;Length:C16($Chaine);1;-1)
	If ($Chaine[[$VlCar]]#" ") & ($Chaine[[$VlCar]]#<>ZCR) & ($Chaine[[$VlCar]]#<>ZTab) & ($Chaine[[$VlCar]]#Char:C90(10)) & ($Chaine[[$VlCar]]#" ")
		$Lim:=$VlCar
		$VlCar:=0
	Else 
		$Lim:=$VlCar-1
	End if 
End for 
If ($Lim=0)
	$0:=""
Else 
	$0:=Substring:C12($Chaine;1;$Lim)
End if 