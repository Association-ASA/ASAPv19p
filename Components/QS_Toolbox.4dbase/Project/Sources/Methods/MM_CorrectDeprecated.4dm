//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 28/09/17, 16:17:47
// ----------------------------------------------------
// Méthode : SUPPORT_CorrectDeprecated
// Description
//  
//
// Paramètres
// ----------------------------------------------------
// Idée initiale de B. Soubeyrand.
// Basée sur http://doc.4d.com/4Dv16/4D/16.2/Commandes-obsoletes.906-3432764.fe.html

C_LONGINT:C283($i)
C_LONGINT:C283($L_Start)
C_BOOLEAN:C305($B_Modified; $ToUpdate; $Option1; $Option2)
C_LONGINT:C283($OnErrCall; gerror)
C_TEXT:C284($langage; $old; $new)
C_COLLECTION:C1488($deprecated; $toDeprecated; $workingMethod)
C_OBJECT:C1216($toExecute)
C_REAL:C285($Progressing; $pas)

$deprecated:=New collection:C1472
$workingMethod:=New collection:C1472

// Section des commandes à mettre en commentaires car "Ne plus utiliser"
// ---------------------------------------------------------------------

// _o_GRAPH TABLE  
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(148); "action"; "Set as comment"; "oldDirective"; "(?mi-s)(.*)("+Command name:C538(148)+")(.*)"; "newDirective"; "//\\1\\2\\3"))

//   _o_Convert case 
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(360); "action"; "Set as comment"; "oldDirective"; "(?mi-s)(.*)("+Command name:C538(360)+")(.*)"; "newDirective"; "//\\1\\2\\3"))

//   _o_ADD DATA SEGMENT 
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(361); "action"; "Set as comment"; "oldDirective"; "(?mi-s)(.*)("+Command name:C538(361)+")(.*)"; "newDirective"; "//\\1\\2\\3"))

//  _o_SET PLATFORM INTERFACE 
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(367); "action"; "Set as comment"; "oldDirective"; "(?mi-s)(.*)("+Command name:C538(367)+")(.*)"; "newDirective"; "//\\1\\2\\3"))

// _o_REDRAW LIST 
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(382); "action"; "Set as comment"; "oldDirective"; "(?mi-s)("+Command name:C538(382)+")"; "newDirective"; "//\\1"))

//  _o_Font number 
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(461); "action"; "Set as comment"; "oldDirective"; "(?mi-s)(.*)("+Command name:C538(461)+")(.*)"; "newDirective"; "//\\1\\2\\3"))

//  _o_Font name
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(462); "action"; "Set as comment"; "oldDirective"; "(?mi-s)(.*)("+Command name:C538(462)+")(.*)"; "newDirective"; "//\\1\\2\\3"))

// _o_Get platform interface
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(470); "action"; "Set as comment"; "oldDirective"; "(?mi-s)(.*)("+Command name:C538(470)+")(.*)"; "newDirective"; "//\\1\\2\\3"))

//   _o_DELETE RESOURCE 
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(501); "action"; "Set as comment"; "oldDirective"; "(?mi-s)(.*)("+Command name:C538(501)+")(.*)"; "newDirective"; "//\\1\\2\\3"))

//  _o_SET PICTURE RESOURCE 
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(503); "action"; "Set as comment"; "oldDirective"; "(?mi-s)(.*)("+Command name:C538(503)+")(.*)"; "newDirective"; "//\\1\\2\\3"))

// _o_SET TEXT RESOURCE 
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(505); "action"; "Set as comment"; "oldDirective"; "(?mi-s)(.*)("+Command name:C538(505)+")(.*)"; "newDirective"; "//\\1\\2\\3"))

// _o_SET STRING RESOURCE 
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(507); "action"; "Set as comment"; "oldDirective"; "(?mi-s)(.*)("+Command name:C538(507)+")(.*)"; "newDirective"; "//\\1\\2\\3"))

// _o_SET RESOURCE 
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(509); "action"; "Set as comment"; "oldDirective"; "(?mi-s)(.*)("+Command name:C538(509)+")(.*)"; "newDirective"; "//\\1\\2\\3"))

//  _o_SET RESOURCE NAME 
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(514); "action"; "Set as comment"; "oldDirective"; "(?mi-s)(.*)("+Command name:C538(514)+")(.*)"; "newDirective"; "//\\1\\2\\3"))

// _o_SET RESOURCE PROPERTIES 
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(516); "action"; "Set as comment"; "oldDirective"; "(?mi-s)(.*)("+Command name:C538(516)+")(.*)"; "newDirective"; "//\\1\\2\\3"))

// _o_SET WEB DISPLAY LIMITS  --> Si appelé, erreur 33
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(620); "action"; "Set as comment"; "oldDirective"; "(?mi-s)(.*)("+Command name:C538(620)+")(.*)"; "newDirective"; "//\\1\\2\\3"))

// _o_SET WEB TIMEOUT   --> Si appelé, erreur 33
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(622); "action"; "Set as comment"; "oldDirective"; "(?mi-s)(.*)("+Command name:C538(622)+")(.*)"; "newDirective"; "//\\1\\2\\3"))

// _o_Web Context --> Si appelé, erreur 33
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(647); "action"; "Set as comment"; "oldDirective"; "(?mi-s)(.*)("+Command name:C538(647)+")(.*)"; "newDirective"; "//\\1\\2\\3"))

// _o_Get component resource ID 
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(699); "action"; "Set as comment"; "oldDirective"; "(?mi-s)(.*)("+Command name:C538(699)+")(.*)"; "newDirective"; "//\\1\\2\\3"))

// _o_SET CGI EXECUTABLE --> Si appelé, erreur 33
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(813); "action"; "Set as comment"; "oldDirective"; "(?mi-s)(.*)("+Command name:C538(813)+")(.*)"; "newDirective"; "//\\1\\2\\3"))

// Section des commandes qui nécessitent une mise à jour
// -----------------------------------------------------

// before -> On Load 
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(29); "action"; "Replace by "+Choose:C955($langage="fr"; "Evenement formulaire=sur chargement"; "Form event=On Load"); "oldDirective"; "(?mi-s)("+Command name:C538(29)+")"; "newDirective"; Choose:C955($langage="fr"; "Evenement formulaire=sur chargement"; "Form event=On Load")))

// _o_during 
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(30); "action"; "Replace by "+Choose:C955($langage="fr"; "Evenement formulaire=sur clic"; "Form event=On Clicked"); "oldDirective"; "(?mi-s)("+Command name:C538(30)+")"; "newDirective"; Choose:C955($langage="fr"; "Evenement formulaire=sur clic"; "Form event=On Clicked")))

// After --> On Validate
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(31); "action"; "Replace by "+Choose:C955($langage="fr"; "Evenement formulaire=Sur validation"; "Form event=On Validate"); "oldDirective"; "(?mi-s)("+Command name:C538(31)+")"; "newDirective"; Choose:C955($langage="fr"; "Evenement formulaire=Sur validation"; "Form event=On Validate")))

// En entete  -> Sur entête
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(112); "action"; "Replace by "+Choose:C955($langage="fr"; "Evenement formulaire=sur entête"; "Form event=On Header"); "oldDirective"; "(?mi-s)("+Command name:C538(112)+")"; "newDirective"; Choose:C955($langage="fr"; "Evenement formulaire=sur entête"; "Form event=On Header")))

// En rupture  -> Sur impression sous total
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(113); "action"; "Replace by "+Choose:C955($langage="fr"; "Evenement formulaire=Sur impression sous total"; "Form event=On Printing Break"); "oldDirective"; "(?mi-s)("+Command name:C538(113)+")"; "newDirective"; Choose:C955($langage="fr"; "Evenement formulaire=Sur impression sous total"; "Form event=On Printing Break")))

// En pied  -> Sur impression pied de page
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(191); "action"; "Replace by "+Choose:C955($langage="fr"; "Evenement formulaire=Sur impression pied de page"; "Form event=On Printing Footer"); "oldDirective"; "(?mi-s)("+Command name:C538(191)+")"; "newDirective"; Choose:C955($langage="fr"; "Evenement formulaire=Sur impression pied de page"; "Form event=On Printing Footer")))

//_o_ACTIVER BOUTON ({*;}object) 
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(192); "action"; "Replace by "+Command name:C538(1123)+" -> true"; "oldDirective"; "(?mi-s)("+Command name:C538(192)+"\\(([^\\)]*)\\))"; "newDirective"; Command name:C538(1123)+"(\\2;"+Command name:C538(214)+")"))

//_o_INACTIVER BOUTON({*;}object) 
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(193); "action"; "Replace by "+Command name:C538(1123)+" -> false"; "oldDirective"; "(?mi-s)("+Command name:C538(193)+"\\(([^\\)]*)\\))"; "newDirective"; Command name:C538(1123)+"(\\2;"+Command name:C538(215)+")"))

// _o_array string
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(218); "action"; "Replace by "+Command name:C538(222); "oldDirective"; "(?mi-s)("+Command name:C538(218)+"\\(\\d*;([^\\)]*)\\))"; "newDirective"; Command name:C538(222)+"(\\2)"))

// _o_c_integer
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(282); "action"; "Replace by "+Command name:C538(283); "oldDirective"; "(?mi-s)("+Command name:C538(282)+"\\(([^\\)]*)\\))"; "newDirective"; Command name:C538(283)+"(\\2)"))

// _o_c_string
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(293); "action"; "Replace by "+Command name:C538(284); "oldDirective"; "(?mi-s)("+Command name:C538(293)+"\\(([^\\)]*)\\))"; "newDirective"; Command name:C538(284)+"(\\2)"))

// Self
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(308); "action"; "Replace by "+Command name:C538(1124); "oldDirective"; "(?mi-s)("+Command name:C538(308)+")+"; "newDirective"; "("+Command name:C538(1124)+"(Object current:K67:2))"))

// Outside call
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(328); "action"; "Replace by "+Choose:C955($langage="fr"; "Evenement formulaire=Sur appel extérieur"; "Form event=On Outside Call"); "oldDirective"; "(?mi-s)("+Command name:C538(328)+")"; "newDirective"; Choose:C955($langage="fr"; "Evenement formulaire=Sur appel extérieur"; "Form event=On Outside Call")))

// Activation
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(346); "action"; "Replace by "+Choose:C955($langage="fr"; "Evenement formulaire=Sur activation"; "Form event=On activate"); "oldDirective"; "(?mi-s)("+Command name:C538(346)+")"; "newDirective"; Choose:C955($langage="fr"; "Evenement formulaire=Sur activation"; "Form event=On activate")))

// Desactivation
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(347); "action"; "Replace by "+Choose:C955($langage="fr"; "Evenement formulaire=Sur désactivation"; "Form event=On Deactivate"); "oldDirective"; "(?mi-s)("+Command name:C538(347)+")"; "newDirective"; Choose:C955($langage="fr"; "Evenement formulaire=Sur désactivation"; "Form event=On Deactivate")))

//     _o_QT COMPRESS PICTURE    ->  CONVERT PICTURE
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(355); "action"; "Replace by "+Command name:C538(1002); "oldDirective"; "(?mi-s)("+Command name:C538(355)+")(.*)"; "newDirective"; Command name:C538(1002)+"\\2"))

//    _o_DATA SEGMENT LIST()  ->  Data file
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(527); "action"; "You have to use: "+Command name:C538(490); "oldDirective"; "(?mi-s)(.*)("+Command name:C538(527)+")(.*)"; "newDirective"; Command name:C538(490)))

//  //    _o_INTEGRATE LOG FILE -> INTEGRATE MIRROR LOG FILE
//$deprecated.push(New object("toDo";False;"toUpdate";Command name(927);"action";"You have to use: "+Command name(1312);"oldDirective";"(?mi-s)(.*)("+Command name(927)+")(.*)";"newDirective";Command name(1312)))


// DOM SET XML DECLARATION ( refElément ; encodage {; autonome {; indentation}} )  
// --> Indentation must be replaced by XML SET OPTIONS
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(859); "action"; "Replace by "+Command name:C538(1090); "oldDirective"; "(?mi-s)("+Command name:C538(859)+")(.*);(.*);(.*);(.*)"; "newDirective"; "\\1\\2;\\3;\\4)\n"+Command name:C538(1090)+"\\2;\\5"))

//    _o_USE EXTERNAL DATABASE     ->  SQL LOGIN 
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(959); "action"; "Replace by "+Command name:C538(817); "oldDirective"; "(?mi-s)("+Command name:C538(959)+")(.*)"; "newDirective"; Command name:C538(817)+"\\2"))

//    _o_USE INTERNAL DATABASE    ->  SQL LOGOUT  
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(960); "action"; "Replace by "+Command name:C538(872); "oldDirective"; "(?mi-s)("+Command name:C538(960)+")(.*)"; "newDirective"; Command name:C538(872)))

//     _o_PICTURE TYPE LIST   ->  PICTURE CODEC LIST 
$deprecated.push(New object:C1471("toDo"; False:C215; "toUpdate"; Command name:C538(681); "action"; "Replace by "+Command name:C538(992); "oldDirective"; "(?mi-s)("+Command name:C538(681)+")(.*)"; "newDirective"; Command name:C538(992)+"\\2"))

//  // _o_AP BLOB to print settings 
//$deprecated.push(New object("toDo";false;"toUpdate";Command name(61954);"action";"Replace by "+Command name(1434);"oldDirective";"(?mi-s)("+Command name(61954)+"\\(\\d*;([^\\)]*)\\))";"newDirective";Command name(1434)+"(\\2)"))

//  // _o_AP Print settings to BLOB 
//$deprecated.push(New object("toDo";false;"toUpdate";Command name(61955);"action";"Replace by "+Command name(1433);"oldDirective";"(?mi-s)("+Command name(61955)+"\\(\\d*;([^\\)]*)\\))";"newDirective";Command name(1433)+"(\\2)"))

// Initialisation, just in case
C_BOOLEAN:C305($Option1; $Option2)
C_OBJECT:C1216($Form)
C_LONGINT:C283($ref; $window)

$Form:=New object:C1471("options"; $deprecated; "option1"; 0; "option2"; 0; "methodSelected"; Form:C1466.methodSelected.length)
$ref:=Open form window:C675("_Deprecated"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
DIALOG:C40("_Deprecated"; $Form)
CLOSE WINDOW:C154
$toDeprecated:=$deprecated.filter("collFindTrue")  // We get only a collection on what we have to update

// --------------

If (($toDeprecated.length>0) | ($Form.option1=1) | ($Form.option2=1)) & (ok=1)
	
	$MESS:="Do you want to upgrade selected methods Now?"
	CONFIRM:C162($MESS; "Update methods now"; "I will make a backup first")
	
	If (ok=1)
		
		C_COLLECTION:C1488($workingMethod)
		If (Form:C1466.methodSelected.length>0)
			$workingMethod:=Form:C1466.methodSelected
		Else 
			$action:=False:C215
			If (x_io_confirm_yesNo("No methods selected. Do you want to continue on ALL methods?"; ->$action))
				$workingMethod:=Storage:C1525.allMethods
			End if 
		End if 
		
		If ($workingMethod.length>0)
			
			$OnErrCall:=0
			$methCourante:=Method called on error:C704
			ON ERR CALL:C155("BASE_GetError")
			
			// Barber
			//$BarIBuildArrays:=THERM_Init ("Updating declaration in "+String($workingMethod.length)+" methods.";"";"images/bevels/btn_attributes.png")
			
			// Initialisation
			C_OBJECT:C1216($param)
			$param:=New object:C1471("title"; "Updating declaration in "+String:C10($workingMethod.length)+" methods."; "icon"; "btn_attributes.png"; "type"; 0)
			QST_progress_start($param)
			$window:=$param.window
			
			$Progressing:=$workingMethod.length
			$Progression:=0
			$Pas:=1/($Progressing+1)
			
			// Work in progress
			$i:=0
			For each ($ent; $workingMethod)
				// for each method
				$B_Modified:=False:C215
				$L_Start:=1
				$Progression:=$Progression+$pas
				$i:=$i+1
				
				//If ($i%10=0)
				//Progress SET PROGRESS ($BarIBuildArrays;$Progression;"";True)
				//End if 
				
				$param.value:=$progression
				$param.content:=$ent.name
				CALL FORM:C1391($window; "progressBar_update"; $param)
				
				METHOD GET CODE:C1190($ent.name; $MethodeToCheck; *)
				
				For each ($toExecute; $toDeprecated)
					$old:=$toExecute.oldDirective
					$new:=$toExecute.newDirective
					$erreur:=REGEX_SubstituteText($old; $new; ->$MethodeToCheck)
					
					If ($erreur=0)
						$B_Modified:=True:C214
					End if 
					
				End for each 
				
				// Section des Caractères speciaux
				// Char(9|10|13|34) -> \t\n\r\"
				// --------------------------------
				If ($Form.option1=1)
					$ToUpdate:=(Position:C15(Command name:C538(90); $MethodeToCheck)>0)
					If ($ToUpdate)
						$vt_pattern:="(?mi-s)("+Command name:C538(90)+"\\((9|10|13|34)\\))"
						
						C_LONGINT:C283($vl_start)
						ARRAY LONGINT:C221($tl_pos; 0x0000)
						ARRAY LONGINT:C221($tl_len; 0x0000)
						C_LONGINT:C283($vl_ascii)
						C_TEXT:C284($vt_expression)
						
						$vl_start:=1
						
						While (Match regex:C1019($vt_pattern; $MethodeToCheck; $vl_start; $tl_pos; $tl_len))
							$vt_expression:=Substring:C12($MethodeToCheck; $tl_pos{1}; $tl_len{1})
							$vl_ascii:=Num:C11(Substring:C12($MethodeToCheck; $tl_pos{2}; $tl_len{2}))
							
							Case of 
								: ($vl_ascii=9)
									$vt_litteral:="\\t"
									
								: ($vl_ascii=10)
									$vt_litteral:="\\n"
									
								: ($vl_ascii=13)
									$vt_litteral:="\\r"
									
								: ($vl_ascii=34)
									$vt_litteral:="\\\""
							End case 
							$vt_litteral:="\""+$vt_litteral+"\""
							
							$MethodeToCheck:=Delete string:C232($MethodeToCheck; $tl_pos{1}; $tl_len{1})
							$MethodeToCheck:=Insert string:C231($MethodeToCheck; $vt_litteral; $tl_pos{1})
							
							$vl_start:=$tl_pos{1}+Length:C16($vt_litteral)
						End while 
						$B_Modified:=True:C214
						
					End if 
					
				End if 
				
				// Section du traitement des ajouts de chaines de caractères :   "xxx"+"yyy"  --> "xxxyyy"
				// Ce qui est enlevé correspond à la chaine    "+"
				// --------------------------------------------------
				
				If ($Form.option2=1)
					$vt_pattern:="(?mi-s)(\"\\+\")"
					
					C_LONGINT:C283($vl_start)
					ARRAY LONGINT:C221($tl_pos; 0x0000)
					ARRAY LONGINT:C221($tl_len; 0x0000)
					C_LONGINT:C283($vl_ascii)
					C_TEXT:C284($vt_expression)
					
					$vl_start:=1
					
					While (Match regex:C1019($vt_pattern; $MethodeToCheck; $vl_start; $tl_pos; $tl_len))
						$vt_expression:=Substring:C12($MethodeToCheck; $tl_pos{1}; $tl_len{1})
						$vt_litteral:=""
						
						$MethodeToCheck:=Delete string:C232($MethodeToCheck; $tl_pos{1}; $tl_len{1})
						$MethodeToCheck:=Insert string:C231($MethodeToCheck; $vt_litteral; $tl_pos{1})
						
						$vl_start:=$tl_pos{1}+Length:C16($vt_litteral)
					End while 
					$B_Modified:=True:C214
					
				End if 
				
				If ($B_Modified)
					METHOD SET CODE:C1194($ent.name; $MethodeToCheck; *)
					$ent.code:=$MethodeToCheck
					METHODS_clearCode($ent)
					If (gError=-9766)  // Method open in Edit mode
						$OnErrCall:=$OnErrCall+1
					End if 
				End if 
				
			End for each 
			
			ON ERR CALL:C155($methCourante)
			
			//$Progression:=1
			//Progress SET PROGRESS ($BarIBuildArrays;$Progression;"Done";True)
			//Progress QUIT ($BarIBuildArrays)
			
			$param.value:=1
			$param.content:="Clearing..."
			CALL FORM:C1391(Storage:C1525.windows.progress; "progressBar_update"; $param)
			PROCESS_sleep(10)
			
			$mess:="Update finished."+Choose:C955($OnErrCall#0; "\n\nSome methods were opened during the operation and haven't been updated."; "")
			$mess:=$mess+"\rMay you should perform a new DB analysis to update Command used."
			displayInfo($MESS; "red")
			
			KILL WORKER:C1390("QST_Progress")
			
		End if 
	End if 
	
Else 
	
	$mess:="No command to replace has been selected."
	displayInfo($MESS)
	
End if 