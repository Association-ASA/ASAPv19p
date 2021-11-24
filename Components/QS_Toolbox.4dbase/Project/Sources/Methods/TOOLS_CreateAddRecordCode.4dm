//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
$position:=Form:C1466.posCurrentTable-1

If ($position>=0)
	If (Storage:C1525.structureTable[$position].id>0)
		$NumTable:=Storage:C1525.structureTable[$position].id
		OBJECT SET VISIBLE:C603(*;"NbEnrTable";$NumTable>0)
		If ($NumTable>0)
			  //ZptTable:=Table($NumTable)
			(OBJECT Get pointer:C1124(Object named:K67:5;"NbEnrTable"))->:=Records in table:C83(Table:C252($NumTable)->)
			
			$InitValeur:=""
			
			$NomTable:="["+Storage:C1525.structureTable[$position].name+"]"
			$Code:=""
			$Code:=Command name:C538(68)+"("+$NomTable+")\r"  // create record
			
			
			For ($lFieldScan;1;Get last field number:C255($NumTable))
				
				If (Is field number valid:C1000($NumTable;$lFieldScan))
					$FieldName:=Field name:C257($NumTable;$lFieldScan)
					
					GET FIELD PROPERTIES:C258(Field:C253($NumTable;$lFieldScan);$vType;$long)
					Case of 
							
						: ($vType=Is real:K8:4) | ($vType=Is longint:K8:6) | ($vType=Is integer:K8:5)
							$InitValeur:="0"
							
						: ($vType=Is text:K8:3) | (($vType=Is alpha field:K8:1) & ($long>0))
							$InitValeur:=Char:C90(Double quote:K15:41)+Char:C90(Double quote:K15:41)
							
						: ($vType=Is date:K8:7)
							$InitValeur:="!00/00/0000!"
							
						: ($vType=Is time:K8:8)
							$InitValeur:="?00:00:00?"
							
						: ($vType=Is boolean:K8:9)
							$InitValeur:=String:C10(Command name:C538(215))  //"false"
							
						: (($vType=Is alpha field:K8:1) & ($long=0))
							$InitValeur:=Char:C90(Double quote:K15:41)+Generate UUID:C1066+Char:C90(Double quote:K15:41)
							
						Else   //Ben on n'en sait rien
							
							$InitValeur:=""
					End case 
					
					Case of 
						: ($vType=Is BLOB:K8:12)
							$Code:=$Code+Command name:C538(606)+"("+$NomTable+$FieldName+";0)\r"  // set blob size
							
						: ($vType=Is picture:K8:10)
							$Code:=$Code+Command name:C538(286)+"($Image)\r"  // C_Image
							$Code:=$Code+$NomTable+$FieldName+":=$image\r"
							
						: ($vType=Is object:K8:27)
							$Code:=$Code+Command name:C538(1216)+"($Object)\r"  // C_Object
							$Code:=$Code+"$Object:=new object(\"First Name\";\"John\";\"Name\";\"Doe\")\r"  // OB SET
							$Code:=$Code+$NomTable+$FieldName+":=$Object\r"
							
						Else   // Cas général
							
							$Code:=$Code+$NomTable+$FieldName+":="+$InitValeur+"\r"
					End case 
				End if 
				
			End for 
			
			$Code:=$Code+Command name:C538(53)+"("+$NomTable+")"  // save record
			SET TEXT TO PASTEBOARD:C523($Code)
			$FenetreInformation:="4D code for 'Add Record' generated successfully."
			
		Else 
			$FenetreInformation:="Select a Table first."
		End if 
		
		displayInfo ($FenetreInformation)
	End if 
End if 