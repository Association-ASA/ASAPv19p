//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 30/01/18, 08:00:44
  // ----------------------------------------------------
  // Méthode : Str_IsLongint
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------
  // http://forums.4d.com/Post/FR/11828168/1/11828169#11828169


  //Str_isLongint(string_t)-> bool

C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_REAL:C285($_r)

$0:=False:C215
$in_t:=$1
$_r:=Num:C11($in_t)

Case of 
	: ($_r>MAXLONG:K35:2)  //or 2^31-1
	: ($_r<-(MAXLONG:K35:2+1))  //or-2^31
		  //: (Not(Match regex("^[-+]?\\d+[eE]?.[+-]?.[\\d]*$";$in_t;1)))
	: (Not:C34(Match regex:C1019("^[+-]?\\d{1,10000}$";$in_t;1)))
	Else 
		$0:=True:C214
End case 