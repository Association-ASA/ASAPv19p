//%attributes = {"invisible":true,"preemptive":"capable","published4DMobile":{"scope":"none"},"publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
  // ----------------------------------------------------
  // Nom utilisateur (OS) : Association QualiSoft
  // Date et heure : 21/02/19, 16:29:52
  // Paramètres
  // ----------------------------------------------------
  // $1 : Object (row)
  // $2 - $9 : Integer corresponding to checkbox
  // $10 : type of preemptive mode of the Method  
  // $11 : Method Visible if True
  // ----------------------------------------------------
  // Méthode : CM_displayOne
  // Description
  // callback function to select row to display
  // See why .filter() is used
  // https://forums.4d.com/Post/FR/28656363/1/28661721#28661721

C_OBJECT:C1216($1)
C_LONGINT:C283($2;$3;$4;$5;$6;$7;$8;$9)  // $cb1;$cb2;$cb3;$cb4;$cb5;$cb6;$cb7;$cb8
C_TEXT:C284($10)  // $preemptive
C_BOOLEAN:C305($11)  // $visible

$1.result:=False:C215  // By default, not displayed

If ($1.value.path="Path project method")
	
	If ($1.value.attributes.invisible=True:C214) & ($2=1) & ($11=False:C215)
		$toCount:=True:C214
	End if 
	
	If ($1.value.attributes.invisible=False:C215) & ($2=1) & ($11=True:C214)
		$toCount:=True:C214
	End if 
	
	If ($1.value.attributes.publishedWeb=True:C214) & ($3=1)
		$toCount:=True:C214
	End if 
	
	If ($1.value.attributes.publishedSoap=True:C214) & ($4=1)
		$toCount:=True:C214
	End if 
	
	If ($1.value.attributes.publishedWsdl=True:C214) & ($5=1)
		$toCount:=True:C214
	End if 
	
	If ($1.value.attributes.shared=True:C214) & ($6=1)
		$toCount:=True:C214
	End if 
	
	If ($1.value.attributes.publishedSql=True:C214) & ($7=1)
		$toCount:=True:C214
	End if 
	
	If ($1.value.attributes.executedOnServer=True:C214) & ($8=1)
		$toCount:=True:C214
	End if 
	
	If ($1.value.attributes.preemptive=$10) & ($9=1)
		$toCount:=True:C214
	End if 
End if 


If ($toCount)
	$1.result:=True:C214
End if 