//%attributes = {}

  // ----------------------------------------------------
  // Nom utilisateur (OS) : cgm
  // Date et heure : 28/09/13, 14:10:26
  // ----------------------------------------------------
  // Méthode : AsaDiaFabriqueTbMin
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------
C_LONGINT:C283($Pos)
C_TEXT:C284($Tout;$T)
$Doc:=$1
$T:=$2

$CR:=Char:C90(Retour chariot:K15:38)
$Tab:=Char:C90(Tabulation:K15:37)

RECEIVE PACKET:C104($Doc;$Tout;$T)
  // FIXER TEXTE DANS CONTENEUR($Tout)
$0:=$Tout
ARRAY TEXT:C222(<>TbMailAsa;0)
ARRAY TEXT:C222(<>TbTypeLicence;0)
ARRAY INTEGER:C220(<>TbNbAutor;0)
ARRAY INTEGER:C220(<>TbNbUtil;0)
ARRAY TEXT:C222(<>TbMailUtil;0)
$Pos:=Position:C15($CR;$Tout)
$Reste:=Substring:C12($Tout;($Pos+1))
Repeat 
	$Pos:=Position:C15($CR;$Reste)
	$Ligne:=Substring:C12($Reste;1;($Pos-1))
	$Reste:=Substring:C12($Reste;($Pos+1))
	If ($Ligne#"")
		$Pos:=Position:C15($Tab;$Ligne)
		$email:=Substring:C12($Ligne;1;($Pos-1))
		If ($email[[1]]=Char:C90(10))
			$email:=Substring:C12($email;2)
		End if 
		If ($email[[Length:C16($email)]]=" ")
			$email:=Substring:C12($email;1;Length:C16($email)-1)
		End if 
		If (Find in array:C230(<>TbMailAsa;$email)<0)  // non doublon
			APPEND TO ARRAY:C911(<>TbMailAsa;$email)
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15($Tab;$Ligne)
			APPEND TO ARRAY:C911(<>TbNbAutor;Num:C11(Substring:C12($Ligne;1;($Pos-1))))
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15($Tab;$Ligne)
			APPEND TO ARRAY:C911(<>TbTypeLicence;Substring:C12($Ligne;1;($Pos-1)))
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			
			$Pos:=Position:C15($Tab;$Ligne)
			APPEND TO ARRAY:C911(<>TbNbUtil;Num:C11(Substring:C12($Ligne;1;($Pos-1))))
			$Ligne:=Substring:C12($Ligne;($Pos+1))
			
			APPEND TO ARRAY:C911(<>TbMailUtil;$Ligne)
			
		Else 
			  //TRACE
		End if 
	End if 
Until ($Pos=0)