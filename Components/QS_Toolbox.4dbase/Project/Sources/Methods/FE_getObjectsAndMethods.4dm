//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 15/06/18, 07:21:35
  // ----------------------------------------------------
  // Paramètres
  // $1 = Table number
  // $2 = Form name
  // $3 = Pointer on array of Object names
  // $4 = Pointer on array of Variables pointer
  // $5 = Pointer on array of Page (longint)
  // {$6} = Pointer on array of form widget Methods
  // ----------------------------------------------------
  // Méthode : FORM_Get_ObjectsAndMethods
  // Description
  //  

ASSERT:C1129(Count parameters:C259>=5;"Param number must be at least 5")
  //ASSERT(Type($1)=Is longint;"$1 must be an integer")
  //ASSERT(Type($2)=Is text;"$2 must be a text = form name")
  //ASSERT(Type($3)=Is pointer;"$3 must be a pointer")
  //ASSERT(Type($4)=Is pointer;"$4 must be a pointer")
  //ASSERT(Type($5)=Is pointer;"$5 must be a pointer")

C_LONGINT:C283($1)
C_TEXT:C284($2)
C_POINTER:C301($3;$4;$5)

FE_formLoad ($1;$2)

CLEAR VARIABLE:C89($3->)
CLEAR VARIABLE:C89($4->)
CLEAR VARIABLE:C89($5->)
FORM GET OBJECTS:C898($3->;$4->;$5->;Form all pages:K67:7+Form inherited:K67:8)

If (Count parameters:C259=6)
	ASSERT:C1129(Value type:C1509($6)=Is pointer:K8:14;"$6 must be a pointer")
	CLEAR VARIABLE:C89($6->)
	If ($1#0)  // It is a table
		METHOD GET PATHS FORM:C1168(Table:C252($1)->;$6->;$2;*)
	Else   // Form projects
		METHOD GET PATHS FORM:C1168($6->;$2;*)
	End if 
End if 