//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm 
// Date et heure : 10/09/21, 06:40:18
// ----------------------------------------------------
// Méthode : QuizzEcritHTMLPUMPhotoSup
// Description
// Fonction qui renvoie le HTML du menu local 
//  en fonction des valeurs possibles 
// du tableau passé en premier paramètre
// Paramètres : $1=Pt sur tableau des valeurs
//              $2=propriété de [XData]XObjet
//              $3=Rang de la photo ($Salé de QuizzListePhotosQuizz)
// ----------------------------------------------------
C_LONGINT:C283($Salé; $FT)
$PtTb:=$1
$Proprio:=$2
$Rang:=$3
$ValeurAnt:=""
$ValeurAnt:=(Num:C11($Proprio[[1]]="e")*TbEspecePhoto{$Rang})+(Num:C11($Proprio[[1]]="l")*TbLesionPhoto{$Rang})
$FT:=Size of array:C274($PtTb->)
$PUM:="     <select id="+<>ZGuil+"PUM"+$Proprio+TbUUIDPhoto{$Rang}+<>ZGuil+" class="+<>ZGuil+"textebanalgrand"+<>ZGuil+">"+<>ZCR
$Selected:=Num:C11($ValeurAnt=("Choisissez une "+$Proprio))*"selected "
$PUM:=$PUM+"       <option "+$Selected+" value="+<>ZGuil+"0"+<>ZGuil+" >Choisissez une "+$Proprio+"</option>"+<>ZCR
For ($Salé; 1; $FT)
	$Valeur:=$PtTb->{$Salé}
	If (Count parameters:C259=3)
		$Selected:=Num:C11($ValeurAnt=$Valeur)*"selected "
	Else 
		$Selected:=Num:C11($4=$Valeur)*"selected "
	End if 
	$PUM:=$PUM+"       <option "+$Selected+" value="+<>ZGuil+String:C10($Salé)+<>ZGuil+" >"+$Valeur+"</option>"+<>ZCR
End for 
$0:=$PUM+"     </select>"
