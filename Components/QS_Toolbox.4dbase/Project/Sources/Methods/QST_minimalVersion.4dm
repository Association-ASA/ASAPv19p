//%attributes = {"invisible":true}
var $0 : Boolean

$0:=True:C214
If (Application version:C493<"1800")  // V18R6 is the first version which allows point notation
	ALERT:C41("Sorry, QS_Toolbox required a newer version of 4D (v18R6 and above)")
	$0:=False:C215
End if 