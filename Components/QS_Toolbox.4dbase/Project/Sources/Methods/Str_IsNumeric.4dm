//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 22/03/18, 08:26:24
  // ----------------------------------------------------
  // Méthode : STR_IsNumeric
  // Description
  //  
  //
  // Paramètres
  // ----------------------------------------------------
  // http://kb.4d.com/assetid=76754


  //STR_IsNumeric

  //Purpose: test a string to see if it is a number

  //$1 - text - Candidate string

C_TEXT:C284($MethodName_T)
$MethodName_T:=Current method name:C684
  //===================== Declare Variables ==================================
  //method_parameters_declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($Buffer_T;$1)
  //--------------------------------------------------------------------------------
  //method_wide_constants_declarations
  //--------------------------------------------------------------------------------
  //local_variable_declarations
C_LONGINT:C283($Ndx)
C_TEXT:C284($Hex_T)
C_BOOLEAN:C305($isHEX_B)
  //====================== Initialize and Setup ================================

$Buffer_T:=$1

  //======================== Method Actions ==================================

If ($Buffer_T="Ox@")
	  // Test for valid hexidecimal
	  //
	$Hex_T:=$Buffer_T
	$Hex_T:=Substring:C12($Buffer_T;3)
	For ($Ndx;1;Length:C16($Hex_T))
		$isHEX_B:=(Position:C15($Hex_T[[$Ndx]];"0123456789ABCDEF")>0)
		If (Not:C34($isHEX_B))
			$Ndx:=Length:C16($Hex_T)
		End if 
	End for 
	
	$0:=$isHEX_B
	
Else 
	  // Test the string to see if it contains non numeric characters
	  //
	$0:=($Buffer_T=String:C10(Num:C11(Replace string:C233($Buffer_T;"e";""));"0"*Length:C16($Buffer_T)))
	
End if 