//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// nom utilisateur (OS) : Patrick
// date et heure :
// ----------------------------------------------------
// méthode :
// description
//
//

// ------------ Déclarations de gestion standard du formulaire ------------

C_TEXT:C284($0; $1; $par_t; $formName_t; $LB_t; $error; $LB_t)
C_LONGINT:C283($2; $par_l; $params)
C_POINTER:C301($3; $par_p)

// ------------ Déclarations spécifique au formulaire ------------
C_BOOLEAN:C305(Konstant)

// ------------------------------------------
// initialisation des paramètres
// ------------------------------------------

$error:=""
$nmc_t:=Current method name:C684
$params:=Count parameters:C259
$formName_t:=Replace string:C233($nmc_t; "_mng"; "")
$currentPage:=FORM Get current page:C276

$par_t:=OBJECT Get name:C1087
$par_l:=Form event code:C388
$par_p:=OBJECT Get pointer:C1124

// ***
$LB_t:="LB_nom"  // définition du nom de la ListBox si nécessaire

// ***

If ($params>0)
	
	$par_t:=$1  // Object nale
	
	If ($params>1)
		
		$par_l:=$2  // event name
		
		If ($params>2)
			$par_p:=$3  // pointer on the object
		End if 
		
	End if 
End if 

If ($par_t="")  // lancement si pas de paramètre
	
	If ($par_l=0)  // si pas d'évènement formulaire
		$par_t:="K_processNew_t"  // demandons alors le lancement d'un nouveau process
	End if 
	
End if 

// ------------------------------------------
// démarrage de la gestion
// ------------------------------------------

Case of 
		
		// ------------------------------------------
		// lancement d'un nouveau process
		// ------------------------------------------
		
	: ($par_t="K_processNew_t")
		
		$pss_l:=Process number:C372($nmc_t)
		
		If ($pss_l#0)
			BRING TO FRONT:C326($pss_l)
		Else 
			$pss_l:=New process:C317($nmc_t; 0; $nmc_t; "K_openForm_t"; *)
		End if 
		
	: ($par_t="K_openForm_t")
		C_OBJECT:C1216($data)
		$data:=New object:C1471
		$win_l:=Open form window:C675($formName_t; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
		DIALOG:C40($formName_t; $data)
		CLOSE WINDOW:C154($win_l)
		
		// ------------------------------------------
		// gestion des évènements formulaire
		// ------------------------------------------
		
	: ($par_t=$formName_t)
		
		Case of 
				
			: ($par_l=On Load:K2:1)
				
				Form:C1466.languages:=New list:C375  // just to remember the ref and clean it
				APPEND TO LIST:C376(Form:C1466.languages; "En"; 1)
				APPEND TO LIST:C376(Form:C1466.languages; "Fr"; 2)
				
				OBJECT SET TITLE:C194(*; "GotoPage"; "Go to\\Converter")
				OBJECT SET TITLE:C194(*; "selectFrom"; "From: En")
				OBJECT SET TITLE:C194(*; "selectTo"; "To: Fr")
				
				(OBJECT Get pointer:C1124(Object named:K67:5; "searchConverter"))->:=""
				Konstant:=False:C215
				
				COMMANDS_Translation
				Form:C1466.display:=Form:C1466.command
				Form:C1466.display:=Form:C1466.display
				
			: ($par_l=On Unload:K2:2)
				CLEAR LIST:C377(Form:C1466.languages; *)
				
		End case 
		
		// ------------------------------------------
		// gestion des objets du formulaire. Evènement 'On Clicked' doit être activé sur les objets.
		// ------------------------------------------
		
		// -- Page 0 --
		
	: ($par_t="GotoPage")
		
		If (FORM Get current page:C276=1)
			OBJECT SET TITLE:C194(*; "GotoPage"; "Go to\\Command list")
			FORM GOTO PAGE:C247(2)
		Else 
			OBJECT SET TITLE:C194(*; "GotoPage"; "Go to\\Converter")
			FORM GOTO PAGE:C247(1)
		End if 
		
		displayInfo("")
		
		// ------------------------------------------
		// initialisation de la gestion des objets d'une ListBox
		// l'appel est de type : Methode_mng ("Nom de la LB";Form event)
		// ------------------------------------------
		
	: ($par_t=$LB_t)
		
		Case of 
				
			: ($par_l=On Clicked:K2:4)
				
		End case 
		
		// ------------------------------------------
		// RIEN n'est prévu pour cet objet
		// ------------------------------------------
		
	Else 
		
		$error:="Unexpected error on: "+$nmc_t+"\rObject name: "+$par_t+"\rEvent: "+String:C10($par_l)
		
End case 

If ($error#"")
	$0:=$error
End if 
