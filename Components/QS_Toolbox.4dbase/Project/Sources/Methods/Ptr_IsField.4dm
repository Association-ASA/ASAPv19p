//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 10/06/18, 07:58:13
  // ----------------------------------------------------
  // Paramètres
  // $1 = 
  // $2 = 
  // ----------------------------------------------------
  // Méthode : Ptr_IsField
  // Description
  //  http://forums.4d.com/Post/FR/24604397/1/24619895#24619895

  //Ptr_isField(unPointeur_p{;type_l)-> bool
  //retourne si unPointeur_p pointe un champ
  //$2 optionnel vérifier le type du champ
  //cf Ptr_isTable, Ptr_isArray
  // Arnaud* 13/04/2015* ajout vérif de type optionnel
C_BOOLEAN:C305($0)
C_POINTER:C301($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($out_b)
C_TEXT:C284($varName_t)
C_LONGINT:C283($table_l;$field_l)
C_LONGINT:C283($params_l)
  //_
$out_b:=False:C215
$params_l:=Count parameters:C259
  //$nmc_t:=Current method name
Case of 
	: (Not:C34(Asserted:C1132($params_l>0;Current method name:C684+" $1 expected")))
	: ($1=Null:C1517)
		  //que dalle
	Else 
		If (Not:C34(Is a variable:C294($1)))
			RESOLVE POINTER:C394($1;$varName_t;$table_l;$field_l)
			$out_b:=(Is field number valid:C1000($table_l;$field_l))
			If ($out_b)
				If ($params_l>1)  //on contrôle également le type
					$out_b:=(Type:C295($1->)=$2)
				End if 
			End if 
		End if 
End case 
$0:=$out_b
  //_