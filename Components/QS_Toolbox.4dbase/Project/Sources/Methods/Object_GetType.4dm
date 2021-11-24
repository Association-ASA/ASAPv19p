//%attributes = {"invisible":true,"shared":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // date et heure : 16/09/14, 18:47:53
  // ----------------------------------------------------
  // méthode : Object_GetType
  // description
  // http://doc.4d.com/4D-Langage-14.2/Objets-Formulaires/OBJET-Lire-type.301-1586144.fr.html
  //
  // paramètres
  // ----------------------------------------------

C_TEXT:C284($1;$0;$Objet;$type)

$Objet:=$1
$type:="Object type unknown"

Case of 
		
	: (OBJECT Get type:C1300(*;$Objet)=0)
		$type:="Object type unknown"  // 
		
	: (OBJECT Get type:C1300(*;$Objet)=1)
		$type:="static text"  // "texte statique"
		
	: (OBJECT Get type:C1300(*;$Objet)=2)
		$type:="static picture"  // "image statique"
		
	: (OBJECT Get type:C1300(*;$Objet)=3)
		$type:="text input"
		
	: (OBJECT Get type:C1300(*;$Objet)=4)
		$type:="picture input"  // "saisie image"
		
	: (OBJECT Get type:C1300(*;$Objet)=5)
		$type:="radio button field"  // "champ radio boutons"
		
	: (OBJECT Get type:C1300(*;$Objet)=6)
		$type:="hierarchical list"  // "liste hiérarchique"
		
	: (OBJECT Get type:C1300(*;$Objet)=7)
		$type:="listbox"
		
	: (OBJECT Get type:C1300(*;$Objet)=8)
		$type:="listbox header"  // "listbox entête"
		
	: (OBJECT Get type:C1300(*;$Objet)=9)
		$type:="listbox column"  // "listbox colonne"
		
	: (OBJECT Get type:C1300(*;$Objet)=10)
		$type:="listbox footer"  // "listbox pied"
		
	: (OBJECT Get type:C1300(*;$Objet)=11)
		$type:="combobox"
		
	: (OBJECT Get type:C1300(*;$Objet)=12)
		$type:="popup dropdown list"  // "popup liste déroulante"
		
	: (OBJECT Get type:C1300(*;$Objet)=13)
		$type:="hierarchical popup"  // "menu déroulant hiérarchique"
		
	: (OBJECT Get type:C1300(*;$Objet)=14)
		$type:="picture popup"  // "popup menu image"
		
	: (OBJECT Get type:C1300(*;$Objet)=15)
		$type:="push button"  // "bouton poussoir"
		
	: (OBJECT Get type:C1300(*;$Objet)=16)
		$type:="3D button"  // "bouton 3D"
		
	: (OBJECT Get type:C1300(*;$Objet)=17)
		$type:="highlight button"  // "bouton inversé"
		
	: (OBJECT Get type:C1300(*;$Objet)=18)
		$type:="invisible button"  // "bouton invisible"
		
	: (OBJECT Get type:C1300(*;$Objet)=19)
		$type:="picture button"  // "bouton image"
		
	: (OBJECT Get type:C1300(*;$Objet)=20)
		$type:="button grid"  // "grille de boutons"
		
	: (OBJECT Get type:C1300(*;$Objet)=21)
		$type:="group"  // "groupe"
		
	: (OBJECT Get type:C1300(*;$Objet)=22)
		$type:="radio button"  // "bouton radio"
		
	: (OBJECT Get type:C1300(*;$Objet)=23)
		$type:="3D radio button"  // "bouton radio 3D"
		
	: (OBJECT Get type:C1300(*;$Objet)=24)
		$type:="picture radio button"  // "bouton radio image"
		
	: (OBJECT Get type:C1300(*;$Objet)=25)
		$type:="checkbox"  // "case à cocher"
		
	: (OBJECT Get type:C1300(*;$Objet)=26)
		$type:="3D checkbox"  // "case à cocher 3D"
		
	: (OBJECT Get type:C1300(*;$Objet)=27)
		$type:="progress indicator"  // "indicateur de progression"
		
	: (OBJECT Get type:C1300(*;$Objet)=28)
		$type:="dial"  // "cadran"
		
	: (OBJECT Get type:C1300(*;$Objet)=29)
		$type:="ruler"  // "règle"
		
	: (OBJECT Get type:C1300(*;$Objet)=30)
		$type:="groupbox"  // "zone de groupe"
		
	: (OBJECT Get type:C1300(*;$Objet)=31)
		$type:="rectangle"
		
	: (OBJECT Get type:C1300(*;$Objet)=32)
		$type:="line"  // "ligne"
		
	: (OBJECT Get type:C1300(*;$Objet)=33)
		$type:="rounded rectangle"  // "rectangle arrondi"
		
	: (OBJECT Get type:C1300(*;$Objet)=34)
		$type:="oval"  // "ovale"
		
	: (OBJECT Get type:C1300(*;$Objet)=35)
		$type:="matrix"  // "matrice"
		
	: (OBJECT Get type:C1300(*;$Objet)=36)
		$type:="splitter"  // "séparateur"
		
	: (OBJECT Get type:C1300(*;$Objet)=37)
		$type:="tab control"  // onglet
		
	: (OBJECT Get type:C1300(*;$Objet)=38)
		$type:="plugin area"  // "zone plug-in"
		
	: (OBJECT Get type:C1300(*;$Objet)=39)
		$type:="subform"  // "sous-formulaire"
		
	: (OBJECT Get type:C1300(*;$Objet)=40)
		$type:="web area"
		
		  // v16R4
	: (OBJECT Get type:C1300(*;$Objet)=41)
		$type:="write pro area"
		
	: (OBJECT Get type:C1300(*;$Objet)=42)
		$type:="view pro area"
		
End case 

$0:=$type
