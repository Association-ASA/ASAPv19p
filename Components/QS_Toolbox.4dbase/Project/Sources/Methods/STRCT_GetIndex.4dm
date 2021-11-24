//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable"}
  // ----------------------------------------------------
  // User name (OS): Vanessa Talbot
  // Date and time: 16/01/17, 15:18:50
  // ----------------------------------------------------
  // Method: getIndex
  // Description
  //   * Export the structure with Export structure command
  //   * Parse the index information in the xml tree with the DTD information 
  //       - ./Resources/DTD/base.dtd
  //       - ./Resources/DTD/common.dtd
  //       - ./Resources/DTD/base_core.dtd
  //   * Save the result in C_Object
  //
  // Parameters:
  //   return an C_Object that contains the index information
  // 
  // ----------------------------------------------------
  // https://blog.4d.com/detailed-analysis-database-structure/

C_TEXT:C284($xmlStructure;$name;$tmpName;$tmpVal)
C_LONGINT:C283($iRef;$iAtt;$numberRef)
ARRAY TEXT:C222($arrRef;0)

C_OBJECT:C1216($oIndex;$oTmp)
ARRAY OBJECT:C1221($arrIndex;0)
ARRAY OBJECT:C1221($arrField;0)

EXPORT STRUCTURE:C1311($xmlStructure)
$refXMLStructure:=DOM Parse XML variable:C720($xmlStructure)

$refXML:=DOM Find XML element:C864($refXMLStructure;"base/index";$arrRef)
$numberRef:=Size of array:C274($arrRef)
For ($iRef;1;$numberRef)
	  //<!ELEMENT index(field_ref+)>
	  //<!ATTLIST index
	  //kind(regular | keywords)"regular"
	  //unique_keys(True | False)"false"
	  //name CDATA#IMPLIED
	  //uuid CDATA#IMPLIED
	  //type NMTOKEN#IMPLIED
	  //>
	
	$numAttributes:=DOM Count XML attributes:C727($arrRef{$iRef})
	For ($iAtt;1;$numAttributes)
		DOM GET XML ATTRIBUTE BY INDEX:C729($arrRef{$iRef};$iAtt;$tmpName;$tmpVal)
		OB SET:C1220($oIndex;$tmpName;$tmpVal)
	End for 
	
	$xml_Child_Ref:=DOM Get first child XML element:C723($arrRef{$iRef})
	While (OK=1)
		DOM GET XML ELEMENT NAME:C730($xml_Child_Ref;$name)
		
		Case of 
			: ($name="field_ref")
				  //<!ELEMENT field_ref(table_ref?)>
				  //<!ATTLIST field_ref
				  //uuid CDATA#REQUIRED
				  //name CDATA#IMPLIED
				  //>
				$numAttributes:=DOM Count XML attributes:C727($xml_Child_Ref)
				For ($iAtt;1;$numAttributes)
					DOM GET XML ATTRIBUTE BY INDEX:C729($xml_Child_Ref;$iAtt;$tmpName;$tmpVal)
					OB SET:C1220($oTmp;$tmpName;$tmpVal)
				End for 
				
				$xml_Child2_Ref:=DOM Get first child XML element:C723($xml_Child_Ref)
				While (OK=1)
					DOM GET XML ELEMENT NAME:C730($xml_Child2_Ref;$name)
					Case of 
						: ($name="table_ref")
							  //<!ELEMENT table_ref(base_ref?)>
							  //<!ATTLIST table_ref
							  //uuid CDATA#REQUIRED
							  //name CDATA #IMPLIED
							$numAttributes:=DOM Count XML attributes:C727($xml_Child2_Ref)
							For ($iAtt;1;$numAttributes)
								DOM GET XML ATTRIBUTE BY INDEX:C729($xml_Child2_Ref;$iAtt;$tmpName;$tmpVal)
								Case of 
									: ($tmpName="name")
										$tableName:=$tmpVal
										$oTmp.table_name:=$tmpVal
									: ($tmpName="uuid")
										$oTmp.table_uuid:=$tmpVal
								End case 
							End for 
					End case 
					$xml_Child2_Ref:=DOM Get next sibling XML element:C724($xml_Child2_Ref)
				End while 
				
				APPEND TO ARRAY:C911($arrField;$oTmp)
				CLEAR VARIABLE:C89($oTmp)
		End case 
		
		$xml_Child_Ref:=DOM Get next sibling XML element:C724($xml_Child_Ref)
	End while 
	
	OB SET ARRAY:C1227($oIndex;"field";$arrField)
	APPEND TO ARRAY:C911($arrIndex;$oIndex)
	
	CLEAR VARIABLE:C89($arrField)
	CLEAR VARIABLE:C89($oIndex)
	
End for 

DOM CLOSE XML:C722($refXMLStructure)

OB SET ARRAY:C1227($oIndex;"index";$arrIndex)

$0:=$oIndex