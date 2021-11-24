//%attributes = {"invisible":true,"lang":"fr"}
// ----------------------------------------------------
// Method : REGEX_ExtractText
// Created 28/09/07 by Vincent de Lachaux
// ----------------------------------------------------
// Description
// Alias "QF_REExtractText"
// ----------------------------------------------------
// Paramètres
// $1 = Regular expression
// $2 = Target text
// $3 = Group numbers to extract
// $4 = Array of extracted segments
// $5 = Regular expression flags
// $0 = Error result
// ----------------------------------------------------

C_LONGINT:C283($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_POINTER:C301($4)
C_LONGINT:C283($5)

C_BOOLEAN:C305($Boo_Array2D; $Boo_OK)
C_LONGINT:C283($Lon_Current_Group; $Lon_Groups; $Lon_i; $Lon_Index; $Lon_Index_Group; $Lon_Options; $Lon_Parameters; $Lon_Start)
C_TEXT:C284($Txt_Error_Method; $Txt_Extracted; $Txt_Pattern; $Txt_Target)

ARRAY LONGINT:C221($tLon_Lengths; 0x0000)
ARRAY LONGINT:C221($tLon_Positions; 0x0000)
ARRAY TEXT:C222($tTxt_Groups; 0x0000)

If (False:C215)
	C_LONGINT:C283(REGEX_ExtractText; $0)
	C_TEXT:C284(REGEX_ExtractText; $1)
	C_TEXT:C284(REGEX_ExtractText; $2)
	C_TEXT:C284(REGEX_ExtractText; $3)
	C_POINTER:C301(REGEX_ExtractText; $4)
	C_LONGINT:C283(REGEX_ExtractText; $5)
End if 

$Lon_Parameters:=Count parameters:C259

If ($Lon_Parameters<4)
	
	rgx_Lon_Error:=-50  //Parameter error
	
Else 
	
	If ($Lon_Parameters>=5)
		
		$Lon_Options:=$5
		
	End if 
	
	$Txt_Pattern:=REGEX_Options($Lon_Options)+$1
	
	If (Length:C16($3)>0)
		
		REGEX_SplitText("\\s"; $3; ->$tTxt_Groups; (0 ?+ 1) ?+ 11)
		
	End if 
	
	$Lon_Groups:=Size of array:C274($tTxt_Groups)
	
	$Boo_Array2D:=(Type:C295($4->)=Est un tableau 2D:K8:24)
	CLEAR VARIABLE:C89($4->)
	
	rgx_Lon_Error:=-50*Num:C11(($Lon_Groups>1) & Not:C34($Boo_Array2D))  //Parameter error
	
	$Txt_Error_Method:=Method called on error:C704
	ON ERR CALL:C155("REGEX_NO_ERROR")
	
	$Lon_Start:=1
	
	If (rgx_Lon_Error=0)
		
		$Txt_Target:=$2
		
		Repeat 
			
			$Lon_Index:=$Lon_Index+1
			
			$Boo_OK:=Match regex:C1019($Txt_Pattern; $Txt_Target; $Lon_Start; $tLon_Positions; $tLon_Lengths)
			
			If ($Boo_OK) & (rgx_Lon_Error=0)
				
				If ($Boo_Array2D)
					
					If ($Lon_Groups=0)
						
						ARRAY TEXT:C222($4->; $Lon_Index; Size of array:C274($tLon_Positions))
						
					Else 
						
						ARRAY TEXT:C222($4->; $Lon_Index; $Lon_Groups)
						
					End if 
				End if 
				
				$Lon_Current_Group:=0
				
				For ($Lon_i; 0; Size of array:C274($tLon_Positions); 1)
					
					$Lon_Index_Group:=Choose:C955($Lon_Groups>0; Find in array:C230($tTxt_Groups; String:C10($Lon_Current_Group)); $Lon_Current_Group)
					
					If ($Lon_Index_Group>=0)
						
						$Txt_Extracted:=Substring:C12($Txt_Target; $tLon_Positions{$Lon_i}; $tLon_Lengths{$Lon_i})
						
						If ($Boo_Array2D)
							
							$4->{$Lon_Index}{$Lon_Index_Group}:=$Txt_Extracted
							
						Else 
							
							If (($Lon_i=0) & ($Lon_Index=1)) | ($Lon_i>0)
								
								APPEND TO ARRAY:C911($4->; $Txt_Extracted)
								
							End if 
						End if 
					End if 
					
					If ($tLon_Positions{$Lon_i}>0)
						
						$Lon_Start:=$tLon_Positions{$Lon_i}+$tLon_Lengths{$Lon_i}
						
					End if 
					
					$Lon_Current_Group:=$Lon_Current_Group+1
					
				End for 
			End if 
		Until (Not:C34($Boo_OK))
		
		If (rgx_Lon_Error=0)
			
			rgx_Lon_Error:=-Num:C11(Size of array:C274($4->)=0)
			
		End if 
	End if 
	
	ON ERR CALL:C155($Txt_Error_Method)
	
End if 

$0:=rgx_Lon_Error

rgx_Lon_Error:=0