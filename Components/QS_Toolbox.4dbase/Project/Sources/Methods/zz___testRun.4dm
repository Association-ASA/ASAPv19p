//%attributes = {"invisible":true}
  //C_TEXT($mycode)

  //METHOD GET CODE("z___testComment";$mycode)
  //METHOD_getCleanCode (->$mycode)

  //TRACE


ARRAY TEXT:C222($ar_MethodNames;0)
ARRAY TEXT:C222($ar_MethodPaths;0)
$cr:=Char:C90(Carriage return:K15:38)
BEEP:C151

$start:=Milliseconds:C459

METHOD GET NAMES:C1166($ar_MethodNames;*)
METHOD GET PATHS:C1163(Path all objects:K72:16;$ar_MethodPaths)

$listOfCalls:=New object:C1471  //Contiendra la liste des méthodes avec, pour chacune, la liste des méthodes appelées
  //On peut utiliser un Objet pour ça car les noms de méthodes sont uniques.
For ($path;1;Size of array:C274($ar_MethodPaths))
	$testPath:=$ar_MethodPaths{$path}
	$colFound:=New collection:C1472
	METHOD GET CODE:C1190($testPath;$testCode)
	  // On réduit la taille de la méthode et on enlève les commentaires qui pourraient contenir des noms de méthodes.
	$listOfLines:=New collection:C1472
	$listOfLines:=Split string:C1554(Replace string:C233($testCode;"\t";"");"\r";sk ignore empty strings:K86:1+sk trim spaces:K86:2)
	For each ($line;$listOfLines)
		$del:=False:C215
		Case of 
			: ($line="//@")
				$del:=True:C214
			: ($line="C_@")
				$del:=True:C214
			: ($line="ARRAY @") | ($line="TABLEAU @")
				$del:=True:C214
			Else 
				$pos:=Position:C15("//";$line)
				If ($pos>0)
					$line:=Substring:C12($line;1;$pos-1)
				End if 
		End case 
	End for each 
	$testCode:=$listOfLines.join($cr)  //On va recréer la méthode nettoyée
	
	For ($i;1;Size of array:C274($ar_MethodNames))
		$ok2Add:=False:C215
		If (Position:C15($ar_MethodNames{$i};$testCode;*)>0)  // l'astérisque peut être utilisée car le nom de la méthode est toujours écrit de la même façon
			$colFound.push($ar_MethodNames{$i})
		End if 
	End for 
	If ($colFound.length>0)
		$listOfCalls[$testPath]:=$colFound
	End if 
End for 
$end:=Milliseconds:C459

$duration:=$end-$start

ALERT:C41(String:C10($duration))
