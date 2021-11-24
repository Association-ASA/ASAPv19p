//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable"}
  // ----------------------------------------------------
  // User name (OS): Vanessa Talbot
  // Date and time: 16/01/17, 10:55:39
  // ----------------------------------------------------
  // Method: getRelation
  // Description
  //   * Export the structure with Export structure command
  //   * Parse the relation information in the xml tree with the DTD information 
  //       - ./Resources/DTD/base.dtd
  //       - ./Resources/DTD/common.dtd
  //       - ./Resources/DTD/base_core.dtd
  //   * Save the result in C_Object
  //
  // Parameters
  //   return an C_Object that contains the relation information
  // ----------------------------------------------------
  // https://blog.4d.com/detailed-analysis-database-structure/

C_TEXT:C284($XMLStructure;$tmpName;$tmpVal)
C_LONGINT:C283($iRef;$iAtt)
ARRAY TEXT:C222($arrRef;0)

C_OBJECT:C1216($oRelation;$oTmp;$oColor)
ARRAY OBJECT:C1221($arrRelation;0)
ARRAY OBJECT:C1221($arrRelatedField;0)

EXPORT STRUCTURE:C1311($XMLStructure)
$refXMLStructure:=DOM Parse XML variable:C720($xmlStructure)

$refXML:=DOM Find XML element:C864($refXMLStructure;"base/relation";$arrRef)
$numberRef:=Size of array:C274($arrRef)
For ($iRef;1;$numberRef)
	  //<!ELEMENT relation(related_field+, relation_extra?)>
	  //<!ATTLIST relation
	  //name_Nto1 CDATA#IMPLIED
	  //name_1toN CDATA#IMPLIED
	  //uuid CDATA#IMPLIED
	  //auto_load_Nto1(True | False)"false"
	  //auto_load_1toN(True | False)"false"
	  //foreign_key(True | False)"false"
	  //integrity(None | REJECT | delete)"none"
	  //state NMTOKEN#REQUIRED
	  //>
	
	$numAttributes:=DOM Count XML attributes:C727($arrRef{$iRef})
	For ($iAtt;1;$numAttributes)
		DOM GET XML ATTRIBUTE BY INDEX:C729($arrRef{$iRef};$iAtt;$tmpName;$tmpVal)
		OB SET:C1220($oRelation;$tmpName;$tmpVal)
	End for 
	
	$xml_Child_Ref:=DOM Get first child XML element:C723($arrRef{$iRef})
	While (OK=1)
		
		DOM GET XML ELEMENT NAME:C730($xml_Child_Ref;$name)
		
		Case of 
			: ($name="related_field")
				  //<!ELEMENT related_field(field_ref)>
				  //<!ATTLIST related_field
				  //kind(source | destination)#REQUIRED
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
						: ($name="field_ref")
							  //<!ELEMENT field_ref(table_ref?)>
							  //<!ATTLIST field_ref
							  //uuid CDATA#REQUIRED
							  //name CDATA#IMPLIED
							  //>
							$numAttributes:=DOM Count XML attributes:C727($xml_Child2_Ref)
							For ($iAtt;1;$numAttributes)
								DOM GET XML ATTRIBUTE BY INDEX:C729($xml_Child2_Ref;$iAtt;$tmpName;$tmpVal)
								OB SET:C1220($oTmp;$tmpName;$tmpVal)
							End for 
							
							$xml_Child3_Ref:=DOM Get first child XML element:C723($xml_Child2_Ref)
							While (OK=1)
								DOM GET XML ELEMENT NAME:C730($xml_Child3_Ref;$name)
								Case of 
									: ($name="table_ref")
										  //<!ELEMENT table_ref(base_ref?)>
										  //<!ATTLIST table_ref
										  //uuid CDATA#REQUIRED
										  //name CDATA#IMPLIED
										  //>
										$numAttributes:=DOM Count XML attributes:C727($xml_Child3_Ref)
										For ($iAtt;1;$numAttributes)
											DOM GET XML ATTRIBUTE BY INDEX:C729($xml_Child3_Ref;$iAtt;$tmpName;$tmpVal)
											Case of 
												: ($tmpName="name")
													$tableName:=$tmpVal
													OB SET:C1220($oTmp;"table_name";$tmpVal)
												: ($tmpName="uuid")
													OB SET:C1220($oTmp;"table_uuid";$tmpVal)
											End case 
											
										End for 
								End case 
								$xml_Child3_Ref:=DOM Get next sibling XML element:C724($xml_Child3_Ref)
							End while 
							
					End case 
					
					$xml_Child2_Ref:=DOM Get next sibling XML element:C724($xml_Child2_Ref)
				End while 
				
				APPEND TO ARRAY:C911($arrRelatedField;$oTmp)
				CLEAR VARIABLE:C89($oTmp)
				
			: ($name="relation_extra")
				  //<!ELEMENT relation_extra(editor_relation_info?)>
				  //<!ATTLIST relation_extra
				  //entry_wildchar(True | False)"false"
				  //entry_create(True | False)"false"
				  //choice_field NMTOKEN#IMPLIED
				  //entry_autofill(True | False)"false"
				  //>
				
				$numAttributes:=DOM Count XML attributes:C727($xml_Child_Ref)
				For ($iAtt;1;$numAttributes)
					DOM GET XML ATTRIBUTE BY INDEX:C729($xml_Child_Ref;$iAtt;$tmpName;$tmpVal)
					OB SET:C1220($oRelation;$tmpName;$tmpVal)
				End for 
				
				$xml_Child2_Ref:=DOM Get first child XML element:C723($xml_Child_Ref)
				While (OK=1)
					DOM GET XML ELEMENT NAME:C730($xml_Child2_Ref;$name)
					Case of 
						: ($name="editor_relation_info")
							  //<!ELEMENT editor_relation_info(color)>
							  //<!ATTLIST editor_relation_info
							  //via_point_x NMTOKEN#IMPLIED
							  //via_point_y NMTOKEN#IMPLIED
							  //prefers_left(True | False)"false"
							  //smartlink(True | False)"false"
							  //>
							
							  //ignored attribute
							
							$xml_Child3_Ref:=DOM Get first child XML element:C723($xml_Child2_Ref)
							While (OK=1)
								DOM GET XML ELEMENT NAME:C730($xml_Child3_Ref;$name)
								Case of 
									: ($name="color")
										  //<!ELEMENT color EMPTY>
										  //<!ATTLIST color
										  //red CDATA#REQUIRED
										  //green CDATA#REQUIRED
										  //blue CDATA#REQUIRED
										  //alpha CDATA#IMPLIED
										  //>
										For ($iAtt;1;$numAttributes)
											DOM GET XML ATTRIBUTE BY INDEX:C729($xml_Child3_Ref;$iAtt;$tmpName;$tmpVal)
											OB SET:C1220($oColor;$tmpName;$tmpVal)
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
	
	OB SET:C1220($oRelation;"color";$oColor)
	OB SET ARRAY:C1227($oRelation;"related_field";$arrRelatedField)
	APPEND TO ARRAY:C911($arrRelation;$oRelation)
	CLEAR VARIABLE:C89($oRelation)
	CLEAR VARIABLE:C89($oColor)
	CLEAR VARIABLE:C89($arrRelatedField)
	
End for 

DOM CLOSE XML:C722($refXMLStructure)

OB SET ARRAY:C1227($oRelation;"relation";$arrRelation)

$0:=$oRelation