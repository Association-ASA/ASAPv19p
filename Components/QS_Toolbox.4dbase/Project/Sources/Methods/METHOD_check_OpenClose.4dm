//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 05/04/19, 14:46:15
  // Méthode : METHOD_check_OpenClose
  // ----------------------------------------------------
  // Paramètres
  // $1 = path (text)
  // $0 = collection
  // ----------------------------------------------------
  // Description
  //  list commands requiring closure command, otherwise that could generate a memory leak
  // take care of  'alone' open command
  // take care of  'alone' closure command


C_TEXT:C284($1;$path)
C_COLLECTION:C1488($coll;$pattern;$allCommands;$j)
C_OBJECT:C1216($token)

$path:=$1
$coll:=New collection:C1472
$pattern:=New collection:C1472
$allCommands:=New collection:C1472

  // List is sort by Closure command

  //  creer enregistrement - dupliquer enregistrement - recevoir enregistrement 
  // _o_ajouter sous enregistrement - _o_creer sous enregistrement - _o_modifier sous enregistrement
$pattern.push(New object:C1471("open";225;"close";53))
$pattern.push(New object:C1471("open";72;"close";53))
$pattern.push(New object:C1471("open";79;"close";53))
$pattern.push(New object:C1471("open";202;"close";53))
$pattern.push(New object:C1471("open";203;"close";53))
$pattern.push(New object:C1471("open";68;"close";53))

  // charger ensemble -  Ensemble vide - Nommer ensemble - Copier ensemble
$pattern.push(New object:C1471("open";116;"close";117))
$pattern.push(New object:C1471("open";140;"close";117))
$pattern.push(New object:C1471("open";185;"close";117))
$pattern.push(New object:C1471("open";600;"close";117))

  // Sémaphore - Effacer sémaphore
$pattern.push(New object:C1471("open";143;"close";144))

  // lecture ecriture - lecture seulement
$pattern.push(New object:C1471("open";146;"close";145))

  // creer fenetre - _o_creer fenetre externe - creer fenetre formulaire
$pattern.push(New object:C1471("open";153;"close";154))
$pattern.push(New object:C1471("open";309;"close";154))
$pattern.push(New object:C1471("open";675;"close";154))


  // Empiler enregistrement - Dépiler enregistrement
$pattern.push(New object:C1471("open";176;"close";177))

  // supprimer messages - laisser messages
$pattern.push(New object:C1471("open";175;"close";181))

  // Debut transaction - Valider transaction / Annuler transaction
$pattern.push(New object:C1471("open";239;"close";240))
$pattern.push(New object:C1471("open";239;"close";241))

  // Ajouter à document / Créer document / Ouvrir document - Fermer document
$pattern.push(New object:C1471("open";264;"close";267))
$pattern.push(New object:C1471("open";265;"close";267))
$pattern.push(New object:C1471("open";266;"close";267))

  // Copier Selection / Deplacer Selection - Effacer Selection
$pattern.push(New object:C1471("open";331;"close";333))
$pattern.push(New object:C1471("open";334;"close";333))

  // Nouvelle Liste / Charger Liste /  Blob vers Liste - Supprimer liste
$pattern.push(New object:C1471("open";375;"close";377))
$pattern.push(New object:C1471("open";383;"close";377))
$pattern.push(New object:C1471("open";557;"close";377))

  //  // Fixer limite recherche (x)
  //$CmdOpen{$i}:=Command name(395)+"\\(([^\\)])\\))"
  //$CmdClose{$i}:=Command name(395)+"\\(0\\)"  // Fixer limite recherche (0)
  //$i:=$i+1

  //  // Fixer destination recherche (x;y)
  //$CmdOpen{$i}:=Command name(396)+"\\(([^\\)]*)\\))"
  //$CmdClose{$i}:=Command name(396)+"\\(([^\\)]{1,1})\\))"  // Fixer destination recherche (x)
  //$i:=$i+1

  // Ouvrir fichier ressources - fermer fichier ressources
$pattern.push(New object:C1471("open";497;"close";498))

  // creer menu - Effacer menu
$pattern.push(New object:C1471("open";408;"close";978))

  //  //  SET TIMER   - 
  //$CmdOpen{$i}:=Command name(645)+"\\(([^\\)])\\))"
  //$CmdClose{$i}:=Command name(645)+"\\(0\\)"  // set timer (0)
  //$i:=$i+1

  // DOM Analyser source XML / DOM Analyser variable XML - DOM Fermer XML
$pattern.push(New object:C1471("open";719;"close";722))
$pattern.push(New object:C1471("open";720;"close";722))

  // QR creer zone hors ecran - QR Supprimer zone hors ecran
$pattern.push(New object:C1471("open";735;"close";754))

  // SAX ouvrir element XML / SAX ouvrir element XML Tableaux - SAX Fermer element XML
$pattern.push(New object:C1471("open";853;"close";854))
$pattern.push(New object:C1471("open";921;"close";854))

  // OPEN PRINTING JOB  - CLOSE PRINTING JOB
$pattern.push(New object:C1471("open";995;"close";996))

  // FORM LOAD - FORM UNLOAD
$pattern.push(New object:C1471("open";1103;"close";1299))

  // LDAP Login - LDAP Logout
$pattern.push(New object:C1471("open";1326;"close";1327))

  // SVG_Open_File / SVG_Copy / SVG_New - SVG_Clear
$pattern.push(New object:C1471("open";65996;"close";65997))
$pattern.push(New object:C1471("open";65998;"close";65997))
$pattern.push(New object:C1471("open";65999;"close";65997))

  // -----------------------------------------------------
$j:=Storage:C1525.allMethods.indices("name = :1";$path)
If ($j.length>0)
	
	$allCommands:=Storage:C1525.allMethods[$j[0]].commandToken
	
	For each ($token;$pattern)
		$open:=":C"+String:C10($token.open)
		$close:=":C"+String:C10($token.close)
		If ($allCommands.indexOf($open)#-1)  // OPEN thing has been found
			If ($allCommands.indexOf($close)=-1)  // NOthing has been found
				$coll.push("'"+Command name:C538($token.open)+"' without "+Command name:C538($token.close)+" command")
			End if 
		End if 
		
		If ($allCommands.indexOf($close)#-1)  // CLOSE thing has been found
			If ($allCommands.indexOf($open)=-1)  // NOthing has been found
				$coll.push("'"+Command name:C538($token.open)+"' open command is missing with "+Command name:C538($token.close))
			End if 
		End if 
		
	End for each 
End if 

$0:=$coll