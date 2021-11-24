//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // date et heure : 16/09/14, 18:47:53
  // ----------------------------------------------------
  // méthode : Object_GetAction
  // description
  // http://doc.4d.com/4D-Langage-14.2/Objets-Formulaires/OBJET-Lire-action.301-1586156.fr.html
  //
  // paramètres
  // ----------------------------------------------------

C_TEXT:C284($1;$0;$Objet;$type)

$Objet:=$1
$type:="No action"

Case of 
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object No standard action:K76:1)  // 0
		$type:="No action"  // No action
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Cancel action:K76:2)  // 1
		$type:="Cancel"  // annuler"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Accept action:K76:3)  // 2
		$type:="Accept"  // valider"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Next record action:K76:4)  // 3
		$type:="Next record"  // enreg suivant"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Previous record action:K76:5)  // 4
		$type:="Previous record"  // enreg précédent"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object First record action:K76:6)  //5
		$type:="First record"  // premier enreg"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Last record action:K76:7)  //6
		$type:="Last record"  // dernier enreg"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Delete record action:K76:8)  //7
		$type:="Delete record"  // supprimer enreg"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Next page action:K76:9)  //8
		$type:="Next page"  // page suivante"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Previous page action:K76:10)  //9
		$type:="Previous page"  // page précédente"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object First page action:K76:11)  //10
		$type:="First page"  // première page"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Last page action:K76:12)  //11
		$type:="Last page"  // dernière page"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Edit subrecord action:K76:13)  //12
		$type:="Edit subrecord"  // modifier sous enreg"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Delete subrecord action:K76:14)  //13
		$type:="Delete subrecord"  // supprimer sous enreg"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Add subrecord action:K76:15)  //14
		$type:="Add subrecord"  // ajouter sous enreg"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Goto page action:K76:16)  //15
		$type:="Goto page"  // aller à page"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Automatic splitter action:K76:17)  //16
		$type:="Automatic splitter"  // séparateur auto"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Undo action:K76:18)  //17
		$type:="Undo"  // annuler édition"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Cut action:K76:19)  //18
		$type:="Cut"  // couper"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Copy action:K76:20)  //19
		$type:="Copy"  // copier"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Paste action:K76:21)  //20
		$type:="Paste"  // coller"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Clear action:K76:22)  //21
		$type:="Clear"  // effacer"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Select all action:K76:23)  //22
		$type:="Select all"  // tout sélectionner"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Show Clipboard action:K76:24)  //23
		$type:="Show clipboard"  // afficher Presse papiers"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Test Application action:K76:25)  //26
		$type:="Test application"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Quit action:K76:26)  //27
		$type:="Quit"  // quitter"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Redo action:K76:27)  //31
		$type:="Repeat"  // répéter"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Database Settings action:K76:28)  //32
		$type:="Database settings"  // propriétés de la base"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Return to Design mode action:K76:29)  //35
		$type:="Return to Design mode"  // retour au mode Développement"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object MSC action:K76:30)  //36
		$type:="CSM"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Open back URL action:K76:31)  //37
		$type:="Open back URL"  // ouvrir URL précédent"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Open next URL action:K76:32)  //38
		$type:="Open next URL"  // ouvrir URL suivant"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Refresh current URL action:K76:33)  //39
		$type:="Refresh current URL"  // actualiser URL courant"
		
	: (_O_OBJECT Get action:C1260(*;$Objet)=_o_Object Stop loading URL action:K76:34)  //40
		$type:="Stop loading URL"  // arrêter chargement URL"
		
End case 

$0:=$type
