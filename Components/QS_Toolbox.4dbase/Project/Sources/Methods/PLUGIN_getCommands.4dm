//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
#DECLARE($resource : Object)->$commandInfo : Object
ARRAY TEXT:C222($themes; 0x0000)
ARRAY LONGINT:C221($pos; 0x0000)
ARRAY LONGINT:C221($len; 0x0000)
ARRAY OBJECT:C1221($commands; 0x0000)
C_OBJECT:C1216($command; $argument)

$type:=OB Get:C1224($resource; "type")

$commandInfo:=New object:C1471
OB SET:C1220($commandInfo; "name"; "")
OB SET NULL:C1233($commandInfo; "id")

Case of 
		
	: ($type="rsr")
		$rsr:=Open resource file:C497($resource.path)
		
		If (OK=1)
			
			ARRAY TEXT:C222($resourceTypes; 0x0000)
			
			// public types are: THM#, 4BNX, STR#, FON#, 4DK#
			RESOURCE TYPE LIST:C499($resourceTypes; $rsr)
			
			If (Find in array:C230($resourceTypes; "4BNX")#-1)  // is a plugin resource
				
				ARRAY TEXT:C222($resourceNames; 0)
				ARRAY LONGINT:C221($resourceIds; 0)
				ARRAY TEXT:C222($commandSignatures; 0)
				RESOURCE LIST:C500("4BNX"; $resourceIds; $resourceNames; $rsr)
				
				If (Size of array:C274($resourceIds)#0)
					
					OB SET:C1220($commandInfo; "id"; $resourceIds{1})
					OB SET:C1220($commandInfo; "name"; $resourceNames{1})
					C_BLOB:C604($FON; $THM)
					
					If (Find in array:C230($resourceTypes; "FON#")#-1)
						
						GET RESOURCE:C508("FON#"; $resourceIds{1}; $FON; $rsr)
						
						If (Find in array:C230($resourceTypes; "THM#")#-1)
							
							STRING LIST TO ARRAY:C511($resourceIds{1}; $commandSignatures; $rsr)
							RESOURCE LIST:C500("THM#"; $resourceIds; $resourceNames; $rsr)
							
							If (Size of array:C274($resourceIds)#0)
								GET RESOURCE:C508("THM#"; $resourceIds{1}; $THM; $rsr)
							End if 
							
						Else 
							
							// 4D View and 4D Write
							$localisedPath:=Replace string:C233($path; $resourceNames{1}+".rsrc"; "en.lproj"+Folder separator:K24:12+"Localized.rsrc"; *)
							
							If (Test path name:C476($localisedPath)=Is a document:K24:1)
								
								$localised:=Open resource file:C497($localisedPath)
								RESOURCE TYPE LIST:C499($resourceTypes; $localised)
								
								If (Find in array:C230($resourceTypes; "THM#")#-1)
									
									Case of 
											
										: (OB Get:C1224($commandInfo; "name")="4D Write")
											STRING LIST TO ARRAY:C511($resourceIds{1}; $commandSignatures; $localised)
											
										: (OB Get:C1224($commandInfo; "name")="4D View")
											STRING LIST TO ARRAY:C511(12256; $commandSignatures; $localised)
											
									End case 
									
									RESOURCE LIST:C500("THM#"; $resourceIds; $resourceNames; $localised)
									
									If (Size of array:C274($resourceIds)#0)
										GET RESOURCE:C508("THM#"; $resourceIds{1}; $THM; $localised)
									End if 
									
								End if 
								
								CLOSE RESOURCE FILE:C498($localised)
								
							End if 
							
							$offset:=0x0000
							For ($i; 1; BLOB to integer:C549($THM; 0; $offset))
								APPEND TO ARRAY:C911($themes; BLOB to text:C555($THM; 1; $offset))
							End for 
							
						End if 
						
						For ($i; 1; Size of array:C274($commandSignatures))
							
							CLEAR VARIABLE:C89($command)
							$commandSignature:=$commandSignatures{$i}
							
							If (Match regex:C1019("([^(:]+)\\(?([^\\:)]*)\\)?:?(.?)"; $commandSignature; 1; $pos; $len))
								
								If (BLOB size:C605($FON)#0) & (Size of array:C274($themes)>0)
									OB SET:C1220($command; "theme"; $themes{$FON{$i-1}})
								Else 
									//OB SET NULL($command;"theme")
									OB SET:C1220($command; "theme"; "n/a")
									
								End if 
								
								OB SET:C1220($command; "command"; Substring:C12($commandSignature; $pos{1}; $len{1}))
								OB SET:C1220($command; "command_id"; $i)
								OB SET:C1220($command; "command_type"; Get_type_name(Substring:C12($commandSignature; $pos{3}; $len{3})))
								$syntax:=Substring:C12($commandSignature; $pos{2}; $len{2})
								OB SET:C1220($command; "syntax"; $syntax)
								$ii:=0x0001
								ARRAY OBJECT:C1221($commandArguments; 0)
								
								While (Match regex:C1019("(&(.))(;.+|$)"; $syntax; 1; $pos; $len))
									
									CLEAR VARIABLE:C89($argument)
									OB SET:C1220($argument; "argument_id"; $ii)
									OB SET:C1220($argument; "argument_type"; Get_type_name(Substring:C12($syntax; $pos{2}; $len{2})))
									$syntax:=Substring:C12($syntax; $pos{3}; $len{3})
									$ii:=$ii+1
									APPEND TO ARRAY:C911($commandArguments; $argument)
									
								End while 
								
								OB SET ARRAY:C1227($command; "arguments"; $commandArguments)
								APPEND TO ARRAY:C911($commands; $command)
								
							End if 
						End for 
					End if 
				End if 
				
				CLOSE RESOURCE FILE:C498($rsr)
				
			End if 
		End if 
		
	: ($type="json")
		$json:=Document to text:C1236($resource.path; "utf-8")
		
		If (OK=1)
			
			$commandInfo:=JSON Parse:C1218($json)
			OB GET ARRAY:C1229($commandInfo; "commands"; $commands)
			
			For ($i; 1; Size of array:C274($commands))
				
				$command:=$commands{$i}
				$commandSignature:=OB Get:C1224($command; "syntax")
				
				If (Match regex:C1019("([^(:]+)\\(?([^\\:)]*)\\)?:?(.?)"; $commandSignature; 1; $pos; $len))
					
					OB SET:C1220($command; "command_id"; $i)
					OB SET:C1220($command; "command"; Substring:C12($commandSignature; $pos{1}; $len{1}))
					OB SET:C1220($command; "command_type"; Get_type_name(Substring:C12($commandSignature; $pos{3}; $len{3})))
					$syntax:=Substring:C12($commandSignature; $pos{2}; $len{2})
					$ii:=0x0001
					ARRAY OBJECT:C1221($commandArguments; 0)
					
					While (Match regex:C1019("(&(.))(;.+|$)"; $syntax; 1; $pos; $len))
						
						CLEAR VARIABLE:C89($argument)
						OB SET:C1220($argument; "argument_id"; $ii)
						OB SET:C1220($argument; "argument_type"; Get_type_name(Substring:C12($syntax; $pos{2}; $len{2})))
						$syntax:=Substring:C12($syntax; $pos{3}; $len{3})
						$ii:=$ii+1
						APPEND TO ARRAY:C911($commandArguments; $argument)
						
					End while 
					
					OB SET ARRAY:C1227($command; "arguments"; $commandArguments)
					
				End if 
			End for 
			
			OB REMOVE:C1226($commandInfo; "commands")  // remove element #0
			OB SET ARRAY:C1227($commandInfo; "commands"; $commands)
			
		End if 
End case 

OB SET ARRAY:C1227($commandInfo; "commands"; $commands)