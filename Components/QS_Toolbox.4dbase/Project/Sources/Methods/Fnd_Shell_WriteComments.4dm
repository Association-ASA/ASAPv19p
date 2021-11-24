//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  // ---------------------------------------------------- 
  // Project Method: Fnd_Shell_WriteComments {(Method Name; Do not use)} 

  // This method will create documentation comments 
  //   it is based on the assumption that you format your 
  //    method header comments in the same manner as Foundation 
  //  The second paramater is just used to trigger the method 
  //   starting in a new process, you should not pass anything in this parameter

  // Access: Shared 

  // Parameters: 
  //   $1 : Text : Either pass 
  //       (a) "" - All methods (or don't pass any parameters) 
  //       (b) "Prefix" - Only methods which match a prefix (Eg. Fnd_Art) 
  //       (c) "Specific method name" - write comments for that method 
  //   $2 : Longint : Do not use this 

  // Created by Wayne Stewart 
  // ---------------------------------------------------- 
  // http://4d.1045681.n5.nabble.com/v13-method-comments-the-Explorer-Pane-td5757752.html#a5757754

C_TEXT:C284($1)
C_LONGINT:C283($2)

C_LONGINT:C283($CurrentMethod_i;$NumberOfMethods_i;$Position_i;$ProcessID_i;$StackSize_i)
C_TEXT:C284($FirstChars_t;$MethodCode_t;$MethodName_t;$ThreadSafe_t;$ThreadSafeSection_t)
C_OBJECT:C1216($Attributes_o)

ARRAY TEXT:C222($MethodCode_at;0)
ARRAY TEXT:C222($MethodNames_at;0)


$StackSize_i:=0

If (Count parameters:C259=2)
	
	  //COPY ARRAY(QS_MethodName_Ref;$MethodNames_at)
	METHOD GET PATHS:C1163(Path project method:K72:1;$MethodNames_at;*)
	
	$MethodName_t:=$1
	
	If (Length:C16($MethodName_t)>0)  //  A method name or prefix has been specified
		
		$NumberOfMethods_i:=Count in array:C907($MethodNames_at;$MethodName_t)
		
		If ($NumberOfMethods_i=1)  // exactly one match (use this specific method)
			APPEND TO ARRAY:C911($MethodNames_at;$MethodName_t)
		Else 
			
			$NumberOfMethods_i:=Size of array:C274($MethodNames_at)
			For ($CurrentMethod_i;$NumberOfMethods_i;1;-1)  // Go Backwards 
				If ($MethodNames_at{$CurrentMethod_i}=($MethodName_t+"@"))
				Else 
					DELETE FROM ARRAY:C228($MethodNames_at;$CurrentMethod_i)
				End if 
				
			End for 
			
		End if 
		
	End if 
	
	$NumberOfMethods_i:=Size of array:C274($MethodNames_at)
	
	METHOD GET CODE:C1190($MethodNames_at;$MethodCode_at)
	
	ARRAY TEXT:C222($MethodComments_at;$NumberOfMethods_i)
	
	For ($CurrentMethod_i;1;$NumberOfMethods_i)
		$MethodCode_t:=$MethodCode_at{$CurrentMethod_i}
		
		$Position_i:=Position:C15("comment added and reserved by 4D.\r";$MethodCode_t)
		
		$MethodCode_t:=Substring:C12($MethodCode_t;$Position_i+Length:C16("comment added and reserved by 4D.\r"))
		
		  //  Threadsafe? 
		METHOD GET ATTRIBUTES:C1334($MethodNames_at{$CurrentMethod_i};$Attributes_o)
		$ThreadSafe_t:=$Attributes_o.preemptive
		
		Case of 
			: ($ThreadSafe_t="capable")
				$ThreadSafeSection_t:="\rPreemptive\r"
				
			: ($ThreadSafe_t="incapable")
				$ThreadSafeSection_t:="\rCooperative\r"
				
			: ($ThreadSafe_t="indifferent")
				$ThreadSafeSection_t:="\rPreemptive capable\r"
				
		End case 
		
		$MethodCode_t:=Replace string:C233($MethodCode_t;"\r  // Access: Shared\r";"\r  // Access: Shared\r"+$ThreadSafeSection_t)
		$MethodCode_t:=Replace string:C233($MethodCode_t;"\r  // Access: Private\r";"\r  // Access: Shared\r"+$ThreadSafeSection_t)
		
		  //  End Threadsafe section 
		
		$MethodCode_t:=Replace string:C233($MethodCode_t;"  // ----------------------------------------------------\r";"")
		$MethodCode_t:=Replace string:C233($MethodCode_t;"// ----------------------------------------------------\r";"")
		
		$MethodCode_t:=Replace string:C233($MethodCode_t;"  // Project Method: ";"")
		$MethodCode_t:=Replace string:C233($MethodCode_t;"// Project Method: ";"")
		
		$MethodCode_t:=Replace string:C233($MethodCode_t;"  // ";"")
		$MethodCode_t:=Replace string:C233($MethodCode_t;"// ";"")
		
		$Position_i:=Position:C15("Created by";$MethodCode_t)
		
		$MethodCode_t:=Substring:C12($MethodCode_t;1;($Position_i-3))
		
		$FirstChars_t:=Substring:C12($MethodCode_t;1;2)
		While ($FirstChars_t="\r\r")
			$MethodCode_t:=Substring:C12($MethodCode_t;2)
			$FirstChars_t:=Substring:C12($MethodCode_t;1;2)
		End while 
		
		$MethodComments_at{$CurrentMethod_i}:=$MethodCode_t
		
	End for 
	
	METHOD SET COMMENTS:C1193($MethodNames_at;$MethodComments_at)
	
Else 
	
	If (Count parameters:C259=1)
		$MethodName_t:=$1
	Else 
		$MethodName_t:=""
	End if 
	
	  // This version allows for any number of processes 
	  // $ProcessID_i:=New Process(Current method name;$StackSize_i;Current method name;0)
	
	  // On the other hand, this version allows for one unique process 
	$ProcessID_i:=New process:C317(Current method name:C684;$StackSize_i;Current method name:C684;$MethodName_t;0;*)
	
	RESUME PROCESS:C320($ProcessID_i)
	SHOW PROCESS:C325($ProcessID_i)
	BRING TO FRONT:C326($ProcessID_i)
End if 
