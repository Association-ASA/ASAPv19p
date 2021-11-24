//%attributes = {"invisible":true,"published4DMobile":{"scope":"none"},"publishedWeb":false,"publishedSoap":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false,"preemptive":"indifferent"}
C_COLLECTION:C1488($Methods)
If (Form:C1466.methodSelected.length>0)
	$Methods:=Form:C1466.methodSelected
Else 
	$Methods:=Form:C1466.listboxDisplayed
	
End if 

$n:=$Methods.length
$action:=False:C215
If (x_io_confirm_yesNo("Execute Beautifier on "+String:C10($n)+" methods?"; ->$action))
	
	If (x_io_confirm_yesNo("Before continuing, confirm that methods are closed..."; ->$action))
		
		C_TIME:C306($heureDebut)
		C_REAL:C285($Pas; $Progression)
		C_TEXT:C284($info; $codeMethod; $time)
		C_OBJECT:C1216($method)
		
		$heureDebut:=Current time:C178
		$Progression:=0
		$i:=0
		$Pas:=1/($n+1)
		$info:="Beautifying "+String:C10($n)+" methods."
		
		// Initialisation
		C_OBJECT:C1216($param)
		C_LONGINT:C283($window)
		C_COLLECTION:C1488($data)
		$param:=New object:C1471("title"; $info; "icon"; "btn_attributes.png"; "type"; 0)
		QST_progress_start($param)
		$window:=$param.window
		$data:=Storage:C1525.allMethods
		
		For each ($method; $data) Until ($i<=$n)
			$methodName:=$method.name
			
			$i:=$i+1
			$param.value:=$Progression
			$param.content:="Updating "+$methodName
			CALL FORM:C1391($window; "progressBar_update"; $param)
			
			Case of 
					// exception cases
				: ($methodName="MIMOSA_EnjoliverMethod")
				: ($methodName="REGEX_@")
				: ($methodName="TOGBTN_@")
				: ($methodName="TOGCTN_@")
				: ($methodName="TOGOBJ_@")
					
				Else 
					METHOD GET CODE:C1190($methodName; $codeMethod; *)  // since the host database & to be sure to work on the latest version
					$codeMethod:=METHOD_MIMOSA_Enjoliver($codeMethod; False:C215)
					$method.code:=$codeMethod
					UPDT_WriteMethod($methodName; $codeMethod)
			End case 
			
		End for each 
		
		$param.value:=1
		$param.content:="Cleaning."
		CALL FORM:C1391(Storage:C1525.windows.progress; "progressBar_update"; $param)
		PROCESS_sleep(10)
		KILL WORKER:C1390("QST_Progress")
		
		C_TIME:C306($duration)
		$duration:=Current time:C178-$heureDebut
		
		If (String:C10($duration\60)="0")
			$time:=String:C10($duration)+" s"
		Else 
			$time:=String:C10($duration\60)+" mn"
		End if 
		$FenetreInformation:=String:C10($i)+" methods treated in "+$Time
	End if 
	
Else 
	ALERT:C41("May I will backup the database before.")
End if 

