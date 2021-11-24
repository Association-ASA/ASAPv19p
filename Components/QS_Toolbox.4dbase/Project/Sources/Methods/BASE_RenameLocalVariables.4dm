//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 10/06/18, 08:44:50
  // ----------------------------------------------------
  // Paramètres
  // $0 = updated code
  // $1 = code
  // $2 = pointer to array of variable to replace
  // $3 = pointer to array of variable replace by
  // ----------------------------------------------------
  // Méthode : BASE_RenameLocalVariables
  // Description
  //  http://forums.4d.com/Post/FR/19466642/1/19466643#19466643

  // BASE_RenameLocalVariables (code_t;$arrFind_p;$arrReplace_p) -> txt
  // rename ONLY local variable(s)

C_TEXT:C284($0;$1;$code_t;$ligne_t)
C_POINTER:C301($2;$3;$4)
C_LONGINT:C283($start_l;$pos_l;$len_l)
ARRAY TEXT:C222($find_at;0)  //$2
ARRAY TEXT:C222($replace_at;0)  //$3
ARRAY TEXT:C222($found_at;0)  //$4
  //_
ASSERT:C1129(Count parameters:C259>2)
ASSERT:C1129(Ptr_IsArray ($2;Text array:K8:16))
ASSERT:C1129(Ptr_IsArray ($3;Text array:K8:16))
$code_t:=$1
COPY ARRAY:C226($2->;$find_at)
COPY ARRAY:C226($3->;$replace_at)

If ((Size of array:C274($find_at)=Size of array:C274($replace_at)))
	
	C_COLLECTION:C1488($Coll)
	
	$Coll:=New collection:C1472
	$Coll:=Split string:C1554($code_t;"\r")
	
	$rxLocale_t:="\\$\\w{1,31}"
	$rxParam_t:="\\$\\{?\\d{1,3}\\}?"
	
	For each ($ligne_t;$coll)
		
		Case of 
			: (Position:C15("//";$ligne_t)=1)
				  // comment line -> do nothing
				
			Else 
				
				$start_l:=1
				$maxLen_l:=Length:C16($ligne_t)+1
				
				While (Match regex:C1019($rxLocale_t;$ligne_t;$start_l;$pos_l;$len_l))
					$var_t:=Substring:C12($ligne_t;$pos_l;$len_l)
					$start_l:=$pos_l+$len_l
					
					If (Not:C34(Match regex:C1019($rxParam_t;$var_t;1)))  // not a parameter
						$j_l:=Find in array:C230($replace_at;$var_t)  // alreday done
						
						If ($j_l<1)
							If (Find in array:C230($found_at;$var_t)<1)
								APPEND TO ARRAY:C911($found_at;$var_t)
							End if 
							
							$j_l:=Find in array:C230($find_at;$var_t)  // remplacement existe
							
							If ($j_l>0)
								$ligne_t:=Delete string:C232($ligne_t;$pos_l;$len_l)
								$ligne_t:=Insert string:C231($ligne_t;$replace_at{$j_l};$pos_l)
								$maxLen_l:=Length:C16($ligne_t)+1
								If ($start_l>$maxLen_l)  // saleté de bug…
									$start_l:=$maxLen_l
								End if 
							End if 
						End if 
					End if 
				End while 
		End case 
		
	End for each 
	
	If (Count parameters:C259>3)
		SORT ARRAY:C229($found_at;>)
		COPY ARRAY:C226($found_at;$4->)
	End if 
	
	$0:=$Coll.join("\r")
Else 
	$0:=$code_t
End if 