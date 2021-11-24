//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 30/01/18, 18:43:49
  // ----------------------------------------------------
  // Méthode : QS_CheckVariableName
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------
C_TEXT:C284($1;$Var)
C_BOOLEAN:C305($2;$DisplayAlert)

$Var:=$1
$DisplayAlert:=$2

  // Check consistency on object name
  // -------------------------------

If (Str_IsLongint ($var))
	$var:="badObjectName_"+$var
End if 

If (Position:C15("$";$Var;1)=1)
	$var:="dollar_"+Substring:C12($Var;2)
End if 

If (Position:C15("<>";$Var;1)=1)
	$var:="diamond_"+Substring:C12($Var;3)
End if 

If (Position:C15(".";$Var;1)>0)
	$var:=Substring:C12($Var;1;Position:C15(".";$Var;1)-1)+"DOT"+Substring:C12($Var;Position:C15(".";$Var;1)+1)
End if 

While (Position:C15("-";$Var)>0)  // not authorizes character
	$var:=Substring:C12($Var;1;Position:C15("-";$Var;1)-1)+"_"+Substring:C12($Var;Position:C15("-";$Var;1)+1)
End while 

While (Position:C15("(";$Var;1)>0)  // not authorizes character
	$var:=Substring:C12($Var;1;Position:C15("(";$Var;1)-1)+"_"+Substring:C12($Var;Position:C15("(";$Var;1)+1)
End while 

While (Position:C15(")";$Var;1)>0)  // not authorizes character
	$var:=Substring:C12($Var;1;Position:C15(")";$Var;1)-1)+"_"+Substring:C12($Var;Position:C15(")";$Var;1)+1)
End while 

While (Position:C15("[";$Var;1)>0)  // not authorizes character
	$var:=Substring:C12($Var;1;Position:C15(")";$Var;1)-1)+"_"+Substring:C12($Var;Position:C15(")";$Var;1)+1)
End while 

While (Position:C15("]";$Var;1)>0)  // not authorizes character
	$var:=Substring:C12($Var;1;Position:C15(")";$Var;1)-1)+"_"+Substring:C12($Var;Position:C15(")";$Var;1)+1)
End while 

$0:=$var