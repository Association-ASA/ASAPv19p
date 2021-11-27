//%attributes = {}
  //debugFormName_MO
  //Méthode objet, type texte non saisissable
  //Contexte formulaire courant en mode application
  // sur chargement, affiche le nom du form courant dans l'objet
  // sur clic, menu contextuel pour ouvrir :
  //   le formulaire dans son éditeur
  //   la méthode formulaire dans son éditeur ou son manager s'il existe
  //   le contenu de Form au format json

  //µ EJ le 08/01/20 appel dans conteneur sous formulaire "widgetFormulaire"
  //µ Arnaud * 00/06/2019 * ouvre le manager de form s'il existe 
  //µ Arnaud * 02/02/2019 
  //µ Arnaud * 24/05/2018
  //© Arnaud * 18/05/2018 

C_LONGINT:C283($1)
If (Not:C34(Is compiled mode:C492))
	
	If (Count parameters:C259>0)  // EJ le 08/01/20
		$event_l:=$1
	Else 
		$event_l:=Form event code:C388
	End if 
	
	$formObj_t:=OBJECT Get name:C1087
	
	Case of 
			
		: ($event_l=On Load:K2:1)
			
			If (True:C214)  //User_isDev)
				$table_p:=Current form table:C627
				If (Is nil pointer:C315($table_p))
					$nom_t:=Current form name:C1298
				Else 
					$nom_t:="["+Table name:C256($table_p)+"]"+Current form name:C1298
				End if 
				If (Type:C295(Self:C308->)=Is text:K8:3)
					OBJECT Get pointer:C1124(Object named:K67:5;$formObj_t)->:=" {/} "
				Else 
					OBJECT SET TITLE:C194(*;$formObj_t;" {/} ")
				End if 
				OBJECT SET HELP TIP:C1181(*;$formObj_t;$nom_t)
				OBJECT SET VISIBLE:C603(*;$formObj_t;True:C214)
				C_LONGINT:C283($left_l;$top_l;$right_l;$bottom_l)
				OBJECT GET COORDINATES:C663(*;$formObj_t;$left_l;$top_l;$right_l;$bottom_l)
				  //OBJECT GET BEST SIZE(*;$formObj_t;$largeurOpt_l;$hauteurOpt_l)
				$largeurOpt_l:=20
				OBJECT SET COORDINATES:C1248(*;$formObj_t;$left_l;$top_l;$left_l+$largeurOpt_l;$bottom_l)
				OBJECT SET RGB COLORS:C628(*;$formObj_t;0x0000;Background color none:K23:10)
			Else   //hide
				OBJECT SET VISIBLE:C603(*;$formObj_t;False:C215)
			End if 
			
		: ($event_l=On Long Click:K2:37)
			
			
		: ($event_l=On Clicked:K2:4)
			  //gestion du clic long : pas avec objet texte, faudrait un bouton…
			C_LONGINT:C283($X_l;$Y_l;$bouton_l)
			$ticks_l:=Tickcount:C458+60
			Repeat 
				GET MOUSE:C468($X_l;$Y_l;$bouton_l)
			Until ($bouton_l=0)
			$clicLong_b:=(Tickcount:C458>$ticks_l)
			$clicCourt_b:=(Tickcount:C458<=$ticks_l)
			
			$cmdK_t:="cmdK"  //methode poubelle pour pouvoir exécuter cmd+K 
			ARRAY TEXT:C222($menu_a2t;2;0)  //C1=path;C2=user interface
			$table_p:=Current form table:C627
			$formNom_t:=Current form name:C1298
			
			  //méthode formulaire
			If (Is nil pointer:C315($table_p))
				$chemin_t:=METHOD Get path:C1164(Path project form:K72:3;$formNom_t)
			Else 
				$chemin_t:=METHOD Get path:C1164(Path table form:K72:5;$table_p->;$formNom_t)
			End if 
			If ($chemin_t#"")
				APPEND TO ARRAY:C911($menu_a2t{1};$chemin_t)
				APPEND TO ARRAY:C911($menu_a2t{2};"form method")
			End if 
			
			  //form
			$useCmdK_t:=""
			If (xxDoa_methodExists ($cmdK_t))
				$quote_t:="\""
				$useCmdK_t:="?"
				If (Is nil pointer:C315($table_p))
					$chemin_t:=$useCmdK_t+$quote_t+$formNom_t+$quote_t
				Else 
					$chemin_t:=$useCmdK_t+"["+Table name:C256($table_p)+"];"+$quote_t+$formNom_t+$quote_t
				End if 
				APPEND TO ARRAY:C911($menu_a2t{1};$chemin_t)
				APPEND TO ARRAY:C911($menu_a2t{2};"form editor")
				
				  //fonction Form de 4D
				APPEND TO ARRAY:C911($menu_a2t{1};"Form")
				APPEND TO ARRAY:C911($menu_a2t{2};"Form")
				
				  //hierarchie [hote[sous formulaires]..]
				APPEND TO ARRAY:C911($menu_a2t{1};"Hierarchie")
				APPEND TO ARRAY:C911($menu_a2t{2};"Hierarchie")
				
				  //relations [hote[sous formulaires]..]
				APPEND TO ARRAY:C911($menu_a2t{1};"Liens auto")
				APPEND TO ARRAY:C911($menu_a2t{2};"Liens auto")
				
			End if 
			
			$menuRef_t:=Create menu:C408  //MMM
			For ($i_l;1;Size of array:C274($menu_a2t{1}))
				APPEND MENU ITEM:C411($menuRef_t;$menu_a2t{2}{$i_l})
				SET MENU ITEM PARAMETER:C1004($menuRef_t;$i_l;$menu_a2t{1}{$i_l})
			End for 
			$chemin_t:=Dynamic pop up menu:C1006($menuRef_t)  //;"";$X_l;$Y_l)
			RELEASE MENU:C978($menuRef_t)  //MMM
			If ($chemin_t#"")
				$error_t:=""
				Case of 
						
						  //: ($chemin_t="FormDyn")
						  //#TODO v17r3 : Form convertir vers dynamique
						
						  //: ($chemin_t="Liens auto")
						  //$relation_c:=Rel_pushPull
						  //$code_t:=Relations_convertToCode($relation_c)
						
					: ($chemin_t="Hierarchie")
						C_OBJECT:C1216($hierarchie_o;$io)
						$io:=New object:C1471
						$io.action:="processNew"
						$io.data:=New object:C1471
						xxForm_hierarchy ($io.data)
						TRACE:C157  //jsonViewer_mng($io)
						
					: ($chemin_t="Form")
						C_OBJECT:C1216($io)
						$io:=New object:C1471
						  //$io.data:=Form
						$io.data:=JSON Parse:C1218(JSON Stringify:C1217(Form:C1466;*))  //pour les entity selection
						$io.action:="processNew"
						$io.event:=0
						TRACE:C157  //jsonViewer_mng($io)
						  //xxJsonViewer_display (JSON Parse(JSON Stringify(Form;*)))
						
					: ($useCmdK_t=$chemin_t[[1]])
						$chemin_t:=Substring:C12($chemin_t;2)
						$error_t:=Dev_openWithCmdeK ($chemin_t)
						
					Else 
						  //ouvrir le manager s'il existe plutôt que la méthode formulaire
						$managerName_t:=""
						$chemin_c:=Split string:C1554($chemin_t;"/")
						Case of 
							: ($chemin_c.length=4)  //form table
								$managerName_t:=$chemin_c[3]+"_mng"
							: ($chemin_c.length=3)  //form projet
								$managerName_t:=$chemin_c[2]+"_mng"
						End case 
						If (xxDoa_methodExists ($managerName_t))
							$chemin_t:=$managerName_t
						End if 
						error_l:=0
						ON ERR CALL:C155("ERR_catchPlus")
						METHOD OPEN PATH:C1213($chemin_t;*)
						ON ERR CALL:C155("")
						  //:C1213 = MÉTHODE OUVRIR CHEMIN
						Case of 
							: (error_l=-9801)
								$error_t:=Command name:C538(1213)+"\rError="+String:C10(error_l)+"\rNo form method"
							: (error_l#0)
								$error_t:=Command name:C538(1213)+"\rError="+String:C10(error_l)
						End case 
				End case 
				If ($error_t#"")
					ALERT:C41($error_t)
				End if 
			End if 
			
	End case 
	
End if 

