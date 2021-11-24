//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
$USE_GENERIC_ARGUMENTS:=True:C214
$GROUP_BY_PLANS:=True:C214

  //QUERY,QUERY SELECTION 
C_OBJECT:C1216($command_o)
$queryCommands:=New collection:C1472(277;341)

$commands:=New object:C1471
C_LONGINT:C283($i)
For each ($i;$queryCommands)
	$command:=Command name:C538($i)
	If ($command#"") & ($command#"_4D")
		$commands[String:C10($i)]:=New object:C1471("name";$command;"id";$i)
	End if 
End for each 

ARRAY TEXT:C222($methods;0)
ARRAY TEXT:C222($command_names;0)
OB GET PROPERTY NAMES:C1232($commands;$command_names)
$total:=Size of array:C274($command_names)

METHOD GET PATHS:C1163(Path all objects:K72:16;$methods)

$token:="([[:letter:][_]][[:letter:][:number:][. _]]+(?<![. ]))"
$id:=":C(\\d{1,4})"
$motif:="("+$token+$id+")"
  //$field_strict:="(\\[[[:letter:][_]][[:letter:][:number:][. _]]+(?<![. ]):\\d{1,5}\\][[:letter:][_]][[:letter:][:number:][. _]]+(?<![. ]):\\d{1,5})"
  //$field:="(\\[[^]]+(?<![. ]):\\d{1,5}\\][^:]+:\\d{1,5})"
  //$date:="!\\d+[-./]\\d+[-./]\\d+!"
  //$time:="\\?\\d+:\\d+:\\d+\\?"
  //$string:="\"[^\"]*\""
$table:="(\\[[[:letter:][_]][[:letter:][:number:][. _]]+(?<![. ]):\\d{1,5}\\])"

$queries:=New collection:C1472

For ($m;1;Size of array:C274($methods))
	$method:=$methods{$m}
	If (Current method path:C1201#$method)
		$ctx:=New object:C1471("lines";Null:C1517;"isOpen";False:C215)
		METHOD GET CODE:C1190($method;$code;Code with tokens:K72:18)
		$lines:=Split string:C1554($code;"\r";sk trim spaces:K86:2)
		$lines.shift()  //remove meta
		For each ($line;$lines)
			Case of 
				: (Match regex:C1019("\\s*";$line))  //blank line
				: (Match regex:C1019("^//.*";$line))  //comment line
				Else 
					$i:=1
					ARRAY LONGINT:C221($pos;0)
					ARRAY LONGINT:C221($len;0)
					While (Match regex:C1019($motif;$line;$i;$pos;$len))
						$command:=Substring:C12($line;$pos{3};$len{3})
						$command_name:=Substring:C12($line;$pos{2};$len{2})
						$command_o:=$commands[$command]
						$i:=$pos{1}+$len{1}
						If ($command_o#Null:C1517)
							If ($command_o.name=$command_name)
								$parsedLine:=$line
								If (Match regex:C1019("\\(([^;]+\\])(;(?:.+?)(?:;\\*)?(?:\\)))";$line;1;$pos;$len))
									
									$continue:=False:C215
									
									$tableToken:=Substring:C12($line;$pos{1};$len{1})
									$ConditionToken:=Substring:C12($line;$pos{2};$len{2})
									
									If (Not:C34(Match regex:C1019("^;(\\[[^\\]]+(?<![. ]):\\d{1,5}\\][^:]+:\\d{1,5})";$ConditionToken;1)))
										  //table name omitted (old syntax)
										$where:=$pos{1}+$len{1}+1
										If (Match regex:C1019("[^/]+\\/([^/]+)\\/";$method;1;$pos;$len))
											$masterTable:=Parse formula:C1576("["+Substring:C12($method;$pos{1};$len{1})+"]";Formula out with tokens:K88:3)
											$line:=Insert string:C231($line;$masterTable;$where)
											$ConditionToken:=Insert string:C231($ConditionToken;$masterTable;2)
										End if 
									End if 
									
									If (Match regex:C1019($table;$tableToken))
										If (Match regex:C1019("w(.+?)(?:;\\*)?(?:\\))";$line;1;$pos;$len))
											$operand:=Substring:C12($line;$pos{1};$len{1})
											$lineBefore:=Substring:C12($line;1;$pos{1}-1)
											$lineAfter:=Substring:C12($line;$pos{1}+$len{1})
											  //escape parameters, variables and methods
											If ($USE_GENERIC_ARGUMENTS)
												$operand:="\"?\""
											Else 
												$operand:="\""+Replace string:C233($operand;"\"";"\\\"";*)+"\""
											End if 
											$parsedLine:=$lineBefore+$operand+$lineAfter
											$continue:=True:C214
										Else 
											  //the operator is variable, ignore
										End if 
										If ($continue)
											$isOpen:=Match regex:C1019(";\\*\\)(?:\\s*//.*)?";$line;1;$pos;$len)
											$html:="<p class=\"code\"><span class=\"command\">"+$command_o.name+"</span>("+\
												"<span class=\"table\">"+Parse formula:C1576($tableToken)+"</span>"+\
												Parse formula:C1576($ConditionToken)+"</p>"
											Case of 
												: (Not:C34($isOpen)) & (Not:C34($ctx.isOpen))
													$q:=New object:C1471(\
														"command";$command_o;\
														"method";$method;\
														"code";New collection:C1472(New object:C1471("raw";$line;"cajoled";$parsedLine;"html";$html)))
													Case of 
														: ($command_o.id=341)
															$starter:="ALL RECORDS:C47("+$tableToken+")\r"
															$q.code.unshift(New object:C1471("cajoled";$starter))
													End case 
													$queries.push($q)
												: ($isOpen) & (Not:C34($ctx.isOpen))
													$ctx.isOpen:=True:C214
													$ctx.lines:=New collection:C1472(New object:C1471("raw";$line;"cajoled";$parsedLine;"html";$html))
												: (Not:C34($isOpen)) & ($ctx.isOpen)
													$q:=New object:C1471(\
														"command";$command_o;\
														"method";$method;\
														"code";$ctx.lines.push(New object:C1471("raw";$line;"cajoled";$parsedLine;"html";$html)))
													Case of 
														: ($command_o.id=341)
															$starter:="ALL RECORDS:C47("+$tableToken+")\r"
															$q.code.unshift(New object:C1471("cajoled";$starter))
													End case 
													$queries.push($q)
													$ctx.isOpen:=False:C215
												: ($isOpen) & ($ctx.isOpen)
													$ctx.lines.push(New object:C1471("raw";$line;"cajoled";$parsedLine;"html";$html))
											End case 
										End if 
									End if 
								End if 
							End if 
						End if 
					End while 
			End case 
		End for each 
	End if 
End for 

C_OBJECT:C1216($plans)
C_OBJECT:C1216($aPlan)
$plans:=New object:C1471
C_OBJECT:C1216($query)

For each ($query;$queries)
	$code:=$query.code.extract("cajoled").join("\r";ck ignore null or empty:K85:5)
	  //plan is always text format (no xml support)
	$template:="<!--#4dcode\r"+\
		"DESCRIBE QUERY EXECUTION:C1044(True:C214)\r"+$code+"\r"+\
		"$path:=Get last query plan:C1046(Description in text format:K19:5)\r"+\
		"DESCRIBE QUERY EXECUTION:C1044(False:C215)\r"+\
		"-->$4deval($path)"
	$plan:=""
	
	ERASE WINDOW:C160($w)
	GOTO XY:C161(0;0)
	MESSAGE:C88($code)
	PROCESS_sleep (0)
	
	
	PROCESS 4D TAGS:C816($template;$plan)
	$query.plan:=$plan
	
	$hash:=Generate digest:C1147($plan;SHA1 digest:K66:2)
	
	$aPlan:=$plans[$hash]
	If ($aPlan=Null:C1517)
		$aPlan:=New object:C1471("plan";New collection:C1472)
		$plans[$hash]:=$aPlan
	End if 
	$aPlan.plan.push(New object:C1471("method";$query.method;"code";$query.code;"plan";$plan))
	
End for each 

C_COLLECTION:C1488($cPlan)
C_OBJECT:C1216($oCode)

$log:=""

If ($GROUP_BY_PLANS)
	
	$cPlan:=New collection:C1472
	
	For each ($hash;$plans)
		$aPlan:=$plans[$hash]
		$oPlan:=New object:C1471(\
			"plan";$aPlan.plan[0].plan;\
			"count";$aPlan.plan.length;\
			"code";$aPlan.plan.extract("method";"method";"code";"code"))
		$cPlan.push($oPlan)
	End for each 
	
	$cPlan:=$cPlan.orderBy("count desc")
	
	For each ($aPlan;$cPlan)
		$log:=$log+"<p><span class=\"count\">("+String:C10($aPlan.count)+")</span></p>\r"
		$log:=$log+"<pre>\r"+$aPlan.plan+"</pre>\r"
		$log:=$log+"<hr />\r"
		For each ($oCode;$aPlan.code)
			$log:=$log+"<p><span class=\"method\">"+$oCode.method+"</span></p>\r"
			For each ($html;$oCode.code.extract("html"))
				$log:=$log+Parse formula:C1576($html)+"\r"
			End for each 
		End for each 
		$log:=$log+"<hr />\r"
	End for each 
	
Else 
	
	For each ($query;$queries)
		$log:=$log+"<p><span class=\"method\">"+$query.method+"</span></p>\r"
		$log:=$log+"<hr />\r"
		For each ($html;$query.code.extract("html"))
			$log:=$log+Parse formula:C1576($html)+"\r"
		End for each 
		$log:=$log+"<pre>\r"+$query.plan+"</pre>\r"
		$log:=$log+"<hr />\r"
	End for each 
	
End if 


$head:="<head>\r<style>\rp.code{font-size:13px;font-family:sans-serif;color:#999;}\r"+\
"span.count{font-size:13px;font-family:sans-serif;font-weight:bold;color:#911;}\r"+\
"span.command{font-size:13px;font-family:sans-serif;font-weight:bold;color:#050;}\r"+\
"span.table{font-size:13px;font-family:sans-serif;color:#835C3B;}\r"+\
"span.method{font-size:13px;font-family:sans-serif;font-weight:bold;font-style:italic;color:#005;}\r"+\
"</style>\r</head>\r"

$log:="<html>\r"+$head+"<body>\r"+$log+"</body>\r</html>"

$path:=System folder:C487(Desktop:K41:16)+"plans.html"
TEXT TO DOCUMENT:C1237($path;$log;"utf-8")

$path:=System folder:C487(Desktop:K41:16)+"queries.json"
TEXT TO DOCUMENT:C1237($path;JSON Stringify:C1217($queries);"utf-8")

$path:=System folder:C487(Desktop:K41:16)+"plans.json"
TEXT TO DOCUMENT:C1237($path;JSON Stringify:C1217($cPlan);"utf-8")
