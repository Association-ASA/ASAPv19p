//%attributes = {"invisible":true,"executedOnServer":true,"preemptive":"capable"}
  // ----------------------------------------------------
  // User name (OS): Vanessa Talbot
  // Date and time: 16/01/17, 14:20:19
  // ----------------------------------------------------
  // Method: getTablesAndFields
  // Description
  //   * Export the structure with Export structure command
  //   * Parse the tables and field information in the xml tree with the DTD information 
  //       - ./Resources/DTD/base.dtd
  //       - ./Resources/DTD/common.dtd
  //       - ./Resources/DTD/base_core.dtd
  //   * Save the result in C_Object
  //
  // Parameters
  //   return an C_Object that contains the tables and field information
  // ----------------------------------------------------
  // https://blog.4d.com/detailed-analysis-database-structure/

C_TEXT:C284($XMLStructure;$name)
C_LONGINT:C283($iRef;$iAtt;$numberRef)
ARRAY TEXT:C222($arrRef;0)

C_OBJECT:C1216($oTable;$oTmp;$oIndex;$oColor;$oCoordinates)

ARRAY OBJECT:C1221($arrTable;0)
ARRAY OBJECT:C1221($arrField;0)
ARRAY OBJECT:C1221($arrPrimaryKey;0)
ARRAY OBJECT:C1221($arrIndex;0)

EXPORT STRUCTURE:C1311($XMLStructure)
$refXMLStructure:=DOM Parse XML variable:C720($xmlStructure)
$refXML:=DOM Find XML element:C864($refXMLStructure;"base/table";$arrRef)
$numberRef:=Size of array:C274($arrRef)
For ($iRef;1;$numberRef)
	  // <!ELEMENT table (field*,primary_key*,table_extra?)>
	  //<!ATTLIST table
	  //uuid CDATA#IMPLIED
	  //name CDATA#REQUIRED
	  //id NMTOKEN#IMPLIED
	  //leave_tag_on_delete(True | False)"false"
	  //sql_schema_id NMTOKEN#IMPLIED
	  //sql_schema_name CDATA#IMPLIED
	  //keep_record_stamps(True | False)"true"
	  //keep_record_sync_info(True | False)"false"
	  //hide_in_REST(True | False)"false"
	  //prevent_journaling(True | False)"false"
	  //>
	$numAttributes:=DOM Count XML attributes:C727($arrRef{$iRef})
	
	For ($iAtt;1;$numAttributes)
		DOM GET XML ATTRIBUTE BY INDEX:C729($arrRef{$iRef};$iAtt;$tmpName;$tmpVal)
		OB SET:C1220($oTable;$tmpName;$tmpVal)
	End for 
	
	$xml_Child_Ref:=DOM Get first child XML element:C723($arrRef{$iRef})
	While (OK=1)
		
		DOM GET XML ELEMENT NAME:C730($xml_Child_Ref;$name)
		
		Case of 
			: ($name="field")
				  //<!ELEMENT field(index_ref*,field_extra?)>
				  //<!ATTLIST field
				  //name CDATA#REQUIRED
				  //uuid CDATA#IMPLIED
				  //type NMTOKEN#REQUIRED
				  //limiting_length NMTOKEN#IMPLIED
				  //unique(True | False)"false"
				  //autosequence(True | False)"false"
				  //not_null(True | False)"false"
				  //never_null(True | False)"false"
				  //text_switch_size NMTOKEN#IMPLIED
				  //blob_switch_size NMTOKEN#IMPLIED
				  //id NMTOKEN#IMPLIED
				  //autogenerate(True | False)"false"
				  //store_as_utf8(True | False)"false"
				  //store_as_UUID(True | False)"false"
				  //styled_text(True | False)"false"
				  //outside_blob(True | False)"false"
				  //hide_in_REST(True | False)"false"
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
						: ($name="index_ref")
							  //<!ELEMENT index_ref EMPTY>
							  //<!ATTLIST index_ref
							  //uuid CDATA#REQUIRED
							  //>
							
							$numAttributes:=DOM Count XML attributes:C727($xml_Child2_Ref)
							For ($iAtt;1;$numAttributes)
								DOM GET XML ATTRIBUTE BY INDEX:C729($xml_Child2_Ref;$iAtt;$tmpName;$tmpVal)
								OB SET:C1220($oIndex;$tmpName;$tmpVal)
							End for 
							
							APPEND TO ARRAY:C911($arrIndex;$oIndex)
							CLEAR VARIABLE:C89($oIndex)
							
						: ($name="field_extra")
							  //<!ELEMENT field_extra(qt_spatial_settings?,tip?,comment*, editor_field_info?)>
							  //<!ATTLIST field_extra
							  //visible(True | False)"true"
							  //enterable(True | False)"true"
							  //modifiable(True | False)"true"
							  //mandatory(True | False)"false"
							  //multi_line(True | False | default)"default"
							  //compressed(True | False)"false"
							  //enumeration_id NMTOKEN"-1"
							  //position NMTOKEN#IMPLIED
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
									: ($name="qt_spatial_settings")
										  //<!ELEMENT qt_spatial_settings EMPTY>
										  //<!ATTLIST qt_spatial_settings
										  //codec_type CDATA#REQUIRED
										  //depth NMTOKEN#REQUIRED
										  //spatial_quality NMTOKEN#REQUIRED
										  //>
										
										  // ignored
										
									: ($name="tip")
										  //<!ELEMENT tip (#PCDATA)>
										DOM GET XML ELEMENT VALUE:C731($xml_Child3_Ref;$tmpVal)
										OB SET:C1220($oTmp;"tip";$tmpVal)
										
									: ($name="comment")
										$numAttributes:=DOM Count XML attributes:C727($xml_Child3_Ref)
										For ($iAtt;1;$numAttributes)
											DOM GET XML ATTRIBUTE BY INDEX:C729($xml_Child3_Ref;$iAtt;$tmpName;$tmpVal)
											If (($tmpName="format") & ($tmpVal="text"))
												DOM GET XML ELEMENT VALUE:C731($xml_Child3_Ref;$tmpVal)
												OB SET:C1220($oTmp;"comment";$tmpVal)
											End if 
										End for 
										
									: ($name="editor_field_info")
										  //<!ELEMENT editor_field_info (color?)>
										
										$xml_Child4_Ref:=DOM Get first child XML element:C723($xml_Child3_Ref)
										While (OK=1)
											DOM GET XML ELEMENT NAME:C730($xml_Child4_Ref;$name)
											Case of 
												: ($name="color")
													  //<!ELEMENT color EMPTY>
													  //<!ATTLIST color
													  //red CDATA#REQUIRED
													  //green CDATA#REQUIRED
													  //blue CDATA#REQUIRED
													  //alpha CDATA#IMPLIED
													  //>
													$numAttributes:=DOM Count XML attributes:C727($xml_Child4_Ref)
													For ($iAtt;1;$numAttributes)
														DOM GET XML ATTRIBUTE BY INDEX:C729($xml_Child4_Ref;$iAtt;$tmpName;$tmpVal)
														OB SET:C1220($oColor;$tmpName;$tmpVal)
													End for 
											End case 
											
											$xml_Child4_Ref:=DOM Get next sibling XML element:C724($xml_Child4_Ref)
										End while 
										
										OB SET:C1220($oTmp;"color";$oColor)
										CLEAR VARIABLE:C89($oColor)
										
								End case 
								
								$xml_Child3_Ref:=DOM Get next sibling XML element:C724($xml_Child3_Ref)
							End while 
							
					End case 
					
					$xml_Child2_Ref:=DOM Get next sibling XML element:C724($xml_Child2_Ref)
				End while 
				
				If (Size of array:C274($arrIndex)>0)
					OB SET ARRAY:C1227($oTmp;"index_ref";$arrIndex)
				End if 
				
				APPEND TO ARRAY:C911($arrField;$oTmp)
				CLEAR VARIABLE:C89($arrIndex)
				CLEAR VARIABLE:C89($oTmp)
				
			: ($name="primary_key")
				  //<!ELEMENT primary_key EMPTY>
				  //<!ATTLIST primary_key
				  //field_name CDATA#REQUIRED
				  //field_uuid CDATA#IMPLIED
				  //>
				$numAttributes:=DOM Count XML attributes:C727($xml_Child_Ref)
				
				For ($iAtt;1;$numAttributes)
					DOM GET XML ATTRIBUTE BY INDEX:C729($xml_Child_Ref;$iAtt;$tmpName;$tmpVal)
					OB SET:C1220($oTmp;$tmpName;$tmpVal)
				End for 
				
				APPEND TO ARRAY:C911($arrPrimaryKey;$oTmp)
				CLEAR VARIABLE:C89($oTmp)
				
				
			: ($name="table_extra")
				  //<!ELEMENT table_extra(comment*, editor_table_info?)>
				  //<!ATTLIST table_extra
				  //visible(True | False)"true"
				  //trigger_load(True | False)"false"
				  //trigger_insert(True | False)"false"
				  //trigger_delete(True | False)"false"
				  //trigger_update(True | False)"false"
				  //trashed(True | False)"false"
				  //>
				$numAttributes:=DOM Count XML attributes:C727($xml_Child_Ref)
				
				For ($iAtt;1;$numAttributes)
					DOM GET XML ATTRIBUTE BY INDEX:C729($xml_Child_Ref;$iAtt;$tmpName;$tmpVal)
					OB SET:C1220($oTable;$tmpName;$tmpVal)
				End for 
				
				$xml_Child2_Ref:=DOM Get first child XML element:C723($xml_Child_Ref)
				While (OK=1)
					DOM GET XML ELEMENT NAME:C730($xml_Child2_Ref;$name)
					Case of 
						: ($name="editor_table_info")
							  //<!ELEMENT editor_table_info(color?,coordinates?)>
							  //<!ATTLIST editor_table_info
							  //fields_orderingNMTOKEN#IMPLIED
							  //collapsed(True | False)"false"
							  //displayable_fields_countNMTOKEN#IMPLIED
							  //>
							$numAttributes:=DOM Count XML attributes:C727($xml_Child2_Ref)
							For ($iAtt;1;$numAttributes)
								DOM GET XML ATTRIBUTE BY INDEX:C729($xml_Child2_Ref;$iAtt;$tmpName;$tmpVal)
								OB SET:C1220($oTable;$tmpName;$tmpVal)
							End for 
							
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
										$numAttributes:=DOM Count XML attributes:C727($xml_Child3_Ref)
										For ($iAtt;1;$numAttributes)
											DOM GET XML ATTRIBUTE BY INDEX:C729($xml_Child3_Ref;$iAtt;$tmpName;$tmpVal)
											OB SET:C1220($oColor;$tmpName;$tmpVal)
										End for 
										
									: ($name="coordinates")
										  //<!ELEMENT coordinates EMPTY>
										  //<!ATTLIST coordinates
										  //left CDATA#IMPLIED
										  //top CDATA#IMPLIED
										  //right CDATA#IMPLIED
										  //bottom CDATA#IMPLIED
										  //width CDATA#IMPLIED
										  //height CDATA#IMPLIED
										  //>
										$numAttributes:=DOM Count XML attributes:C727($xml_Child3_Ref)
										For ($iAtt;1;$numAttributes)
											DOM GET XML ATTRIBUTE BY INDEX:C729($xml_Child3_Ref;$iAtt;$tmpName;$tmpVal)
											OB SET:C1220($oCoordinates;$tmpName;$tmpVal)
										End for 
										
								End case 
								
								$xml_Child3_Ref:=DOM Get next sibling XML element:C724($xml_Child3_Ref)
							End while 
							
						: ($name="comment")
							  //<!ELEMENT comment(#PCDATA)>
							  //<!ATTLIST comment
							  //format CDATA#IMPLIED
							  // >
							$numAttributes:=DOM Count XML attributes:C727($xml_Child2_Ref)
							
							For ($iAtt;1;$numAttributes)
								DOM GET XML ATTRIBUTE BY INDEX:C729($xml_Child2_Ref;$iAtt;$tmpName;$tmpVal)
								If (($tmpName="format") & ($tmpVal="text"))
									DOM GET XML ELEMENT VALUE:C731($xml_Child2_Ref;$tmpVal)
									OB SET:C1220($oTable;"comment";$tmpVal)
								End if 
								
							End for 
							
					End case 
					
					$xml_Child2_Ref:=DOM Get next sibling XML element:C724($xml_Child2_Ref)
				End while 
				
				OB SET:C1220($oTable;"color";$oColor)
				OB SET:C1220($oTable;"coordinates";$oCoordinates)
				CLEAR VARIABLE:C89($oColor)
				CLEAR VARIABLE:C89($oCoordinates)
				
		End case 
		
		$xml_Child_Ref:=DOM Get next sibling XML element:C724($xml_Child_Ref)
		
	End while 
	
	If (Size of array:C274($arrPrimaryKey)>0)
		  //OB SET ARRAY($oTable;"PrimaryKey";$arrPrimaryKey)
		For ($iAtt;1;Size of array:C274($arrPrimaryKey))
			For ($iField;1;Size of array:C274($arrField))
				
				If ($arrField{$iField}.uuid=$arrPrimaryKey{$iAtt}.field_uuid)
					
					OB SET:C1220($arrField{$iField};"pk";"true")
					$iField:=Size of array:C274($arrField)+1
				End if 
				
			End for 
		End for 
	End if 
	
	If (Size of array:C274($arrField)>0)
		OB SET ARRAY:C1227($oTable;"Field";$arrField)
	End if 
	
	APPEND TO ARRAY:C911($arrTable;$oTable)
	CLEAR VARIABLE:C89($arrField)
	CLEAR VARIABLE:C89($arrPrimaryKey)
	CLEAR VARIABLE:C89($oTable)
	
End for 
DOM CLOSE XML:C722($refXMLStructure)

OB SET ARRAY:C1227($oTable;"table";$arrTable)

C_OBJECT:C1216($0)
$0:=$oTable