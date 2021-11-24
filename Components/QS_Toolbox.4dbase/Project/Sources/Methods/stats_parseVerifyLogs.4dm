//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
  //change these if necessary
$verificationLogFilePath:=Get 4D file:C1418(Verification log file:K5:37)
$lang:=Get database localization:C1009(Default localization:K5:21)

Case of 
	: (Is macOS:C1572)
		$resourcesPath:=Application file:C491+Folder separator:K24:12+"Contents"+Folder separator:K24:12+"Resources"+Folder separator:K24:12
	: (Is Windows:C1573)
		$resourcesPath:=Path to object:C1547(Application file:C491).parentFolder+"Resources"+Folder separator:K24:12
	Else 
		$resourcesPath:=""
End case 

$r:=Get localized string:C991(":8009,19")

$xlfPath:=$resourcesPath+$lang+".lproj"+Folder separator:K24:12+"DataToolLog"+Uppercase:C13($lang)+".xlf"

ASSERT:C1129(Test path name:C476($xlfPath)=Is a document:K24:1)

$dom:=DOM Parse XML source:C719($xlfPath)

$labels:=New object:C1471

If (OK=1)
	ARRAY TEXT:C222($groups;0)
	$group:=DOM Find XML element:C864($dom;"xliff/file/body/group";$groups)
	For ($i;1;Size of array:C274($groups))
		$group:=$groups{$i}
		$id:=""
		DOM GET XML ATTRIBUTE BY NAME:C728($group;"id";$id)
		$o:=New object:C1471
		$labels[$id]:=$o
		ARRAY TEXT:C222($transUnits;0)
		$transUnit:=DOM Find XML element:C864($group;"group/trans-unit";$transUnits)
		For ($ii;1;Size of array:C274($transUnits))
			$transUnit:=$transUnits{$ii}
			$id:=""
			DOM GET XML ATTRIBUTE BY NAME:C728($transUnit;"id";$id)
			$target:=DOM Find XML element:C864($transUnit;"trans-unit/target")
			If (OK=1)
				$value:=""
				DOM GET XML ELEMENT VALUE:C731($target;$value)
				$o[$id]:=$value
			End if 
		End for 
	End for 
	DOM CLOSE XML:C722($dom)
End if 

  //8009:Verify steps
$labels["Additional errors"]:=$labels["8009"]["1"]
$labels["Checking tables"]:=$labels["8009"]["2"]
$labels["Checking indexes"]:=$labels["8009"]["3"]
$labels["Move original"]:=$labels["8009"]["4"]
$labels["Move the new file to the original location"]:=$labels["8009"]["5"]
$labels["Move original index"]:=$labels["8009"]["6"]
$labels["Move the new index file to the original location"]:=$labels["8009"]["7"]
$labels["Verify the internal database of the structure"]:=$labels["8009"]["8"]
$labels["Check Bittables for segments"]:=$labels["8009"]["9"]
$labels["Initialization of the resources for the verify operation"]:=$labels["8009"]["10"]
$labels["Move original log file"]:=$labels["8009"]["11"]
$labels["Opening the database in maintenance mode"]:=$labels["8009"]["12"]
$labels["Additional warnings"]:=$labels["8009"]["13"]

  //8010:Verify Application Progress
$labels["Check Database Methods"]:=$labels["8010"]["1"]
$labels["Check Project Methods"]:=$labels["8010"]["2"]
$labels["Check Trigger Methods"]:=$labels["8010"]["3"]
$labels["Check Project Forms"]:=$labels["8010"]["4"]
$labels["Check Table Forms"]:=$labels["8010"]["5"]
$labels["Check User and Group information"]:=$labels["8010"]["6"]
$labels["Check Orphan Methods"]:=$labels["8010"]["7"]
$labels["Check the folders of the Explorer"]:=$labels["8010"]["8"]
$labels["Check help tips"]:=$labels["8010"]["9"]
$labels["Check menu bars and menus"]:=$labels["8010"]["10"]
$labels["Check lists"]:=$labels["8010"]["11"]
$labels["Check Orphan Forms"]:=$labels["8010"]["12"]
$labels["Check Picture Library"]:=$labels["8010"]["13"]
$labels["Check Tables And Fields Names"]:=$labels["8010"]["14"]

  //8011:Verify Application Errors

  //33:{Name} refers to a deprecated picture. Picture library ID = {Name2}, Name = {Name3}.
  //34:Deprecated picture: ID = {Name}, Name = {Name2}.
  //35:{Name} uses a deprecated picture format: PICT.
  //36:{Name} uses a deprecated picture format for printing on platform {Name2}: PICT.
  //37:Deprecated picture for printing on platform {Name3}: ID = {Name} Name = {Name2}.
  //38:{Name} refers to a deprecated picture for printing on platform {Name4}. Picture library ID = {Name2}, Name = {Name3}.

$regex:=New object:C1471

  //make regex from xliff string
  //{Name} は古い形式のピクチャー(PICT)を使用しています。
  //(.+)\\s*は古い形式のピクチャー\\(PICT\\)を使用しています。

$str:=$labels["8011"]["35"]
$str:=Replace string:C233($str;"(PICT)";"\\(PICT\\)";*)
$str:=Replace string:C233($str;"{Name}";"(.+)";*)
$regex["deprecated picture format"]:=$str

$str:=$labels["8011"]["34"]
$str:=Replace string:C233($str;"{Name}";"(.+)";*)
$str:=Replace string:C233($str;"{Name2}";"(.+)";*)
$regex["deprecated picture"]:=$str

$log:=New object:C1471
$log.libraryPict:=New collection:C1472
$log.tableFormPict:=New object:C1471
$log.projectFormPict:=New object:C1471

If (Test path name:C476($verificationLogFilePath)=Is a document:K24:1)
	
	$dom:=DOM Parse XML source:C719($verificationLogFilePath)
	
	If (OK=1)
		
		ARRAY TEXT:C222($steps;0)
		$step:=DOM Find XML element:C864($dom;"verifylog/step";$steps)
		
		For ($i;1;Size of array:C274($steps))
			
			$step:=$steps{$i}
			$title:=""
			DOM GET XML ATTRIBUTE BY NAME:C728($step;"title";$title)
			
			Case of 
				: ($title=$labels["Opening the database in maintenance mode"])  //メンテナンスモードでデータベースを開く
					
				: ($title=$labels["Verify the internal database of the structure"])  //ストラクチャーの内部データベースを検査
					
				: ($title=$labels["Check Tables And Fields Names"])  //テーブル名とフィールド名を検査
					
				: ($title=$labels["Check Project Methods"])\
					 | ($title=$labels["Check Trigger Methods"])\
					 | ($title=$labels["Check Database Methods"])
					
					ARRAY TEXT:C222($steps2;0)
					$step2:=DOM Find XML element:C864($step;"step/step";$steps2)
					$lines:=New collection:C1472
					For ($ii;1;Size of array:C274($steps2))
						$step2:=$steps2{$ii}
						$title:=""
						DOM GET XML ATTRIBUTE BY NAME:C728($step2;"title";$title)  //method name
						$info:=""
						ARRAY LONGINT:C221($pos;0)
						ARRAY LONGINT:C221($len;0)
						DOM GET XML ELEMENT VALUE:C731(DOM Find XML element:C864($step2;"step/info");$info)
						If (Match regex:C1019(":\\s*(\\d+)\\s*lines$";$info;1;$pos;$len))
							$lines.push(Num:C11(Substring:C12($info;$pos{1};$len{1})))
						End if 
					End for 
					
				: ($title=$labels["Check Project Forms"]) | ($title=$labels["Check Table Forms"])
					
					ARRAY TEXT:C222($steps2;0)
					$step2:=DOM Find XML element:C864($step;"step/step";$steps2)
					$lines:=New collection:C1472
					For ($ii;1;Size of array:C274($steps2))
						$step2:=$steps2{$ii}
						$formName:=""
						DOM GET XML ATTRIBUTE BY NAME:C728($step2;"title";$formName)
						ARRAY TEXT:C222($steps3;0)
						$step3:=DOM Find XML element:C864($step2;"step/step";$steps3)
						For ($iii;1;Size of array:C274($steps3))
							$step3:=$steps3{$iii}
							$objectName:=""
							DOM GET XML ATTRIBUTE BY NAME:C728($step3;"title";$objectName)
							$info:=""
							ARRAY LONGINT:C221($pos;0)
							ARRAY LONGINT:C221($len;0)
							DOM GET XML ELEMENT VALUE:C731(DOM Find XML element:C864($step3;"step/info");$info)
							If (Match regex:C1019(":\\s*(\\d+)\\s*lines$";$info;1;$pos;$len))
								$lines.push(Num:C11(Substring:C12($info;$pos{1};$len{1})))
							End if 
						End for 
						
						ARRAY TEXT:C222($warnings;0)
						$warning:=DOM Find XML element:C864($step2;"step/warning";$warnings)
						
						For ($iii;1;Size of array:C274($warnings))
							$warning:=$warnings{$iii}
							$value:=""
							ARRAY LONGINT:C221($pos;0)
							ARRAY LONGINT:C221($len;0)
							DOM GET XML ELEMENT VALUE:C731($warning;$value)
							If (Match regex:C1019($regex["deprecated picture format"];$value;1;$pos;$len))
								$name:=Substring:C12($value;$pos{1};$len{1})
								
								Case of 
									: ($title=$labels["Check Project Forms"])
										
										If (Match regex:C1019(".([^.]+)\\.Page(\\d+)\\.([^.]+)";$name;1;$pos;$len))
											
											$formName:=Substring:C12($name;$pos{1};$len{1})
											$pageNumber:=Substring:C12($name;$pos{2};$len{2})
											$objectName:=Substring:C12($name;$pos{3};$len{3})
											
											If ($log.projectFormPict[$formName]=Null:C1517)
												$log.projectFormPict[$formName]:=New object:C1471
											End if 
											
											If ($log.projectFormPict[$formName][$pageNumber]=Null:C1517)
												$log.projectFormPict[$formName][$pageNumber]:=New collection:C1472
											End if 
											
											($log.projectFormPict[$formName][$pageNumber]).push($objectName)
											
										End if 
										
									: ($title=$labels["Check Table Forms"])
										
										If (Match regex:C1019("\\[([^]]+)\\]\\.([^.]+)\\.Page(\\d+)\\.([^.]+)";$name;1;$pos;$len))
											
											$tableName:=Substring:C12($name;$pos{1};$len{1})
											$formName:=Substring:C12($name;$pos{2};$len{2})
											$pageNumber:=Substring:C12($name;$pos{3};$len{3})
											$objectName:=Substring:C12($name;$pos{4};$len{4})
											
											If ($log.tableFormPict[$tableName]=Null:C1517)
												$log.tableFormPict[$tableName]:=New object:C1471
											End if 
											
											If ($log.tableFormPict[$tableName][$formName]=Null:C1517)
												$log.tableFormPict[$tableName][$formName]:=New object:C1471
											End if 
											
											If ($log.tableFormPict[$tableName][$formName][$pageNumber]=Null:C1517)
												$log.tableFormPict[$tableName][$formName][$pageNumber]:=New collection:C1472
											End if 
											
											($log.tableFormPict[$tableName][$formName][$pageNumber]).push($objectName)
											
										End if 
										
								End case 
								
							End if 
						End for 
						
					End for 
					
				: ($title=$labels["Check Orphan Methods"])  //リンクのないメソッドを検査
					
					ARRAY TEXT:C222($warnings;0)
					$warning:=DOM Find XML element:C864($step;"step/warning";$warnings)
					
				: ($title=$labels["Check Picture Library"])  //ピクチャーライブラリを検査
					
					ARRAY TEXT:C222($warnings;0)
					$warning:=DOM Find XML element:C864($step;"step/warning";$warnings)
					
					For ($ii;1;Size of array:C274($warnings))
						$warning:=$warnings{$ii}
						$value:=""
						ARRAY LONGINT:C221($pos;0)
						ARRAY LONGINT:C221($len;0)
						DOM GET XML ELEMENT VALUE:C731($warning;$value)
						If (Match regex:C1019($regex["deprecated picture"];$value;1;$pos;$len))
							$id:=Substring:C12($value;$pos{1};$len{1})
							$name:=Substring:C12($value;$pos{2};$len{2})
							$log.libraryPict.push(New object:C1471("id";$id;"name";$name))
						End if 
					End for 
					
				: ($title=$labels["Check Orphan Forms"])  //リンクのないフォームを検査
					
					ARRAY TEXT:C222($warnings;0)
					$warning:=DOM Find XML element:C864($step;"step/warning";$warnings)
					
				Else 
					
			End case 
		End for 
		
		DOM CLOSE XML:C722($dom)
		
	End if 
	
End if 

$lines:=New collection:C1472
C_TEXT:C284($formName;$pageNumber;$objectName)
For each ($formName;$log.projectFormPict)
	For each ($pageNumber;$log.projectFormPict[$formName])
		For each ($objectName;$log.projectFormPict[$formName][$pageNumber])
			$lines.push(New collection:C1472($formName;$pageNumber;$objectName).join("\t"))
		End for each 
	End for each 
End for each 

  //$lines:=New collection
  //C_TEXT($tableName;$formName;$pageNumber;$objectName)
  //For each ($tableName;$log.tableFormPict)
  //For each ($formName;$log.tableFormPict[$tableName])
  //For each ($pageNumber;$log.tableFormPict[$tableName][$formName])
  //For each ($objectName;$log.tableFormPict[$tableName][$formName][$pageNumber])
  //$lines.push(New collection($tableName;$formName;$pageNumber;$objectName).join("\t"))
  //End for each 
  //End for each
  //End for each 
  //End for each 

  //$lines:=New collection
  //C_OBJECT($libraryPict)
  //For each ($libraryPict;$log.libraryPict)
  //$lines.push(New collection($libraryPict.id;$libraryPict.name).join("\t"))
  //End for each 

SET TEXT TO PASTEBOARD:C523($lines.join("\r";ck ignore null or empty:K85:5))
