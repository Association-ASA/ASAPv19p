//%attributes = {"lang":"fr"}

// ----------------------------------------------------
// Nom utilisateur : cgm
// Date et heure : 28/11/17, 08:17:25
// ----------------------------------------------------
// Méthode : WebAffichePageAsaDia
// Description
// Permet d'afficher la page d'AsaDia sans changer ni le bandeau, ni le pied
//
// Paramètre $1=message ajax type ajaxpageAjaxLesionF£cegeheme@wanadoo.fr
// ----------------------------------------------------


C_TEXT:C284($1; $Mess; $Page; $HTML)
$Mess:=$1

$Page:=Substring:C12($Mess; 13)  // le nom de la page à afficher
$Pos:=Position:C15("£"; $Page)
VarLogin:=Substring:C12($Page; ($Pos+1))
$Page:=Substring:C12($Page; 1; ($Pos-1))
Gibier:=($Page[[Length:C16($Page)]]="G")
$IndiceLangue:=Length:C16($Page)-Num:C11(Gibier)

Case of 
	: ($Page="Moti@")
		DiaWebAbouleListeMotif
		
	: ($Page="Les@")
		$Langue:=$Page[[$IndiceLangue]]
		DiaWebAbouleListeLesion($Langue; True:C214)
		//EXÉCUTER MÉTHODE($Methode)
		//Si ($Page="@A")
		//WebAbouleListeLesionA
		//Sinon
		//WebAbouleListeLesionF
		//Fin de si
		
	: ($Page="Diapo@")
		$Langue:=$Page[[$IndiceLangue]]
		DiaWebAbouleListeDiapo($Langue; False:C215)
		//Si ($Page="@A")
		//WebAbouleListeDiapoA
		//Sinon
		//WebAbouleListeDiapoF
		//Fin de si
		
	: ($Page="Diagnos@")
		$Langue:=$Page[[$IndiceLangue]]+(Num:C11(Gibier)*"G")
		DiaWebEcritPageDiagnose($Langue; False:C215)
		//Si ($Page="@A")
		//WebEcritPageDiagnoseA
		//Sinon
		//WebEcritPageDiagnoseF
		//Fin de si
		
		
	: ($Page="Organes@")
		DiaWebAbouleOrganesSains
		
	: ($Page="Quizz@")
		DiaWebAbouleListeQuizz
		
	: ($Page="Text@")
		DiaWebEcritPageTexte
		
	: ($Page="panier@")
		$Langue:=$Page[[Length:C16($Page)]]
		DiaWebAbouleListePaniers($Langue)
		
	: ($Page="lancerpanier@")
		$Langue:=$Page[[Length:C16($Page)]]
		DiaWebPanierDiaporama($Langue)
End case 
