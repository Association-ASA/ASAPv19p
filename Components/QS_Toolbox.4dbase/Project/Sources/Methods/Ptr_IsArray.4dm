//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 10/06/18, 07:45:46
  // ----------------------------------------------------
  // Paramètres
  // $1 = 
  // $2 = 
  // ----------------------------------------------------
  // Méthode : Ptr_IsArray
  // Description
  //  http://forums.4d.com/Post/FR/4942528/1/4942529#4942529

  //Ptr_isArray(unPointeur_p{;type_l{;type2_l{..;typeN_l)-> bool
  //retourne si unPointeur_p pointe un tableau à une dimension
  //$2..$N optionnels types de tableaux à vérifier

  // SAMPLE
  //TraiteUnTableauDeNombres(tableau_p)
  //C_POINTER($1)
  //If (Ptr_IsArray ($1;Integer array;LongInt array;Real array))
  //  //jébon
  //Else 
  //ALERT("$1 ne pointe pas un tableau de nombres")
  //End if

  //Ptr_isArray(unPointeur_p{;type_l{;type2_l{..;typeN_l)-> bool
  //retourne si unPointeur_p pointe un tableau à une dimension
  //$2..$N optionnels filtre types de tableaux acceptés
  //cf Ptr_isTable, Ptr_isField, Ptr_isVar
C_BOOLEAN:C305($0)
C_POINTER:C301($1)
C_LONGINT:C283(${2})

C_BOOLEAN:C305($isArray_b)
C_LONGINT:C283($i_l)
C_LONGINT:C283($params_l)
C_LONGINT:C283($type_l)

  //_
$isArray_b:=False:C215
$params_l:=Count parameters:C259
If (Asserted:C1132($params_l>0;Current method name:C684+" 1 parametre requis"))
	If (Is a variable:C294($1))
		$type_l:=Type:C295($1->)
		  //litanie des types tableau monodim
		$isArray_b:=(($type_l>13) & ($type_l<23)) | \
			($type_l=26) | \
			($type_l=31) | \
			($type_l=32) | \
			($type_l=39)
		  //26=tableau entier64???
		  //31=tableau blob
		  //32=tableau heure
		  //39=tableau objet
		
		If ($isArray_b) & ($params_l>1)  //vérifier aussi le type
			$i_l:=2
			Repeat 
				$isArray_b:=($type_l=${$i_l})
				$i_l:=$i_l+1
			Until ($i_l>$params_l) | ($isArray_b)
		End if 
	End if 
End if 
$0:=$isArray_b
  //_

