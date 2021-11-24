//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // nom utilisateur (OS) : Association QualiSoft
  // date et heure : 14/04/16, 07:16:32
  // ----------------------------------------------------
  // méthode : TOOL_Is4DIdentifier
  // description
  // http://kb.4d.com/assetid=77501
  //
  // paramètres
  // ----------------------------------------------------

  //Name: TOOL_Is4DIdentifier
  //Path: TOOL_Is4DIdentifier

  //Purpose: Check to see if the passed value is valid as a 4D identifier.
  //4D identifiers follow these rules:
  //-A name must begin with an alphabetic character or underscore.
  //-Thereafter, the name can include alphabetic characters, numeric characters,
  //the space character, and the underscore character.
  //-Periods, slashes, quotation marks and colons are not allowed.
  //-Characters reserved for use as operators, such as * and +, are not allowed.
  //-4D ignores any trailing spaces.
  //-See http://doc.4d.com/4Dv15/help/Title/en/page701.html

  //$1 - TEXT - 4D method or object name


C_TEXT:C284($MethodName_T)
$MethodName_T:=Current method name:C684

  // ===================== Declare Variables ==================================
  // method_parameters_declarations

C_TEXT:C284($1;$Identifier_T)
C_BOOLEAN:C305($0;$IsIdentifier_B)

  // --------------------------------------------------------------------------
  // method_wide_constants_declarations
  // --------------------------------------------------------------------------
  // local_variable_declarations

C_LONGINT:C283($Len;$Params_L)
C_TEXT:C284($Pattern_T)

  // ====================== Initialize and Setup ================================

$Params_L:=Count parameters:C259
$Identifier_T:=$1

  // ======================== Method Actions ==================================

  // note: \w is Regex shorthand for alphanumeric or underscore, e.g. [a-zA-Z0-9_]
  //

$Pattern_T:="\\w[\\w ]+\\w"
$IsIdentifier_B:=Match regex:C1019($Pattern_T;$Identifier_T;1)

If ($IsIdentifier_B)
	
	  // identifier length limited to 31 characters, not counting <> on interprocess vars and arrays
	  //
	
	$Len:=31
	
	If (Position:C15("<>";$Identifier_T)=1)
		$Len:=33
	End if 
	
	If (Length:C16($Identifier_T)>$Len)
		$IsIdentifier_B:=False:C215
	End if 
	
End if 

  // ======================== Clean up and Exit =================================

$0:=$IsIdentifier_B
