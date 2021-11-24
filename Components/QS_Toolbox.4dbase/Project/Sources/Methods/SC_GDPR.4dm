//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
// ----------------------------------------------------
// Nom utilisateur (OS) : Association QualiSoft
// Date et heure : 11/05/18, 22:38:23
// ----------------------------------------------------
// Paramètres
// {$1} = to export on file
// ----------------------------------------------------
// Méthode : SC_GDPR
// Description
// https://blog.4d.com/4d-helps-you-comply-with-gdpr/

C_TEXT:C284($XMLStructure; $name; $ReadVal; $tableName; $fieldname)
C_LONGINT:C283($iRef; $iAtt; $numberRef)
ARRAY TEXT:C222($arrRef; 0)
C_BOOLEAN:C305($1)
C_COLLECTION:C1488($result)
C_OBJECT:C1216($grpd)

$Listbox_Name:="LB_Information"
LB_Init_Start($Listbox_Name)

$result:=New collection:C1472
EXPORT STRUCTURE:C1311($XMLStructure)

$refXMLStructure:=DOM Parse XML variable:C720($xmlStructure)
$refXML:=DOM Find XML element:C864($refXMLStructure; "base/table"; $arrRef)
$numberRef:=Size of array:C274($arrRef)

For ($iRef; 1; $numberRef)
	
	$numAttributes:=DOM Count XML attributes:C727($arrRef{$iRef})
	$xml_Child_Ref:=DOM Get first child XML element:C723($arrRef{$iRef})
	
	//Make sure the element exists
	While (OK=1)
		
		DOM GET XML ELEMENT NAME:C730($xml_Child_Ref; $name)
		
		Case of 
			: ($name="field")
				
				$numAttributes:=DOM Count XML attributes:C727($xml_Child_Ref)
				$xml_Child2_Ref:=DOM Get first child XML element:C723($xml_Child_Ref)
				While (OK=1)
					DOM GET XML ELEMENT NAME:C730($xml_Child2_Ref; $name)
					Case of 
							
						: ($name="field_extra")
							
							$xml_Child3_Ref:=DOM Get first child XML element:C723($xml_Child2_Ref)
							
							While (OK=1)
								
								DOM GET XML ELEMENT NAME:C730($xml_Child3_Ref; $name)
								Case of 
									: ($name="comment")
										
										DOM GET XML ELEMENT VALUE:C731($xml_Child3_Ref; $ReadVal)
										
										$numAttributes:=DOM Count XML attributes:C727($xml_Child3_Ref)
										
										For ($iAtt; 1; $numAttributes)
											DOM GET XML ATTRIBUTE BY INDEX:C729($xml_Child3_Ref; $iAtt; $attName; $attVal)
											If (($attName="format") & ($attVal="text"))
												If (($ReadVal%Lowercase:C14("gdpr")) | ($ReadVal%Lowercase:C14("rgpd")))
													
													DOM GET XML ATTRIBUTE BY NAME:C728($arrRef{$iRef}; "name"; $tableName)
													DOM GET XML ATTRIBUTE BY NAME:C728($xml_Child_Ref; "name"; $fieldName)
													
													$result.push(New object:C1471("method"; $tableName; "field name"; $fieldName))
													
												End if 
											End if 
											
										End for 
										
								End case 
								$xml_Child3_Ref:=DOM Get next sibling XML element:C724($xml_Child3_Ref)
							End while 
							
					End case 
					
					$xml_Child2_Ref:=DOM Get next sibling XML element:C724($xml_Child2_Ref)
				End while 
				
		End case 
		
		$xml_Child_Ref:=DOM Get next sibling XML element:C724($xml_Child_Ref)
		
	End while 
	
End for 

DOM CLOSE XML:C722($refXMLStructure)
// Extract to a file

If ($result.length>0)
	If (Count parameters:C259=1)
		C_TEXT:C284($tmp)
		$tmp:=""
		
		For each ($grpd; $result)
			$tmp:=$tmp+$grpd.method+";"+$grpd["field name"]+Char:C90(Carriage return:K15:38)
		End for each 
		
		//choose a custom location to save the report
		ARRAY TEXT:C222($selected; 0x0000)
		
		If (Select document:C905("GDPR quick report.csv"; "csv"; "Report name:"; File name entry:K24:17; $selected)#"")
			$path:=$selected{1}
		End if 
		
		If (OK=1)
			If ($path#"")
				TEXT TO DOCUMENT:C1237($path; $tmp)
			End if 
		End if 
		
	Else 
		
		// --------------------------------------------
		// Listbox construction
		// --------------------------------------------
		
		LB_buildByCollection($result; $Listbox_Name)
		
		Form:C1466.result:=$result.copy()
		ARRAY TEXT:C222($tabPropertyNames; 0x0000)
		OB GET PROPERTY NAMES:C1232($result[0]; $tabPropertyNames)
		
		For ($i; 1; Size of array:C274($tabPropertyNames))
			Case of 
				: ($i=1)
					OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Table")
					LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 300)
					
				: ($i=2)
					OBJECT SET TITLE:C194(*; "QS_header"+String:C10($i); "Field")
					LISTBOX SET COLUMN WIDTH:C833(*; "QS_Col_"+$tabPropertyNames{$i}; 300)
					
			End case 
			
		End for 
		
		displayInfo("")
		ARRAY LONGINT:C221($MyEventsOnLB; 1)
		$MyEventsOnLB{1}:=On Clicked:K2:4
		OBJECT SET EVENTS:C1239(*; $Listbox_Name; $MyEventsOnLB; Enable events disable others:K42:37)
	End if 
	
Else 
	
	displayInfo("No GRPD information found in structure definition tables."; "green")
	
End if 