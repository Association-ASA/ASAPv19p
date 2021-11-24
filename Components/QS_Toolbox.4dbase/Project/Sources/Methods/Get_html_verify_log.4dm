//%attributes = {"invisible":true,"preemptive":"capable","publishedSoap":false,"publishedWeb":false,"publishedWsdl":false,"shared":false,"publishedSql":false,"executedOnServer":false}
C_BLOB:C604($stdInData;$stdOutData;$stdErrData)
C_TEXT:C284($1;$xmlPath;$2;$lang)
C_TEXT:C284($0)

$xmlPath:=$1
$lang:=$2
$subPath:="Resources"+Folder separator:K24:12+$lang+".lproj"+Folder separator:K24:12+"LogStyleSheet.xsl"
$xsltFolder:=XSLT_Get_folder 

If (Is macOS:C1572)
	$xslPath:=Application file:C491+Folder separator:K24:12+"Contents"+Folder separator:K24:12+$subPath
	If (Test path name:C476($xslPath)=Is a document:K24:1)
		$arguments:=" "+LEP_Escape (Convert path system to POSIX:C1106($xslPath))
		$arguments:=$arguments+" "+LEP_Escape (Convert path system to POSIX:C1106($xmlPath))
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_CURRENT_DIRECTORY";$xsltFolder)
		LAUNCH EXTERNAL PROCESS:C811("xsltproc"+$arguments;$stdInData;$stdOutData;$stdErrData)
	End if 
	
Else 
	$xslPath:=Path to object:C1547(Application file:C491).parentFolder+$subPath
	If (Test path name:C476($xslPath)=Is a document:K24:1)
		$arguments:=" "+LEP_Escape ($xslPath)
		$arguments:=$arguments+" "+LEP_Escape ($xmlPath)
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_BLOCKING_EXTERNAL_PROCESS";"true")
		SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE";"true")
		LAUNCH EXTERNAL PROCESS:C811($xsltFolder+"xsltproc.exe"+$arguments;$stdInData;$stdOutData;$stdErrData)
	End if 
End if 

$stdOut:=Convert to text:C1012($stdOutData;"utf-8")
$0:=$stdOut