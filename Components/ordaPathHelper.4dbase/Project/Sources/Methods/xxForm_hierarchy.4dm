//%attributes = {}
  //xxForm_hierarchy (obj_o)
  //explore la structure des sous formulaires en partant du formulaire courant
  //$1 objet, doit être référencé avant l'appel (New object) :
  //  level : profondeur
  //  container : nom du conteneur SF 
  //  path : chemin depuis hôte (commence par "window/..." si hôte est "le plus haut")
  //  formName : nom du formulaire, Null si SF non instancié
  //  tableNumber : numéro de la table si form table, Null si form projet
  //  subforms[] : collection de SF inclus, chacun structuré comme précède

  //© Arnaud * 21/03/2019 08:25:45
  //  https://forums.4d.com/Post//28997466/1/#28997467 * "Form digger"

C_OBJECT:C1216($1)
C_OBJECT:C1216($currentForm_o)

C_OBJECT:C1216($sousForm_o)
C_LONGINT:C283($i_l)
C_TEXT:C284($nmc_t)
If (False:C215)
	C_OBJECT:C1216(xxForm_hierarchy ;$1)
End if 

$nmc_t:=Current method name:C684
ASSERT:C1129(Count parameters:C259>0)
ASSERT:C1129($1#Null:C1517)
$currentForm_o:=$1
If ($currentForm_o.level=Null:C1517)  //1er appel
	$currentForm_o.level:=1
	$currentForm_o.container:="window#"+String:C10(Current form window:C827)
	$currentForm_o.path:="window/"
End if 
$currentForm_o.formName:=Current form name:C1298
If (Is nil pointer:C315(Current form table:C627))
	$currentForm_o.tableNumber:=Null:C1517
Else 
	$currentForm_o.tableNumber:=Table:C252(Current form table:C627)
End if 
$currentForm_o.subforms:=New collection:C1472

ARRAY TEXT:C222($nom_at;0x0000)
FORM GET OBJECTS:C898($nom_at;$var_ap;Form current page:K67:6)
For ($i_l;1;Size of array:C274($nom_at))
	If (OBJECT Get type:C1300(*;$nom_at{$i_l})=Object type subform:K79:40)
		$sousForm_o:=New object:C1471
		$sousForm_o.level:=$currentForm_o.level+1
		$sousForm_o.container:=$nom_at{$i_l}
		$sousForm_o.path:=$currentForm_o.path+$sousForm_o.container+"/"
		$currentForm_o.subforms.push($sousForm_o)
	End if 
End for 

C_OBJECT:C1216($sousForm_o)
For each ($sousForm_o;$currentForm_o.subforms)
	EXECUTE METHOD IN SUBFORM:C1085($sousForm_o.container;$nmc_t;*;$sousForm_o)  //ré entrant
	Case of 
		: ($sousForm_o.subforms=Null:C1517)  //se produit si sous formulaire vide (non instancié)
			$sousForm_o.formName:=Null:C1517
		: ($sousForm_o.subforms.length=0)  //aucun sous formulaire
			OB REMOVE:C1226($sousForm_o;"subforms")
	End case 
End for each 
  //_
