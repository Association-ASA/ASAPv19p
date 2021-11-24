//%attributes = {"invisible":true,"preemptive":"indifferent","executedOnServer":false,"publishedSql":false,"shared":false,"publishedWsdl":false,"publishedSoap":false,"publishedWeb":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Patrick EMANUEL
  // Date et heure : 02/06/20, 13:58:10
  // ----------------------------------------------------
  // Méthode : d3_export
  // Description
  // 
  //
  // Paramètres
  // ----------------------------------------------------


C_COLLECTION:C1488($allMethods;$pos;$paths;$data)
C_OBJECT:C1216($method)
C_TEXT:C284($onePath)
C_TEXT:C284($1)

$option:=Num:C11($1)
ON ERR CALL:C155("BASE_GetError")
$root:=Storage:C1525.QS_TBX_SHARED_DATA.QS_TBX_DBName
$choice:=Choose:C955(Form:C1466.callees;"callers";"callees")
$data:=Storage:C1525.allMethods

Case of 
		
	: ($option=50)
		
		  // *********************************************************************
		  // "sunburn"
		  // *********************************************************************
		$ref:=New collection:C1472
		$collName:=New collection:C1472
		
		If (Form:C1466.name="")  // We take everything
			  //$paths:=$data.distinct("path").orderBy("asc")
			$paths:=$data.distinct("path")
			For each ($onePath;$paths)
				
				If ($ref.length>=1)
					$subRef:=$ref[$ref.length-1].children
				End if 
				  //$allMethods:=$data.query("path =:1 orderBy name";$onePath)
				$allMethods:=$data.query("path =:1";$onePath)
				$subRef.push(New object:C1471("name";Form:C1466.name;"size";1;"stroke";"#01579B";"fill";"#B3E3F3";"children";New collection:C1472))
				$collName.push(Form:C1466.name)
				For each ($method;$allMethods)
					MCC_d3_addCallees ($method;$subRef;$collName;$choice)
				End for each 
			End for each 
			
		Else   // We start from form.name
			
			  //$pos:=$data.indices("name =:1";Form.name)
			  //If ($pos#Null)
			  //MCC_d3_addCallees ($data[$pos[0]];$ref;$collName;$choice)
			  //End if 
			If (Form:C1466.name#"")
				MCC_d3_addCallees (Storage:C1525.index[Form:C1466.name];$ref;$collName;$choice)
			End if 
			
		End if 
		
		$text:=JSON Stringify:C1217($ref;*)
		
	: ($option=51)
		
		  // *********************************************************************
		  // "tree_collapse_full"
		  // *********************************************************************
		$d3:=New object:C1471("name";$root;"children";New collection:C1472)
		$ref:=$d3.children
		$collName:=New collection:C1472
		
		If (Form:C1466.name="")  // We take everything
			$paths:=$data.distinct("path").orderBy("asc")
			For each ($onePath;$paths)
				$ref.push(New object:C1471("name";$onePath;"children";New collection:C1472))
				$subRef:=$ref[$ref.length-1].children
				
				$allMethods:=$data.query("path =:1 and orderBy name";$onePath)
				
				For each ($method;$allMethods)
					
					MCC_d3_addCallees ($method;$subRef;$collName;$choice)
					
				End for each 
				
			End for each 
		Else   // We start from form.name
			
			  //$pos:=$data.indices("name =:1";Form.name)
			  //If ($pos#Null)
			  //MCC_d3_addCallees ($data[$pos[0]];$ref;$collName;$choice)
			  //End if 
			If (Form:C1466.name#"")
				MCC_d3_addCallees (Storage:C1525.index[Form:C1466.name];$ref;$collName;$choice)
			End if 
		End if 
		
		$text:=JSON Stringify:C1217($d3;*)
		
		
	: ($option=52) | ($option=53)
		
		  // *********************************************************************
		  // "tree_radial_tidy" or "tree_dity"
		  // *********************************************************************
		C_TEXT:C284($label)
		
		If (Form:C1466.name="")  // We take everything
			$ref:=New collection:C1472($root)
			$paths:=$data.distinct("path").orderBy("asc")
			
			For each ($onePath;$paths)
				$label:=$root+"."+$onePath
				$ref.push($label)
				$allMethods:=$data.query("path =:1 and orderBy name";$onePath)
				
				For each ($method;$allMethods)
					MCC_tidy_addCallees ($method;$ref;$label;$choice)
				End for each 
				
			End for each 
		Else   // We start from form.name
			$ref:=New collection:C1472(Form:C1466.name)
			  //$pos:=$data.indices("name =:1";Form.name)
			  //If ($pos#Null)
			  //MCC_tidy_addCallees ($data[$pos[0]];$ref;Form.name;$choice)
			  //$ref.remove(1;1)
			  //End if 
			If (Form:C1466.name#"")
				MCC_tidy_addCallees (Storage:C1525.index[Form:C1466.name];$ref;Form:C1466.name;$choice)
				$ref.remove(1;1)
			End if 
			
		End if 
		
		$text:=""
		For each ($txt;$ref)
			If ($text="")
				$text:="id,value"+Char:C90(Carriage return:K15:38)+$txt+","+Char:C90(Carriage return:K15:38)
			Else 
				$text:=$text+$txt+","+String:C10(Random:C100)+Char:C90(Carriage return:K15:38)
			End if 
		End for each 
		
		
	: ($option=54)
		
		  // *********************************************************************
		  // "edge_bundling"
		  // *********************************************************************
		$collName:=New collection:C1472
		
		If (Form:C1466.name="")  // We take everything
			$paths:=$data.distinct("path").orderBy("asc")
			For each ($onePath;$paths)
				
				$allMethods:=$data.query("path =:1";$onePath)
				For each ($method;$allMethods)
					MCC_d3_addCalleesBundling ($method;$collName;$choice)
				End for each 
				
			End for each 
			
		Else   // We start from form.name
			
			  //$pos:=$data.indices("name =:1";Form.name)
			  //If ($pos#Null)
			  //MCC_d3_addCalleesBundling ($data[$pos[0]];$collName;$choice)
			  //End if 
			If (Form:C1466.name#"")
				MCC_d3_addCalleesBundling (Storage:C1525.index[Form:C1466.name];$collName;$choice)
			End if 
			
		End if 
		
		$text:=JSON Stringify:C1217($collName;*)
		
	Else 
		
		
End case 

$0:=$text