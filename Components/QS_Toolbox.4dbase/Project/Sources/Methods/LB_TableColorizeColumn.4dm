//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 10/06/18, 08:24:07
  // ----------------------------------------------------
  // Paramètres
  // $1 = 
  // $2 = 
  // ----------------------------------------------------
  // Méthode : LB_TableColorizeColumn
  // Description
  //  méthode qui colorie une listbox sélection d'après sa table et permet optionnellement d'accentuer la couleur d'une des colonnes. 

  // http://forums.4d.com/Post/FR/14230252/1/14230253#14230253


  //UI_LBsTableColor(nomListbox_t{;nomColonnePlusFoncee_t)
  //fixe couleurs fond alternées
  //d'une listbox sélection selon sa table
  //$2 optionnel nom de colonne plus foncée
C_TEXT:C284($1)
C_TEXT:C284($2)
  //_
Case of 
	: (Not:C34(Asserted:C1132(Count parameters:C259>0;Current method name:C684+" $1 listbox name missing")))
	: (Not:C34(Asserted:C1132(Length:C16($1)>0;Current method name:C684+" $1 listbox name empty")))
	Else 
		C_TEXT:C284($name_t)
		$name_t:=$1  // Listbox name
		C_LONGINT:C283($table_l)
		LISTBOX GET TABLE SOURCE:C1014(*;$name_t;$table_l)
		
		If (Is table number valid:C999($table_l))
			C_LONGINT:C283($color1_l;$color2_l;$sat_l)
			$sat_l:=10
			OBJECT SET RGB COLORS:C628(*;$name_t;-255;$color1_l;$color2_l)
			
			If (Count parameters:C259>1)
				If (Length:C16($2)>0)
					$name_t:=$2  // Column name
					OBJECT SET RGB COLORS:C628(*;$name_t;-255;$color2_l;$color1_l)
				End if 
			End if 
		End if 
End case 